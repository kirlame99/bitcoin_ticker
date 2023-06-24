import 'package:http/http.dart' as http;
import 'dart:convert';




class NetworkHelper{

  NetworkHelper(this.url);

  final String url;

  Future getData() async {

    Uri uri = Uri.parse(url);
    try{
      http.Response response = await http.get(uri);
      if(response.statusCode == 200){
        Map<String,dynamic> data = jsonDecode(response.body);
        return data['rate'].toInt();
      }
      else{
        print(response.statusCode);
        return(0);
      }
    }
    catch(e){
      print(e);
    }  

  }
}