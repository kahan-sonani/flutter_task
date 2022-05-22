import 'package:flutter/material.dart';
import 'package:flutter_task/views/edit_view.dart';
import 'package:flutter_task/widgets/dialogwidget.dart';
import 'package:flutter_task/widgets/subCategory.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter DropDownButton',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

// Initial Selected Value
  String? dropdownvalue;

// List of items in our dropdown menu
  Map<String, List<String>> categories = {};

  Widget? dialog;

  List<Widget> subCategories = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Task"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
            children: [
              Center(
                child: Container(
                  margin: const EdgeInsets.only(top: 20.0),
                  child: const Text(
                    "Categories",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: DropdownButton(
                          isExpanded: true,
                          value: dropdownvalue,
                          icon: const Icon(Icons.keyboard_arrow_down),
                          items: categories.keys.map<DropdownMenuItem<String>>((String _value) => DropdownMenuItem<String>(
                              value: _value, // add this property an pass the _value to it
                              child: Text(_value,
                                style: const TextStyle(
                                  color: Colors.blue
                                ),
                              )))
                              .toList(),
                          onChanged: (String? e){
                            setState((){
                              dropdownvalue = e!;
                            });
                          }
                      ),
                    ),
                    InputWidget(
                        onButtonClick: categoryAddCallBack,
                        label: 'Category Name',
                        title: 'Add Category'
                    ),
                  ],
                ),
              ),
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: subCategories,
             ),
              SubCategoryList(items: categories[dropdownvalue] ?? []),
            ],
          ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(
              builder: (context) => EditView(categories: categories,)));
        },
        tooltip: 'Next',
        child: const Icon(Icons.navigate_next),
      ),
    );
  }

  categoryAddCallBack(text){
    if(categories.isEmpty){
      subCategories = [
        const Text(
          'Sub Categories',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20
          ),
        ),
        InputWidget(
          onButtonClick: subCategoryAddCallback,
          title: 'Add Sub Category',
          label: 'Sub Category Name',
        ),
      ];
    }

    if(categories.containsKey(text)) {
      const snackBar = SnackBar(
        content: Text('Category already exists!'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    else {
      categories.putIfAbsent(text, () => <String>[]);
      setState((){
        dropdownvalue = text;
      });
      Navigator.pop(context);
    }
  }

  subCategoryAddCallback(text){

    List<String>? list = categories[dropdownvalue];

    if(list!.contains(text)){
      const snackBar = SnackBar(
          content: Text('Sub Category already exists!')
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    else{
      setState((){
        list.add(text);
        setState((){});
      });
      Navigator.pop(context);
    }
  }
}






