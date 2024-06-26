import 'package:cardgame/screen/game.dart';
import 'package:flutter/material.dart';
import 'package:cardgame/screen/highscore.dart';
import 'package:cardgame/screen/login.dart';
import 'package:cardgame/screen/result.dart';
import 'package:shared_preferences/shared_preferences.dart';

String active_user="";
String _user_id = "";

void doLogout() async {
  final prefs = await SharedPreferences.getInstance();
  prefs.remove("user_id");
  main();
}


Future<String> checkUser() async {
    final prefs = await SharedPreferences.getInstance();
    String user_id = prefs.getString("user_id") ?? '';
    return user_id;
  }

void main() {
  // runApp(const MyApp());
    WidgetsFlutterBinding.ensureInitialized();
  checkUser().then((String result) {
    if (result == '')
      runApp(MyLogin());
    else {
      active_user = result;
      runApp(MyApp());
    }
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //kalo mau tambahain routes baru, bisa  ditambahkan sesudah 'about': (context) => About(),'history': (context) => History(),
      routes: { 'game': (context) => Game(),
                'result': (context) => Result(),
                'highscore': (context) => Highscore(),
                'login': (context) => MyLogin(),
                },
      title: 'Card Game',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Card Game'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // int _counter = 0;

  // void _incrementCounter() {
  //   setState(() {

  //     _counter++;
  //   });
  // }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(widget.title),
      ),
      drawer: myDrawer(),
      body: Center(
        child: Column(children: [
        Text("Play Button"),
        ElevatedButton(
          // style: ButtonStyle(backgroundColor:),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Game()));
            },
            child: Text("Game")),
      ]),
      ),
    );
  }

    Drawer myDrawer() {
    return Drawer(
      elevation: 16.0,
      child: Column(
        children: <Widget>[
          UserAccountsDrawerHeader(
              accountName: Text("Theodorus"),
              accountEmail: Text(active_user),
              // accountEmail: Text("Theodorus@gmail.com"),
              currentAccountPicture: CircleAvatar(
              backgroundImage:
                  NetworkImage("https://i.pravatar.cc/150"))
          ),
          ListTile(
            title: new Text("High Score"),
            leading: new Icon(Icons.numbers_outlined),
            onTap: () {
                Navigator.popAndPushNamed(
                    context, 'highscore');}
          ),
          // ListTile(
          //   title: new Text("Logout"),
          //   leading: new Icon(Icons.person),
          //   onTap: () {
          //       Navigator.popAndPushNamed(
          //           context, 'login');}
          // ),
          ListTile(
            // title: new Text("Login "),
            title: new Text(active_user != ""? "Logout":"Login"),
            leading: new Icon(active_user != "" ? Icons.logout : Icons.login),
            onTap: () {
              if (active_user != "") {
                doLogout();
              } else {
                Navigator.popAndPushNamed(
                    //ini lebih oke, krn drawernya ketutup kalo balik
                    context,
                    'login');
              }
            }
          ),
          
        ],
      ),
    );
  }
}
