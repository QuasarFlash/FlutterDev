import 'package:flutter/material.dart';
import '../mixins/validation_mixin.dart';

class LoginScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return LogicScreenState();
  }
}

class LogicScreenState extends State<LoginScreen> with ValidationMixin {
  final formKey =GlobalKey<FormState>();
  String email = '';
  String pass = '';
  Widget emailField(){
    return TextFormField(
      validator: validateEmail,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: 'Email',
        hintText: 'name@example.com',
      ),
    );
  }

  Widget passwordField(){
    return TextFormField(
      obscureText: false,
      validator: validatePassword,
      onSaved: (String value){
        pass = value;
      },
      decoration: InputDecoration(
        labelText: 'Password',
        hintText: 'Password',

      ),
    );
  }

  Widget submitButton(){
    return RaisedButton(
      color: Colors.blue,
      child: Text('Submit'),
      onPressed: (){
        if(formKey.currentState.validate()){
          formKey.currentState.save();
        }
      },
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20.0),
      child:Form(
        key: formKey,
        child: Column(
          children: <Widget>[
            emailField(),
            passwordField(),
            Container(margin:EdgeInsets.only(top:25.0)),
            submitButton(),
          ],
        ),
      ),
    );
  }
}