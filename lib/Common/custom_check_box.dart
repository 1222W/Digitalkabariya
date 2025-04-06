import 'package:digital_kabaria_app/utils/app_colors.dart';
import 'package:flutter/material.dart';

class CustomCheckboxListTile extends StatefulWidget {
  final bool? value;
  final String? text;
  final void Function(bool?)? onChanged;

  const CustomCheckboxListTile({super.key, this.value, this.onChanged, this.text});

  @override
  _CustomCheckboxListTileState createState() => _CustomCheckboxListTileState();
}

class _CustomCheckboxListTileState extends State<CustomCheckboxListTile> {
  late bool _isChecked;

  @override
  void initState() {
    super.initState();
    _isChecked = widget.value ?? false;
  }

  void _onChanged(bool? newValue) {
    setState(() {
      _isChecked = newValue ?? false;
    });
    if (widget.onChanged != null) {
      widget.onChanged!(newValue);
    }
  }

  @override
  void didUpdateWidget(CustomCheckboxListTile oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      setState(() {
        _isChecked = widget.value ?? false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Checkbox(
activeColor: AppColors.appColor,          value: _isChecked,
          onChanged: _onChanged,
        ),
        GestureDetector(
          onTap: () {
            _onChanged(!_isChecked);
          },
          child: Text(widget.text ?? ''),
        ),
      ],
    );
  }
}
