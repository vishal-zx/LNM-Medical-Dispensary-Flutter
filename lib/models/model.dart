import '../pages/doctor/view_pat_history.dart';
import '../pages/patient/view_med_cert_reqs.dart';

class MedRec {
  final PatDetails patDetails;
  final PatHistory patHis;

  const MedRec({
    required this.patHis,
    required this.patDetails,
  });
}

class MedCert {
  final PatDetails patDetails;
  final MedCertRequests medCert;

  const MedCert({
    required this.medCert,
    required this.patDetails,
  });
}