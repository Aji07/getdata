
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getdata/Api/apirequest.dart';
import 'package:getdata/Model/data.dart';
import 'package:image_picker/image_picker.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //bool sawp = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown,
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Center(child: Text("RetfoFit Implementation",
          style: TextStyle(fontSize: 30,
              fontWeight: FontWeight.bold,
              fontFamily: 'First',
               ),)),
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(70))
        ),
      ),

        body: RefreshIndicator(
          onRefresh:() async {
                       await Future.delayed(Duration(seconds: 3),(){
                         _buildBody(context);
                       });
                       }
          ,child: _buildBody(context))
    );
  }
}

FutureBuilder<ResponseData> _buildBody(BuildContext context) {
  final client = ApiRequest(Dio(BaseOptions(contentType: "application/json")),
      baseUrl: 'http://gorest.co.in/public-api');
  return FutureBuilder<ResponseData>(
      future: client.getUsers(),
      builder: (context, snapshot) {
        print('Snapshot Error:${snapshot.error}');
        if (snapshot.connectionState == ConnectionState.done) {
          print('Snapshot ConnectionState:${snapshot.connectionState}\nConnectionState Done${ConnectionState.done}');
          final posts = snapshot.data;
          print('Snapshot Data:${posts}');
          if (posts != null) {
            return _buildPosts(context, posts);
          }
          else {
            return Center(
              child: Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.red,
                child: Center(child: CircularProgressIndicator()),
              ),
            );
          }
        }
        else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      });

}
Widget _postdetails(BuildContext context,ResponseData posts,index){
  return Scaffold(
    backgroundColor: Colors.white,
    appBar: PreferredSize(
      preferredSize: Size.fromHeight(100),
      child: AppBar(
        centerTitle: true,
        backgroundColor:Colors.red,
        leading: GestureDetector(
            onTap: (){
              Navigator.of(context).pop();
            },
            child: Icon(Icons.arrow_back_ios)),
        title: Text('Profile Infermation', style: TextStyle(fontSize: 30,
          fontWeight: FontWeight.bold,
          fontFamily: 'First',
        ),),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
            GestureDetector(
                onTap: (){
                    Navigator.of(context).pop();
                },
                child: Icon(Icons.camera_alt_sharp)),
            GestureDetector(
                onTap: (){
                  Navigator.of(context).pop();
                },
                child: Icon(Icons.chat_bubble_outline_sharp)),
            GestureDetector(
                onTap: (){
                  Navigator.of(context).pop();
                },
                child: Icon(Icons.contact_page_outlined)),
            GestureDetector(
                onTap: (){
                  Navigator.of(context).pop();
                },
                child: Icon(Icons.more_horiz_outlined)),
          ],),
        )
      ),
    ),
    body: OrientationBuilder(
      builder: (context,orientation){
        return  orientation==Orientation.landscape
              ? Column(
                children: [
                  Center(child: CircularProgressIndicator(
                    color: Colors.deepOrange,),),
                  Align(child: Text('Rotate Your Screen !!!\nLandscape mode Not Support !!!'),
                    alignment: FractionalOffset.center,),
                ],
              )
              : Padding(
          padding: const EdgeInsets.only(left: 5.0,top: 35),
          child: Container(
            width: 420,
            height:200,
            decoration: BoxDecoration(
              color: Colors.redAccent,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Name    : '+posts.data[index]['name'].toString(),
                    style: TextStyle(color: Colors.white),),
                  Text('E-Mail    : '+posts.data[index]['email'].toString(),
                    style: TextStyle(color: Colors.white),),
                  Text('Gender  : '+posts.data[index]['gender'].toString(),
                    style: TextStyle(color: Colors.white),),
                  Text('Status   : '+posts.data[index]['status'].toString(),
                    style: TextStyle(color: Colors.white),),
                ],
              ),
            ),
          ),
        );
      }
    ),
  );
}
Widget _buildPosts(BuildContext context, ResponseData posts) {
  return ListView.builder(
      itemCount: posts.data.length,
      itemBuilder: (context, index) {
        return Container(
          height: 100,
          child: Card(
            margin: EdgeInsets.all(1),
            semanticContainer: true,
              shadowColor: Colors.black,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  side: BorderSide(width: 1,color: Colors.black)),
              child: ListTile(
                onTap:  (){
                  print('OnTaped');
                Navigator.of(context).push(MaterialPageRoute(builder:(context)=>_postdetails(context, posts,index)));
                },
                onLongPress: (){
                  print('Longpressed');
                  Navigator.of(context).push(MaterialPageRoute(builder:(context)=>_postdetails(context, posts,index)));
                },
                leading: Icon(Icons.account_balance, color: Colors.redAccent, size: 45,),
                title: Text(posts.data[index]['name'], style: TextStyle(fontSize: 20),),
                subtitle: Text(
                  posts.data[index]['email'],
                  style: TextStyle(fontSize: 15),
                ),
                trailing: Text(posts.data[index]['status']),

              ),

          ),
        );
      },

  );
}
