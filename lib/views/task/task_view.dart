library task_view;

import 'package:responsive_builder/responsive_builder.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'task_view_model.dart';

part 'task_mobile.dart';

class TaskView extends StatelessWidget {
  const TaskView({Key key}) : super(key: key);
  static const routeName = 'TaskView';

  @override
  Widget build(BuildContext context) {
    TaskViewModel viewModel = TaskViewModel();

    return ViewModelBuilder<TaskViewModel>.reactive(
        viewModelBuilder: () => viewModel,
        onModelReady: (viewModel) {
          // Do something once your viewModel is initialized
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
