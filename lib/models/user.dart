class AppUser {
  String uid;
  String name;
  String email;
  String username;
  String status;
  int state;
  String profilePhoto;

  AppUser({
    this.uid,
    this.name,
    this.email,
    this.username,
    this.status,
    this.state,
    this.profilePhoto,
  });

  Map toMap(AppUser appUser) {
    var data = Map<String, dynamic>();
    data['uid'] = appUser.uid;
    data['name'] = appUser.name;
    data['email'] = appUser.email;
    data['username'] = appUser.username;
    data['status'] = appUser.status;
    data['state'] = appUser.state;
    data['profile_photo'] = appUser.profilePhoto;
    return data;
  }

  AppUser.fromMap(Map<String, dynamic> mapData) {
    this.uid = mapData['uid'];
    this.name = mapData['name'];
    this.email = mapData['email'];
    this.username = mapData['username'];
    this.status = mapData['status'];
    this.state = mapData['state'];
    this.profilePhoto = mapData['profile_photo'];
  }
}
