import 'package:flutter/material.dart';

class SpookyBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final void onTap;

  // Se quiser outra cor no futuro, é só passar aqui.
  final Color barColor;

  const SpookyBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.barColor = const Color(0xFFFF472F), // <- #FF472F (sua cor)
  });

  @override
  Widget build(BuildContext context) {
    // Cores derivadas automaticamente da cor da barra
    final onColor = _autoOnColor(barColor); // preto ou branco p/ contraste
    final onColorDim = onColor.withOpacity(0.72); // não-selecionado
    final glowLight = _lighten(barColor, 0.18); // brilho claro
    final glowDeep = _darken(barColor, 0.22); // brilho profundo
    final borderCol = _lighten(barColor, 0.38).withOpacity(0.24);

    return SafeArea(
      minimum: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Container(
        height: 70,
        decoration: BoxDecoration(
          color: barColor,
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              blurRadius: 24,
              spreadRadius: 1,
              offset: const Offset(0, 8),
              color: _darken(barColor, 0.35).withOpacity(0.55),
            ),
          ],
          border: Border.all(color: borderCol, width: 1),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(22),
          child: LayoutBuilder(
            builder: (context, constraints) {
              const glowW = 72.0;
              const glowH = 58.0;
              const itemsCount = 4; // ajuste se mudar a quantidade
              final itemW = constraints.maxWidth / itemsCount;
              final glowLeft =
                  (itemW * currentIndex) + (itemW / 2) - (glowW / 2);

              return Stack(
                children: [
                  // Glow/halo do item selecionado (em tons do laranja)
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeOut,
                    left: glowLeft
                        .clamp(0.0, constraints.maxWidth - glowW)
                        .toDouble(),
                    top: 6,
                    child: Container(
                      width: glowW,
                      height: glowH,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: glowLight.withOpacity(0.75),
                            blurRadius: 22,
                            spreadRadius: 4,
                          ),
                          BoxShadow(
                            color: glowDeep.withOpacity(0.45),
                            blurRadius: 28,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                    ),
                  ),

                  // BottomNavigationBar real
                  BottomNavigationBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    type: BottomNavigationBarType.fixed,
                    currentIndex: currentIndex,
                    //onTap: onTap,
                    selectedItemColor: Colors.amber,
                    unselectedItemColor: Colors.black,
                    selectedFontSize: 12,
                    unselectedFontSize: 11,
                    showUnselectedLabels: true,
                    items: const [
                      BottomNavigationBarItem(
                        icon: Icon(Icons.home_rounded),
                        label: 'Home 🎃',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.auto_awesome_rounded),
                        label: 'Spells 👻',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.storefront),
                        label: 'Store 📦 ',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.icecream),
                        label: 'Candy 🍬',
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

/// ——— utilitários de cor ———
Color _autoOnColor(Color bg) {
  // Usa luminância para escolher preto ou branco com bom contraste
  return bg.computeLuminance() > 0.5 ? Colors.black : Colors.white;
}

Color _lighten(Color c, double amount) {
  final hsl = HSLColor.fromColor(c);
  final l = (hsl.lightness + amount).clamp(0.0, 1.0);
  return hsl.withLightness(l).toColor();
}

Color _darken(Color c, double amount) {
  final hsl = HSLColor.fromColor(c);
  final l = (hsl.lightness - amount).clamp(0.0, 1.0);
  return hsl.withLightness(l).toColor();
}
