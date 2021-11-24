class SplitString {
  String tokenString(String cookies) {
    String authToken = cookies.split('auth_token=')[1].replaceAll(RegExp('='), '');
    if(authToken == '') {
      return "";
    }
    return authToken;
  }
}