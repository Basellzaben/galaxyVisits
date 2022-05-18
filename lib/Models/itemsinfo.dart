class itemsinfo {
  double price;
  String Item_Name,Ename;
  String Unit;
  String Item_No;
  String barcode;

  itemsinfo({required this.price, required this.Item_Name, required this.Unit
  ,required this.Item_No, required this.barcode,required this.Ename
  });

  factory itemsinfo.fromJson(Map<String, dynamic> json) {
    return itemsinfo(
      price: json['price'],
      Item_Name: json['Item_Name'],
      Ename: json['Ename'],
      Unit: json['Unit'],
      Item_No: json['Item_No'],
      barcode: json['barcode'],
    );
  }
}