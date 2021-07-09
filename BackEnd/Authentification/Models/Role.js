var mongoose =require('mongoose');
const Role =mongoose.model('Role',{
    libelle:{type:String,enum:['SAdmin','Admin','Employee'],default:'Admin'}
 });
module.exports=Role;