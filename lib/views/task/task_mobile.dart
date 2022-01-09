part of task_view;

class _TaskMobile extends StatelessWidget {
  final TaskViewModel vM;

  const _TaskMobile(this.vM);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: _body(context),
    );
  }

  Widget _appBar(BuildContext context) {
    return AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          IconButton(
            onPressed: () => vM.saveTask(context),
            icon: const Icon(Icons.check, color: Colors.black),
          )
        ]);
  }

  Widget _body(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Form(
            key: vM.formKey,
            child: Column(children: [
              TextFormField(
                  // If we want validate with validator atribute uncomment this line
                  // validator: emptyValidator,
                  controller: vM.titleController,
                  decoration: _decoration(isTitle: true),
                  style: const TextStyle(fontSize: 24)),
              SizedBox(
                height: MediaQuery.of(context).size.height,
                child: TextFormField(
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
