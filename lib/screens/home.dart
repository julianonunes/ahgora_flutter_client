import 'package:ahgora/models/user.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _user = User();
  final _formKey = GlobalKey<FormState>();
  final _tokenNode = FocusNode();
  final _userNode = FocusNode();
  final _passwordNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        child: Builder(
          builder: (context) => Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Image.asset("assets/images/logo.png",
                      fit: BoxFit.scaleDown,
                      width: 160,
                      alignment: Alignment.center),
                  margin: EdgeInsets.only(top: 100.0),
                ),
                Expanded(
                  child: ListView(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.all(20.0),
                        child: TextFormField(
                          textInputAction: TextInputAction.next,
                          focusNode: _tokenNode,
                          onFieldSubmitted: (term) {
                            _fieldFocusChange(context, _tokenNode, _userNode);
                          },
                          onSaved: (val) {
                            setState(() {
                              _user.identity = val;
                            });
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Chave Ahgora',
                          ),
                          validator: (value) {
                            return value.isEmpty
                                ? 'Preencha com a chave obtida no localStorage em seu navegador já autenticado.'
                                : null;
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(20.0),
                        child: TextFormField(
                          textInputAction: TextInputAction.next,
                          focusNode: _userNode,
                          onFieldSubmitted: (term) {
                            _fieldFocusChange(
                                context, _userNode, _passwordNode);
                          },
                          onSaved: (val) {
                            setState(() {
                              _user.account = val;
                            });
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Usuário'),
                          validator: (value) {
                            return value.isEmpty ? 'Preencha o usuário.' : null;
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(20.0),
                        child: TextFormField(
                          textInputAction: TextInputAction.next,
                          focusNode: _passwordNode,
                          onSaved: (val) {
                            setState(() {
                              _user.password = val;
                            });
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(), labelText: 'Senha'),
                          validator: (value) {
                            return value.isEmpty ? 'Preencha a senha.' : null;
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(20.0),
                        child: MaterialButton(
                          color: Colors.redAccent,
                          textColor: Colors.white,
                          onPressed: () {
                            final form = _formKey.currentState;
                            if (form.validate()) {
                              form.save();
                              _user.register().then((response) {
                                if (response.statusCode == 200 && json.decode(response.body).error != true) {
                                  final snackbar = SnackBar(content: Text('Ponto registrado'));
                                  Scaffold.of(context).showSnackBar(snackbar);
                                }
                                else {
                                  final snackbar = SnackBar(content: Text('Erro ao bater ponto, confira os dados. Mensagem: ' + json.decode(response.body).message));
                                  Scaffold.of(context).showSnackBar(snackbar);
                                }
                              });
                            }
                          },
                          child: Text('Registrar'),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }
}
