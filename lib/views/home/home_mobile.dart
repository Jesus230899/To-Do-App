part of home_view;

class _HomeMobile extends StatelessWidget {
  final HomeViewModel vM;

  const _HomeMobile(this.vM);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(),
      floatingActionButton: _btnAdd(context),
    );
  }

  Widget _appBar() {
    return AppBar(
        title: const Text('Mis tareas', style: TextStyle(color: Colors.black)),
        elevation: 0);
  }

  Widget _body() {
    return vM.loader ? showLoader() : _lisTasks();
  }

  Widget _lisTasks() {
    if (vM.tasks.isEmpty) {
      return const Center(child: Text('Aún no se ha escrito ninguna nota'));
    } else {
      return ListView.builder(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemCount: vM.tasks.length,
        itemBuilder: (context, index) => _itemTask(vM.tasks[index]),
      );
    }
  }

  Widget _itemTask(TaskModel task) {
    return ListTile(
      onTap: () {},
      title: Text(task.title),
      subtitle: Text(task.dueDate.toString()),
    );
  }

  Widget _btnAdd(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => Navigator.pushNamed(context, TaskView.routeName),
      backgroundColor: Colors.blue[900],
      child: const Icon(Icons.add),
    );
  }
}
