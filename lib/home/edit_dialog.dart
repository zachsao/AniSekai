import 'package:anisekai/graphql/operations.dart';
import 'package:anisekai/home/progress_mutation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class EditDialog extends StatefulWidget {
  const EditDialog(
      {Key? key,
      required this.entryId,
      required this.title,
      required this.currentProgress,
      required this.maxProgress})
      : super(key: key);
      
  final int entryId;
  final String title;
  final int currentProgress;
  final int maxProgress;

  @override
  State<EditDialog> createState() => _EditDialogState();
}

class _EditDialogState extends State<EditDialog> {
  late TextEditingController textController;

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    textController =
        TextEditingController(text: widget.currentProgress.toString());
    super.initState();
  }

  void increment() {
    setState(() {
      int previousValue = int.parse(textController.text);
      int newValue = previousValue == widget.maxProgress
          ? widget.maxProgress
          : previousValue + 1;
      textController.text = "$newValue";
    });
  }

  void decrement() {
    setState(() {
      int previousValue = int.parse(textController.text);
      int newValue = previousValue == 0 ? 0 : previousValue - 1;
      textController.text = "$newValue";
    });
  }

  void onSavePressed(RunMutation runMutation) {
    int progress = int.parse(textController.text);
    runMutation({"entryId": widget.entryId, "progress": progress});
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xFF2B2D42),
      title: Text(widget.title),
      titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 8.0),
            child: Text(
              'Episode progress',
              style: TextStyle(color: Colors.white),
            ),
          ),
          Row(
            children: [
              IconButton(
                onPressed: decrement,
                icon: const Icon(Icons.arrow_drop_down),
                iconSize: 48,
                color: Colors.white,
              ),
              Expanded(
                child: TextField(
                  controller: textController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide.none),
                      fillColor: Color(0xFF393B54),
                      filled: true),
                  style: const TextStyle(color: Colors.white),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                ),
              ),
              IconButton(
                onPressed: increment,
                icon: const Icon(Icons.arrow_drop_up),
                iconSize: 48,
                color: Colors.white,
              ),
            ],
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => {Navigator.pop(context)},
          child: const Text('CANCEL'),
        ),
        buildMutation(entryUpdateMutation, (_, runMutation) {
          return TextButton(
            onPressed: () => { onSavePressed(runMutation) },
            child: const Text('SAVE'),
          );
        })
      ],
    );
  }
}
