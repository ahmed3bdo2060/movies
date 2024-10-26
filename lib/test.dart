import 'package:flutter/material.dart';

class Test extends StatefulWidget{
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  late List <TextEditingController >controller = [];
  String? type;
  int count = 0;
  @override
  void initState() {
    super.initState();
    controller.addAll(List.generate(1, (_) => TextEditingController()));

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              TextField(
                controller:controller[count] ,
                decoration: InputDecoration(fillColor: Colors.red),),
              TextButton(onPressed: () {
                count++;
                controller.addAll(List.generate(count, (_) => TextEditingController()));
                setState(() {

                });

              }, child: Text("press")),
              Expanded(
                child: GridView.builder(
                  itemCount: count,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,

                  ),
                  itemBuilder: (context, index) => Text(controller[index].text),),
              )
            ],
          ),
        ),
      ),

    );
  }
}