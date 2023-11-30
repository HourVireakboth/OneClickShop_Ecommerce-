import 'package:flutter/material.dart';
import 'package:oneclickshop/misc/color.dart';


class ChoiceChipWidget extends StatefulWidget {
  final List<String> reportList;

  ChoiceChipWidget(this.reportList);

  @override
  // ignore: library_private_types_in_public_api
  _ChoiceChipWidgetState createState() => _ChoiceChipWidgetState();
}

class _ChoiceChipWidgetState extends State<ChoiceChipWidget> {
  String selectedChoice = "";

  _buildChoiceList() {
    List<Widget> choices = [];
    widget.reportList.forEach((item) {
      choices.add(Container(
        padding: const EdgeInsets.only(right: 14),
        child: ChoiceChip(
          label: Text(item),
          labelStyle: const TextStyle(
              color: Colors.black, fontSize: 14.0, fontWeight: FontWeight.bold),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          side: BorderSide(width: 1 ,color: AppColor.textgreyColor ),
          backgroundColor: AppColor.backgroundWhite ,
          selectedColor: AppColor.backgroudButtonColor,
          selected: selectedChoice == item,
          onSelected: (selected) {
            setState(() {
              selectedChoice = item;
            });
          },
        ),
      ));
    });
    return choices;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: _buildChoiceList(),
    );
  }
}