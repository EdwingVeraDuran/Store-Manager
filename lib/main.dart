import 'package:flutter/material.dart';
import 'package:store_manager/app.dart';
import 'package:store_manager/utilities/supabase_service.dart';

void main() async {
  await SupabaseService.initializeApp();
  runApp(MainApp());
}
