class Animal {
  final int id;
  final String name;
  Animal({required this.name, required this.id});

  Map<String, dynamic> toMap() {
    return {"id": id, "name": name};
  }
}
