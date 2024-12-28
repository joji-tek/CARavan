

class BookingDetailsScreen  {
  final String carModel;
  final String licensePlate;
  final String issueDescription;
  final String street;
  final String city;
  final String state;
  final String zipCode;
  final String country;
  final String landmark;
  final String serviceProviderName;
  final String serviceProviderProfile;
  final bool isUrgent;
  final String issuePrice;

  const BookingDetailsScreen({
    required this.carModel,
    required this.licensePlate,
    required this.issueDescription,
    required this.street,
    required this.city,
    required this.state,
    required this.zipCode,
    required this.country,
    required this.landmark,
    required this.serviceProviderName,
    required this.serviceProviderProfile,
    required this.isUrgent,
    required this.issuePrice,
  });
}