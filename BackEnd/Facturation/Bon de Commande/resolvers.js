const BonDeCommande = require('./Bon de commande.js');
const nodemailer = require("nodemailer");

const Article = require('../../Vente&Achat/Article/Article');

var ObjectId = require('mongoose').Types.ObjectId;
const { forEachField } = require('graphql-tools');
let transporter = nodemailer.createTransport({
    host: "smtp-mail.outlook.com",
    port: 587,
    secure: false, // true for 465, false for other ports
    auth: {
      user: 'ghaith1997@live.com', // generated ethereal user
      pass: '@@Ghaith', // generated ethereal password
    },
  });
  htmlerender=()=>{
for(let i=0;i<4;i++){
     `
     <td>ref</td>
    <td>Label</td>
    <td>Qtt</td>
    <td>PU</td>
    <td>Totale HT</td>
    <td>Totale HT</td>
    `
    
}
  };
const resolvers={
    Query:{
        
        GetBonDeCommande:async (_,{IdEnt})=>{
            var id=ObjectId(IdEnt)
            try{
              console.log(IdEnt)
                var x= await BonDeCommande.find().populate('Client').populate('IdEnt').populate({path:'Commande',populate:'Article'});
console.log(x);
                return x;
            }catch(exp){
                
                console.log(exp);
            }

        }


    },
    Mutation:{
        CreateBonDeCommande:async (_,{Commande,Client,IdEnt})=>{
            try{
              
              
 
                

               
                
                    var bonDeCommande=  new BonDeCommande({Commande:Commande,Client:Client,IdEnt:IdEnt}).save()
               
                    return 1
                  
 
             }catch(exp){
                 
                 console.log(exp) ;
                 return -1;
                 
             }
 

        },
        SendBonDeCommandeToClient:async(_,{IdBonDC})=>{
            try{
                var bonDeCommande= await (await (await (await BonDeCommande.findOne({_id:IdBonDC}).populate('Client').populate('IdEnt').populate({path:'Commande',populate:'Article'}))));
                
               var items=[];
              for(let j=0; j<bonDeCommande.Commande.Article.length;j++){
                   items[j]=bonDeCommande.Commande.Article[j]
                  
               }
               var rows = items.map(({refArticle, Label, PrixVente,items},index) =>
               `
               <tr>
               <td>${refArticle}</td>
              <td>${Label}</td>
              <td>${bonDeCommande.Commande.Quant[index]}</td>
              <td>${PrixVente+" DT"}</td>
              <td>${PrixVente*bonDeCommande.Commande.Quant[index]+" DT"}</td>
              td>${(PrixVente*bonDeCommande.Commande.Quant[index]+" DT")*1.19}</td>
              </tr>
              `).join('');

               
               console.log(rows);
              let info = await transporter.sendMail({
                    from: '"SmallB 🏬" <ghaith1997@live.com>', // sender address
                    to:`${bonDeCommande.Client.Email}`, // list of receivers
                    subject: ` Votre Bon de commande N° ${bonDeCommande.refBonDC}`, // Subject line
                    
                     text:"Bienvenue a SmallB votre compte est creer avec succès",// plain text body
                    html: `<html><head></head>
                    <body>
                        <p style="text-align: left;">
                      ${bonDeCommande.IdEnt.NomLegal}</br>
                         Téléphone:${bonDeCommande.IdEnt.Phone}  </br>
                         Email:${bonDeCommande.IdEnt.Email}</br>
                         FAX:${bonDeCommande.IdEnt.Fax}</br>
                        </p>
                        <p style="text-align: left;">
                            <H3>Client:${bonDeCommande.Client.Nom+" "+bonDeCommande.Client.Prenom}</H3>
                            <H3>Devis N°:${bonDeCommande.refBonDC}</H3>
                        </p>
                        
                
                        
                        <table border="1" style="border-collapse :collapse;">
                          
                          <tr>
                            <th>ref</th>
                            <th>Label</th>
                            <th>Qtt</th>
                            <th>PU</th>
                            <th>Totale </th>
                            
                        
                        
                       ${ rows}
                      
                         
                             
                             <td colspan="5"><H4>TotaleTTC:<p>${bonDeCommande.Commande.TotalTTC+" DT"}<p></H4></td>
                         </tr>
                        </table>
                    </body>
                </html>`
                    , // html body
                  });
                
                  console.log("Message sent: %s", info.messageId);
                  
                
                  
                  console.log("Preview URL: %s", nodemailer.getTestMessageUrl(info));
                  
                return true;
                  
 
             }catch(exp){
                 
                 console.log(exp) ;
                 return false;
                 
             }
        }
        
    }
}
module.exports=resolvers;