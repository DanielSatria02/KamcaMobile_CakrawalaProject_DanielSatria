import 'package:flutter/material.dart';
import 'package:kamca_app/Model/Header_Model.dart';
import 'package:kamca_app/Service/user_session.dart';
import 'package:kamca_app/View/Login_Page.dart';

class HeaderController {
	HeaderController({HeaderPanelModel? panelModel})
		: panelModel = panelModel ?? const HeaderPanelModel();

	final HeaderPanelModel panelModel;
	bool _isPanelOpen = false;

	bool get isPanelOpen => _isPanelOpen;

	Future<void> togglePanel() async {
		_isPanelOpen = !_isPanelOpen;
		await Future<void>.delayed(const Duration(milliseconds: 1));
	}

	Future<void> closePanel() async {
		if (!_isPanelOpen) return;
		_isPanelOpen = false;
		await Future<void>.delayed(const Duration(milliseconds: 1));
	}

	Future<void> logout(BuildContext context) async {
		await KamcaSessionStore.instance.clearUser();
		await Future<void>.delayed(const Duration(milliseconds: 220));
		if (!context.mounted) return;

		Navigator.of(context).pushAndRemoveUntil(
			MaterialPageRoute(builder: (_) => const KamcaBackgroundScreen()),
			(route) => false,
		);
	}
}