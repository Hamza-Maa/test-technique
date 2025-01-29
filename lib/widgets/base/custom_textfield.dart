import 'package:flutter/material.dart';

class StyledInputField extends StatefulWidget {
  final TextEditingController controller;
  final String hint;
  final TextInputType inputType;
  final bool obscureText;
  final ValueChanged<String>? onChanged;

  const StyledInputField({
    super.key,
    required this.controller,
    required this.hint,
    this.inputType = TextInputType.text,
    this.obscureText = false,
    this.onChanged,
  });

  @override
  _StyledInputFieldState createState() => _StyledInputFieldState();
}

class _StyledInputFieldState extends State<StyledInputField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      keyboardType: widget.inputType,
      obscureText: _obscureText,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        hintText: widget.hint,
        hintStyle: TextStyle(color: Color(0xFFB4B4B4)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: const BorderSide(color: Color(0xFFB4B4B4)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: const BorderSide(color: Color(0xFFB4B4B4)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: const BorderSide(color: Color(0xFFB4B4B4)),
        ),
        suffixIcon: widget.obscureText
            ? IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                  color: Color(0xFFB4B4B4),
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              )
            : null,
        contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      ),
      style: const TextStyle(color: Colors.black, fontSize: 14),
    );
  }
}
