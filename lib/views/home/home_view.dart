library home_view;

import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:to_do_app/core/models/task_model.dart';
import 'package:to_do_app/theme/theme.dart';
import 'package:to_do_app/views/task/task_view.dart';
import 'package:to_do_app/widgets/loader.dart';
import 'home_view_model.dart';

part 'home_mobile.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeViewModel viewModel = HomeViewModel();
    return ViewModelBuilder<HomeViewModel>.reactive(
        viewModelBuilder: () => viewModel,
        onModelReady: (viewModel) {
          viewModel.onInit();
          // Do something once your viewModel is initialized
        },
        builder: (context, viewModel, child) {
          return ScreenTypeLayout(
            mobile: _HomeMobile(viewModel),
            desktop: _HomeMobile(viewModel),
            tablet: _HomeMobile(viewModel),
          );
        });
  }
}
