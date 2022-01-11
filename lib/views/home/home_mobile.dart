part of home_view;

class _HomeMobile extends StatelessWidget {
  final HomeViewModel vM;

  const _HomeMobile(this.vM);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      // We use the refresh indicator for refresh and actualize the data in the homePage using the function getNotes.
      body: RefreshIndicator(
          color: AppColors.accentColor,
          onRefresh: () async => await vM.getNotes(),
          child: _body(context)),
      floatingActionButton: _btnAdd(context),
    );
  }

  // This function return the appBar.
  Widget _appBar() {
    return AppBar(
        title: const Text('Mis tareas', style: TextStyle(color: Colors.black)),
        elevation: 0);
  }

  // This function return the body
  Widget _body(BuildContext context) {
    // If loader is true, we show a loader in the center of the screen, if is false, we show the list of staks
    return vM.loader ? Center(child: showLoader()) : _lisTasks(context);
  }

  // This function return a TextField. When the user write some text, we show the list of result search.
  Widget _search() {
    return TextField(
        // We use onChanged to know the current text in the TextField, this call the function search.
        onChanged: (value) => vM.search(value),
        decoration: InputDecoration(
            hintText: 'Busca tareas',
            border: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.all(Radius.circular(22)),
            ),
            filled: true,
            fillColor: Colors.grey[200],
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(22),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.all(Radius.circular(22)),
            )));
  }

  // This function return the list of tasks received from the server, if this list is empty ww show a message in the middle of the screen.
  Widget _lisTasks(BuildContext context) {
    // We define the size of the appBar in const variable.
    const int appBarHeight = 50;
    // If the list of staks is empty, we show a message.
    if (vM.tasks.isEmpty) {
      // This message is child of listView because we need this widget to use the RefreshIndicator.
      return ListView(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          children: [
            SizedBox(
              // We assign the size of this widget
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
      // We show list of widgets: the textfield to search and the list of tasks.
      return FadeIn(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                _search(),
                const SizedBox(height: 20),
                _list(context),
              ],
            ),
          ),
        ),
      );
    }
  }

  // This function return the list of task.
  Widget _list(BuildContext context) {
    // We assign the list of tasks according to showSearch
    List<TaskModel> tasks = vM.showSearch ? vM.resultTask : vM.tasks;
    // If the result of search is empty, we show a message.
    if (vM.tasks.isEmpty) {
      return FadeIn(
          child: const Text('No hubo resultados.',
              style: TextStyle(color: Colors.grey)));
    }
    // If the search has result, we show the list.
    return Expanded(
      child: ListView.separated(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        itemCount: tasks.length,
        itemBuilder: (context, index) =>
            _itemTask(task: tasks[index], context: context),
        separatorBuilder: (context, index) => const SizedBox(height: 10),
      ),
    );
  }

  // This function return a item of the task list.
  Widget _itemTask({@required TaskModel task, @required BuildContext context}) {
    return Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          color: Colors.white),
      child: ListTile(
        // We send the object to TaskView using arguments. Edit is true because the user can edit or delete the task.
        onTap: () => Navigator.pushNamed(context, TaskView.routeName,
            arguments: {"task": task, "edit": true}).then((value) {
          // When the user return to HomePage, return a value, if the value is null, we get the notes because the user update a value, else, the user delete a task and we need to update the list of staks.
          if (value != null) {
            vM.updateTasks(value);
          } else {
            vM.getNotes();
          }
        }),
        // Show the title of the task.
        title: Text(
          task.title,
          style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              overflow: TextOverflow.ellipsis),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // If the value of dueDate is diffent to null, we show this info.
            Text(task.dueDate == null ? '' : task.dueDate.toString()),
          ],
        ),
        // If the user complete this task, we show a icon to differentiate the tasks.
        trailing: Visibility(
            visible: task.isCompleted == 1,
            child: const Icon(Icons.check_circle_outline_outlined,
                color: Colors.green)),
      ),
    );
  }

  // This function contains the FloatingActionButton to go to TaskView
  Widget _btnAdd(BuildContext context) {
    return FloatingActionButton(
      // We need to send task null and edit false, because the user only can add new task, but not edit or delete.
      onPressed: () => Navigator.pushNamed(context, TaskView.routeName,
          arguments: {"task": null, "edit": false}).then((value) {
        if (value != null) {
          // When the user return to HomePage, we receive the object added and add to the list of staks.
          vM.addTask(value);
        }
      }),
      backgroundColor: Colors.blue[900],
      child: const Icon(Icons.add),
    );
  }
}
