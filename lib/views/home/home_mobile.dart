part of home_view;

class _HomeMobile extends StatelessWidget {
  final HomeViewModel vM;

  const _HomeMobile(this.vM);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: SingleChildScrollView(
        child: RefreshIndicator(
            color: AppColors.accentColor,
            onRefresh: () async => await vM.getNotes(),
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

  Widget _search() {
    return TextField(
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

  Widget _filter() {
    return ExpansionTile(
      title: const Text('Filtrar', style: TextStyle(color: Colors.black)),
      iconColor: Colors.black,
      children: [
        _listTag(),
        const Divider(),
        _estatus(),
      ],
    );
  }

  Widget _listTag() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Etiquetas'),
        const SizedBox(height: 10),
        SizedBox(
          height: 40,
          child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: tags.length,
            itemBuilder: (context, index) => _itemTag(tags[index]),
            separatorBuilder: (context, index) => const SizedBox(width: 5),
          ),
        ),
      ],
    );
  }

  Widget _itemTag(String tag) {
    bool isSelected = tag == vM.tag;
    return customTag(
        onPressed: () => vM.tag = tag, isSelected: isSelected, name: tag);
  }

  Widget _estatus() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Estado'),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            customTag(
                onPressed: () => vM.status = 'Completado',
                isSelected: vM.status == 'Completado',
                name: 'Completado'),
            customTag(
                onPressed: () => vM.status = 'No completado',
                isSelected: vM.status == 'No completado',
                name: 'No completado'),
          ],
        ),
      ],
    );
  }

  Widget _lisTasks(BuildContext context) {
    const int appBarHeight = 50;
    if (vM.tasks.isEmpty) {
      return ListView(
          shrinkWrap: true,
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              _search(),
              // _filter(),
              const SizedBox(height: 20),
              _list(context),
            ],
          ),
        ),
      );
    }
  }

  Widget _list(BuildContext context) {
    List<TaskModel> tasks = vM.showSearch ? vM.resultTask : vM.tasks;
    if (vM.tasks.isEmpty) {
      return FadeIn(
          child: const Text('No hubo resultados.',
              style: TextStyle(color: Colors.grey)));
    }
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.7,
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

  Widget _itemTask({@required TaskModel task, @required BuildContext context}) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        color: Colors.white,
      ),
      child: ListTile(
        onTap: () => Navigator.pushNamed(context, TaskView.routeName,
            arguments: {"task": task, "edit": true}),
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
            Text(task.description.substring(
                0,
                (task.description.length >= 50
                    ? 50
                    : task.description.length))),
            Text(task.dueDate.toString()),
          ],
        ),
        trailing: SizedBox(
            width: 100,
            height: 40,
            child:
                customTag(onPressed: null, isSelected: false, name: task.tags)),
      ),
    );
  }

  Widget _btnAdd(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => Navigator.pushNamed(context, TaskView.routeName,
          arguments: {"task": null, "edit": false}),
      backgroundColor: Colors.blue[900],
      child: const Icon(Icons.add),
    );
  }
}
