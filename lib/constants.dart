import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:local/list.dart';

var local;
List itemlist = [];
bool itemloading = true;
final list_hive = Hive.box('location');
var map;
List data = [];
List temp = [];
var mymap;
