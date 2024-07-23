import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper{
static String userId="UserKey";
static String userNameKey ="UserNameKey";
static String userEmailKey ="UserEmailKey";
static String userWalletKey ="UserWalletKey";
static String userProfileKey ="UserProfileKey";

Future<bool> saveUserId(String getUserId)async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
 return prefs.setString(userId, getUserId);
}
Future<bool> saveUserName(String getUserName)async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.setString(userNameKey, getUserName);
}
Future<bool> saveUserEmail(String getUserEmail)async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.setString(userEmailKey, getUserEmail);
}
Future<bool> saveUserWallet(String getUserWallet)async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.setString(userWalletKey, getUserWallet);
}
Future<bool> saveUserProfile(String getUserProfile)async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.setString(userProfileKey, getUserProfile);
}
Future<String?>getUserId()async{
  SharedPreferences prefs =await SharedPreferences.getInstance();
  return prefs.getString(userId);
}
Future<String?>getUserName()async{
  SharedPreferences prefs =await SharedPreferences.getInstance();
  return prefs.getString(userNameKey);
}
Future<String?>getUserEmail()async{
  SharedPreferences prefs =await SharedPreferences.getInstance();
  return prefs.getString(userEmailKey);
}
Future<String?>getUserWallet()async{
  SharedPreferences prefs =await SharedPreferences.getInstance();
  return prefs.getString(userWalletKey);
}
Future<String?>getUserProfile()async{
  SharedPreferences prefs =await SharedPreferences.getInstance();
  return prefs.getString(userProfileKey);
}
}