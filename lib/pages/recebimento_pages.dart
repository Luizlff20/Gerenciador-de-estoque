import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/opcoes_pages.dart';
import 'package:flutter_application_1/pages/widgets_pages.dart';

class RecebimentoPage extends StatefulWidget {
  const RecebimentoPage({Key? key});

  @override
  _RecebimentoPageState createState() => _RecebimentoPageState();
}

class _RecebimentoPageState extends State<RecebimentoPage> {
  List<Product> productList = [
    Product(
      productName: 'JOELHO SOLD 20MM',
      codigo: '001',
      quantidade: '10',
      isChecked: false,
    ),
    Product(
      productName: 'TUBO 100MM ESG',
      codigo: '002',
      quantidade: '100',
      isChecked: false,
    ),
  ];

  void validateProducts() {
    bool allChecked = productList.every((product) => product.isChecked);
    if (allChecked) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              'Recebimento Conferido',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            content: const Text(
              'Todos os produtos foram conferidos.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  if (allChecked) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => OpcaoPage()),
                    );
                  } else {
                    Navigator.of(context).pop();
                  }
                },
                child: const Text(
                  'Fechar',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              'Recebimento Incompleto',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            content: const Text(
              'Existem produtos não conferidos.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'Fechar',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF00141b),
        title: const Text('Recebimentos'),
        actions: <Widget>[
          SizedBox(
            width: 70,
            height: 70,
            child: IconButton(
              icon: Image.asset('assets/images/Stock_Manager_logo.png'),
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        color: const Color(0xFF00141b),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const SizedBox(
              height: 60,
            ),
            search(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    const CustomCard(
                      numeroPedido: '123456',
                      fornecedor: 'Tigre Materiais',
                    ),
                    const SizedBox(height: 20),
                    for (var product in productList)
                      ProductCard(
                        product: product,
                        onChanged: (value) {
                          setState(() {
                            product.isChecked = value!;
                          });
                        },
                      ),
                  ],
                ),
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                color: Color(0xFF5271FF),
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              child: ElevatedButton(
                onPressed: validateProducts,
                style: ElevatedButton.styleFrom(
                  primary: Colors
                      .transparent, // Define a cor transparente como plano de fundo
                  elevation: 0, // Remove a sombra do botão
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: const Text(
                  'Conferir Recebimento',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomCard extends StatelessWidget {
  final String numeroPedido;
  final String fornecedor;

  const CustomCard({
    required this.numeroPedido,
    required this.fornecedor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xffFF914D),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Número do Pedido',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    numeroPedido,
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Text(
                  '|',
                  style: TextStyle(color: Colors.black, fontSize: 50),
                ),
              ],
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Fornecedor',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    fornecedor,
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductCard extends StatefulWidget {
  final Product product;
  final ValueChanged<bool?>? onChanged;

  const ProductCard({
    required this.product,
    this.onChanged,
  });

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xffFF914D),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Nome Produto: ${widget.product.productName}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        'Código: ${widget.product.codigo}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        'Quantidade: ${widget.product.quantidade}',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              children: [
                const SizedBox(width: 16.0),
                IconButton(
                  onPressed: () {
                    setState(() {
                      widget.product.isChecked = !widget.product.isChecked;
                      widget.onChanged?.call(widget.product.isChecked);
                    });
                  },
                  icon: widget.product.isChecked
                      ? const Icon(
                          Icons.check_circle,
                          color: Colors.green,
                        )
                      : const Icon(
                          Icons.check_box_outline_blank_sharp,
                          color: Colors.red,
                        ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class Product {
  final String productName;
  final String codigo;
  final String quantidade;
  bool isChecked;

  Product({
    required this.productName,
    required this.codigo,
    required this.quantidade,
    required this.isChecked,
  });
}
