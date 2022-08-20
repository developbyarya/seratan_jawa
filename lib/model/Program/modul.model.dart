class Modul {
  final String title;
  List<ModulData> data;

  Modul(this.title, this.data);
}

class ModulData {
  final tipe;
  final Map<String, dynamic> data;

  ModulData(this.tipe, this.data);
}
