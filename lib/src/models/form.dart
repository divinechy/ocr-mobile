class MyForm {
  final String image;
  final String imageType;

  MyForm({this.image, this.imageType});

  factory MyForm.fromJson(Map<String, dynamic> jsonData) {
    return MyForm(
      image: jsonData['image'],
      imageType: jsonData['imageType'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'image': image,
      'imageType': imageType,
    };
  }
  
}
