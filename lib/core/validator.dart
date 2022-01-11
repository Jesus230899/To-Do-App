// important!
// This fie contains the valitadors that can be used in the app

// This is the empty validator
String emptyValidator(String value) {
  if (value.isEmpty) {
    return 'Campo vacio';
  }
  return null;
}
