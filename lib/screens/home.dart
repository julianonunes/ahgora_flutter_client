import 'package:ahgora/models/user.dart';
import 'package:flutter/material.dart';

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
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Chave ',
                          ),
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
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Usuário'),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(20.0),
                        child: TextFormField(
                          textInputAction: TextInputAction.next,
                          focusNode: _passwordNode,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(), labelText: 'Senha'),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(20.0),
                        child: MaterialButton(
                          color: Colors.redAccent,
                          textColor: Colors.white,
                          onPressed: () => {},
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
