import '../pages/doctor/view_pat_history.dart';

class MedRec {
  final PatDetails patDetails;
  final PatHistory patHis;

  const MedRec({
    required this.patHis,
    required this.patDetails,
  });
}