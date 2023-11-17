import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: cat(),
  ));
}

Stream<int> add() async* {
  for (int i = 1; i <= 10; i++) {
    await Future.delayed(Duration(seconds: 1));
    yield i;
  }
}
List data = [];
class cat extends StatelessWidget {
  const cat({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: StreamBuilder(
            stream: add(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(child: Text("error"));
              } else {
                data.add(snapshot.data);
                print(data);
                return Center(
                    child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) {
                      return Text(
                        data[index].toString(),
                        style: TextStyle(fontSize: 30),
                      );
                    },));
              }
            }),
      ),
    );
  }
}
