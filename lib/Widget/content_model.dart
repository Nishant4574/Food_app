class UnboardingContent {
  String image;
  String title;
  String description;
  UnboardingContent({
    required this.description,
    required this.image,
    required this.title,
  });


}
List<UnboardingContent> contents = [
  UnboardingContent(
      description: "Pick your food from our menu\n..... More than 35 times",
      image: "img/screen1.png",
      title: "Select from our\n Best Menu"),
  UnboardingContent(description: "You can pay cash on delivery\n and card payment is available", image: "img/screen2.png", title: "Easy and online payment"),
  UnboardingContent(description: "Delivered the food on your door step\n as soon as possible", image: "img/screen3.png", title: "Quick delivery ant your doorstep")
];
