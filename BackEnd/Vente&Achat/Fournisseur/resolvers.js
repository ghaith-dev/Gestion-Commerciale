const Fournisseur = require('./Fournisseur.js');
const nodemailer = require("nodemailer");
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
    Query:{
        GetFournisseurs:async (_,{IdEnt})=>{
            try{
              var fournisseur = await Fournisseur.find({IdEnt:IdEnt});
               return fournisseur;


            }catch(exp){
                
                throw new exp;
            }

        },
        GetFournisseur:async (_,{Nom,IdEnt})=>{
            try{
              var fournisseur = await Fournisseur.find({'Nom':new RegExp(Nom, 'i'),IdEnt:IdEnt});
             
               return fournisseur;


            }catch(exp){
                
                throw new exp;
            }

        }


    },
    Mutation:{
        CreateFournisseur:async (_,{Nom,Prenom,Email,Phone,NomEntreprise,Civility,Comment,IdEnt})=>{
            try{
                var fournisseur = await Fournisseur.findOne({Email:Email});
                if(fournisseur==null)
              {var fournisseur = await new Fournisseur({Nom:Nom,Prenom:Prenom,Email:Email,Phone:Phone,NomEntreprise:NomEntreprise,Civility:Civility,Comment:Comment,IdEnt:IdEnt}).save();
               return 1;}else
               return 0


            }catch(exp){
                
                console.log(exp) ;
                return -1;
                
            }

        },
        UpdateFournisseur:async (_,{IdFournisseur,Nom,Prenom,Email,Phone,Civility,NomEntreprise,Comment})=>{
            try{
                var fournisseur = await Fournisseur.findByIdAndUpdate(IdFournisseur,{

                  $set:{
                    Nom:Nom,
                    Prenom:Prenom,
                    Email:Email,
                    Phone:Phone,
                    Civility:Civility,
                    NomEntreprise:NomEntreprise,
                    
                    Comment:Comment
                                      }  
                }
                );
                return true;
                


            }catch(exp){
                
                throw new exp;
                
                
            }

        },
        DeleteFournisseur:async (_,{IdFournisseur})=>{
            try{
                var fournisseur = await Fournisseur.findByIdAndDelete(IdFournisseur) ;
                return true;
            }catch(exp){
                
                throw new exp;
            }
        },
        FournisseurSendMail:async(_,{IdFournisseur,Object,Titel})=>{
            
            try{
                var fournisseur = await Fournisseur.findById(IdFournisseur);
                let info = await transporter.sendMail({
                from: '"SmallB 🏬" <ghaith1997@live.com>', // sender address
                to:fournisseur.Email, // list of receivers
                subject: `${Titel}`, // Subject line
                
                 text:`${Object}`,// plain text body
                html: 
                `<p>${Object}</p>`
                +"</b>"+"<br>Merci de choisier SmallB."+"</p>"
                , // html body
              });
              return true;
            }catch(exp){return false,console.log(exp)}
        }
    }
}
module.exports=resolvers;