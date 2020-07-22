import 'package:flutter/material.dart';
import 'package:AziApp/ytvideo.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart' show Video;

void main() {
  ErrorWidget.builder = (FlutterErrorDetails details) {
    return Container(
      alignment: Alignment.center,
      child: 
        Image.asset("assets/OnException2.png"),
        
    );
    };
    runApp(AziApp());
} 

Widget onExpection (FlutterErrorDetails error) {
  return Center (child: Text("ERROR!"),);
}

class AziApp extends StatefulWidget {
  AziApp({Key key}) : super(key: key);
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<AziApp> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  List<Widget> _widgetOptions = <Widget>[
    Center(
        child: FutureBuilder<Video>(
            future: fetchAziYT(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Image.network(snapshot.data.thumbnails.maxResUrl),
                    Text(snapshot.data.title),
                  ],
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return CircularProgressIndicator();
            })),
    Text(
      'Index 1: Azi_SNS',
      style: optionStyle,
    ),
    Text(
      'Index 2: Azi_Info',
      style: optionStyle,
    ),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    throw ("에러화면 테스트!");
    return MaterialApp(
      title: 'AziApp',
      home: Scaffold(
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.video_library),
              title: Text('아지 유튜브'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.people),
              title: Text('아지 SNS'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.info),
              title: Text('아지 정보'),
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.pink[300],
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
