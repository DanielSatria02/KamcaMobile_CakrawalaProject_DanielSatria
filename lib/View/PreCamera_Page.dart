import 'package:flutter/material.dart';
import 'package:kamca_app/Component/Button.dart';
import 'package:kamca_app/Controller/PreCamera_controller.dart';
import 'package:kamca_app/Service/user_session.dart';

class PreCameraPage extends StatelessWidget {
	PreCameraPage({
		super.key,
		this.userName,
		this.profileImageAsset,
		PreCameraController? preCameraController,
	}) : _preCameraController =
				preCameraController ??
				PreCameraController(
					userName: userName ?? KamcaSessionStore.instance.userName,
					profileImageAsset: profileImageAsset ?? KamcaSessionStore.instance.profileImageAsset,
				);

 	final String? userName;
	final String? profileImageAsset;

	final PreCameraController _preCameraController;

	@override
	Widget build(BuildContext context) {
		final TextTheme textTheme = Theme.of(context).textTheme;

		return Scaffold(
			backgroundColor: const Color(0xFFF6F6F6),
			body: SafeArea(
				child: Padding(
					padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
					child: Column(
						children: <Widget>[
							Expanded(
								child: SingleChildScrollView(
									child: Container(
										padding: const EdgeInsets.all(20),
										decoration: BoxDecoration(
											color: Colors.white,
											borderRadius: BorderRadius.circular(16),
											boxShadow: const <BoxShadow>[
												BoxShadow(
													color: Color(0x26000000),
													blurRadius: 20,
													offset: Offset(0, 8),
												),
											],
										),
										child: Column(
											crossAxisAlignment: CrossAxisAlignment.start,
											children: <Widget>[
								Text(
									'Start Smart Scan',
									style: textTheme.headlineMedium?.copyWith(
										fontWeight: FontWeight.w500,
									) ??
										const TextStyle(
											fontSize: 15,
											fontWeight: FontWeight.w500,
										),
								),
								const SizedBox(height: 12),
								Text(
									'With this face scan, the application can only analyze within the limitation it has.',
									style: textTheme.bodyMedium?.copyWith(fontSize: 12),
								),
								const SizedBox(height: 24),
								Text(
									'Process of this Scan',
									style: textTheme.headlineSmall?.copyWith(
										fontWeight: FontWeight.w500,
									) ??
										const TextStyle(
											fontSize: 15,
											fontWeight: FontWeight.w500,
										),
								),
								const SizedBox(height: 14),
								Container(
									padding: const EdgeInsets.all(14),
									decoration: BoxDecoration(
										color: const Color(0xFFF8F8F8),
										borderRadius: BorderRadius.circular(12),
										border: Border.all(color: const Color(0xFFE6E6E6)),
									),
									child: Row(
										crossAxisAlignment: CrossAxisAlignment.start,
										children: <Widget>[
											Container(
												width: 44,
												height: 44,
												decoration: BoxDecoration(
													color: Color.fromARGB(255, 19, 40, 34),
													shape: BoxShape.rectangle,
													borderRadius: BorderRadius.circular(999),
												),
												child: const Center(
													child: Icon(
														Icons.sentiment_satisfied_alt_rounded,
														size: 26,
														color: Color.fromARGB(255, 255, 255, 255),
													),
												),
											),
											const SizedBox(width: 12),
											Expanded(
												child: Column(
													crossAxisAlignment: CrossAxisAlignment.start,
													children: <Widget>[
														Text(
															'Face scanning',
															style: textTheme.titleMedium?.copyWith(
																fontWeight: FontWeight.w700,
															) ??
																const TextStyle(
																	fontSize: 15,
																	fontWeight: FontWeight.w700,
																),
														),
														const SizedBox(height: 4),
														Text(
															'Get a face shot by following the instructions that will be provided.',
															style: textTheme.bodyMedium?.copyWith(fontSize: 12),
														),
													],
												),
											),
										],
									),
								),
								const SizedBox(height: 12),
								Container(
									padding: const EdgeInsets.all(14),
									decoration: BoxDecoration(
										color: const Color(0xFFF8F8F8),
										borderRadius: BorderRadius.circular(12),
										border: Border.all(color: const Color(0xFFE6E6E6)),
									),
									child: Row(
										crossAxisAlignment: CrossAxisAlignment.start,
										children: <Widget>[
											Container(
												width: 44,
												height: 44,
												decoration: BoxDecoration(
													color: Color.fromARGB(255, 19, 40, 34),
													shape: BoxShape.rectangle,
													borderRadius: BorderRadius.circular(999),
												),
												child: const Center(
													child: Icon(
														Icons.sentiment_satisfied_alt_rounded,
														size: 26,
														color: Color.fromARGB(255, 255, 255, 255),
													),
												),
											),
											const SizedBox(width: 12),
											Expanded(
												child: Column(
													crossAxisAlignment: CrossAxisAlignment.start,
													children: <Widget>[
														Text(
															'How the AI Works',
															style: textTheme.titleMedium?.copyWith(
																fontWeight: FontWeight.w700,
															) ??
																const TextStyle(
																	fontSize: 15,
																	fontWeight: FontWeight.w700,
																),
														),
														const SizedBox(height: 4),
														Text(
															'Wait for the AI to analyze your skin condition',
															style: textTheme.bodyMedium?.copyWith(fontSize: 12),
														),
													],
												),
											),
										],
									),
								),
											],
										),
									),
								),
							),
							const SizedBox(height: 16),
							SizedBox(
								width: double.infinity,
								child: KamcaButton(
									text: 'Agree & Continue',
									height: 44,
									backgroundColor: const Color.fromARGB(255, 19, 40, 34),
									textColor: const Color.fromARGB(255, 220, 200, 187),
									onPressed: () async {
										await _preCameraController.agreeAndContinue(context);
									},
								),
							),
							const SizedBox(height: 10),
							SizedBox(
								width: double.infinity,
								child: KamcaButton(
									text: 'Disagree & Shop Only',
									height: 44,
									backgroundColor: Color.fromARGB(255, 19, 40, 34),
									textColor: const Color.fromARGB(255, 220, 200, 187),
									onPressed: () async {
										await _preCameraController.disagreeAndGoToHome(context);
									},
								),
							),
						],
					),
				),
			),
		);
	}
}
