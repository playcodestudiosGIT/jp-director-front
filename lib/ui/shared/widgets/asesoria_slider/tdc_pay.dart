import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';

class TdcPay extends StatelessWidget {
  const TdcPay({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        const SizedBox(height: 80,),
        SizedBox(
        width: 300,
        height: 200,
          child: CreditCardWidget(
                  
                     cardNumber: '4242 4242 4242 4242',
                     expiryDate: '02/43',
                     cardHolderName: 'Samuel Lopez',
                     cvvCode: '333',
                     showBackView: false,
                     onCreditCardWidgetChange: (p0) => {},
                     isChipVisible: false,
                     isSwipeGestureEnabled: false,
                  )
        ),
      
      ],
    );
  }
}
