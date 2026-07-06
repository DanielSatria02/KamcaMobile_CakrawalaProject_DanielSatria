import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:kamca_app/Component/Button.dart';
import 'package:kamca_app/Controller/Camera_controller.dart';
import 'package:kamca_app/Service/user_session.dart';
import 'package:kamca_app/View/Vide_Page.dart';

class CameraPage extends StatefulWidget {
	const CameraPage({
		super.key,
		this.userName,
		this.profileImageAsset,
		this.cameraController,
	});

 	final String? userName;
	final String? profileImageAsset;
	final KamcaCameraController? cameraController;

	@override
	State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
	late final KamcaCameraController _cameraPageController;
	late final String _userName;
	late final String? _profileImageAsset;

	CameraController? _cameraController;
	bool _isInitializing = true;
	String? _cameraError;
	bool _shouldShowPermissionSettingsAction = false;

	@override
	void initState() {
		super.initState();
		_userName = widget.userName ?? KamcaSessionStore.instance.userName;
		_profileImageAsset = widget.profileImageAsset ?? KamcaSessionStore.instance.profileImageAsset;
		_cameraPageController = widget.cameraController ?? const KamcaCameraController();
		unawaited(_initializeCamera());
	}

	Future<void> _initializeCamera() async {
		setState(() {
			_isInitializing = true;
			_cameraError = null;
			_shouldShowPermissionSettingsAction = false;
		});

		try {
			final CameraController? cameraController = await _cameraPageController.initializeFrontCamera();
			if (!mounted) {
				await cameraController?.dispose();
				return;
			}

			if (cameraController == null) {
				setState(() {
					_isInitializing = false;
					_cameraError = 'No available camera was found on this device.';
				});
				return;
			}

			setState(() {
				_cameraController = cameraController;
				_isInitializing = false;
			});
		} on CameraPermissionDeniedException catch (error) {
			if (!mounted) return;
			setState(() {
				_isInitializing = false;
				_shouldShowPermissionSettingsAction = error.permanentlyDenied;
				_cameraError = error.permanentlyDenied
						? 'Camera permission is permanently denied. Please enable it in settings.'
						: 'Camera permission was denied. Please allow access and try again.';
			});
		} catch (_) {
			if (!mounted) return;
			setState(() {
				_isInitializing = false;
				_cameraError = 'Unable to start the camera. Please check permissions and try again.';
			});
		}
	}

	@override
	void dispose() {
		unawaited(_cameraController?.dispose());
		super.dispose();
	}

	Future<void> _captureAndOpenVidePage() async {
		String? capturedImagePath;
		final CameraController? cameraController = _cameraController;

		if (cameraController != null &&
				cameraController.value.isInitialized &&
				!cameraController.value.isTakingPicture) {
			try {
				final XFile capturedFile = await cameraController.takePicture();
				capturedImagePath = capturedFile.path;
			} catch (_) {
				capturedImagePath = null;
			}
		}

		if (!mounted) return;

		await Navigator.of(context).push(
			MaterialPageRoute(
				builder: (_) => VidePage(
					userName: _userName,
					profileImageAsset: _profileImageAsset,
					capturedImagePath: capturedImagePath,
				),
			),
		);
	}

	@override
	Widget build(BuildContext context) {
		final CameraController? cameraController = _cameraController;

		return Scaffold(
			backgroundColor: Colors.black,
			appBar: AppBar(
				title: const Text('Smart Scan Camera'),
				backgroundColor: Colors.black,
				foregroundColor: Colors.white,
			),
			body: Stack(
				children: <Widget>[
					Positioned.fill(
						child: _buildCameraBackground(cameraController),
					),
					Align(
						alignment: Alignment.bottomCenter,
						child: Padding(
							padding: const EdgeInsets.all(16),
							child: _buildInstructionContainer(),
						),
					),
				],
			),
		);
	}

	Widget _buildCameraBackground(CameraController? cameraController) {
		if (_isInitializing) {
			return const Center(child: CircularProgressIndicator());
		}

		if (_cameraError != null) {
			return Center(
				child: Padding(
					padding: const EdgeInsets.fromLTRB(20, 20, 20, 190),
					child: Column(
						mainAxisSize: MainAxisSize.min,
						children: <Widget>[
							Text(
								_cameraError!,
								textAlign: TextAlign.center,
								style: const TextStyle(color: Colors.white),
							),
							const SizedBox(height: 14),
							ElevatedButton(
								onPressed: _initializeCamera,
								child: const Text('Retry'),
							),
							if (_shouldShowPermissionSettingsAction) ...<Widget>[
								const SizedBox(height: 8),
								TextButton(
									onPressed: () async {
										await _cameraPageController.openPermissionSettings();
									},
									child: const Text('Open Settings'),
								),
							],
						],
					),
				),
			);
		}

		if (cameraController == null) {
			return const SizedBox.shrink();
		}

		return Center(
			child: AspectRatio(
				aspectRatio: cameraController.value.aspectRatio,
				child: CameraPreview(cameraController),
			),
		);
	}

	Widget _buildInstructionContainer() {
		return Container(
			width: double.infinity,
			padding: const EdgeInsets.all(16),
			decoration: BoxDecoration(
				color: Colors.white,
				borderRadius: BorderRadius.circular(16),
			),
			child: Column(
				mainAxisSize: MainAxisSize.min,
				crossAxisAlignment: CrossAxisAlignment.start,
				children: <Widget>[
					const Text(
						'(1.). Position your face in the circle.',
						style: TextStyle(
							color: Colors.black,
							fontSize: 13,
						),
					),
					const SizedBox(height: 6),
					const Text(
						'(2.). Look Left & Right.',
						style: TextStyle(
							color: Colors.black,
							fontSize: 13,
						),
					),
					const SizedBox(height: 6),
					const Text(
						'(3.). Continue till the bar is filled & click capture.',
						style: TextStyle(
							color: Colors.black,
							fontSize: 13,
						),
					),
					const SizedBox(height: 14),
					SizedBox(
						width: double.infinity,
						child: KamcaButton(
							text: 'Capture',
							height: 44,
							backgroundColor: const Color.fromARGB(255, 19, 40, 34),
							textColor: const Color.fromARGB(255, 220, 200, 187),
							onPressed: _captureAndOpenVidePage,
						),
					),
				],
			),
		);
	}
}
