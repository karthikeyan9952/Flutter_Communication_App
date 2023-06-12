import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

//declare logger
var logger = Logger(filter: null, printer: PrettyPrinter(), output: null);

//keys
GlobalKey<ScaffoldState> materialKey = GlobalKey<ScaffoldState>();
