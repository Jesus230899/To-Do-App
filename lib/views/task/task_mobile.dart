part of task_view;

class _TaskMobile extends StatelessWidget {
  final TaskViewModel viewModel;

  _TaskMobile(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('TaskMobile')),
    );
  }
}