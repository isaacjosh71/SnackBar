
class Content{
  String image;
  String text;
  String description;

  Content({required this.image, required this.description, required this.text});
}

List<Content> contents= [
  Content(
 image:'assets/images/18.jpg',
 text: 'Order Online',
 description: 'We provide quick delivery services with best quality of snacks at your preferred location',
  ),

  Content(
    image: 'assets/images/20.jpg',
    description: 'We save the stress for you to find the nearest bakeries and restaurants closest to you',
      text: 'Discover restaurants near you',),

  Content(
    image: 'assets/images/21.jpg',
    description: 'Stay updated with our exquisite food blogs with various dishes all over the world',
      text: 'Meal Magazines'),
];