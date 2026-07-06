class HeaderPanelModel {
  final String logoutText;
  final Duration animationDuration;
  final double panelWidthFactor;

  const HeaderPanelModel({
    this.logoutText = 'Log Out',
    this.animationDuration = const Duration(milliseconds: 280),
    this.panelWidthFactor = 0.5,
  });
}