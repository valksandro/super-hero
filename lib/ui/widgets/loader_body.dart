

import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:super_hero/core/enums/viewstate.dart';
import 'package:super_hero/core/providers/base_provider.dart';

class LoaderBody extends StatelessWidget {
  final Widget child;
  final Color color;

  const LoaderBody({this.child, this.color = Colors.red});

  @override
  Widget build(BuildContext context) => Consumer<BaseProvider>(
        builder: (cx, model, ch) => ModalProgressHUD(
              progressIndicator: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(color)),
              opacity: 0.1,
              inAsyncCall: model.state == ViewState.busy,
              child: child,
            ));
}
