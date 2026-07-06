import 'package:flutter/material.dart';

enum FooterAction { home, shop, kamAi, message, profile }

class FooterItemModel {
	const FooterItemModel({
		required this.icon,
		required this.label,
		required this.action,
		this.isKamAi = false,
	});

	final IconData icon;
	final String label;
	final FooterAction action;
	final bool isKamAi;
}

class FooterStyleModel {
	const FooterStyleModel({
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
}

class FooterModel {
	const FooterModel({
		this.style = const FooterStyleModel(),
		this.items = const [
			FooterItemModel(
				icon: Icons.home_outlined,
				label: 'Home',
				action: FooterAction.home,
			),
			FooterItemModel(
				icon: Icons.shopping_bag_outlined,
				label: 'Shop',
				action: FooterAction.shop,
			),
			FooterItemModel(
				icon: Icons.photo_camera_outlined,
				label: 'Kam AI',
				action: FooterAction.kamAi,
				isKamAi: true,
			),
			FooterItemModel(
				icon: Icons.send_outlined,
				label: 'Message',
				action: FooterAction.message,
			),
			FooterItemModel(
				icon: Icons.person_outline,
				label: 'Profile',
				action: FooterAction.profile,
			),
		],
	});

	final FooterStyleModel style;
	final List<FooterItemModel> items;
}
