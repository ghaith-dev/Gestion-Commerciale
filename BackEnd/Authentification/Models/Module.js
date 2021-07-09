var mongoose =require('mongoose');
const Module =mongoose.model('Module',{ 
    libelle:{type:String,default:null},
    SubModule:[{type:String}]
});
module.exports=Module;