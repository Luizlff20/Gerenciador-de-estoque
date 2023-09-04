// ignore_for_file: unused_import, avoid_print
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/product.dart';
import 'package:flutter_application_1/pages/opcoes_pages.dart';
import 'package:flutter_application_1/pages/widgets_pages.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../dto/product_request.dart';
import '../widgets/card_product.dart';

class Consulta extends StatefulWidget {
  const Consulta({super.key});

  @override
  _ConsultaState createState() => _ConsultaState();
}

class _ConsultaState extends State<Consulta> {
  final double appBarTopMargin = 0.0;
  final double appBarBottomMargin = 0.0;
  List<ProductRequest> products = [];
  final String? _host = dotenv.env['HOSTNAME'];

  @override
  void initState() {
    super.initState();
    listarProdutos();
  }

  Future<void> listarProdutos() async {
    final response = await http.get(Uri.parse('$_host/listproducts'));
    if (response.statusCode == 200) {
      print(response.body);
      final Map<String, dynamic> responseBody = json.decode(response.body);
      final List<dynamic> produtosJson = responseBody["products"];

      setState(() {
        products =
            produtosJson.map((json) => ProductRequest.fromJson(json)).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(80.0 + appBarTopMargin + appBarBottomMargin),
        child: Container(
          margin:
              EdgeInsets.only(top: appBarTopMargin, bottom: appBarBottomMargin),
          child: AppBar(
            backgroundColor: const Color(0xFF00141b),
            title: const Text(
              'Consulta',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            centerTitle: true,
            actions: [
              Image.asset(
                'assets/images/Stock_Manager_logo.png',
                width: 80.0,
                height: 80.0,
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Color(0xFF00141b),
      body: SingleChildScrollView(
        child: Container(
          color: Color(0xFF00141b),
          margin: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const SizedBox(height: 20),
              search(),
              const SizedBox(height: 25),
              for (ProductRequest produto in products)
                Column(children: [
                  CardProduct(
                      id: produto.id,
                      amount: produto.amount,
                      brand: produto.brand,
                      name: produto.name,
                      type: produto.type),
                  const SizedBox(height: 20)
                ])
            ],
          ),
        ),
      ),
    );
  }
}


// CardProduct(
//                       id: produto.id,
//                       amount: produto.amount,
//                       brand: produto.brand,
//                       name: produto.name,
//                       type: produto.type)