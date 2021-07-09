
var User = require('./Models/User.js');
var Entreprise = require('./Models/Entreprise.js')
var Modules = require('./Models/Module.js')
const bcrypt = require('bcryptjs');
const Module = require('./Models/Module.js');
const Plan = require('./Models/Plan.js');
const Role = require('./Models/Role.js');
const Abonne = require('./Models/Abonne.js');
const https = require('https')

const PasswordRecovry =require('./Models/PasswordRecovry.js');
const jsonwebtoken = require('jsonwebtoken')

const nodemailer = require("nodemailer");
const { json } = require('body-parser');



  
  let transporter = nodemailer.createTransport({
    host: "smtp-mail.outlook.com",
    port: 587,
    secure: false, // true for 465, false for other ports
    auth: {
      user: 'ghaith1997@live.com', // generated ethereal user
      pass: '@@Ghaith', // generated ethereal password
    },
  });




const resolvers={
   Query: {
    getEmployees:async(_,{IdEnt})=>{
      try{var emp=await User.find({Role:"6065bf5bcf348e16f4ba7cbc",IdEnt:IdEnt});
      
      return emp
      }catch(exceptionS){
   
      
      return false}
    },
    checkSubscription:async(_,{Entr})=>{
      try{var subs=await Abonne.findOne({user:Entr});
      
        return true
        }catch(exceptionS){
     
        
        return false}
    },
    IsExpired:async (_,{IdEntr} )=>{
try{
  var subsc=await Abonne.findOne({user:IdEntr});
  var Rdate=new Date;
  var Ndate=new Date;
Rdate=subsc['date'];
  console.log(Ndate.toDateString())
  console.log(Rdate.toDateString())
  if(Ndate.toDateString()==Rdate.toDateString()){
    return true
  }else{
    return false
  }      
      
}catch(expired){
console.log(expired);
}
    },
      
        
    
       getmoduls:()=>Module.find(),
      
        
      
        
       getUsers:()=>User.find().populate({path:'Role',select:'libelle'}).populate('IdEnt'),
       getUserById:async(_,{IdUser})=>User.findById(IdUser).populate({path:'Role',select:'libelle'}).populate('IdEnt'),
       getUser:async(_,{Email})=>{
            return  await  (await User.find({'Email':new RegExp(Email, 'i')}).populate('Role').populate('IdEnt'))},
       getEntreprises:()=>Entreprise.find().populate('module').exec(),
       getEntreprise:async (_,{NomLegal})=>{
         console.log(`/.*${NomLegal}.*/`);
          return await Entreprise.find({'NomLegal':new RegExp(NomLegal, 'i')}).populate('module').exec()
       },
       getFirm:(_,{idFirm})=>Entreprise.findById(idFirm).populate('module'),
       getPlans:()=>Plan.find(),
       getPlan:async(_,{id})=>{
        var plan=await Plan.findById(id);
      
          return plan
          
          
       },
       getRoles:async()=>{
         try{
           return await Role.find()
         }catch(exp){console.log(exp)}
       },
       checkRecovryCode:async (_,{Email,Code})=>{
         try{
          var pswdR=await PasswordRecovry.findOne({Email:Email})
          if(pswdR==null){
            return -1
            
          }else{
            if(pswdR['PasswordRecovryCode']!=Code){
              return 0
            }else{
              await PasswordRecovry.findOneAndDelete({PasswordRecovryCode:Code});
              return 1
            }
          }


         }catch(exp){
           console.log(exp)

         }
       },
       getSubscriptions:async()=>{
          
          var sub=await( Abonne.find()).populate('user').populate('plan');
          return sub;
       },
getSubscription:async(_,{id})=>{
    return await Abonne.find({$where:id}).populate('user').populate('plan');
},
IsVerified:async (_,{IdUser})=>{
  try{
 var user = await User.findById(IdUser);
     if(user.IsVerified){
       return true  
     }else{
       return false
     }
  }catch(exp){
    console.log(exp)
  }
}
   },
   Mutation:{
        CreatUser:async(_,{Nom,Prenom,Email,Phone,Password,IdEnt,Role,Photo})=>{
        try{
          var useremail= await User.findOne({Email:Email});
            if(useremail==null){var pswd=  await bcrypt.hash(Password,10);
      const user = new User({Nom,Prenom,Email,Phone,Password: await bcrypt.hash(Password,10),IdEnt,Role,Photo,verifyingcode:Math.floor(Math.random()*6000),IsVerified:false});
       await (await user.save()).populate('IdEnt');
         console.log('User Created');
         
        
        let info = await transporter.sendMail({
          from: '"SmallB 🏬" <ghaith1997@live.com>', // sender address
          to:user['Email'], // list of receivers
          subject: "Verifier votre email adresse ✔", // Subject line
          
           text:"Bienvenue a SmallB votre compte est creer avec succès",// plain text body
          html: "<H3>Bienvenue a SmallB</H3>"
          +"<p>Bienvenue dans notre platform votre compte est creer avec succès <br> votre code est &nbsp"+"<b>"+ +user['verifyingcode']
          +"</b>"+"<br>Merci de choisier SmallB."+"</p>"
          , // html body
        });
      
        console.log("Message sent: %s", info.messageId);
        
      
        
        console.log("Preview URL: %s", nodemailer.getTestMessageUrl(info));
        //-----------------------
        console.log(user['Email'])
        const token = jsonwebtoken.sign(
          { id: user['id'], Email: user['Email']},
          'gahahahaj',
          { expiresIn: '5y' }
        )
       
         return {user,token,Msg:'Your Account is Created'}}else{
           return {Msg:'Cette adresse e-mail est utilisée , veuillez insérer un autre e-mail'}}
       
        }catch( exp ){
            console.log("lol",exp)
        }},
    
        SetIdEnt:async(_,{IdUser,IdEnt})=>{
          try{
            var user = await User.findByIdAndUpdate(IdUser,{
              $set:{
                IdEnt:IdEnt
              }
            }).populate('IdEnt').exec();
            
            return user
          }catch(Exec){

            console.log(Exec)
            return null;
          }
        },
     CreatModule:async(_,{libelle,SubModule})=>{
         try{
           console.log(SubModule);
            const module = new Modules({libelle,SubModule});
           await module.save();
           console.log('Module Created');
           return module;
          
          } catch(expetion){
           console.log(expetion);
        }  
      },
      UpdateModule:async(_,{libelle,IdModule})=>{
        try{
           const module = await Modules.findByIdAndUpdate(IdModule,{
             $set:{
              libelle:libelle
             }
           });
       
          console.log('Module Updated');
          return true;
         
         } catch(expetion){
           
          console.log(expetion);
          


       }  
     },
      CreateEntreprise: async (_,{NomLegal,TypeDeCommerce,module,Phone,Email,Fax,Adresse,Logo})=>{ 
            try{
            const entr= new Entreprise({NomLegal,TypeDeCommerce,module,Phone,Email,Fax,Adresse,Logo});
             await entr.save();
             console.log('Entreprise Created');
              return entr;
             
             }catch(exp1){
             console.log(exp1);
            }
         },
        CreatePlan: async(_,{planType,prix,duree})=>{
          try{
           const plan = new Plan({planType,prix,duree});
            await plan.save();
            return plan;
            console.log('Plan added');
           }catch(exceptionplan){
          console.log(exceptionplan);
          }
        },
        CreateRole:async(_,{libelle})=>{
            try{
             const role = new Role({libelle})
             await role.save();
             console.log('Role Saved');
             return role;
            

            }catch(exceptionrole){
               return exceptionrole
            }
        },
        CreateSubscription:async(_,{user,plan})=>{
          try{
            
            var plans =await  Plan.findById(plan).exec();
            const dure=plans['duree'];
            var dateoftoday= new Date
            dateoftoday.setDate(dateoftoday.getDate()+dure)
            
             const date = dateoftoday
             
            const abonne= new Abonne({user,plan,date});
          await (await abonne.save()).populate('Entreprise').populate('Plan');
          console.log('Subscription created');
          return abonne
          
          }catch(exceptionabonne){
              console.log(exceptionabonne)
          }

        },
        CancelSubscription: async(_,{IdSub})=>{
          try{
            var sub= await Abonne.findByIdAndDelete(IdSub);
            return true
          }catch(expcancel){
            return false
            console.log(expcancel)
          }

        },
        DeletePlan:async(_,{IdPlan})=>{
          try{
            var sub= await Plan.findByIdAndDelete(IdPlan);
            return true
          }catch(expp){
            return false
            console.log(expp)
          }

        },
        UpdatePlan:async(_,{IdPlan,planType,prix,duree})=>{
          try{
           var plan= await Plan.findByIdAndUpdate(IdPlan,{
             $set:{
              planType:planType,
              prix:prix,
              duree:duree

             }
           }
            
            );
            return true

          }catch(expup){
            return false
            console.log(expp);
          }
        },
        UpdateUser:async(_,{IdUser,Nom,Prenom,Email,Phone,Photo})=>{
          try{
           var plan= await User.findByIdAndUpdate(IdUser,{
             $set:{
              Nom:Nom,
              Prenom:Prenom,
              Email:Email,
              Phone:Phone,
              Photo:Photo

             }
           }
            
            );
            return true

          }catch(expuser){
            return false
            
          }
        },
        UpdatePassword:async(_,{IdUser,Password,oldPassword})=>{
          try{
           var user= await User.findById(IdUser);
           console.log(user.Password)
           if(await bcrypt.compare(oldPassword,user['Password'])){
             
           var plan= await User.findByIdAndUpdate(IdUser,{
             
             $set:{
              Password: await bcrypt.hash(Password,10)

             }
           }
            
            );
            return 1}else{
              return -1
            }

          }catch(expuser){
            return 0
            
          }
        },
        DeleteUser:async(_,{IdUser})=>{
            try{
            var sub= await User.findByIdAndDelete(IdUser);
            return true
          }catch(expp){
            return false
            
          }},
          ChangeRole:async(_,{IdUser,IdAdmin,IdRole})=>{
            try{
              var admin= await User.findById(IdAdmin).populate('Role')
               if(admin['Role']['libelle']=='Admin'){
                var user= await User.findByIdAndUpdate(IdUser,
                  {$set:{
                    Role:IdRole


                  }}
                  
                  )
                  return true;
               }

            }catch(excp){
              return false;

            }

          },
          getVerified:async(_,{IdUser,Code})=>{

            try{
              var user= await User.findById(IdUser);

              
            
              if(user['verifyingcode']==Code){ await User.findByIdAndUpdate(IdUser,
              {
                
                $set:{
                  IsVerified:true,
                  verifyingcode:null
                }
              }
              
              
              );
              return true}else{
                return false
              }
            }catch(exp){
                console.log(exp);
               
              }

          },
          InviteUser:async(_,{Email,IdEnt})=>{
            let r = Math.random().toString(36).substring(7);
            var code=Math.floor((Math.random()*20)+1000);
            let password=`${r}${code}`
            let passwd=await bcrypt.hash(password,10)
            var entr= await Entreprise.findById(IdEnt)
            var user = await new User({IdEnt:IdEnt,Email:Email,Password:passwd,IsVerified:true,Role:"6065bf5bcf348e16f4ba7cbc",Phone:12345678}).save();
            console.log(user);
            let info = await transporter.sendMail({
              from: '"SmallB 🏬" <ghaith1997@live.com>', // sender address
              to:Email, // list of receivers
              subject: "invitation", // Subject line
              
               text:"Une réinitialisation du mot de passe de votre compte a été demandée.",// plain text body
              html: `<H3>Vous avez été invité à travailler dans ${entr.NomLegal} votre information de connexion est  </H3>`+
              `<b>Email:${Email}</b> <br>`+
              `<b>Mot de passe: ${password} <br>`+
              `Si vous avez reçu cet e-mail par accident, veuillez contacter l'expéditeur pour plus d'informations.<br>`+
              `<H3>Adresse mail de l'expéditeur:${entr.Email}</H3>`

              , // html body
            });
          
            console.log("Message sent: %s", info.messageId);
            
          
            
            console.log("Preview URL: %s", nodemailer.getTestMessageUrl(info));
            return true;
          },
          GeneratePasswordRecovryCode:async(_,{Email})=>{
            try{
              var user=await User.findOne({Email:Email})
              if(user!=null){ 
                var code=Math.floor((Math.random()*500000)+100000);
              
               var pswdRecovry=new PasswordRecovry({PasswordRecovryCode:code,Email:Email,createdAt:Date.now()});
               PasswordRecovry.createIndexes({createdAt: 1,expireAfterSeconds: 3600})
               await pswdRecovry.save();
            
               console.log(Email)
              let info = await transporter.sendMail({
                from: '"SmallB 🏬" <ghaith1997@live.com>', // sender address
                to:Email, // list of receivers
                subject: "Réinitialiser le mot de passe", // Subject line
                
                 text:"Une réinitialisation du mot de passe de votre compte a été demandée.",// plain text body
                html: "<H3>Une réinitialisation du mot de passe de votre compte a été demandée.</H3>"
                +"<p>"+"Bonjour &nbsp"+user['Nom']+"<br>"+"Une réinitialisation du mot de passe de votre compte a été demandée <br> votre code de réinitialisation est : &nbsp"+"<b>"+ +code.toString() 
                +"</b>"+"<br>Remarque : ce code est valable pendant 12 heures. Après expiration de ce délai, vous devrez soumettre une nouvelle demande de réinitialisation de mot de passe."+"</p>"
                , // html body
              });
            
              console.log("Message sent: %s", info.messageId);
              
            
              
              console.log("Preview URL: %s", nodemailer.getTestMessageUrl(info));

               return 1
               }else{
                 return 0
               }
           
              

            }catch(exp){
              console.log(exp);
              
            }

          },
          PasswordRecovry:async(_,{Email,Password})=>{
            try{
              var emailc=await User.findOne({Email:Email})
              if(emailc!=null){
                await User.findOneAndUpdate({Email:Email},{
                   $set:{
                     Password:await bcrypt.hash(Password,10)
                   }    
                   
                });
                
                return true
                
              }else{
                return false
              }
            }catch(exp){console.log(exp)}
          },
          DeleteEntreprise:async(_,{IdEntr})=>{
            try{
              await Entreprise.findByIdAndDelete(IdEntr);
              await User.remove({IdEnt:IdEntr});
              return 'l`entreprise est supprimer avec succès';
            }catch(exp){console.log(exp)
              return 'Un probleme est survenue'
            
            }

          },UpdateEntreprise:async(_,{IdEntr,NomLegal,Phone,Email,Fax,Adresse,Logo})=>{
            try{
              await Entreprise.findByIdAndUpdate(IdEntr,{
                $set:{
                  NomLegal:NomLegal,
                  Phone:Phone,
                  Email:Email,
                  Fax:Fax,
                  Adresse:Adresse,
                  Logo:Logo
                }
              });
              
              return 'l`entreprise est Modifier avec succès';
            }catch(exp){console.log(exp)
              return 'Un probleme est survenue'
            
            }
          },
          Login:async (_,{Email,Password})=>{
            
            try{
              
              
              var user=await User.findOne({Email:Email}).populate('Role').populate('IdEnt');
              
              if(user==null){
               return null
              }if(user.IsVerified==false){
                return{Msg:'verifier votre Compte  '}

              }else{
                const token = jsonwebtoken.sign(
                  { id: user.id, email: user.email},
                  'hdfjfke',
                  { expiresIn: '1m'})
                if(await bcrypt.compare(Password,user.Password)==true){
                  console.log(user.Nom)
                  return{user,token}
                }else{
                  return null
                }
              }



            }catch(exp){console.log(exp)}
          },
          SuspendUser:async(_,{IdUser,Stat})=>{
            try{
              
              if(Stat==0){
             var user = await User.findByIdAndUpdate(IdUser,{
               $set:{
                Suspended:true
               }
             });
             let info = await transporter.sendMail({
              from: '"SmallB 🏬" <ghaith1997@live.com>', // sender address
              to:user.Email, // list of receivers
              subject: "Votre Compte a été Temporairement Suspendu", // Subject line
              
               text:"Votre Compte a été Temporairement Suspendu.",// plain text body
              html: "<H3>Votre Compte a été Temporairement Suspendu.</H3>"
              + 'Bonjour, votre compte a été temporairement suspendu,'+'<br/>'+ 'veuillez nous envoyer un email ou répondre à ce mail.'
            
              , // html body
            });
            return true;
          }else{
              var user = await User.findByIdAndUpdate(IdUser,{
                $set:{
                 Suspended:false
                }
              });
              return true;
             }
            
          
            
             
            }catch(e){
              console.log(e);
              return false}
          },
		  ResendCode:async(_,{IdUser})=>{
			  try{
				  var user= await User.findById(IdUser);
				  if(user!=null&&user.verifyingcode!=null){
					  let info = await transporter.sendMail({
                from: '"SmallB 🏬" <ghaith1997@live.com>', // sender address
                to:user.Email, // list of receivers
                subject: "Réinitialiser le mot de passe", // Subject line
                
                 text:"Une réinitialisation du mot de passe de votre compte a été demandée.",// plain text body
                html: "<H3>Une réinitialisation du mot de passe de votre compte a été demandée.</H3>"
                +"<p>"+"Bonjour &nbsp"+user['Nom']+"<br>"+"Une réinitialisation du mot de passe de votre compte a été demandée <br> votre code de réinitialisation est : &nbsp"+"<b>"+ +user.verifyingcode 
                +"</b>"+"<br>Remarque : ce code est valable pendant 12 heures. Après expiration de ce délai, vous devrez soumettre une nouvelle demande de réinitialisation de mot de passe."+"</p>"
                , // html body
              });
            
              console.log("Message sent: %s", info.messageId);
              
            
              
              console.log("Preview URL: %s", nodemailer.getTestMessageUrl(info));
					  return true
				  }else{
            console.log(user.Email)
					  return false
					  
				  }
			  }catch(exp){
				  console.log(exp);
			  }
		  }


        }


};
module.exports= resolvers;

