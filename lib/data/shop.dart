// repair_shops.dart
class RepairShop {
  final String name;
  final String location;
  final String number;
  final String openingHours;

  RepairShop({
    required this.name,
    required this.location,
    required this.number,
    required this.openingHours,
  });
}

// Sample repair shop data
final List<RepairShop> repairShops = [
  RepairShop(
    name: 'Mechanic User',
    location: 'Urdneta City',
    number: '09123728293',
    openingHours: 'Mon-Fri: 8 AM - 6 PM, Sat: 9 AM - 4 PM',
  ),
  RepairShop(
    name: 'AutoCare Service Center',
    location: '456 Elm St, Townsville',
    number: '1234567976',
    openingHours: 'Mon-Sat: 7 AM - 7 PM',
  ),
  RepairShop(
    name: 'Speedy Car Fix',
    location: '789 Oak St, Metro City',
    number: '1234567976',
    openingHours: 'Mon-Fri: 8 AM - 5 PM',
  ),
];
