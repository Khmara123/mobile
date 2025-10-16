import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Widget currencyMenuItem() {
    return Column(
      children: [
        CircleAvatar(radius: 20),
        Text("some text"),
        Text("some text"),
      ],
    );
  }

  Widget calendarItem() {
    return Container(
      child: Column(children: [Text("date"), Text("date2"), Text("date3")]),
    );
  }

  Widget calendar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        calendarItem(),
        calendarItem(),
        calendarItem(),
        calendarItem(),
        calendarItem(),
      ],
    );
  }

  Widget currencyList() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(child: Row(children: [Text('1'), Text('___2')])),
        Container(color: Colors.red, width: 100, height: 100),
      ],
    );
  }

  Widget currencyMenu() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [currencyMenuItem(), currencyMenuItem(), currencyMenuItem()],
    );
  }

  Widget headerTop() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(height: 100, width: 100, child: CircleAvatar(radius:20)),
        Container(height: 50, width: 200,// color: Colors.yellow,
                 
    ),
      ],
    );
  }

  Widget headerContent() {
    return Row(children: [ Column(
      
      //      crossAxisAlignment: CrossAxisAlignment.start,
      
       
      children: [
        
        SizedBox(height:15),
        Container(
       //   color: Colors.red,
       //   height: 20,
          width: 100,
          child: Text("first text"),
        ),
        Container(
      //    color: Colors.black,
      //    height: 20,
          width: 100,
          child: Text("second text"),
        ),
         SizedBox(height:15),
      ])],
    );
  }

  Widget header() {
    return Container(
      //alignment: Alignment.centerLeft,
      //     alignment: AlignmentGeometry.xy(  x:0 ,y:0   ),
      padding: EdgeInsetsGeometry.only(left: 30, right: 30),
       decoration: BoxDecoration(color:Colors.red,
                                            image: const DecorationImage(
      image: NetworkImage('https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg'),
      fit: BoxFit.cover)),
      child: Column(children: [headerTop(), headerContent()]),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Column()

    return MaterialApp(
      home: Scaffold(
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [header(), currencyMenu(), calendar(), currencyList()],
          ),
        ),
      ),
    );

    //  Center(child: Text('Hello, World!'))  ),

    //    Container();
  }
}