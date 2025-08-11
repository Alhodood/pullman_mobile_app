import 'package:flutter/material.dart';

class AppDropDownButton extends StatelessWidget {
  const AppDropDownButton(
      {Key? key, required this.itemList, this.hint, required this.onChange})
      : super(key: key);
  final List itemList;
  final String? hint;
  final void Function(dynamic) onChange;

  @override
  Widget build(BuildContext context) {
    return Container(padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(   
        // border: Border.all(color: const Color.fromRGBO(105, 105, 105, 0.25) ),
           color: Colors.transparent
,borderRadius: BorderRadius.circular(10)),
        height: 40,
        width: double.infinity,
        child: DropdownButton(
          hint: Text(hint.toString()),
          underline: const SizedBox(),
          items: itemList.map((element) {
            return DropdownMenuItem(
              value: element,
              child: Text(element),
            );
          }).toList(),
          onChanged: onChange,
          isExpanded: true,
        ));
  }
}