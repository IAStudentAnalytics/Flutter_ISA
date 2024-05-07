
class CoursR {
  final String id;  
  final String nomCoursR;
  final String description;
  final String pdff;

  CoursR({
    required this.id,
    required this.nomCoursR,
    required this.description,
    required this.pdff,
  });
}

class CoursData {
  final List<CoursR> coursList;

  CoursData({
    required this.coursList,
  });
}