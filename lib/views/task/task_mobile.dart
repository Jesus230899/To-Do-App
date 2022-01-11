part of task_view;

class _TaskMobile extends StatelessWidget {
  final TaskViewModel vM;

  const _TaskMobile(this.vM);

  @override
  Widget build(BuildContext context) {
    // We show a Stack to show a loader in the middle of the screen.
    return Stack(
      children: [
        Scaffold(
          appBar: _appBar(context),
          body: _body(context),
        ),
        _showloader(context),
      ],
    );
  }

  // This function return a loader
  Widget _showloader(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Visibility(
      visible: vM.loader,
      child: Container(
        width: size.width,
        height: size.height,
        color: Colors.black.withOpacity(0.4),
        child:
            Center(child: SizedBox(width: 35, height: 35, child: showLoader())),
      ),
    );
  }

  Widget _appBar(BuildContext context) {
    return AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          // This widget show the cupertino switch to complete the task.
          Row(children: [
            const Text('Completada', style: TextStyle(color: Colors.black)),
            const SizedBox(width: 5),
            CupertinoSwitch(
                value: vM.isCompleted,
                onChanged: (value) => vM.isCompleted = !vM.isCompleted)
          ]),
          _divider(),
          // If the task is editable, ww show the button to delete the task.
          Visibility(
            visible: vM.isEditable,
            child: IconButton(
              onPressed: () => vM.onPressedDelete(context),
              icon: const Icon(Icons.delete, color: Colors.black),
            ),
          ),
          _divider(),
          // This button save the task.
          IconButton(
            onPressed: () => vM.onPressed(context),
            icon: const Icon(Icons.check, color: Colors.black),
          )
        ]);
  }

  // This function return a divider that is used in the appbar to separate the button actions.
  Widget _divider() {
    return Visibility(
      visible: vM.isEditable,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        color: Colors.grey[350],
        width: 1,
        height: double.infinity,
      ),
    );
  }

  // This widget return the body of the screen.
  Widget _body(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Form(
            key: vM.formKey,
            child: Column(children: [
              _listTag(),
              const SizedBox(height: 15),
              TextFormField(
                  // If we want validate with validator atribute uncomment this line
                  // validator: emptyValidator,
                  controller: vM.titleController,
                  decoration: _decoration(isTitle: true),
                  style: const TextStyle(fontSize: 24)),
              // This TextFormField has a SizedBox parent, this is used tho show in all screen the textfield.
              SizedBox(
                height: MediaQuery.of(context).size.height,
                child: TextFormField(
                    // All line in the textfield has a 24 height, for this reason we calculate the height of the screen between the height of the line.
                    maxLines:
                        MediaQuery.of(context).size.height.toInt() ~/ 24 - 2,
                    // If we want validate with validator atribute uncomment this line
                    // validator: emptyValidator,
                    controller: vM.descriptionControler,
                    decoration: _decoration(isTitle: false),
                    style: const TextStyle(fontSize: 16)),
              ),
            ])),
      ),
    );
  }

  // This function return a widget, this is the list of tags created locally
  Widget _listTag() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Etiquetas'),
        const SizedBox(height: 10),
        SizedBox(
          // We define the height of this list.
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

  // This function return a item tag.
  Widget _itemTag(String tag) {
    // If the tag from param is equal to tag in viewModel it means that is selected
    bool isSelected = tag == vM.tag;
    return customTag(
        onPressed: () => vM.tag = tag, isSelected: isSelected, name: tag);
  }

  // We define the decoration of the TextFormField for this screen.
  InputDecoration _decoration({@required isTitle}) {
    return InputDecoration(
      contentPadding: const EdgeInsets.all(5),
      hintText: isTitle ? "Titulo" : "Escribe algo",
      hintStyle: TextStyle(color: Colors.grey, fontSize: isTitle ? 24 : 16),
      border: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primaryColor)),
      enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primaryColor)),
      errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primaryColor)),
      focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primaryColor)),
    );
  }
}
