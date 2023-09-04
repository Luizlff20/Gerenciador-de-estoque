import 'package:flutter/material.dart';

Widget search() {
  return Container(
    height: 60,
    decoration: const BoxDecoration(
      color: Color(0xFF5271FF),
      borderRadius: BorderRadius.all(
        Radius.circular(128),
      ),
    ),
    child: Row(
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.only(left: 10),
        ),
        const Icon(color: Colors.white, Icons.search),
        const SizedBox(width: 10),
        Expanded(
          child: Container(
            padding: const EdgeInsets.only(left: 10),
            child: TextFormField(
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                hintText: "Nome do Produto",
                hintStyle: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                ),
              ),
              style: const TextStyle(
                fontSize: 20,
                fontFamily: 'Poppins',
                color: Colors.white,
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 10,
          child: Icon(
            color: Colors.white,
            Icons.qr_code_scanner,
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(10),
        ),
        const SizedBox(
          width: 10,
          child: Icon(
            color: Colors.white,
            Icons.filter_list,
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(right: 40),
        ),
      ],
    ),
  );
}
