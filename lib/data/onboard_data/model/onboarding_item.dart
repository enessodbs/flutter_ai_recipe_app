
class OnboardingItemModel  {
  final String image;
  final String title;
  final String subtitle;

  const OnboardingItemModel({
    required this.image,
    required this.title,
    required this.subtitle,
  });

  // copyWith metodu (Immutable yapıyı koruyarak değişiklik yapmak için)
  OnboardingItemModel copyWith({
    String? image,
    String? title,
    String? subtitle,
  }) {
    return OnboardingItemModel(
      image: image ?? this.image,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
    );
  }

  // JSON'a dönüştürme
  Map<String, dynamic> toJson() {
    return {
      'image': image,
      'title': title,
      'subtitle': subtitle,
    };
  }

  // JSON'dan nesne oluşturma
  factory OnboardingItemModel.fromJson(Map<String, dynamic> json) {
    return OnboardingItemModel(
      image: json['image'],
      title: json['title'],
      subtitle: json['subtitle'],
    );
  }

  List<Object?> get props => [image, title, subtitle];
}
