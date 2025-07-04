class SingleCatModel {
  final String url;

  SingleCatModel({required this.url});

  factory SingleCatModel.fromJson(dynamic json) =>
      SingleCatModel(url: json['url']);
}
