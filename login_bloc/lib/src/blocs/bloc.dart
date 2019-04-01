import 'dart:async';
import 'validators.dart';
import 'package:rxdart/rxdart.dart';
import 'package:async/async.dart';
class Bloc extends Object with Validators {

  final _email = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();

  // final _email = StreamController<String>.broadcast();
  // final _password = StreamController<String>.broadcast();

  // Add data to stream
  Function(String) get changeEmail => _email.sink.add;
  Function(String) get changePassword => _password.sink.add;

  //Retrieve data from stream
  Stream<String> get email => _email.stream.transform(validateEmail);
  Stream<String> get password => _password.stream.transform(validatePassword);

  Stream<bool> get submitValid => Observable.combineLatest2(email, password, (String ema, String pass) => true);

  submit(){

    final validEmail = _email.value;
    final validPassword = _password.value;

    print(validEmail);
    print(validPassword);
  }

  dispose(){
    _email.close();
    _password.close();
  }
}
// Global Instance
// final bloc = Bloc();