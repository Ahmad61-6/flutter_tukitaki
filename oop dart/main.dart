void main(){
Person person = Person();

  person.displayInfo();

  Student student = Student();

  student.name = "Ayman";
  student.studentID = 123;
  student.age = 22;
  student.grade = 'A';

  student.displayInfo();
  student.updateGrade('A+');

  Area area = Area();
  area.height = 10;
  //area.width = 10;
  area.calculateRectangleArea();

}

class Person{
  String name = 'Ayman';
  String fatherName = "Mizanur Rahman";
  int age = 22;

  void displayInfo(){
    print('name: ${name}\nFather name: ${fatherName}\nAge: ${age}');
  }

}

class Student {
  String? name;
  int? studentID;
  int? age;
  String? grade;

  void displayInfo(){
    print('Name: ${name}\nStudent ID: ${studentID}\nAge: ${age}\nGrade: ${grade}\n------------------');
  }

  void updateGrade(String updatedGrade){
    grade = updatedGrade;
    print ("The grade is updated to ${grade}");
    displayInfo();
  }
}

//null check
class Area {
  double? height;
  double? width;

  void calculateRectangleArea(){
    try{
       double areaOfRectangle = height! * width!;
       // areaofRectangle = height ?? 0 * width ?? 0;
    print(areaOfRectangle);

    }catch(e){
      print(e);
    }
   
  }
}