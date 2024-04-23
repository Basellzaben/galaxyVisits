// ignore_for_file: curly_braces_in_flow_control_structures, non_constant_identifier_names

import 'package:flutter/foundation.dart';
import 'package:galaxyvisits/Models/UserDefinitionModel.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqflite.dart';

class SQLHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE IF NOT EXISTS Customers(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        name TEXT,person_name TEXT,no FLOAT NOT NULL,branchid INTEGER , locX TEXT,locY TEXT)""");

    await database.execute("""CREATE TABLE IF NOT EXISTS Items(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        name TEXT,unit TEXT,price double,no TEXT NOT NULL,barcode TEXT)""");
    await database.execute("""CREATE TABLE IF NOT EXISTS Images(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        ImgBase64 TEXT NOT NULL)""");
    await database.execute("""CREATE TABLE IF NOT EXISTS ItemsSelected(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        Qty INTEGER,ItemNo TEXT NOT NULL,name TEXT,OrderQty INTEGER,ExpiryDate TEXT,Note TEXT)""");

    await database.execute("""CREATE TABLE IF NOT EXISTS visited(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,orederno double,
        name TEXT,date TEXT,time TEXT,Note TEXT,endTime TEXT)""");
    await database.execute('''
        CREATE TABLE Payload (
          id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
          Start_Time TEXT,
          End_Time TEXT,
          CusNo REAL,
          ManNo INTEGER,
          X_Lat TEXT,
          Y_Long TEXT,
          DayNum INTEGER,
          Tr_Data TEXT,
          Note TEXT,
          Loct TEXT,
          Duration TEXT,
          CustomersStockModelList TEXT,
          VisitsImageList TEXT
        )
      ''');
      await database.execute(
        'CREATE TABLE IF NOT EXISTS payloadItems (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, Qty INTEGER, ItemNo TEXT, OrderQty INTEGER, ExpiryDate TEXT, Note TEXT,itemName TEXT , payloadId INTEGER)',
      
      );
      await database.execute(
        'CREATE TABLE IF NOT EXISTS payloadImages (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, ImgBase64 TEXT, payloadId INTEGER)',
      );
    await database.execute('''
        CREATE TABLE Settings (
          id INTEGER PRIMARY KEY,
          isOpen INTEGER,
          cusNo REAL,
          cusName TEXT
        )
      ''');
    await database.execute(
      'CREATE TABLE IF NOT EXISTS Time (id INTEGER PRIMARY KEY, start_time TEXT, end_time TEXT)',
    );
    await database.execute('''
    CREATE TABLE IF NOT EXISTS UserDefinition (
      Id INTEGER PRIMARY KEY,
      CompanyId INTEGER,
      NameA TEXT,
      NameE TEXT,
      UserName TEXT,
      Password TEXT,
      GroupID INTEGER,
      Tel TEXT,
      Email TEXT,
      Image TEXT,
      IsActive bool,
      RequireChangePassword bool,
      TypeRep INTEGER,
      IP_Device  TEXT
    )
  ''');

    await database.rawInsert(
        'INSERT INTO Time (id, start_time, end_time) VALUES (?, ?, ?)',
        [1, '00', '00']);

    // Insert initial data if needed
    await database.insert(
        'Settings', {'isOpen': 0, 'cusNo': 0.0, 'cusName': 'حدد العميل'});
  }
    static Future<void> setPayloadItems(int payloadId, List<Map<String, dynamic>> items) async {
    final db = await SQLHelper.db();
    Batch batch = db.batch();
      List<Map<String, dynamic>> itemsselect= await GetSelectedItem();

    for (Map<String, dynamic> item in items) {
      String name = '';

      for (Map<String, dynamic> map in itemsselect) {
  if (map['ItemNo'] == item['ItemNo']) {
    name = map['name'];
    break; // Exit the loop since we found the match
  }
}
      batch.insert('PayloadItems', {
        'Qty': item['Qty'],
        'ItemNo': item['ItemNo'],
        'OrderQty': item['OrderQty'],
        'ExpiryDate': item['ExpiryDate'],
        'itemName': name,
        'Note': item['Note'],
        'PayloadId': payloadId,
      });
    }
    await batch.commit();
  }
  static Future<void> setPayloadImages(int payloadId, List<Map<String, dynamic>> images) async {
    final db = await SQLHelper.db();
    Batch batch = db.batch();
    for (Map<String, dynamic> image in images) {
      batch.insert('PayloadImages', {
        'ImgBase64': image['ImgBase64'],
        'PayloadId': payloadId,
      });
    }
    await batch.commit();
  }
  static Future<void> deleteItemById(int id) async {
    final db = await SQLHelper.db();
    await db.delete('PayloadItems' , where: 'payloadId = ?', whereArgs: [id]);
  }
  static Future<void> deleteImageById (int id) async {
    final db = await SQLHelper.db();
    await db.delete('PayloadImages' , where: 'payloadId = ?', whereArgs: [id]);
  }
  //get all payload items by payload id
  static Future<List<Map<String, dynamic>>> getPayloadItems(int payloadId) async {
    final db = await SQLHelper.db();
    return db.query('PayloadItems', where: 'PayloadId = ?', whereArgs: [payloadId]);
  }
  //get all payload images by payload id
  static Future<List<Map<String, dynamic>>> getPayloadImages(int payloadId) async {
    final db = await SQLHelper.db();
    return db.query('PayloadImages', where: 'PayloadId = ?', whereArgs: [payloadId]);
  }
  // remove data from userdefintion
  static Future<void> clearUserDefinition() async {
    final db = await SQLHelper.db();
    await db.delete('UserDefinition');
  }

 static Future<void> setUserDefinition(UserDefinition user) async {
    final db = await SQLHelper.db();
  await db.insert('UserDefinition', user.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace);
}

 static Future<UserDefinition?> checkLoginAndGetUserData(String username, String password) async {
    final db = await SQLHelper.db();
  List<Map<String, dynamic>> result = await db.rawQuery(
      "SELECT * FROM UserDefinition WHERE UserName = ? AND Password = ?",
      [username, password]);
      // print all value in userdefintion
      print( await db.query('UserDefinition'));

  if (result.isNotEmpty) {
    // User with the provided credentials exists, return the user data
    print(result.first);

    UserDefinition user = UserDefinition.fromJson(result.first);
    return user;
  } else {
    // User does not exist or credentials are incorrect
    return null;
  }
}
static Future<void> clearUserData() async {
    final db = await SQLHelper.db();
  await db.delete('UserDefinition');
}
  static Future<void> clearData() async {
    final db = await SQLHelper.db();
    ;
    await db.delete('Time');
  }

  static Future<String> getStartTime() async {
    final db = await SQLHelper.db();
    List<Map<String, dynamic>> results =
        await db.query('Time', where: 'id = ?', whereArgs: [1]);
    if (results.isNotEmpty) {
      return results.first['start_time'];
    }
    return "00:00";
  }

  static Future<String> getEndTime() async {
    final db = await SQLHelper.db();
    List<Map<String, dynamic>> results =
        await db.query('Time', where: 'id = ?', whereArgs: [1]);
    if (results.isNotEmpty) {
      return results.first['end_time'];
    }
    return "00:00";
  }

  static Future<void> saveStartTime(String startTime) async {
    final db = await SQLHelper.db();
    int rowsUpdated = await db
        .rawUpdate('UPDATE Time SET start_time = ? WHERE id = 1', [startTime]);

    if (rowsUpdated == 0) {
      await db.rawInsert(
          'INSERT INTO Time (id, start_time, end_time) VALUES (?, ?, ?)',
          [1, startTime, '00:00']);
    }
  }

  static Future<void> saveEndTime(String endTime) async {
    final db = await SQLHelper.db();
    await db.rawUpdate('UPDATE Time SET end_time = ? WHERE id = 1', [endTime]);
  }

  static Future<void> updateCusNo(double newCusNo) async {
    final db = await SQLHelper.db();
    await db.update('Settings', {'cusNo': newCusNo});
  }

  static Future<void> updateCusName(String newCusName) async {
    final db = await SQLHelper.db();
    await db.update('Settings', {'cusName': newCusName});
  }

  static Future<void> updateIsOpen(int newIsOpen) async {
    final db = await SQLHelper.db();
    await db.update('Settings', {'isOpen': newIsOpen});
  }

  static Future<Map<String, dynamic>> getSettings() async {
    final db = await SQLHelper.db();
    List<Map<String, dynamic>> result = await db.query('Settings');
    if (result.isNotEmpty) {
      return result.first;
    }
    return {}; // Return empty map if no data found
  }

  static Future<void> clearSettings() async {
    final db = await SQLHelper.db();
    await db.delete('Settings');
  }

static Future<int> insertPayload(Map<String, dynamic> payload) async {
  final db = await SQLHelper.db();
  int id = await db.insert('Payload', payload);
  return id;
}

  static Future<List<Map<String, dynamic>>> getAllPayloads() async {
    final db = await SQLHelper.db();
    return await db.query('Payload');
  }
static Future<Map<String, dynamic>> getPayloadById(int id) async {
  final db = await SQLHelper.db();
  List<Map<String, dynamic>> payloads = await db.query('Payload', where: 'id = ?', whereArgs: [id]);
  if (payloads.isNotEmpty) {
    return payloads.first;
  } else {
    return {};
  }
}
  static Future<int> deletePayloadById(int id) async {
    final db = await SQLHelper.db();
    return await db
        .delete('Payload' , where: 'id = ?', whereArgs: [id]);
  }

  static Future<void> deletevisit() async {
    final db = await SQLHelper.db();
    try {
      await db.delete("visited");
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }

  static Future<List<Map<String, dynamic>>> searchvisited(
      String? search) async {
    final db = await SQLHelper.db();
    if (search != null) if (search.isNotEmpty) {
      return db.query('visited',
          orderBy: "id", where: " name" " LIKE  '%" + search + "%'");
    }

    if (search == "all") {
      return db.query('visited', orderBy: "id");
    }

    return db.query('visited', orderBy: "id");
  }

  static Future<List<Map<String, dynamic>>> searchvisiteddate(
      String? search) async {
    // Globalvireables.date="";

    final db = await SQLHelper.db();
    if (search != null) if (search.isNotEmpty) {
      return db.query('visited',
          orderBy: "id", where: " date" " LIKE  '%" + search + "%'");
    }

    if (search == "all") {
      return db.query('visited', orderBy: "id");
    }

    return db.query('visited', orderBy: "id");
  }

  static Future<List<Map<String, dynamic>>> GetVisited() async {
    final db = await SQLHelper.db();

    return db.query('visited', orderBy: "id");
  }

  static Future<int> createvisit(
      double orederno, String name, String date, String time,String endTime) async {
    final db = await SQLHelper.db();

    final data = {
      'orederno': orederno,
      'name': name,
      'date': date,
      'time': time,
      'endTime': endTime,
    };
    final id = await db.insert('visited', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<void> UPDATETables(sql.Database database) async {}

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'galaxy.db',
      version: 32,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        var batch = db.batch();
        if (oldVersion < newVersion) {
          await UPDATETables(db);
        }
        await batch.commit();
      },
    );
  }

  static Future<List<Map<String, dynamic>>> GetCustomers() async {
    final db = await SQLHelper.db();
    return db.query('Customers', orderBy: "id");
  }

  static Future<List<Map<String, dynamic>>> GetImgs() async {
    final db = await SQLHelper.db();
    return db.query('Images', orderBy: "id");
  }

  static Future<List<Map<String, dynamic>>> GetItems() async {
    final db = await SQLHelper.db();
    return db.query('Items', orderBy: "id");
  }

  static Future<int> createCustomers(String name, String person, int no,
      int? branchid, String locX, String locY) async {
    final db = await SQLHelper.db();

    final data = {
      'name': name,
      'person_name': person,
      'no': no,
      'branchid': branchid,
      'locX': locX,
      'locY': locY
    };
    final id = await db.insert('Customers', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<int> createitems(
      String name, String unit, double price, String no, String barcode) async {
    final db = await SQLHelper.db();

    final data = {
      'name': name,
      'unit': unit,
      'no': no,
      'price': price,
      'barcode': barcode
    };
    final id = await db.insert('Items', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<int> createImage(String base) async {
    final db = await SQLHelper.db();

    final data = {'ImgBase64': base};
    final id = await db.insert('Images', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  // Delete
  static Future<void> deleteCustomers() async {
    final db = await SQLHelper.db();
    try {
      await db.delete("Customers");
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }

  static Future<void> deleteitems() async {
    final db = await SQLHelper.db();
    try {
      await db.delete("Items");
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }
/*  static  getCountCustomers() async {
    //database connection
    */ /*final db = await SQLHelper.db();
    var x = await db.query('SELECT COUNT (*) from Customers');
        int? count =await Sqflite.firstIntValue(x);

   // int? count = await Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM Customers'));
*/ /*

    final db = await SQLHelper.db();
    var result = await db.query("Customers");
     result = db.query('Customers', orderBy: "id");

    print(result.length.toString()+"  counttt");

    Globalvireables.sizeCustomers = result.length;

}*/

  static Future<List<Map<String, dynamic>>> search(String? search) async {
    final db = await SQLHelper.db();
    if (search != null) if (search.isNotEmpty) {
      return db.query('Items',
          orderBy: "id",
          where: " name" " LIKE  '%" +
              search +
              "%'" +
              "or" +
              " barcode" +
              " LIKE  '%" +
              search +
              "%'");
    }

    if (search == "All") {
      return db.query('Items', orderBy: "id");
    }

    return db.query('Items', orderBy: "id");
  }

  static Future<List<Map<String, dynamic>>> searchbar(String? search) async {
    final db = await SQLHelper.db();
    if (search != null) if (search.isNotEmpty) {
      return db.query('Items',
          orderBy: "id", where: " barcode" " LIKE  '%" + search + "%'");
    }

    if (search == "All") {
      return db.query('Items', orderBy: "id");
    }

    return db.query('Items', orderBy: "id");
  }

  static Future<List<Map<String, dynamic>>> searchCustomers(
      String? search) async {
    final db = await SQLHelper.db();
    if (search != null) if (search.isNotEmpty) {
      return db.query('Customers',
          orderBy: "id", where: " name" " LIKE  '%" + search + "%'");
    }

    if (search == "All") {
      return db.query('Customers', orderBy: "id");
    }

    return db.query('Customers', orderBy: "id");
  }

  static Future<List<Map<String, dynamic>>> itemSelected(String ItemNo) async {
    final db = await SQLHelper.db();
    return db.query('ItemsSelected',
        orderBy: "id", where: " ItemNo = " + ItemNo + "");
  }

  static Future<int> selectItem(String name, int Qty, String no, int OrderQty,
      String ExpiryDate, String Note) async {
    final db = await SQLHelper.db();

    final data = {
      'name': name,
      'Qty': Qty,
      'ItemNo': no,
      'OrderQty': OrderQty,
      'ExpiryDate': ExpiryDate,
      'Note': Note
    };
    final id = await db.insert('ItemsSelected', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<void> clearItemsSelected() async {
    final db = await SQLHelper.db();
    try {
      await db.delete("ItemsSelected");
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }

  static Future<void> clearImagesSelected() async {
    final db = await SQLHelper.db();
    try {
      await db.delete("Images");
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }

  static Future<List<Map<String, dynamic>>> GetSelectedItem() async {
    final db = await SQLHelper.db();
    return db.query('ItemsSelected', orderBy: "id" /*,columns: ["Qty","no"]*/);
  }

  static Future<List<Map<String, dynamic>>> GetSelectedItemFORPOST() async {
    final db = await SQLHelper.db();
    return db.query('ItemsSelected',
        orderBy: "id",
        columns: ["Qty", "ItemNo", "OrderQty", "ExpiryDate", "Note"]);
  }

  static Future<List<Map<String, dynamic>>> GetImgsFORPOST() async {
    final db = await SQLHelper.db();
    return db.query('Images', orderBy: "id", columns: ["ImgBase64"]);
  }

  static Future<int> updateItem(
      int Qty, int id, int OrderQty, String ExpiryDate, String Note) async {
    final db = await SQLHelper.db();

    final data = {
      'Qty': Qty,
      'OrderQty': OrderQty,
      'ExpiryDate': ExpiryDate,
      "Note": Note
    };

    final result = await db.update('ItemsSelected', data,
        where: "id = '" + id.toString() + "'");

    return result;
  }

  static Future<void> deleteselectedItem(String ItemNo) async {
    final db = await SQLHelper.db();
    try {
      await db.delete("ItemsSelected", where: "ItemNo = " + ItemNo + "");
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }

  static Future<void> deleteImage(int id) async {
    final db = await SQLHelper.db();
    try {
      await db.delete("Images", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }
}
