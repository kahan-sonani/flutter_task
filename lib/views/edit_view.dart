import 'package:flutter/material.dart';
import 'package:flutter_task/widgets/expandableTile.dart';

class EditView extends StatelessWidget {

  Map<String, List<String>> categories;

  EditView({Key? key, required this.categories}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
        leading: GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back
          ),
        ),
        actions: [
          GestureDetector(
            onTap: (){
              //TODO: delete selected items from the menuBar remaining
            },
            child: const Padding(
              padding: EdgeInsets.all(15.0),
              child: Icon(Icons.delete),
            ),
          )
        ],
      ),
      body: CategoryList(categories: categories,),
    );
  }
}
