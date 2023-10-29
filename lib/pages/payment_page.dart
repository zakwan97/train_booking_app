import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:train_booking_app/services/supabase_client.dart' as source;

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  late SupabaseClient client;
  String tableName = 'Train';

  List<dynamic> data = [];

  @override
  void initState() {
    super.initState();
    client = SupabaseClient(source.supabaseUrl, source.supabaseApiKey);
    fetchDataFromSupabase();
  }

  Future<void> fetchDataFromSupabase() async {
    // final response = await http.get(
    //   Uri.parse('$supabaseUrl/rest/v1/$tableName'),
    //   headers: {
    //     'apikey': supabaseApiKey,
    //   },
    // );

    final response = await client
        .from('Train')
        .select()
        .order('trainID', ascending: true)
        .execute();

    if (response.status == 200) {
      setState(() {
        // data = json.decode(response.data);
      });
      print(response.data);
    } else {
      print(response.status);
      throw Exception('Failed to fetch data from Supabase');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Supabase Data Fetcher'),
      ),
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(data[index]),
          );
        },
      ),
    );
  }
}
