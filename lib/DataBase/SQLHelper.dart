import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:galaxyvisits/GlobalVaribales.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:collection/collection.dart';
class SQLHelper {



  static Future<void> createTables(sql.Database database) async {

    await database.execute("""CREATE TABLE IF NOT EXISTS Customers(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        name TEXT,person_name TEXT,no FLOAT NOT NULL)""");

    await database.execute("""CREATE TABLE IF NOT EXISTS Items(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        name TEXT,unit TEXT,price double,no TEXT NOT NULL,barcode TEXT)""");
    await database.execute("""CREATE TABLE IF NOT EXISTS Images(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        ImgBase64 TEXT NOT NULL)""");
    await database.execute("""CREATE TABLE IF NOT EXISTS ItemsSelected(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        Qty INTEGER,ItemNo TEXT NOT NULL,name TEXT,OrderQty INTEGER,ExpiryDate TEXT)""");


    await database.execute("""CREATE TABLE IF NOT EXISTS visited(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,orederno double,
        name TEXT,date TEXT,time TEXT)""");

  }

  static Future<void> deletevisit() async {
    final db = await SQLHelper.db();
    try {
      await db.delete("visited");
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }
  static Future<List<Map<String, dynamic>>> searchvisited(String? search) async {
    final db = await SQLHelper.db();
    if(search!=null)
      if (search.length > 0)
        return db.query('visited', orderBy: "id",
            where: " name" + " LIKE  '%" + search + "%'");

    if(search=="all")
      return db.query('visited', orderBy: "id");

    return db.query('visited', orderBy: "id");

  }


  static Future<List<Map<String, dynamic>>> searchvisiteddate(String? search) async {

   // Globalvireables.date="";


    final db = await SQLHelper.db();
    if(search!=null)
      if (search.length > 0)
        return db.query('visited', orderBy: "id",
            where: " date" + " LIKE  '%" + search + "%'");

    if(search=="all")
      return db.query('visited', orderBy: "id");

    return db.query('visited', orderBy: "id");

  }

  static Future<List<Map<String, dynamic>>> GetVisited() async {
    final db = await SQLHelper.db();
    return db.query('visited', orderBy: "id");
  }
  static Future<int> createvisit(double orederno,String name,String date,String time) async {
    final db = await SQLHelper.db();

    final data = await { 'orederno': orederno,
      'name': name,
      'date': date,
      'time': time
    };
    final id = await db.insert('visited', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }


  static Future<void> UPDATETables(sql.Database database) async {

  }


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

  static Future<int> createCustomers(String name, String person ,double no) async {
    final db = await SQLHelper.db();

    final data = await { 'name': name, 'person_name': person,'no':no };
    final id = await db.insert('Customers', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }
  static Future<int> createitems(String name, String unit,double price ,String no,String barcode) async {
    final db = await SQLHelper.db();

    final data = { 'name': name, 'unit': unit,'no':no ,'price':price,'barcode':barcode};
    final id = await db.insert('Items', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<int> createImage(String base) async {
    final db = await SQLHelper.db();

    final data = await { 'ImgBase64': base};
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
    *//*final db = await SQLHelper.db();
    var x = await db.query('SELECT COUNT (*) from Customers');
        int? count =await Sqflite.firstIntValue(x);

   // int? count = await Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM Customers'));
*//*

    final db = await SQLHelper.db();
    var result = await db.query("Customers");
     result = db.query('Customers', orderBy: "id");

    print(result.length.toString()+"  counttt");

    Globalvireables.sizeCustomers = result.length;

}*/

  static Future<List<Map<String, dynamic>>> search(String? search) async {
    final db = await SQLHelper.db();
    if(search!=null)
      if (search.length > 0)
        return db.query('Items', orderBy: "id",
            where: " name" + " LIKE  '%" + search + "%'" +"or"+" barcode" + " LIKE  '%" + search + "%'");

    if(search=="All")
      return db.query('Items', orderBy: "id");

    return db.query('Items', orderBy: "id");

  }
  static Future<List<Map<String, dynamic>>> searchbar(String? search) async {
    final db = await SQLHelper.db();
    if(search!=null)
      if (search.length > 0)
        return db.query('Items', orderBy: "id",
            where: " barcode" + " LIKE  '%" + search + "%'");

    if(search=="All")
      return db.query('Items', orderBy: "id");

    return db.query('Items', orderBy: "id");

  }
  static Future<List<Map<String, dynamic>>> searchCustomers(String? search) async {
    final db = await SQLHelper.db();
    if(search!=null)
      if (search.length > 0)
        return db.query('Customers', orderBy: "id",
            where: " name" + " LIKE  '%" + search + "%'");

    if(search=="All")
      return db.query('Customers', orderBy: "id");

    return db.query('Customers', orderBy: "id");

  }


  static Future<List<Map<String, dynamic>>> itemSelected(String ItemNo) async {
    final db = await SQLHelper.db();
        return db.query('ItemsSelected', orderBy: "id",
            where: " ItemNo = "+ItemNo+"");

  }

  static Future<int> selectItem(String name, int Qty ,String no,int OrderQty,String ExpiryDate) async {
    final db = await SQLHelper.db();

    final data = await { 'name': name, 'Qty': Qty,'ItemNo':no
      ,'OrderQty':OrderQty,'ExpiryDate':ExpiryDate};
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
    return db.query('ItemsSelected', orderBy: "id"/*,columns: ["Qty","no"]*/);
  }
  static Future<List<Map<String, dynamic>>> GetSelectedItemFORPOST() async {
    final db = await SQLHelper.db();
    return db.query('ItemsSelected', orderBy: "id",columns: ["Qty","ItemNo","OrderQty","ExpiryDate"]);
  }

  static Future<List<Map<String, dynamic>>> GetImgsFORPOST() async {
    final db = await SQLHelper.db();
    return db.query('Images', orderBy: "id",columns: ["ImgBase64"]
    );

  }

  static Future<int> updateItem(int Qty,int id,int OrderQty,String ExpiryDate) async {
    final db = await SQLHelper.db();

    final data = {
      'Qty': Qty,
      'OrderQty': OrderQty,
      'ExpiryDate': ExpiryDate
    };

    final result =
    await db.update('ItemsSelected', data, where: "id = '"+id.toString()+"'");

    return result;
  }

  static Future<void> deleteselectedItem(String ItemNo) async {
    final db = await SQLHelper.db();
    try {
      await db.delete("ItemsSelected", where: "ItemNo = "+ItemNo+"");
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