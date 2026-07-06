import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:kamca_app/Controller/Footer_controller.dart';
import 'package:kamca_app/Model/Footer_Model.dart';

class KamcaFooter extends StatelessWidget {
	const KamcaFooter({
		super.key,
		required this.controller,
	});

	final FooterController controller;

	@override
	Widget build(BuildContext context) {
		final model = controller.model;
		final style = model.style;
		final kamAiItem = model.items.firstWhere(
			(item) => item.isKamAi,
			orElse: () => const FooterItemModel(
				icon: Icons.photo_camera_outlined,
				label: 'Kam AI',
				action: FooterAction.kamAi,
				isKamAi: true,
			),
		);

		const overlayTopPadding = 16.0;

		return SizedBox(
			height: style.height + overlayTopPadding,
			child: Stack(
				clipBehavior: Clip.none,
				children: [
					Positioned(
						left: 0,
						right: 0,
						bottom: 0,
						child: PhysicalShape(
							color: style.backgroundColor,
							elevation: 8,
							shadowColor: Colors.black.withOpacity(0.28),
							clipper: const _FooterBiteClipper(),
							child: Container(
								height: style.height,
								padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
								child: Row(
									crossAxisAlignment: CrossAxisAlignment.end,
									children: model.items
											.map(
												(item) => Expanded(
													child: item.isKamAi
															? _KamcaFooterLabelItem(item: item, style: style)
															: _FooterItem(
																	item: item,
																	style: style,
																	onTap: () async => await controller.onTap(context, item.action),
																),
												),
											)
											.toList(),
								),
							),
						),
					),
					Positioned(
						top: 3,
						left: 0,
						right: 0,
						child: Center(
							child: _KamcaFooterIconButton(
								item: kamAiItem,
								style: style,
								onTap: () async => await controller.onTap(context, kamAiItem.action),
							),
						),
					),
				],
			),
		);
	}
}

class _FooterItem extends StatelessWidget {
	const _FooterItem({
		required this.item,
		required this.style,
		required this.onTap,
	});

	final FooterItemModel item;
	final FooterStyleModel style;
	final Future<void> Function() onTap;

	@override
	Widget build(BuildContext context) {
		return Material(
			color: Colors.transparent,
			child: InkWell(
				onTap: () async => await onTap(),
				borderRadius: BorderRadius.circular(10),
				child: Column(
					mainAxisAlignment: MainAxisAlignment.end,
					mainAxisSize: MainAxisSize.min,
					children: [
						Icon(item.icon, color: style.iconColor, size: 23),
						const SizedBox(height: 10),
						Padding(
							padding: const EdgeInsets.only(bottom: 5),
							child: Text(
								item.label,
								style: TextStyle(
									color: style.labelColor,
									fontSize: 11,
									fontWeight: FontWeight.w500,
								),
							),
						),
					],
				),
			),
		);
	}
}

class _KamcaFooterLabelItem extends StatelessWidget {
	const _KamcaFooterLabelItem({
		required this.item,
		required this.style,
	});

	final FooterItemModel item;
	final FooterStyleModel style;

	@override
	Widget build(BuildContext context) {
		return Column(
			mainAxisAlignment: MainAxisAlignment.end,
			mainAxisSize: MainAxisSize.min,
			children: [
				const SizedBox(height: 32),
				Padding(
					padding: const EdgeInsets.only(bottom: 5),
					child: Text(
						item.label,
						style: TextStyle(
							color: style.labelColor,
							fontSize: 10.5,
							fontWeight: FontWeight.w600,
						),
					),
				),
			],
		);
	}
}

class _KamcaFooterIconButton extends StatelessWidget {
	const _KamcaFooterIconButton({
		required this.item,
		required this.style,
		required this.onTap,
	});

	final FooterItemModel item;
	final FooterStyleModel style;
	final Future<void> Function() onTap;

	@override
	Widget build(BuildContext context) {
		return Material(
			color: Colors.transparent,
			shape: const CircleBorder(),
			child: InkWell(
				onTap: () async => await onTap(),
				customBorder: const CircleBorder(),
				child: Container(
					width: 55,
					height: 55,
					decoration: BoxDecoration(
						color: style.kamcaIconBackgroundColor,
						shape: BoxShape.circle,
						boxShadow: [
							BoxShadow(
								color: Colors.black.withOpacity(0.18),
								blurRadius: 8,
								offset: const Offset(0, 3),
							),
						],
					),
					child: Icon(item.icon, color: style.iconColor, size: 33),
				),
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
