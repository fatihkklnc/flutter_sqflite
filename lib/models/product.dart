class Product{
  int id;
  String name,description;
  int unitPrice;
  Product({ this.name,this.description, this.unitPrice});
  Product.witdId({this.id, this.name,this.description, this.unitPrice});//aşağıda oluşturulan this olaylarına altarnetif olarak yapılır.

 Map<String,dynamic> toMap(){
   var map=Map<String,dynamic>();
   map["name"]=name;
   map["description"]=description;
   map["unitPrice"]=unitPrice;
   if(id!=null) {
     map["id"] = id;
   }
   return map;
 }
 Product.fromObject(dynamic o){
   this.id=int.tryParse(o["id"].toString());
   this.name=o["name"];
   this.description=o["description"];
   this.unitPrice=int.tryParse(o["unitPrice"].toString());
 }
}