const  { ApolloServer, gql } = require('apollo-server-express');
const mongoose=require('mongoose');
const AuthR =require('./Authentification/resolvers');
const AuthT =require('./Authentification/typeDefs');
const multer=require('multer');
const client=require('./Vente&Achat/Client/index');
const Devis=require('./Facturation/Devis/index');
const BonDC=require('./Facturation/Bon de Commande/index');
const Fournisseur=require('./Vente&Achat/Fournisseur/index');
const Comptabilte=require('./Comptabilité/index');

const Category=require('./Vente&Achat/Category/index');
const Article=require('./Vente&Achat/Article/index');
const Stock=require('./Vente&Achat/Stock/index');
const Commende=require('./Vente&Achat/Commende/index');



const Cors = require('cors')


var connectDB = require('./Database');

  



const express = require('express');
const startServer= async () =>{
    const app = express();
    const server = new ApolloServer({
    
    typeDefs:[
        AuthT,
     client.typeDefs,
     Fournisseur.typeDefs,
     Category.typeDefs,
     Article.typeDefs,
     Stock.typeDefs,
     Commende.typeDefs,
     Devis.typeDefs,
     BonDC.typeDefs,
     Comptabilte.typeDefs


    ],
    resolvers:[
        AuthR,
        client.resolvers,
        Fournisseur.resolvers,
        Category.resolvers,
        Article.resolvers,
        Stock.resolvers,
        Commende.resolvers,
        Devis.resolvers,
        BonDC.resolvers,
        Comptabilte.resolvers

        
    ]
    });
    server.applyMiddleware({app});
    app.use('/upload', express.static(__dirname +'/upload'));
    var storage = multer.diskStorage({
        destination: function (req, file, cb) {
          cb(null, 'Images')
        },
        filename: function (req, file, cb) {
          cb(null, '1020'+file.originalname)
        }
      });
    
      var upload = multer({ storage: storage });
     app.post('/upload', upload.single('image'), async(req, res, next) => {
        const file = req.file
       if (!file||file.filename.includes('.jpg','.png','jpeg')==false||file.size<2000){
        const error = new Error('Please upload a file')
        error.httpStatusCode = 400
        
        return next("hey error")
    
      }else{
       
          return next('ok')
      }
    }
       );
       app.use('/Images', express.static(__dirname +'/Images'));
       app.use(Cors());
      app.get('./Images/*',(req,res,next)=>{
        res.setHeader('Access-Control-Allow-Origin', '*');
        res.sendfile('./Images/*')
      });
    await connectDB();
    app.listen({port:3000},()=>
    
    console.log('server running at http://127.0.0.1:3000'+server.graphqlPath)
    );
    
    
    

    
};



startServer();