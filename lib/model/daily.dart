class Daliy {
  int id;
  String title;
  String headText;
  String targetDay;
  String imageUrl;
  String remark;

  Daliy({
    this.id,
    this.title,
    this.headText,
    this.targetDay,
    this.imageUrl,
    this.remark,
  });
// Convert a Daliy into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'age': headText,
      'targetDay': targetDay,
      'imageUrl': targetDay,
      'remark': targetDay,
    };
  }
}
