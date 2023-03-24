import 'package:flutter/material.dart';
import 'package:shake_example/constants/colors.dart';

class Toggle extends StatelessWidget {
  final String text;
  final bool enabled;
  final Function onChanged;

  Toggle(
    this.text,
    this.enabled,
    this.onChanged,
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 16,
        ),
        height: 52,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(24)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 5,
                offset: Offset(0, 1),
              )
            ]),
        child: Row(
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Switch(
                activeColor: ThemeColors.primaryColor,
                value: enabled,
                onChanged: (bool value) {
                  onChanged(value);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
