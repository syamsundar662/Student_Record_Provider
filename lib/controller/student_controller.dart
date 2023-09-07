import 'package:flutter/foundation.dart';
import 'package:student_record/controller/db_functions.dart';
import 'package:student_record/model/model.dart';


class StudentController extends ChangeNotifier{

Sql data = Sql();
List<Student> studentList =  <Student>[];
String studentImg =  '';
setImage(String img){
  studentImg =img;
  notifyListeners();

}

getAllStudents() async {
   studentList = await data.getData();
   notifyListeners();
}

addStudents(Student student)async{
 await data.insertInToDb(student);
 getAllStudents();
}

deleteStudent(int id)async{
 await data.deleteData(id);
 getAllStudents();
}

updateStudent(Student student,int id)async{
 await data.updateTable(student,id);
 await getAllStudents();
}
searchResult(String searchQuery) async {
    List<Student> list = await data.getData();
    studentList = list
        .where((student) =>
            student.name.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();
        notifyListeners();
        
  }
}