import 'package:flutter/material.dart';

class KamcaButton extends StatefulWidget {
	const KamcaButton({
		super.key,
		required this.text,
		required this.onPressed,
		this.backgroundColor = const Color.fromARGB(255, 220, 192, 187),
		this.textColor = const Color.fromARGB(255, 0, 0, 0),
		this.width,
		this.height = 40,
		this.borderRadius = 20,
		this.textStyle,
	});

	final String text;
	final Future<void> Function()? onPressed;
	final Color backgroundColor;
	final Color textColor;
	final double? width;
	final double height;
	final double borderRadius;
	final TextStyle? textStyle;

	@override
	State<KamcaButton> createState() => _KamcaButtonState();
}

class _KamcaButtonState extends State<KamcaButton> {
	bool _isLoading = false;

	Future<void> _handleTap() async {
		final callback = widget.onPressed;
		if (_isLoading || callback == null) return;

		setState(() {
			_isLoading = true;
		});

		try {
			await callback();
		} finally {
			if (!mounted) return;
			setState(() {
				_isLoading = false;
			});
		}
	}

	@override
	Widget build(BuildContext context) {
		return SizedBox(
			width: widget.width,
			height: widget.height,
			child: ElevatedButton(
				onPressed: _handleTap,
				style: ElevatedButton.styleFrom(
					backgroundColor: widget.backgroundColor,
					shape: RoundedRectangleBorder(
						borderRadius: BorderRadius.circular(widget.borderRadius),
					),
					textStyle: widget.textStyle ?? const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
				),
				child: _isLoading
						? const SizedBox(
								width: 16,
								height: 16,
								child: CircularProgressIndicator(strokeWidth: 2),
							)
						: Text(
								widget.text,
								style: TextStyle(color: widget.textColor),
							),
			),
		);
	}
}
