import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/dto/product_request.dart';
import 'package:flutter_application_1/pages/cadastro.dart';
import 'package:flutter_application_1/pages/configuracoes_pages.dart';
import 'package:flutter_application_1/pages/login_pages.dart';
import 'package:flutter_application_1/pages/recebimento_pages.dart';
import 'package:flutter_application_1/pages/transferencia_pages.dart';
import 'package:flutter_application_1/pages/widgets_pages.dart';
import 'package:flutter_application_1/pages/consulta_page.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class OpcaoPage extends StatelessWidget {
  final double appBarTopMargin = 0.0; // Margem superior do AppBar
  final double appBarBottomMargin = 0.0;

  const OpcaoPage({super.key}); // Margem inferior do AppBar
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
              'Stock Manager',
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
      body: Container(
        color: const Color(0xFF00141b), 
        child: Center(
          child: GridView.count(
            crossAxisCount: 2, // Dois itens por linha
            padding: const EdgeInsets.all(20.0),
            mainAxisSpacing: 50.0, // Espaçamento vertical entre os itens
            crossAxisSpacing: 30.0, // Espaçamento horizontal entre os itens
            children: [
              ButtonWithImage(
                image: const AssetImage('assets/images/card1.png'),
                text: 'Consulta',
                onPressed: () {
                  
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Consulta()));
                  
                },
              ),
              ButtonWithImage(
                image: const AssetImage('assets/images/card2.png'),
                text: 'Cadastro',
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => Cadastro()));
                },
              ),
              ButtonWithImage(
                image: const AssetImage('assets/images/card3.png'),
                text: 'Recebimento de Produto',
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const RecebimentoPage()));
                  
                },
              ),
              ButtonWithImage(
                image: const AssetImage('assets/images/card4.png'),
                text: 'Transferência',
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const TransferenciaPage()));
                  
                },
              ),
              ButtonWithImage(
                image: const AssetImage('assets/images/card5.png'),
                text: 'Configuração',
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const ConfigPage()));
                },
              ),
              ButtonWithImage(
                image: const AssetImage('assets/images/card6.png'),
                text: 'Sair',
                onPressed: () {
                  showExitConfirmationDialog(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ButtonWithImage extends StatelessWidget {
  final ImageProvider image;
  final String text;
  final VoidCallback onPressed;

  const ButtonWithImage({
    super.key,
    required this.image,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 100,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xffFF914D),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: image,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 8.0),
            Text(
              text,
              style: const TextStyle(
                fontSize: 16.0,
                fontFamily: 'Poppins',
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void showExitConfirmationDialog(BuildContext context) => showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmação'),
          content: const Text('Deseja encerrar a sessão?'),
          actions: [
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Sair'),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                  (Route<dynamic> route) => false,
                );
              },
            ),
          ],
        );
      },
    );
