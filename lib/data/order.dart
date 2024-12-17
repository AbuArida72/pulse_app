class Order {
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
  final String? status;
  const Order({this.id, this.name, this.image, this.discount, this.oldPrice, this.newPrice,
    this.rating, this.piece, this.volumeList, this.needPrescription, this.description, this.status});
}
class OrderList {
  static List<Order> list() {
    const data = <Order> [
      Order(
        id: 1,
        name: 'Betulin Lux',
        image: 'assets/images/bag/1.png',
        discount: '45',
        oldPrice: '100.00',
        newPrice: '55.00',
        rating: '5.0',
        piece: '50',
        volumeList: ['50', '100', '150', '200'],
        needPrescription: true,
        description: 'Plastic oi is a prescription medicine & a preparation of Cetirizine; which '
            'is a potent antihistamine.',
        status: 'Processing'
      ),
      Order(
          id: 2,
          name: 'Eoo Cool',
          image: 'assets/images/bag/2.png',
          discount: '20',
          oldPrice: '80.00',
          newPrice: '64.00',
          rating: '5.0',
          piece: '150',
          volumeList: ['50', '100', '150', '200'],
          needPrescription: false,
          description: 'Plastic oi is a prescription medicine & a preparation of Cetirizine; which is a potent antihistamine.',
          status: 'Confirmed'
      ),
      Order(
          id: 3,
          name: 'Plastic OI',
          image: 'assets/images/bag/3.png',
          discount: '45',
          oldPrice: '100.00',
          newPrice: '55.00',
          rating: '5.0',
          piece: '50',
          volumeList: ['50', '100', '150', '200'],
          needPrescription: true,
          description: 'Plastic oi is a prescription medicine & a preparation of Cetirizine; which is a potent antihistamine.',
          status: 'Picked'
      ),
      Order(
          id: 4,
          name: 'Suligga Max',
          image: 'assets/images/bag/4.png',
          discount: '20',
          oldPrice: '80.00',
          newPrice: '64.00',
          rating: '5.0',
          piece: '150',
          volumeList: ['50', '100', '150', '200'],
          needPrescription: false,
          description: 'Plastic oi is a prescription medicine & a preparation of Cetirizine; which is a potent antihistamine.',
          status: 'Shipped'
      ),
      Order(
          id: 5,
          name: 'Kusadu',
          image: 'assets/images/bag/5.png',
          discount: '45',
          oldPrice: '100.00',
          newPrice: '55.00',
          rating: '5.0',
          piece: '50',
          volumeList: ['50', '100', '150', '200'],
          needPrescription: true,
          description: 'Plastic oi is a prescription medicine & a preparation of Cetirizine; which is a potent antihistamine.',
          status: 'Canceled'
      ),
      Order(
          id: 6,
          name: 'NAPA',
          image: 'assets/images/bag/6.png',
          discount: '20',
          oldPrice: '80.00',
          newPrice: '64.00',
          rating: '5.0',
          piece: '150',
          volumeList: ['50', '100', '150', '200'],
          needPrescription: false,
          description: 'Plastic oi is a prescription medicine & a preparation of Cetirizine; which is a potent antihistamine.',
          status: 'Processing'
      ),
    ];
    return data;
  }
}