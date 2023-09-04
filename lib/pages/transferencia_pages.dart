import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/opcoes_pages.dart';
import 'package:flutter_application_1/pages/widgets_pages.dart';

class TransferenciaPage extends StatefulWidget {
  const TransferenciaPage({Key? key}) : super(key: key);

  @override
  State<TransferenciaPage> createState() => _TransferenciaPageState();
}

class _TransferenciaPageState extends State<TransferenciaPage> {
  List<StockCard> stockCards = [
    StockCard(title: 'CIMENTO 50 KG', stock: '10'),
    StockCard(title: 'ESCADA ALUMINIO', stock: '5'),
    StockCard(title: 'TELHA BRASILIT', stock: '20'),
  ];

  void incrementCounter(StockCard stockCard) {
    setState(() {
      stockCard.counter++;
    });
    print(stockCard.counter);
  }

  void decrementCounter(StockCard stockCard) {
    setState(() {
      stockCard.counter--;
    });
    print(stockCard.counter);
  }

  void incrementCounter2(StockCard stockCard) {
    setState(() {
      stockCard.counter2++;
    });
    print(stockCard.counter2);
  }

  void decrementCounter2(StockCard stockCard) {
    setState(() {
      stockCard.counter2--;
    });
    print(stockCard.counter2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF00141b),
        title: const Text('Transferência'),
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const SizedBox(
                height: 60,
              ),
              search(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 20),
                  ),
                  for (var stockCard in stockCards) buildStockCard(stockCard),
                  Padding(
                    padding: const EdgeInsets.all(50),
                    child: SizedBox(
                      height: 70,
                      width: 70,
                      child: Image.asset(
                        'assets/images/Stock_Manager_logo.png',
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildStockCard(StockCard stockCard) {
    return SizedBox(
      height: 150,
      child: Card(
        color: const Color(0xffFF914D),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8, right: 80),
                    child: Text(
                      stockCard.title,
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 5),
                    child: Expanded(
                      child: Text(
                        'Estoque: ${stockCard.stock}',
                        textAlign: TextAlign.end,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 8, right: 30),
                  child: Text(
                    'Qtde Loja: ',
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                CounterButton(
                  icon: Icons.remove,
                  onPressed: stockCard.isEmpty
                      ? null
                      : () => decrementCounter(stockCard),
                ),
                SizedBox(
                  width: 40,
                  height: 40,
                  child: CounterCard(
                    counter: stockCard.counter,
                  ),
                ),
                CounterButton(
                  icon: Icons.add,
                  onPressed: stockCard.isFull
                      ? null
                      : () => incrementCounter(stockCard),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: Text(
                    'Qtde Deposito: ',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                CounterButton(
                  icon: Icons.remove,
                  onPressed: stockCard.isEmpty
                      ? null
                      : () => decrementCounter2(stockCard),
                ),
                SizedBox(
                  width: 35,
                  height: 40,
                  child: CounterCard(
                    counter: stockCard.counter2,
                  ),
                ),
                CounterButton(
                  icon: Icons.add,
                  onPressed: stockCard.isFull
                      ? null
                      : () => incrementCounter2(stockCard),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 20, left: 5),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const SizedBox(
                      child: UpdateButton(),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class StockCard {
  String title;
  String stock;
  int counter = 0;
  int counter2 = 0;

  StockCard({required this.title, required this.stock});

  bool get isEmpty => counter == 0;
  bool get isFull => counter == 100;
}

class CounterButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;

  const CounterButton({
    Key? key,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(icon),
      onPressed: onPressed,
    );
  }
}

class CounterCard extends StatelessWidget {
  final int counter;

  const CounterCard({Key? key, required this.counter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: SizedBox(
          child: Padding(
            padding: const EdgeInsets.all(3),
            child: Text(
              counter.toString(),
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class UpdateButton extends StatelessWidget {
  const UpdateButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Card(
        color: const Color(0xFF5271FF),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        child: TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OpcaoPage(),
              ),
            );
          },
          child: const Text(
            'ATUALIZAR',
            style: TextStyle(
              fontSize: 14,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
