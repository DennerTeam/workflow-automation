import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gsheets/gsheets.dart';
import 'package:workflow_automation/backend/supabase/database/database.dart';
import 'package:workflow_automation/backend/supabase/database/tables/pg_hostel.dart';
import 'package:workflow_automation/backend/supabase/database/tables/pg_hostel_amenities.dart';
import 'package:workflow_automation/backend/supabase/database/tables/pg_hostel_rent.dart';
import 'package:workflow_automation/backend/supabase/utils/snackbar.dart';
import 'package:workflow_automation/model/pg_hostel.dart';
import 'package:http/http.dart' as http;

class GSheetController extends GetxController {
  // init GSheets
  late final GSheets gsheets;
  // fetch spreadsheet by its id
  Spreadsheet? ss;

  var rowData = Rx<List<PGHostel>>([]);
  var isLoading = false.obs;
  var isDataUploading = false.obs;
  var error = "".obs;

  List<String> columnNames = [
    'name',
    'longitude',
    'latitude',
    'gender',
    'suitedFor',
    'description',
    'photos',
    'contact',
    'email',
    'laundry',
    'mess',
    'cleaning',
    'waterSupply',
    'fridge',
    'gym',
    'geyser',
    'gatedCommunity',
    'waterPurifier',
    'wifi',
    'powerBackup',
    'parking',
    'tv',
    'cctv',
    'lift',
    'singleRent',
    'doubleRent',
    'threePlusRent',
    'threePlusRooms',
    'rules',
    'isUploadedToDB',
  ];

