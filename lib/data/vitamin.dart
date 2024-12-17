class Vitamin {
  final int? id;
  final String? name;
  final String? image;
  final String? rating;
  final String? Price;
  const Vitamin({this.id, this.name, this.image, this.rating, this.Price});
}
class VitaminList {
  static List<Vitamin> list() {
    const data = <Vitamin> [
      Vitamin(
        id: 1,
        name: 'Vitamin D',
        image: 'assets/images/icon.png',
        rating: '5.0',
        Price: '55'
      ),
      Vitamin(
          id: 2,
          name: 'Vitamin C',
          image: 'assets/images/icon.png',
          rating: '5.0',
          Price: '30'
      ),
      Vitamin(
          id: 3,
          name: 'Vitamin A',
          image: 'assets/images/icon.png',
          rating: '4.2',
          Price: '60'
      ),
      Vitamin(
          id: 4,
          name: 'Zinc',
          image: 'assets/images/icon.png',
          rating: '3.9',
          Price: '35'
      ),
    ];
    return data;
  }
}