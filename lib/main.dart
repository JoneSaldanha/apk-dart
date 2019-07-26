import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const request = "https://api.hgbrasil.com/finance?format=json&key=9ff3c741";

void main () {
  runApp(MaterialApp(
      home: Home()

  ));
}

Future<Map> getMoedas() async{

  http.Response resposta = await http.get(request);
//  print(resposta);
//
//  print("STATUS DA CONEXAO");
//  print(resposta.statusCode);

  dynamic r = jsonDecode(resposta.body);
//  print(r["results"]["currencies"]["USD"]["buy"]);

  return r;
  
  }
  
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController realController = TextEditingController();
  TextEditingController dolarController = TextEditingController();


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: Text("\$ Conversor \$"),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: getMoedas(),
        builder: (context, snapshot){

          switch(snapshot.connectionState){

            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(
                child: Text("Carregando dados...")
              );

            default:
              if(snapshot.hasError){
                return Center(
                  child: Text("Erro ao carregar dados")
                );

            }else{
              return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Icon(Icons.monetization_on, size: 150.0, color: Colors.deepPurple),
                      getTextField("Real", "R\$", realController),
                      Divider(),
                      getTextField("Dolar", "\$", dolarController)
                      ],
                ));
            }}
        }),
    );}
}

  
Widget getTextField(String label, String prefix, TextEditingController controlador ){

  return TextField(
    controller: controlador,
    decoration: InputDecoration(
      labelText: label,
      labelStyle: TextStyle(
        color: Colors.white
      ),
      prefixText: prefix,
      border: OutlineInputBorder()
  ));

}