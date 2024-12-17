class Supplement {
  final int? id;
  final String? name;
  final String? image;
  final String? discount;
  final String? oldPrice;
  final String? newPrice;
  final String? rating;
  final String? piece;
  final List? volumeList;
  final bool? needPrescription;
  final String? description;
  const Supplement({this.id, this.name, this.image, this.discount, this.oldPrice, this.newPrice,
    this.rating, this.piece, this.volumeList, this.needPrescription, this.description});
}
class SupplementList {
  static List<Supplement> list() {
    const data = <Supplement> [
      Supplement(
        id: 1,
        name: 'Vitamin',
        image: 'assets/images/supplement/1.png',
        discount: '45',
        oldPrice: '100.00',
        newPrice: '55.00',
        rating: '5.0',
        piece: '50',
        volumeList: ['50', '100', '150', '200'],
        needPrescription: true,
        description: 'Plastic oi is a prescription medicine & a preparation of Cetirizine; which is a potent antihistamine.'
      ),
      Supplement(
          id: 2,
          name: 'Ayurveda',
          image: 'assets/images/supplement/2.png',
          discount: '20',
          oldPrice: '80.00',
          newPrice: '64.00',
          rating: '5.0',
          piece: '150',
          volumeList: ['50', '100', '150', '200'],
          needPrescription: false,
          description: 'Plastic oi is a prescription medicine & a preparation of Cetirizine; which is a potent antihistamine.'
      ),
    ];
    return data;
  }
}