class NearbyShops {
  // Placeholder for mock data
  static Future<List<dynamic>> fetchMockShops() async {
    // Simulate a delay to mimic an API call
    await Future.delayed(const Duration(seconds: 1));

    // Return mock shop data
    return [
      {
        'imageUrl': 'https://conceptualminds.com/wp-content/uploads/2022/08/Wiygul-Auto-Shop-Exterior.jpg',
      },
    ];
  }
}
