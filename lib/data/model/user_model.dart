
// data format from API Response.
// {
// "status": "success",
              // "data": {
              // "_id": "69390ae1880cc5d30a303a02",
              // "email": "dc@mail.com",
              // "firstName": "Motaleb",
              // "lastName": "Hossain",
              // "mobile": "01992542763",
              // "createdDate": "2025-10-02T06:21:41.011Z"
              // },
// "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE3NjU0MzI0NzQsImRhdGEiOiJkY0BtYWlsLmNvbSIsImlhdCI6MTc2NTM0NjA3NH0.CY7pWG1f0YgRjlgg4B3gvKIhLShTJUc4zbFC8M46vPU"
// }

class UserModel{
  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final String mobile;
  final String photo;


  UserModel({required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.mobile,
    required this.photo
  });

  factory UserModel.formJson(Map<String, dynamic> jsonData) {
    return UserModel(id: jsonData['_id'],
        email: jsonData['email'],
        firstName: jsonData['firstName'],
        lastName: jsonData['lastName'],
        mobile: jsonData['mobile'],
        photo: jsonData['photo'] ?? '',
    );
  }

  Map<String, dynamic> toJson(){
    return {
       "_id": id,
       "email": email,
       "firstName": firstName,
       "lastName": lastName,
       "mobile": mobile,
       "photo": photo
    };
  }

}