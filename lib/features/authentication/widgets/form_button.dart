import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class FormButton extends StatelessWidget {
  final void Function(BuildContext)? onTapGesture;
  final bool isEmpty;
  final String buttonText;

  const FormButton({
    super.key,
    required this.isEmpty,
    this.onTapGesture,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapGesture != null ? () => onTapGesture!(context) : null,
      child: FractionallySizedBox(
        widthFactor: 1,
        child: AnimatedContainer(
          padding: const EdgeInsets.symmetric(
            vertical: Sizes.size12,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Sizes.size5),
            color:
                isEmpty ? Colors.grey.shade300 : Theme.of(context).primaryColor,
          ),
          duration: const Duration(milliseconds: 300),
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 300),
            style: TextStyle(
              color: isEmpty ? Colors.grey.shade400 : Colors.white,
              fontWeight: FontWeight.w600,
            ),
            child: Text(
              buttonText,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
