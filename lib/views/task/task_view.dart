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
  static const routeName = 'TaskView';

  @override
  Widget build(BuildContext context) {
    TaskViewModel viewModel = TaskViewModel();

    return ViewModelBuilder<TaskViewModel>.reactive(
        viewModelBuilder: () => viewModel,
        onModelReady: (viewModel) {
          viewModel.onInit(context: context);
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
