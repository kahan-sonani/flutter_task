import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InputWidget extends StatefulWidget {

  Function onButtonClick;

  Icon iconWidget;

  String? title, label, btnText, data;

  InputWidget({Key? key, required this.onButtonClick, this.title, this.label, this.btnText = 'Add', this.iconWidget = const Icon(Icons.add), this.data = ''}) : super(key: key);

  @override
  State<InputWidget> createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {
  final textController = TextEditingController();


  @override
  void dispose(){
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed: (){
      _displayDialog(context);
      textController.text = widget.data!;
    }, icon: widget.iconWidget);
  }

  _displayDialog(context) async{
    return showDialog(
        context: context,
        builder: (context){
          return CupertinoAlertDialog(
            title: Container(
                margin: const EdgeInsets.only(bottom: 20.0),
                child: Text(widget.title!)),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 10),
                    child: Text(
                      widget.label!,
                      style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
                    ),
                  ),
                ),
                Card(
                  child: TextField(
                    controller: textController,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                CupertinoButton.filled(
                  onPressed:(){
                    widget.onButtonClick(textController.text);
                    textController.text = '';
                  },
                  child: Text(widget.btnText!),
                ),
              ],
            ),
          );
        });
  }
}
