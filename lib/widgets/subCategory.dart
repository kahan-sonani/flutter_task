import 'package:flutter/cupertino.dart';

class SubCategoryList extends StatefulWidget {

  SubCategoryList({Key? key, required this.items}) : super(key: key);

  List<String> items = [];

  @override
  State<SubCategoryList> createState() => _SubCategoryListState();
}

class _SubCategoryListState extends State<SubCategoryList> {

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: widget.items.length,
        itemBuilder: (BuildContext ctx, int index){
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
            child: Text(widget.items[index]),
          );
        }
    );
  }
}
