import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../dto/product_request_deposits.dart';

class CardProduct extends StatefulWidget {
  final int id;
  final String name;
  final String type;
  final String brand;
  final int amount;

  CardProduct(
      {required this.id,
      required this.name,
      required this.brand,
      required this.type,
      required this.amount});

  @override
  CardProductState createState() => CardProductState();
}

class CardProductState extends State<CardProduct> {
  bool isExpanded = false;
  final String? _host = dotenv.env['HOSTNAME'];
  List<DepositProduct> depositos = [];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (!isExpanded) {
          final response =
              await http.get(Uri.parse('$_host/product/${widget.id}'));
          if (response.statusCode == 200) {
            print(response.body);
            final Map<String, dynamic> responseBody =
                json.decode(response.body);
            final Map<String, dynamic> produtoJson = responseBody["product"];
            final List<dynamic> deposits = produtoJson["depositos"];
            setState(() {
              depositos = deposits
                  .map((json) => DepositProduct.fromJson(json))
                  .toList();
            });
          }
        }
        setState(() {
          isExpanded = !isExpanded;
        });
      },
      child: Dismissible(
        key: const Key('card'),
        direction: DismissDirection.endToStart,
        confirmDismiss: (direction) async {
          return await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text("Confirmar exclusão"),
              content:
                  const Text("Tem certeza de que deseja excluir este card?"),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text("Cancelar"),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text("Confirmar"),
                ),
              ],
            ),
          );
        },
        onDismissed: (direction) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Card excluído")),
          );
        },
        background: Container(
          color: Colors.red,
          child: Icon(
            Icons.delete,
            color: Colors.white,
            size: 30.0,
          ),
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 20.0),
        ),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.fastOutSlowIn,
          height: isExpanded ? 280.0 : 180.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: const Color(0xffFF914D),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Text(
                        widget.name,
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                            fontSize: 26,
                            color: Colors.black,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'Tipo: ${widget.type}',
                        textAlign: TextAlign.end,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Text(
                        'Marca: ${widget.brand}',
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'Qtde: ${widget.amount}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                  ],
                ),
                if (isExpanded)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      for (DepositProduct deposito in depositos)
                        Expanded(
                          child: Text(
                            '${deposito.name}: ${deposito.amount}',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        )
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
