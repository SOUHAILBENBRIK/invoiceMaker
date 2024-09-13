class Business {
  final String name;
  final String? userName;
  final String? description;
  final String? address;
  final String? email;

  Business(
      {
        this.userName,
        required this.name,
      this.description,
      this.address,
      this.email});
}
