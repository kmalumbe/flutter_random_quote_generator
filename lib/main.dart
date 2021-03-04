import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'QuoteModel.dart';
import 'Controller.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  //Set status bar and system navigation bar color
  SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.white,
    statusBarIconBrightness: Brightness.dark,
    systemNavigationBarColor: Colors.white,
    systemNavigationBarIconBrightness: Brightness.dark,
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      title: 'Flutter Random Quote Generator',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({
    Key key,
  }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Controller controller = Get.put(Controller());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            'Random Quote Generator',
            style: TextStyle(
                color: Colors.black,
                // fontFamily: 'Merienda',
                fontWeight: FontWeight.bold,
                ),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
          child: Obx(
            () => Container(
              height: MediaQuery.of(context).size.height -
                  (56 + MediaQuery.of(context).padding.top),
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: controller.quoteList.isEmpty && controller.loading.value == false
                  ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Problem loading quotes...\nCheck your internet connection.',
                textAlign: TextAlign.center,),
                      SizedBox(height: 18,),
                      FlatButton(
                          onPressed: () async {
                            await controller.fetchQuotes();
                          },
                          height: 60,
                          shape:
                          CircleBorder(side: BorderSide(color: Colors.grey)),
                          child: Icon(
                            Icons.refresh,
                            size: 32,
                            color: Colors.black87,
                          ))
                    ],
                  )
                  : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    controller.loading.value
                        ? CupertinoActivityIndicator()
                        : Text(
                            controller.quote.text ?? '',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 32,
                              color: Colors.black,
                              height: 1.3,
                              letterSpacing: 1,
                              fontFamily: 'Merienda',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                    SizedBox(
                      height: 14,
                    ),
                    controller.loading.value
                        ? Text('Loading quotes...')
                        : Text(
                            controller.quote.author != null
                                ? '- ${controller.quote.author} -'
                                : '- Unknown Author -',
                            textAlign: TextAlign.center,
                            softWrap: true,
                            style: TextStyle(fontSize: 16),
                          ),
                    SizedBox(
                      height: 18,
                    ),
                    controller.loading.value
                        ? Container()
                        :FlatButton(
                        onPressed: () async {
                          setState(() {
                            controller.quote = controller.quoteList[controller
                                .random
                                .nextInt(controller.quoteList.length)];
                          });
                        },
                        height: 60,
                        shape:
                            CircleBorder(side: BorderSide(color: Colors.grey)),
                        child: Icon(
                          CupertinoIcons.shuffle,
                          size: 32,
                          color: Colors.black87,
                        ))
                  ]),
            ),
          ),
        ));
  }
}