  @override
  void onInit() {
    try {
      String private_key_id =
          const String.fromEnvironment('PRIVATE_KEY_ID', defaultValue: 'NULL');
      String client_id =
          const String.fromEnvironment('CLIENT_ID', defaultValue: 'NULL');
      String client_email =
          const String.fromEnvironment('CLIENT_EMAIL', defaultValue: 'NULL');

      var _credentials = {
        "type": "service_account",
        "project_id": "dennermvp",
        "private_key_id": private_key_id,
        "private_key":
            "-----BEGIN PRIVATE KEY-----\nMIIEvwIBADANBgkqhkiG9w0BAQEFAASCBKkwggSlAgEAAoIBAQDC76gK3BgfpraV\nRpKyssuCrwg6G+MNdbC4AA6fmD0t59OC6P9S2hMTeqEiuu/b+PGCIyOJtMSSyVHQ\nViPINeq5R7QvuK6BuwAM7s/i2iTIn/9i8amL2eZBZQO1CiP2F9FHlYMRczyJJYeV\n39UOhOEcvt1rPUgDQDPltQNcKLQE3T75aTaO+j6ih4X82Uq7BHavBW3DGbVi11Gi\niE7Mu8UW3qF+s8R+3ZWotdMMX9g8Ok5SgttP1Iuh5edVkWGPoyZ8XFJ5KXUUUOyA\npVF29FE+e5dzm32lEpjpA9l6WRjxXLu5BTid7iNP7JGIBPAUEEVcj7CndLWo5MQV\nqB6O+QcbAgMBAAECggEAAho2UXtNSpONco+c7Zp1r/rb1Kybxr16HOZG5QHt9kKC\n0HlEG1IxgwVzpok9aqZiOvfl3lA/mzg3t2X0+tZwkqJxEVPITsJsu0Kc1EWaNN3n\nEdupMRgezPsG69hLVbjyw9/hBS7jE53Eo8QqJUTChYEeM9udEU4W9ZAVCL2CL+OW\ngh/THQvW7CEJ9U/4GPhEoInjKj2/6MIYPJXoEunhkHJrgAGj6VrgHwWEdOIIDtnJ\nMwpiUqVcJrRxpU3w6yVph6iW8YCGnUwqqd9ZzPN6ZaeaYVCEoY8Av3mmOhh48JJJ\nc7OYHTs0NAjo/FmCfTfoMICCdYkzBkOVV55bfnArkQKBgQDuEgHDWS9JwBwrVXFk\nmJDd1PHCvapZ+LH8CMWgxbIk0HzKw6xAz7q6ZldJ4QlIYVNQqxmdlIve4PQzbVF3\n/Li7fbCyarywuVQYJA9mPw2F2kp3SWO/9GjsBXGiPZWyZMduiXM/LbuTLnh5YHb+\n/ivCA9SGdvdar5qqFDRf6FGb6QKBgQDRngXnH6aNPqBVW3jF9HxvgDudrCuju93r\nbmC/1vtcVBXMgDSer2ktvk1XAnb7iHI3iPDUp1jIhRENlxJtNqs37w2Xucy0SR9I\nxiQt0TP6jykL0ESJNgwLzmM03Dv2hNRQQIsX/bJ86gfkVWfWvo+dHHyWIy33Gx1m\nH5bm5RJcYwKBgQCRx78CoyMc0yGsu2ZzRiU3YYUlTcT50RsUDT8PQt/iQTSZaRaa\nnVlnePGskLuBce91r0BBSUwZD8EZmLBRfBSW4tGHf2rKAMJpAfPYFXYvZ8s/nlYR\nnhV9qZu60GFRWvrwSgSjRFrfNo6ZLKPRY0ziQjwqlsDC7FMWIMctj3IhuQKBgQCS\nyWrux341KKbUPyLa1HMTDaQxrLA+jz8/L2M208/ffs5pD1pJySIJM1srVAGH8Kuy\n8gVblPiaKnyfnKv9qKvLlm5ZUnXjxdTPfFk3cGlKy1d9+1ETGLLkzZkxGgwvfCLF\nM/1zRmfoC2aNYbU+buFYrusbo/T7NpSmv/ZHKCBsawKBgQDgkPQ5uPC6bys8HtA2\nfUA08Yxw1n+Gq/YLpVNucvc6ohtGAhjBu2dY0tVyYO8979Ncd93M4PVYh0YBbWbP\nRf6GMxrQ9QcU4RRkvaAB6gkmS8uYRSF9fChOdmqS9QMAKum2chCBMjFigptuAjaf\nTjZT82PnA3iicm8iF0ImJqQyZw==\n-----END PRIVATE KEY-----\n",
        "client_email": client_email,
        "client_id": client_id,
        "auth_uri": "https://accounts.google.com/o/oauth2/auth",
        "token_uri": "https://oauth2.googleapis.com/token",
        "auth_provider_x509_cert_url":
            "https://www.googleapis.com/oauth2/v1/certs",
        "client_x509_cert_url":
            "https://www.googleapis.com/robot/v1/metadata/x509/gsheets%40dennermvp.iam.gserviceaccount.com",
        "universe_domain": "googleapis.com"
      };
      gsheets = GSheets(_credentials);
      super.onInit();
    } catch (e) {
      debugPrint(e.toString());
      Get.snackbar("Error", "Couldn't initialise GSheets!",
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  void fetchDataFromSheet() async {
    try {
      isLoading.value = true;
      var _spreadsheetId =
          const String.fromEnvironment('SPREADSHEET_ID', defaultValue: 'NULL');
      ss = await gsheets.spreadsheet(_spreadsheetId);
      var sheet = ss!.worksheetByIndex(0);

      if (sheet == null) {
        Get.snackbar("Error", "Google Sheet not found! Try again!",
            snackPosition: SnackPosition.BOTTOM);
        return;
      }

      rowData.value.clear();

      // final cellsRow = await sheet.cells.row(1);
      // columnNames.value = cellsRow.map((e) => e.value).toList();

      int rowLength = 0, i = 2;
      do {
        final cellRow = await sheet.cells.row(i);

        rowLength = cellRow.length;
        i++;

        if (cellRow.isNotEmpty) {
          PGHostel pg =
              createHostelFromData(cellRow.map((e) => e.value).toList());
          if (!pg.isUploadedToDB) {
            rowData.value.add(pg);
          }
        }
      } while (rowLength != 0);
      isLoading.value = false;
    } catch (e) {
      debugPrint(e.toString());
      Get.snackbar("Error", "An error has occured!",
          snackPosition: SnackPosition.BOTTOM);
      isLoading.value = false;
    }
  }

  Future<void> sendToSupabase() async {
    try {
      isDataUploading.value = true;
      error.value = "";
      var _spreadsheetId =
          const String.fromEnvironment('SPREADSHEET_ID', defaultValue: 'NULL');
      ss = await gsheets.spreadsheet(_spreadsheetId);
      var sheet = ss!.worksheetByIndex(0);

      if (sheet == null) {
        Get.snackbar("Error", "Google Sheet not found! Try again!",
            snackPosition: SnackPosition.BOTTOM);
        isDataUploading.value = false;
        return;
      }

      List<PGHostel> failed = [];

      if (rowData.value.isNotEmpty) {
        for (int i = 0; i < rowData.value.length; i++) {
          PGHostel pg = rowData.value[i];
          if (pg.latitude == 0.0 || pg.longitude == 0.0) {
            failed.add(pg);
          } else if (!pg.isUploadedToDB) {
            await uploadToSupabase(pg, sheet, i + 2);
          }
        }
        Get.snackbar("Success", "Data Successfully Upload!",
            snackPosition: SnackPosition.BOTTOM);
      }

      rowData.value = failed.isNotEmpty ? failed : [];
      isDataUploading.value = false;
    } catch (e) {
      Get.snackbar("Error", "An error has occured!",
          snackPosition: SnackPosition.BOTTOM);
      error.value = e.toString();
      isDataUploading.value = false;
    }
  }

  PGHostel createHostelFromData(List<dynamic> data) {
    final Map<String, double> coordinates = extractCoordinates(data[4]);

    String gender = "";
    String suitedFor = "";

    if (bool.parse(data[6]) && !bool.parse(data[7])) {
      gender = "Male";
    } else if (!bool.parse(data[6]) && bool.parse(data[7])) {
      gender = "Female";
    } else if (bool.parse(data[6]) && bool.parse(data[7])) {
      gender = "Both";
    }

    if (bool.parse(data[9]) && !bool.parse(data[10])) {
      suitedFor = "Student";
    } else if (!bool.parse(data[9]) && bool.parse(data[10])) {
      suitedFor = "Working Professional";
    } else if (bool.parse(data[9]) && bool.parse(data[10])) {
      suitedFor = "Both";
    }

    List<String> urls = [];

    if (data[42].toString().isNotEmpty) urls.add(data[42]);
    if (data[43].toString().isNotEmpty) urls.add(data[43]);
    if (data[44].toString().isNotEmpty) urls.add(data[44]);
    if (data[45].toString().isNotEmpty) urls.add(data[45]);

    return PGHostel(
        name: data[3],
        longitude: coordinates["longitude"]!,
        latitude: coordinates["latitude"]!,
        gender: gender,
        suitedFor: suitedFor,
        description: data[41],
        photos: {"photos": urls},
        contact: data[46],
        email: data[47],
        laundry: bool.parse(data[18]),
        mess: bool.parse(data[19]),
        cleaning: bool.parse(data[20]),
        waterSupply: bool.parse(data[22]),
        lift: bool.parse(data[23]),
        wifi: bool.parse(data[24]),
        fridge: bool.parse(data[25]),
        gym: bool.parse(data[26]),
        powerBackup: bool.parse(data[27]),
        geyser: bool.parse(data[28]),
        cctv: bool.parse(data[29]),
        parking: bool.parse(data[30]),
        gatedCommunity: bool.parse(data[31]),
        waterPurifier: bool.parse(data[32]),
        tv: bool.parse(data[33]),
        singleRent: double.tryParse(data[15]) ?? 0.0,
        doubleRent: double.tryParse(data[16]) ?? 0.0,
        threePlusRent: double.tryParse(data[17]) ?? 0.0,
        threePlusRooms: int.tryParse(data[17]) ?? 0, //change
        rules: {"rules": data[34].toString().split(",").toList()},
        isUploadedToDB:
            data.length == 48 ? false : bool.tryParse(data[48]) ?? false);
  }

  Future<void> uploadToSupabase(PGHostel pg, Worksheet sheet, int i) async {
    try {
      // log(pg.toString());
      var response = await SupaFlow.client.rpc("insert_pg_hostel", params: {
        "_name": pg.name,
        "_x_coordinate": pg.longitude,
        "_y_coordinate": pg.latitude,
        "_gender": pg.gender,
        "_suited_for": pg.suitedFor,
        "_description": pg.description,
        "_photos": pg.photos,
        "_contact": pg.contact,
        "_email": pg.email,
        "_laundry": pg.laundry,
        "_mess": pg.mess,
        "_cleaning": pg.cleaning,
        "_water_supply": pg.waterSupply,
        "_fridge": pg.fridge,
        "_gym": pg.gym,
        "_geyser": pg.geyser,
        "_gated_community": pg.gatedCommunity,
        "_water_purifier": pg.waterPurifier,
        "_wifi": pg.wifi,
        "_power_backup": pg.powerBackup,
        "_parking": pg.parking,
        "_tv": pg.tv,
        "_cctv": pg.cctv,
        "_lift": pg.lift,
        "_single": pg.singleRent,
        "_two": pg.doubleRent,
        "_three_plus": pg.threePlusRent,
        "_three_plus_rooms": pg.threePlusRooms,
        "_rules": pg.rules
      });
      // await Future.delayed(Duration(seconds: 5));
      var res = await sheet.values.insertValue("TRUE", column: 49, row: i);
      debugPrint("Sheet updation : $res");
    } catch (e) {
      debugPrint('Exception when uploading to Supabase: $e');
    }
  }

  Map<String, double> extractCoordinates(String url) {
    RegExp regExp = RegExp(r'@([0-9.-]+),([0-9.-]+)');
    RegExpMatch? match = regExp.firstMatch(url);

    if (match != null && match.groupCount == 2) {
      double latitude = double.parse(match.group(1)!);
      double longitude = double.parse(match.group(2)!);
      return {'latitude': latitude, 'longitude': longitude};
    } else {
      return {'latitude': 0.0, 'longitude': 0.0};
    }
  }
}
