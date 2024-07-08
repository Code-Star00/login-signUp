import 'package:default_screen/modules/sized_box.dart';
import 'package:default_screen/modules/text.dart';
import 'package:flutter/material.dart';

class DialogComponent {
  static dialogComponent(
    BuildContext context,
    Widget? titleWidget,
    Widget contentTextWidget,
    bool isOne,
    List cancelFunction,
    List okFunction, {
    bool barrierDismissible = true,
    bool unfocus = true,
  }) {
    showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          contentPadding: const EdgeInsets.only(top: 10.0),
          title: titleWidget,
          content: SizedBox(
            width: 300.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                contentTextWidget,
                20.h,
                Row(
                  children: [
                    Expanded(
                      child: Ink(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: const Radius.circular(20),
                            bottomRight: Radius.circular(isOne ? 20 : 0),
                          ),
                          border: borderSide(),
                        ),
                        child: InkWell(
                          onTap: cancelFunction[0],
                          overlayColor: WidgetStatePropertyAll(cancelFunction[2][100] as Color),
                          borderRadius: BorderRadius.only(
                            bottomLeft: const Radius.circular(20),
                            bottomRight: Radius.circular(isOne ? 20 : 0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                            child: xText(
                              cancelFunction[1].toString(),
                              14,
                              color: cancelFunction[2],
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ),
                    if (!isOne)
                      Expanded(
                        child: Ink(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              // bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                            ),
                            border: borderSide(),
                          ),
                          child: InkWell(
                            onTap: okFunction[0],
                            overlayColor: WidgetStatePropertyAll(okFunction[2][100] as Color),
                            borderRadius: const BorderRadius.only(
                              // bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                              child: xText(
                                okFunction[1].toString(),
                                14,
                                color: okFunction[2],
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static Border borderSide() {
    return const Border(
      top: BorderSide(
        color: Color.fromRGBO(230, 230, 230, 1),
        width: 0.7,
      ),
      right: BorderSide(
        color: Color.fromRGBO(230, 230, 230, 1),
        width: 0.7,
      ),
    );
  }
}
