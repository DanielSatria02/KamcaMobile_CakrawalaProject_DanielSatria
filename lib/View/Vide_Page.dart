import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kamca_app/Component/Button.dart';
import 'package:kamca_app/Component/Header.dart';
import 'package:kamca_app/Controller/Vide_controller.dart';
import 'package:kamca_app/Service/user_session.dart';

class VidePage extends StatefulWidget {
	const VidePage({
		super.key,
		this.userName,
		this.profileImageAsset,
		this.capturedImagePath,
		this.controller,
	});

 	final String? userName;
	final String? profileImageAsset;
	final String? capturedImagePath;
	final VidePageController? controller;

	@override
	State<VidePage> createState() => _VidePageState();
}

class _VidePageState extends State<VidePage> {
	late final VidePageController _videPageController;
	late final String _userName;
	late final String? _profileImageAsset;

	@override
	void initState() {
		super.initState();
		_userName = widget.userName ?? KamcaSessionStore.instance.userName;
		_profileImageAsset = widget.profileImageAsset ?? KamcaSessionStore.instance.profileImageAsset;
		_videPageController = widget.controller ??
				VidePageController(
					userName: _userName,
					profileImageAsset: _profileImageAsset,
					capturedImagePath: widget.capturedImagePath,
				);
	}

	@override
	Widget build(BuildContext context) {
		final headerController = _videPageController.headerController;
		final panelModel = headerController.panelModel;
		final Size size = MediaQuery.of(context).size;
		final double panelWidth = size.width * panelModel.panelWidthFactor;
		final String? imagePath = _videPageController.capturedImagePath;

		return Scaffold(
			backgroundColor: const Color(0xFFF6F6F6),
			body: Stack(
				children: <Widget>[
					SafeArea(
						top: false,
						child: Column(
							children: <Widget>[
								KamcaHeader(
									userName: _userName,
									isPanelOpen: headerController.isPanelOpen,
									onArrowTap: _handleHeaderArrowTap,
									profileImage: _videPageController.buildProfileImageWidget(),
								),
								Expanded(
									child: SingleChildScrollView(
										padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
										child: Container(
											width: double.infinity,
											padding: const EdgeInsets.all(16),
											decoration: BoxDecoration(
												color: Colors.white,
												borderRadius: BorderRadius.circular(16),
												boxShadow: const <BoxShadow>[
													BoxShadow(
														color: Color(0x22000000),
														blurRadius: 16,
														offset: Offset(0, 6),
													),
												],
											),
											child: Column(
												crossAxisAlignment: CrossAxisAlignment.start,
												children: <Widget>[
													const Text(
														'Captured Result',
														style: TextStyle(
															fontSize: 16,
															fontWeight: FontWeight.w700,
														),
													),
													const SizedBox(height: 12),
													Container(
														width: 150,
														height: 150,
														decoration: BoxDecoration(
															color: const Color(0xFFF2F2F2),
															borderRadius: BorderRadius.circular(12),
															border: Border.all(color: const Color(0xFFDDDDDD)),
														),
														clipBehavior: Clip.antiAlias,
														child: (imagePath != null && imagePath.isNotEmpty)
																? Image.file(
																		File(imagePath),
																		fit: BoxFit.cover,
																		errorBuilder: (context, error, stackTrace) => const _NoCapturePreview(),
																	)
																: const _NoCapturePreview(),
													),
													const SizedBox(height: 12),
													Text(
														(imagePath != null && imagePath.isNotEmpty)
																? 'A local image from camera capture is shown above.'
																: 'No image captured yet. Once camera capture is available, it will appear above.',
														style: const TextStyle(fontSize: 13),
													),
													const SizedBox(height: 16),
													SizedBox(
														width: double.infinity,
														child: KamcaButton(
															text: 'Back to Home',
															height: 44,
															backgroundColor: const Color.fromARGB(255, 19, 40, 34),
															textColor: const Color.fromARGB(255, 220, 200, 187),
															onPressed: _handleBackToHomeTap,
														),
													),
												],
											),
										),
									),
								),
							],
						),
					),
					Positioned.fill(
						child: IgnorePointer(
							ignoring: !headerController.isPanelOpen,
							child: GestureDetector(
								onTap: _handleBackdropTap,
								child: AnimatedContainer(
									duration: panelModel.animationDuration,
									color: headerController.isPanelOpen
												? Colors.black.withValues(alpha: 0.18)
											: Colors.transparent,
								),
							),
						),
					),
					AnimatedPositioned(
						duration: panelModel.animationDuration,
						curve: Curves.easeOutCubic,
						top: 0,
						bottom: 0,
						width: panelWidth,
						right: headerController.isPanelOpen ? 0 : -panelWidth,
						child: SafeArea(
							left: false,
							child: Container(
								padding: const EdgeInsets.fromLTRB(22, 28, 20, 20),
								decoration: BoxDecoration(
									color: const Color.fromARGB(245, 34, 50, 46),
									border: Border(
										left: BorderSide(
											color: Colors.white.withValues(alpha: 0.26),
											width: 1,
										),
									),
									boxShadow: <BoxShadow>[
										BoxShadow(
											color: Colors.black.withValues(alpha: 0.3),
											blurRadius: 18,
											offset: const Offset(-6, 8),
										),
									],
								),
								child: Column(
									crossAxisAlignment: CrossAxisAlignment.start,
									children: <Widget>[
										InkWell(
											onTap: _handleLogoutTap,
											child: const Padding(
												padding: EdgeInsets.symmetric(vertical: 8),
												child: Column(
													crossAxisAlignment: CrossAxisAlignment.start,
													children: <Widget>[
														Text(
															'Log out',
															style: TextStyle(
																color: Color.fromARGB(255, 244, 224, 207),
																fontSize: 17,
																fontWeight: FontWeight.w600,
															),
														),
														SizedBox(height: 8),
														Divider(
															height: 1,
															color: Color.fromARGB(255, 244, 224, 207),
														),
													],
												),
											),
										),
									],
								),
							),
						),
					),
				],
			),
		);
	}

	Future<void> _handleHeaderArrowTap() async {
		await _videPageController.toggleHeaderPanel();
		if (!mounted) return;

		setState(() {});
	}

	Future<void> _handleBackdropTap() async {
		await _videPageController.closeHeaderPanel();
		if (!mounted) return;

		setState(() {});
	}

	Future<void> _handleLogoutTap() async {
		await _videPageController.logout(context);
	}

	Future<void> _handleBackToHomeTap() async {
		await _videPageController.backToHome(context);
	}
}

class _NoCapturePreview extends StatelessWidget {
	const _NoCapturePreview();

	@override
	Widget build(BuildContext context) {
		return const Center(
			child: Icon(
				Icons.image_not_supported_outlined,
				color: Color(0xFF9C9C9C),
				size: 38,
			),
		);
	}
}
