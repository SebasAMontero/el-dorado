import 'package:el_dorado/src/core/app_constants/app_constants.dart';
import 'package:el_dorado/src/presentation/views/0XX_exchange/000_coin_exchange/widgets/coin_exchange_card.dart';
import 'package:flutter/material.dart';

class CoinExchangeView extends StatelessWidget {
  const CoinExchangeView({super.key});

  @override
  Widget build(BuildContext context) {
    const Color lightBlueBackground = Color(0xFFE0F7FA);

    final Color primaryColor = ColorConstants.primary;
    final size = MediaQuery.of(context).size;
    final double circleDiameter = size.width * 2.6;
    return Scaffold(
      backgroundColor: lightBlueBackground,
      body: Stack(
        children: [
          Positioned(
            top: -circleDiameter * 0.2,
            right: -circleDiameter * 0.8,

            child: Container(
              width: circleDiameter,
              height: circleDiameter,
              decoration: BoxDecoration(
                color: primaryColor,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
            ),
          ),
          const Center(child: CoinExchangeCard()),
        ],
      ),
    );
  }
}
