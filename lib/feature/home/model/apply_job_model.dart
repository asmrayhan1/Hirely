class JobApplyModel {
  int? id;
  int jobId;
  String name;
  String email;
  String phone;
  String address;
  String cv;

  // Constructor
  JobApplyModel({
    this.id,
    required this.jobId,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.cv,
  });

  // Factory method to create a JobApply object from a map (e.g., from JSON)
  factory JobApplyModel.fromMap(Map<String, dynamic> map) {
    return JobApplyModel(
      id: map['id'],
      jobId: map['job_id'],
      name: map['name'],
      email: map['email'],
      phone: map['phone'],
      address: map['address'],
      cv: map['cv'],
    );
  }

  // Method to convert JobApply object into a map (e.g., to send it as JSON)
  Map<String, dynamic> toMap() {
    return {
      'job_id': jobId,
      'name': name,
      'email': email,
      'phone': phone,
      'address': address,
      'cv': cv,
    };
  }
}
