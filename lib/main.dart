import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  late String userToken;
  bool setup = false;

  void saveCredentials(String ipAddr, String passwd, String username) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('ipAddr', ipAddr);
    await prefs.setString('username', username);
    await prefs.setString('password', passwd);

  }


  void checkSetup() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? setupPref = prefs.getString('ipAddr');
    if (setupPref == null) {
      setup = true;
    } else {
      setup = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    checkSetup();
    if (setup == true) {
      final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

      String? _ipAddr = "";
      String? _username = "";
      String? _password = "";

      return Scaffold(
        body: Center(
          child: Padding(padding: const EdgeInsets.all(25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                          TextFormField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'IP-Address of Server',
                          ),
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                            onChanged: (String? value) {
                              _ipAddr = value;
                            },
                    ),
                TextFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Username',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your username';
                      }
                      return null;
                    },
                  onChanged: (String? value) {
                      _username = value;

                  },
                ),
                      TextFormField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                        ),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                        onChanged: (String? value) {
                          _password = value;
                        },
                      ),
                      FloatingActionButton.extended(
                        label: const Text("Save"),
                        icon: const Icon(Icons.save),
                        onPressed: () {
                          saveCredentials(_ipAddr!, _password!, _username!);
                        }
                      )
                    ]),
                )
            ],
          ),
        ),
      ));

    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              'Za',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
