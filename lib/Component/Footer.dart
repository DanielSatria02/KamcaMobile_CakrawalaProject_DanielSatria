import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class KamcaFooter extends StatelessWidget {
	const KamcaFooter({
		super.key,
		this.height = 86,
		this.backgroundColor = const Color.fromARGB(255, 35, 53, 49),
		this.iconColor = const Color.fromARGB(255, 220, 192, 187),
		this.labelColor = const Color.fromARGB(255, 220, 192, 187),
		this.kamcaIconBackgroundColor = const Color.fromARGB(255, 35, 53, 49),
	});

	final double height;
	final Color backgroundColor;
	final Color iconColor;
	final Color labelColor;
	final Color kamcaIconBackgroundColor;

	@override
	Widget build(BuildContext context) {
		return PhysicalShape(
			color: backgroundColor,
			elevation: 8,
			shadowColor: Colors.black.withOpacity(0.28),
			clipper: const _FooterBiteClipper(),
			child: Container(
				height: height,
				padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
				child: Row(
					crossAxisAlignment: CrossAxisAlignment.end,
					children: [
						Expanded(
							child: _FooterItem(
								icon: Icons.home_outlined,
								label: 'Home',
								iconColor: iconColor,
								labelColor: labelColor,
							),
						),
						Expanded(
							child: _FooterItem(
								icon: Icons.shopping_bag_outlined,
								label: 'Shop',
								iconColor: iconColor,
								labelColor: labelColor,
							),
						),
						Expanded(
							child: _KamcaFooterItem(
								iconColor: const Color.fromARGB(255, 220, 192, 187),
								labelColor: labelColor,
								circleBackgroundColor: kamcaIconBackgroundColor,
							),
						),
						Expanded(
							child: _FooterItem(
								icon: Icons.send_outlined,
								label: 'Message',
								iconColor: iconColor,
								labelColor: labelColor,
							),
						),
						Expanded(
							child: _FooterItem(
								icon: Icons.person_outline,
								label: 'Profile',
								iconColor: iconColor,
								labelColor: labelColor,
							),
						),
					],
				),
			),
		);
	}
}

class _FooterItem extends StatelessWidget {
	const _FooterItem({
		required this.icon,
		required this.label,
		required this.iconColor,
		required this.labelColor,
	});

	final IconData icon;
	final String label;
	final Color iconColor;
	final Color labelColor;

	@override
	Widget build(BuildContext context) {
		return Column(
			mainAxisAlignment: MainAxisAlignment.end,
			mainAxisSize: MainAxisSize.min,
			children: [
				Icon(icon, color: iconColor, size: 23),
				const SizedBox(height: 10),
				Padding(
					padding: const EdgeInsets.only(bottom: 5),
					child: Text(
						label,
						style: TextStyle(
							color: labelColor,
							fontSize: 11,
							fontWeight: FontWeight.w500,
						),
					),
				),
			],
		);
	}
}

class _KamcaFooterItem extends StatelessWidget {
	const _KamcaFooterItem({
		required this.iconColor,
		required this.labelColor,
		required this.circleBackgroundColor,
	});

	final Color iconColor;
	final Color labelColor;
	final Color circleBackgroundColor;

	@override
	Widget build(BuildContext context) {
		return SizedBox(
			height: 70,
			child: Stack(
				clipBehavior: Clip.none,
				alignment: Alignment.topCenter,
				children: [
					Positioned(
						top: -21,
						child: Container(
							width: 55,
							height: 55,
							decoration: BoxDecoration(
								color: circleBackgroundColor,
								shape: BoxShape.circle,
								boxShadow: [
									BoxShadow(
										color: Colors.black.withOpacity(0.18),
										blurRadius: 8,
										offset: const Offset(0, 3),
									),
								],
							),
							child: Icon(Icons.photo_camera_outlined, color: iconColor, size: 33),
						),
					),
					Positioned(
						bottom: 5,
						child: Text(
							'Kam AI',
							style: TextStyle(
								color: labelColor,
								fontSize: 10.5,
								fontWeight: FontWeight.w600,
							),
						),
					),
				],
			),
		);
	}
}

class _FooterBiteClipper extends CustomClipper<Path> {
	const _FooterBiteClipper();

	@override
	Path getClip(Size size) {
		const cornerRadius = 50.0;
		const biteRadius = 50.0;

		final basePath = Path()
			..addRRect(
				RRect.fromRectAndCorners(
					Rect.fromLTWH(0, 0, size.width, size.height),
					topLeft: Radius.circular(cornerRadius),
					topRight: Radius.circular(cornerRadius),
				),
			);

		final bitePath = Path()
			..addOval(
				Rect.fromCircle(
					center: Offset(size.width / 2, 0),
					radius: biteRadius,
				),
			);

		return Path.combine(ui.PathOperation.difference, basePath, bitePath);
	}

	@override
	bool shouldReclip(covariant _FooterBiteClipper oldClipper) {
		return false;
	}
}
