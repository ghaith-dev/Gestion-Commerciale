const Client = require('./Client.js');
var ObjectId = require('mongoose').Types.ObjectId;
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
        GetClients:async (_,IdEnt)=>{
            
            var id=ObjectId(IdEnt['IdEnt'])
            try{
              var client = await  Client.find({IdEnt:id}).populate('IdEnt')
               return client;


            }catch(exp){
                
                console.log(exp);
            }

        },
        GetClient:async (_,{Nom,IdEnt})=>{
            var id=ObjectId(IdEnt)
            try{
              console.log(Nom);
               return await Client.find({Nom:new RegExp(Nom, 'i'),IdEnt:id});


            }catch(exp){
                
                console.log(exp);
            }

        }


    },
    Mutation:{
        CreateClient:async (_,{Nom,Prenom,Email,Phone,Civility,Comment,IdEnt})=>{
            try{
                var client = await Client.findOne({Email:Email});
                if(client==null)
              {var client = await new Client({Nom:Nom,Prenom:Prenom,Email:Email,Phone:Phone,Civility:Civility,Comment:Comment,IdEnt:IdEnt}).save();
               return 1;}else
               return 0


            }catch(exp){
                
                console.log(exp) ;
                return -1;
                
            }

        },
        UpdateClient:async (_,{IdClient,Nom,Prenom,Email,Phone,Civility,Comment})=>{
            try{
                var client = await Client.findByIdAndUpdate(IdClient,{

                  $set:{
                    Nom:Nom,
                    Prenom:Prenom,
                    Email:Email,
                    Phone:Phone,
                    Civility:Civility,
                    
                    Comment:Comment
                                      }  
                }
                );
                return true;
                


            }catch(exp){
                
                throw new exp;
                
                
            }

        },
        DeleteClient:async (_,{IdClient})=>{
            try{
                var client = await Client.findByIdAndDelete(IdClient) ;
                return true;
            }catch(exp){
                
                throw new exp;
            }
        },
        ClientSendMail:async(_,{IdClient,Object,Titel})=>{
            
            try{
                var client = await Client.findById(IdClient);
                let info = await transporter.sendMail({
                from: '"SmallB 🏬" <ghaith1997@live.com>', // sender address
                to:client.Email, // list of receivers
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