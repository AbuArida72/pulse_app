class Care {
  final int? id;
  final String? name;
  final String? image;
  final String? discount;
  final String? oldPrice;
  final String? newPrice;
  final String? rating;
  final String? volume;
  const Care({this.id, this.name, this.image, this.discount, this.oldPrice, this.newPrice,
    this.rating, this.volume});
}
class CareList {
  static List<Care> list() {
    const data = <Care> [
      Care(
        id: 1,
        name: 'Eoo Cool',
        image: 'assets/images/care/1.png',
        discount: '45',
        oldPrice: '100.00',
        newPrice: '55.00',
        rating: '5.0',
        volume: '100'
      ),
      Care(
          id: 2,
          name: 'Goof Vitas',
          image: 'assets/images/care/2.png',
          discount: '20',
          oldPrice: '80.00',
          newPrice: '64.00',
          rating: '5.0',
          volume: '80'
      ),
    ];
    return data;
  }
}