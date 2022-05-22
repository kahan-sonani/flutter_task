import 'package:flutter/material.dart';
import 'package:flutter_task/widgets/dialogwidget.dart';

class CategoryList extends StatefulWidget {

  CategoryList({Key? key, required this.categories}) : super(key: key);

  Map<String, List<String>> categories;
  Map<String, bool> checked = {};

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: widget.categories.keys.length,
        itemBuilder: (BuildContext context, int index){
          return ExpansionTile(
            title: Text(widget.categories.keys.elementAt(index)),
            trailing: const Icon(Icons.expand_more),
            children: widget.categories.values.elementAt(index).map((e){
              return Container(
                      padding: const EdgeInsets.fromLTRB(20, 15, 15, 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(e),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Checkbox(
                                  value: widget.checked.keys.contains(e) ? widget.checked[e] : false,
                                  onChanged: (val){
                                    setState((){widget.checked[e] = val!;});
                              }),
                              InputWidget(
                                  onButtonClick: (text){
                                    setState((){
                                      if(widget.categories.values.elementAt(index).contains(text)) {
                                        const snackBar = SnackBar(
                                            content: Text('Use a different sub category name!')
                                        );
                                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                      }
                                      else {
                                        widget.categories.values.elementAt(index).remove(e);
                                        widget.categories.values.elementAt(index).add(text);
                                        Navigator.pop(context);
                                      }
                                    });
                                  },
                                  title: 'Update Sub Category',
                                  label: 'Sub Category Name',
                                  iconWidget: const Icon(Icons.edit),
                                  btnText: 'Update',
                                  data: e,
                              ),
                              IconButton(onPressed: (){
                                setState((){
                                  widget.categories.values.elementAt(index).remove(e);
                                  widget.checked.remove(e);
                                });
                              }, icon: const Icon(Icons.delete)),
                            ],
                          ),
                        ],
                      )
                  );
            }).toList(),
          );
        }
    );
  }
  deleteSelected(){
    for(int i = 0; i < widget.checked.keys.length; i++){
      bool v = widget.checked.values.elementAt(i);
      if(v){
        String sub = widget.checked.keys.elementAt(i);
        widget.categories.values.map((List<String> list){
          if(list.contains(sub)){
            list.remove(sub);
          }
        });
      }
    }
  }
}
