import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kamca_app/Model/Footer_Model.dart';
import 'package:kamca_app/Service/user_session.dart';
import 'package:kamca_app/View/PreCamera_Page.dart';

class FooterController {
	FooterController({
		FooterModel? model,
		this.userName,
		this.profileImageAsset,
	}) : model = model ?? const FooterModel();

	final FooterModel model;
 	final String? userName;
	final String? profileImageAsset;
	bool _isBusy = false;

	String get _resolvedUserName => userName ?? KamcaSessionStore.instance.userName;

	String? get _resolvedProfileImageAsset => profileImageAsset ?? KamcaSessionStore.instance.profileImageAsset;

	bool get isBusy => _isBusy;

	Future<void> onTap(BuildContext context, FooterAction action) async {
		if (_isBusy) return;

		_isBusy = true;
		try {
			switch (action) {
				case FooterAction.kamAi:
					await Navigator.of(context).push(
							MaterialPageRoute(
								builder: (_) => PreCameraPage(
									userName: _resolvedUserName,
									profileImageAsset: _resolvedProfileImageAsset,
								),
							),
					);
					break;
				case FooterAction.home:
				case FooterAction.shop:
				case FooterAction.message:
				case FooterAction.profile:
					await _showNotAvailableToast(context, action);
					break;
			}
		} finally {
			_isBusy = false;
		}
	}

	Future<void> _showNotAvailableToast(BuildContext context, FooterAction action) async {
		await Future<void>.delayed(const Duration(milliseconds: 150));
		if (!context.mounted) return;

		final labels = <FooterAction, String>{
			FooterAction.home: 'Home',
			FooterAction.shop: 'Shop',
			FooterAction.message: 'Message',
			FooterAction.profile: 'Profile',
		};

		final name = labels[action] ?? 'Feature';
		ScaffoldMessenger.of(context).showSnackBar(
			SnackBar(content: Text('$name is coming soon ;>')),
		);
	}
}