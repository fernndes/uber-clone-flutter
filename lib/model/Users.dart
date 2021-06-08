class Users {
  String _userId;
  String _name;
  String _email;
  String _password;
  String _isPassenger;

  Users();

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "name": this.name,
      "email": this.email,
      "isPassenger": this.isPassenger
    };

    return map;
  }

  String checkIsPassenger(bool isPassenger) {
    return isPassenger ? "motorista" : "passageiro";
  }

  String get userId => _userId;
  set userId(String value) {
    _userId = value;
  }

  String get name => _name;
  set name(String value) {
    _userId = value;
  }

  String get email => _email;
  set email(String value) {
    _userId = value;
  }

  String get password => _password;
  set password(String value) {
    _userId = value;
  }

  String get isPassenger => _isPassenger;
  set isPassenger(String value) {
    _userId = value;
  }
}
