class Item {
  int? id;
  String? name;
  String? unit;
  double? price;
  String? no;
  String? barcode;

  Item({this.id, this.name, this.unit, this.price, this.no, this.barcode});

  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
      id: map['id'],
      name: map['name'],
      unit: map['unit'],
      price: map['price'],
      no: map['no'],
      barcode: map['barcode'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'unit': unit,
      'price': price,
      'no': no,
      'barcode': barcode,
    };
  }
}