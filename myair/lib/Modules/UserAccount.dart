class UserAccount {
  //final user = FirebaseAuth.instance.currentUser;
  String firebaseId;
  String firstName;
  String lastName;
  String email;
  String password;
  String img;
  List<int> notificationLimits;

  // final User userdu;
  // userAccount(this.userdu);
  Map<String, dynamic> toJson() {
    return {
      "firstname": this.firstName,
      "lastname": this.lastName,
      "email": this.email,
      "password": this.password,
      "img": this.img,
      "pm10": this.notificationLimits.elementAt(0),
      "pm25": notificationLimits.elementAt(1),
      "no2": notificationLimits.elementAt(2),
      "so2": notificationLimits.elementAt(3),
      "o3": notificationLimits.elementAt(4),
      "co": notificationLimits.elementAt(5),
    };
  }

  UserAccount(String firstName, String lastName, String email, String password,
      String img, List<int> notificationLimits) {
    this.firstName = firstName;
    this.lastName = lastName;
    this.email = email;
    this.password = password;
    this.img = img;
    this.notificationLimits = notificationLimits;
  }

  setFId(String id) {
    firebaseId = id;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['userId'] = 1;
    map['firstname'] = firstName;
    map['lastname'] = lastName;
    map['email'] = email;
    map['password'] = password;
    map['image'] = img;
    map['firebaseId'] = firebaseId;
    map['pm10'] = notificationLimits.elementAt(0);
    map['pm25'] = notificationLimits.elementAt(1);
    map['no2'] = notificationLimits.elementAt(2);
    map['so2'] = notificationLimits.elementAt(3);
    map['o3'] = notificationLimits.elementAt(4);
    map['co'] = notificationLimits.elementAt(5);
    return map;
  }

  fromMapObject(Map<String, dynamic> map) {
    firebaseId = map['firebaseId'];
    print(firebaseId);
    firstName = map['firstname'];
    print(firstName);
    lastName = map['lastname'];
    print(lastName);
    email = map['email'];
    print(email);
    password = map['password'];
    print(password);
    img = map['image'];
    print(img);
    notificationLimits = [
      int.parse(map['pm10']),
      int.parse(map['pm25']),
      int.parse(map['no2']),
      int.parse(map['so2']),
      int.parse(map['o3']),
      int.parse(map['co'])
    ];
  }

  void setLimits(List<int> list) {
    this.notificationLimits = list;
  }
}
