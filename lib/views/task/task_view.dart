library task_view;

import 'package:flutter/cupertino.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:to_do_app/core/services/local_data.dart';
import 'package:to_do_app/theme/theme.dart';
import 'package:to_do_app/widgets/loader.dart';
import 'package:to_do_app/widgets/tag.dart';
import 'task_view_model.dart';

part 'task_mobile.dart';

class TaskView extends StatelessWidget {
  const TaskView({Key key}) : super(key: key);
  // We specify the name of the route, this is used when we go to this page and is referenced in the routes.dart file.
  static const routeName = 'TaskView';

  @override
  Widget build(BuildContext context) {
    TaskViewModel viewModel = TaskViewModel();

    return ViewModelBuilder<TaskViewModel>.reactive(
        viewModelBuilder: () => viewModel,
        onModelReady: (viewModel) {
          // We call this function on the init of the screen to fill de data sended in arguments.
          viewModel.onInit(context: context);
        },
        builder: (context, viewModel, child) {
          return ScreenTypeLayout(
            mobile: _TaskMobile(viewModel),
            desktop: _TaskMobile(viewModel),
            tablet: _TaskMobile(viewModel),
          );
        });
  }
}
