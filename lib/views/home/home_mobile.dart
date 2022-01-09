part of home_view;

class _HomeMobile extends StatelessWidget {
  final HomeViewModel vM;

  const _HomeMobile(this.vM);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: RefreshIndicator(
            color: AppColors.accentColor,
            onRefresh: () async {
              await vM.getNotes();
            },
            child: _body(context)),
      ),
      floatingActionButton: _btnAdd(context),
    );
  }

  Widget _appBar() {
    return AppBar(
        title: const Text('Mis tareas', style: TextStyle(color: Colors.black)),
        elevation: 0);
  }

  Widget _body(BuildContext context) {
    return vM.loader ? Center(child: showLoader()) : _lisTasks(context);
  }

  Widget _lisTasks(BuildContext context) {
    const int appBarHeight = 50;
    if (vM.tasks.isEmpty) {
      return ListView(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height -
                  kToolbarHeight -
                  appBarHeight,
              child: Center(
                child: FadeIn(
                    child: const Text('Aún no se ha escrito una tarea.',
                        style: TextStyle(color: Colors.grey))),
              ),
            ),
          ]);
    } else {
      return FadeIn(
        child: ListView.builder(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          itemCount: 10,
          itemBuilder: (context, index) =>
              _itemTask(task: vM.tasks[index], context: context),
        ),
      );
    }
  }

  Widget _itemTask({@required TaskModel task, @required BuildContext context}) {
    return ListTile(
      onTap: () => Navigator.pushNamed(context, TaskView.routeName,
          arguments: {"task": task}),
      title: Text(task.title),
      subtitle: Text(task.dueDate.toString()),
    );
  }

  Widget _btnAdd(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => Navigator.pushNamed(context, TaskView.routeName,
          arguments: {"task": null}),
      backgroundColor: Colors.blue[900],
      child: const Icon(Icons.add),
    );
  }
}
