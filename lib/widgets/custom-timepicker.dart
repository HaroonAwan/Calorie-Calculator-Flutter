import 'package:flutter/material.dart';

class CustomTimePicker extends StatefulWidget {
  TimeOfDay time;
  final title;
  final Function(TimeOfDay) onChanged;
  CustomTimePicker({this.title = "Time", this.onChanged,this.time});

  @override createState() => _CustomTimePickerState();
}

class _CustomTimePickerState extends State<CustomTimePicker> {
  var _textFieldController = TextEditingController();
  TimeOfDay time = TimeOfDay.now();

  @override initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      _textFieldController.text = widget?.time?.format(context) ?? time?.format(context);
    });
    widget.onChanged(time);
  }

  @override build(context) => Padding(
    padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 10),
    child: GestureDetector(
      onTap: () async {
        FocusScope.of(context).nextFocus();
        TimeOfDay t = await showTimePicker(
            context: context,
            initialTime: time
        );
        if(t == null){
          return;
        }
        else{
          setState(() {
            time =t;
            this._textFieldController.text = t.format(context);
            widget.onChanged(t);
          });
        }
      },
      child: Stack(
        children: [
          TextField(
            enabled: false,
            controller: _textFieldController,
            decoration: InputDecoration(
                isDense: true,
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey)),
                labelText: widget.title,
                labelStyle: TextStyle(
                    color: Colors.black
                ),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey)
                )
            ),
          ),

          Align(
            alignment: Alignment(1,-1),
            child: IconButton(
              icon: Icon(Icons.timer),

              onPressed: () async {
                FocusScope.of(context).nextFocus();
                TimeOfDay t = await showTimePicker(
                    context: context,
                    initialTime: time
                );
                if(t == null){
                  return;
                }
                else{
                  setState(() {
                    time =t;
                    this._textFieldController.text = t.format(context);
                    widget.onChanged(t);
                  });
                }
              },
            ),
          ),
        ],
      ),
    ),
  );
}