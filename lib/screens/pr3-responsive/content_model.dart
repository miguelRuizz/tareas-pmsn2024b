class OnboardingContent {
  String? image;
  String? title;
  String? description;

  OnboardingContent({this.image, this.title, this.description});
}

List<OnboardingContent> contents = [
  OnboardingContent(
    image: "assets/orangutanimgs/babyorangutan2.png",
    title: "¡Adopta un orangután!",
    description: "Adoptar un orangután a través de la Borneo Orangutan Survival (BOS) Foundation "
    "ayuda a proteger una especie en peligro crítico, contribuyendo a su rehabilitación "
    "y reintroducción en su hábitat natural. "
  ),
  OnboardingContent(
    image: "assets/orangutanimgs/flyingorangutan.png",
    title: "Elige un tema",
    description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit "
    "sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
    "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris."
  ),
  OnboardingContent(
    image: "assets/orangutanimgs/babyorangutan.png",
    title: "Nuestros Logros",
    description: ""
  ),
];