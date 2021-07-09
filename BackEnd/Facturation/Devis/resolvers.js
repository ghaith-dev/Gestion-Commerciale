const Devis = require('./Devis.js');
const BonDeCommande = require('../../Facturation/Bon de Commande/Bon de commande');

const nodemailer = require("nodemailer");

const Articlee = require('../../Vente&Achat/Article/Article');
const Commande = require('../../Vente&Achat/Commende/Commende');

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
        
        GetDevis:async (_,{IdEnt})=>{
            var id=ObjectId(IdEnt)
            try{
              console.log(IdEnt)
               return await Devis.find({IdEnt:id}).populate('IdEnt').populate('Client').populate('Articles');

 
            }catch(exp){
                
                console.log(exp);
            }

        }


    },
    Mutation:{
        CreateDevis:async (_,{Articles,Client,IdEnt,Quant})=>{
            try{
                var Totaleht=0;
              console.log(Articles);
              console.log(Quant);
 
                 var article =  await Articlee.find({_id:Articles});

               
                 for(let i=0;i<article.length;i++){
                     Totaleht=Totaleht+(Number.parseFloat( article[i].PrixVente)*Quant[i]);
                                      }
                                      console.log('fff')
                    var devis=  new Devis({Articles:Articles,TotaleHT:Totaleht,TotaleTTC:(Totaleht*1.19),Client:Client,IdEnt:IdEnt,qtt:Quant}).save()
                return 1
                  
 
             }catch(exp){
                 
                 console.log(exp) ;
                 return -1;
                 
             }
 

        },
        SendDevisToClient:async(_,{IdDevis})=>{
            try{
                var devis= await (await (await (await Devis.findOne({_id:IdDevis}).populate('Client').populate('IdEnt').populate('Articles'))));
                
               var items=[];
               for(let j=0; j<devis.Articles.length;j++){
                   items[j]=devis.Articles[j]
                  
               }
               var rows = items.map(({refArticle, Label, PrixVente,items},index) =>
               `
               <tr>
               <td>${refArticle}</td>
              <td>${Label}</td>
              <td>${devis.qtt[index]}</td>
              <td>${PrixVente+" DT"}</td>
              <td>${PrixVente*devis.qtt[index]+" DT"}</td>
              td>${(PrixVente*devis.qtt[index]+" DT")*1.19}</td>
              </tr>
              `).join('');

               
               console.log(rows);
               let info = await transporter.sendMail({
                    from: '"SmallB 🏬" <ghaith1997@live.com>', // sender address
                    to:`${devis.Client.Email}`, // list of receivers
                    subject: ` votre Devis N° ${devis.refDevis}`, // Subject line
                    
                     text:"Bienvenue a SmallB votre compte est creer avec succès",// plain text body
                    html: `<html><head></head>
                    <body>
                        <p style="text-align: left;">
                        ${devis.IdEnt.NomLegal}</br>
                         Téléphone:${devis.IdEnt.Phone}  </br>
                         Email:${devis.IdEnt.Email}</br>
                         FAX:${devis.IdEnt.Fax}</br>
                        </p>
                        <p style="text-align: left;">
                            <H3>Client:${devis.Client.Nom+" "+devis.Client.Prenom}</H3>
                            <H3>Devis N°:${devis.refDevis}</H3>
                        </p>
                        
                
                        
                        <table border="1" style="border-collapse :collapse;">
                          
                          <tr>
                            <th>ref</th>
                            <th>Label</th>
                            <th>Qtt</th>
                            <th>PU</th>
                            <th>Totale </th>
                            
                        
                        
                       ${ rows}
                      
                         
                             
                             <td colspan="3"><H4>TotaleTTC:<p>${devis.TotaleTTC+" DT"}<p></H4></td>
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
             
        },
        TrnsformBonDeCommande:async(_,{IdDevis})=>{
            try{
                
                  var devis= (await Devis.findOne({_id:IdDevis}).populate('IdEnt').populate('Client'));
                  var commande=  await new Commande({TotalHT:devis.TotaleHT,TotalTTC:devis.TotaleTTC,Article:devis.Articles,Quant:devis.qtt,IdEnt:devis.IdEnt._id,Client:devis.Client._id}).save();
                  var bonDeCommande=  new BonDeCommande({Commande:commande._id,Client:commande.Client,IdEnt:commande.IdEnt}).save()
              
                  return true
  
              }catch(exp){
                  
                  console.log(exp);
                  return false
              }
        } 
    }
}
module.exports=resolvers;