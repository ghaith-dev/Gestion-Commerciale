const mongoose = require('mongoose');
const MongoClient = require('mongodb').MongoClient;

const connectDB = async() =>{
 

    try{
        
        const conn = await mongoose.connect(`mongodb+srv://ghaith:09866614@cluster0.ljj7z.mongodb.net/GestionCommercial?retryWrites=true&w=majority`,{
            
        usedNewUrlParser:true,
        useUnidiedTopology:true,
        useFindAndModify:false
        }) 
        console.log('Connected:',conn.connection.host)
    }catch(err){
        console.log(err) 
        Process.exit(1)}
}

 
module.exports=connectDB;

