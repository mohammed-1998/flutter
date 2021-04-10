import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';
import 'dart:async';

import 'package:rippledemo/splash_screen.dart';

class Api {
  Future<String> getTeams(String leagueName) async {
    final response = await http.get(
        "https://filesamples.com/samples/document/txt/sample2.txt");

    if (response.statusCode == HttpStatus.OK) {
      read_file_data = response.body;

      if (read_file_data == null)
        return null;
      else
        return read_file_data;
    } else {
      return null;
    }
  }
}