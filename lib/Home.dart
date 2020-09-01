import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map<String, String> estados = { "AC": "Acre", "AL": "Alagoas", "AP": "Amapá",
    "AM": "Amazonas", "BA": "Bahia", "CE": "Ceará", "DF": "Distrito Federal",
    "ES": "Espírito Santo", "GO": "Goiás", "MA": "Maranhão", "MT": "Mato Grosso",
    "MS": "Mato Grosso do Sul", "MG": "Minas Gerais", "PR": "Paraná", "PB": "Paraíba",
    "PA": "Pará", "PE": "Pernambuco", "PI": "Piauí", "RN": "Rio Grande do Norte",
    "RS": "Rio Grande do Sul", "RJ": "Rio de Janeiro", "RO": "Rondônia", "RR": "Roraima",
    "SC": "Santa Catarina", "SE": "Sergipe", "SP": "São Paulo", "TO": "Tocantins", "": "" };

  TextEditingController _controllerCep = TextEditingController();
  String _cep = "";
  String _resultado = "";
  String _logradouro = "";
  String _bairro = "";
  String _localidade = "";
  String _ddd = "";
  String _uf = "";
  String _estado = "";

  _recuperarCep() async {
    String cepDigitado = _controllerCep.text;
    String url = "https://viacep.com.br/ws/${cepDigitado}/json/";
    http.Response response;

    if(await http.get(url) == null){
      print("deu errado");
    }
    response = await http.get(url);

    Map<String, dynamic> retorno = json.decode(response.body);

    setState(() {
      _cep = retorno["cep"];
      _logradouro = retorno["logradouro"];
      _bairro = retorno["bairro"];
      _localidade = retorno["localidade"];
      _uf = retorno["uf"];
      _ddd = retorno["ddd"];
      // _estado = estados[_uf];
      _estado = estados["${_uf}"] + " (${_uf})";
      _controllerCep.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text("Busca CEP",
          style: TextStyle(
            color: Colors.black
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(40),
        child: Column(
          children: <Widget>[
            Image.asset("images/correios.png"),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  labelText: "Digite o cep: ex: 05428200"
              ),
              maxLength: 8,
              textAlign: TextAlign.center,
              style: TextStyle(
                height: 2,
                  fontSize: 20,
              ),
              controller: _controllerCep,
            ),
            RaisedButton(
              color: Colors.amber,
              child: Text("Consultar"),
              onPressed: _recuperarCep,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
            ),
            Text("CEP:" + _cep,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            Text("Logradouro: " +_logradouro,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            Text("Bairro: " + _bairro,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            Text("Cidade: " + _localidade,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            //Text("Estado: " + estados["${_uf}"] + " (${_uf})",
            Text("Estado: " + _estado,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            Text("DDD: " + _ddd,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}