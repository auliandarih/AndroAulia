class OnboardingModel {
  final String imageAsset;
  final String title;
  final String description;

  OnboardingModel({
    required this.description,
    required this.imageAsset,
    required this.title
  });
}

List<OnboardingModel> onboardong = <OnboardingModel>[
  OnboardingModel(
    description: '''''',
    imageAsset: 'assets/images/accounting.png',
    title: 'Accounting App For Your Bussiness',
  ),
  OnboardingModel(
    description: '''''',
    imageAsset: 'assets/images/manage.png',
    title: 'Manage Your Accounting Easily',
  ),
  OnboardingModel(
    description: '''''',
    imageAsset: 'assets/images/hand.png',
    title: 'All in Your Hand',
  ),
];
