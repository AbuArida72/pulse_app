class Vitamin {
  final int? id;
  final String? name;
  final String? image;
  final String? Price;
  final String? rating;
  const Vitamin({this.id, this.name, this.image, this.Price, this.rating});
}
class VitaminList {
  static List<Vitamin> list() {
    const data = <Vitamin> [
      Vitamin(
        id: 1,
        name: 'Vitamin D',
        image: 'assets/images/icon.png',
        Price: '55.00',
        rating: '5.0',
      ),
      Vitamin(
          id: 2,
          name: 'Vitamin C',
          image: 'assets/images/icon.png',
          Price: '30.00',
          rating: '5.0',
      ),
      Vitamin(
          id: 3,
          name: 'Vitamin A',
          image: 'assets/images/icon.png',
          Price: '60.00',
          rating: '4.2',
      ),
      Vitamin(
          id: 4,
          name: 'Zinc',
          image: 'assets/images/icon.png',
          Price: '35.00',
          rating: '3.9',
      ),
      Vitamin(
          id: 5,
          name: 'Calcium',
          image: 'assets/images/icon.png',
          Price: '55.00',
          rating: '5.0',
      ),
      Vitamin(
          id: 6,
          name: 'NAPA',
          image: 'assets/images/icon.png',
          Price: '64.00',
          rating: '5.0',
      ),
    ];
    return data;
  }
}