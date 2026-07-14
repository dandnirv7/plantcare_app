import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

const String appName = "PlantCare";
const String appTagline = "Take care of your plants easily";
const String appVersion = "1.0.0";

const String baseUrl = "https://perenual.com/api";

String get apiKey => dotenv.env["PERENUAL_API_KEY"] ?? "";

const String loginUsername = "dandi";
const String loginPassword = "dandi0350";
const String loginStatusKey = "is_logged_in";

const Color primaryColor = Color(0xFF2E7D32);
const Color secondaryColor = Color(0xFF66BB6A);
const Color backgroundColor = Color(0xFFF7FAF5);
const Color textColor = Color(0xFF263238);
const Color subTextColor = Color(0xFF757575);

const String defaultImageMessage = "Data gambar tidak tersedia";
