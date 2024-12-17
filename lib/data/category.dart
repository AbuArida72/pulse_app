class Category {
  final int? id;
  final String? name;
  final String? image;
  const Category({this.id, this.name, this.image});
}
class CategoryList {
  static List<Category> list() {
    const data = <Category> [
      Category(
        id: 1,
        name: 'Ayurveda',
        image: 'assets/images/category/1.png'
      ),
      Category(
          id: 2,
          name: 'Diabetes',
          image: 'assets/images/category/2.png'
      ),
      Category(
          id: 3,
          name: 'Suplements',
          image: 'assets/images/category/3.png'
      ),
      Category(
          id: 4,
          name: 'Vitamin',
          image: 'assets/images/category/4.png'
      ),
      Category(
          id: 5,
          name: 'Harbal',
          image: 'assets/images/category/5.png'
      ),
    ];
    return data;
  }
}