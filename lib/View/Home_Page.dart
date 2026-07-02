import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:kamca_app/Component/Footer.dart';
import 'package:kamca_app/Component/Header.dart';
import 'package:kamca_app/Component/Product_card.dart';
import 'package:kamca_app/Controller/ProductCardAnime_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
    this.userName = 'User',
    this.profileImageAsset,
  });

  final String userName;
  final String? profileImageAsset;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _didPrecache = false;
  late final ProductCardAnimeController _rightProductCardAnimeController;
  late final ProductCardAnimeController _leftProductCardAnimeController;

  @override
  void initState() {
    super.initState();
    _rightProductCardAnimeController = ProductCardAnimeController(
      direction: ProductCarouselDirection.right,
      viewportFraction: 0.30,
    );
    _leftProductCardAnimeController = ProductCardAnimeController(
      direction: ProductCarouselDirection.left,
      viewportFraction: 0.30,
    );

    unawaited(_rightProductCardAnimeController.initialize());
    unawaited(_leftProductCardAnimeController.initialize());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_didPrecache) return;
    _didPrecache = true;
    unawaited(_precacheHomeAssets());
  }

  Future<void> _precacheHomeAssets() async {
    await precacheImage(const AssetImage('assets/KamcaKats.png'), context);
    await precacheImage(const AssetImage('assets/KamcaLogo.png'), context);
    await precacheImage(const AssetImage('assets/WardahFaceWash.png'), context);

    final profileImageAsset = widget.profileImageAsset;
    if (profileImageAsset != null && profileImageAsset.isNotEmpty) {
      await precacheImage(AssetImage(profileImageAsset), context);
    }
  }

  @override
  void dispose() {
    _rightProductCardAnimeController.dispose();
    _leftProductCardAnimeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/KamcaKats.png',
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 255, 211, 180).withOpacity(0.25),
                    border: Border.all(color: Colors.white.withOpacity(0.25)),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        const Color.fromARGB(255, 248, 234, 215).withOpacity(0.35),
                        const Color.fromARGB(255, 251, 231, 197).withOpacity(0.25),
                      ],
                    ),
                  ),
                  child: SafeArea(
                    top: false,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        KamcaHeader(
                          userName: widget.userName,
                          profileImage: widget.profileImageAsset != null
                              ? ClipOval(
                                  child: Image.asset(
                                    widget.profileImageAsset!,
                                    width: 32,
                                    height: 32,
                                    fit: BoxFit.cover,
                                    gaplessPlayback: true,
                                  ),
                                )
                              : null,
                        ),
                        Expanded(
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              final panelHeight = constraints.maxHeight * 0.465;

                              return Padding(
                                padding: const EdgeInsets.fromLTRB(0, 10, 0, 12),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(18),
                                      child: Image.asset(
                                        'assets/KamcaLogo.png',
                                        width: 80,
                                        height: 80,
                                        fit: BoxFit.cover,
                                        gaplessPlayback: true,
                                      ),
                                    ),
                                    const SizedBox(height: 1),
                                    Text(
                                      'Welcome',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 35,
                                        fontWeight: FontWeight.w500,
                                        shadows: [
                                          Shadow(
                                            color: Colors.black.withOpacity(0.50),
                                            offset: const Offset(0, 6),
                                            blurRadius: 10,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Text(
                                      'to',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 26,
                                        fontWeight: FontWeight.w500,
                                        shadows: [
                                          Shadow(
                                            color: Colors.black.withOpacity(0.34),
                                            offset: const Offset(0, 4),
                                            blurRadius: 8,
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 0),
                                    const _KamcaGlassTitle(),
                                    const SizedBox(height: 8),
                                    ClipRRect(
                                      child: BackdropFilter(
                                        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
                                        child: Container(
                                          width: size.width,
                                          height: panelHeight,
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                              colors: [
                                                const Color.fromARGB(255, 69, 72, 95).withOpacity(0.55),
                                                const Color.fromARGB(255, 19, 25, 36).withOpacity(0.55),
                                              ],
                                            ),
                                            border: Border.all(
                                              color: const Color.fromARGB(255, 84, 88, 112).withOpacity(0.45),
                                              width: 1.4,
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black.withOpacity(0.18),
                                                blurRadius: 18,
                                                offset: const Offset(0, 10),
                                              ),
                                            ],
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                                            child: Column(
                                              children: [
                                                Expanded(
                                                  flex: 4,
                                                  child: ProductCarouselSection(
                                                    controller: _rightProductCardAnimeController,
                                                    cardWidth: 68,
                                                    cardHeight: 92,
                                                  ),
                                                ),
                                                const SizedBox(height: 4),
                                                Expanded(
                                                  flex: 6,
                                                  child: ProductCarouselSection(
                                                    controller: _leftProductCardAnimeController,
                                                    cardWidth: 68,
                                                    cardHeight: 92,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                        const KamcaFooter(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _KamcaGlassTitle extends StatelessWidget {
  const _KamcaGlassTitle();

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Text(
          'Kamca',
          style: TextStyle(
            color: Colors.black.withOpacity(0.33),
            fontSize: 35,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w800,
          ),
        ),
        Text(
          'Kamca',
          style: TextStyle(
            fontSize: 35,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w800,
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = 2
              ..color = Colors.white.withOpacity(0.85),
          ),
        ),
        Text(
          'Kamca',
          style: TextStyle(
            fontSize: 35,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w800,
            foreground: Paint()
              ..color = const Color.fromARGB(235, 255, 238, 230),
            shadows: [
              Shadow(
                color: Colors.black.withOpacity(0.32),
                offset: const Offset(0, 4),
                blurRadius: 10,
              ),
            ],
          ),
        ),
        Transform.translate(
          offset: const Offset(0, 3),
          child: const Text(
            'Kamca',
            style: TextStyle(
              color: Color.fromARGB(148, 249, 210, 199),
              fontSize: 35,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ],
    );
  }
}
