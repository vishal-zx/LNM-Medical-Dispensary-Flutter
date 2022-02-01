import 'dart:io';
import 'package:lnm_medical_dispensary/apis/pdf_api.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import '../models/model.dart';
import '../pages/doctor/view_pat_history.dart';
import '../pages/patient/view_med_cert_reqs.dart';
import 'package:remove_emoji/remove_emoji.dart';
var remove = RemoveEmoji();
class PdfMedCertApi {
  static Future<File> generate(MedCert mc) async {
    final pdf = Document();
    pdf.addPage(MultiPage(
      build: (context) => [
        Column(
          children: [
            header(),
            title(),
            patBody(mc.patDetails),
            certificate(mc.medCert),
            
            Container(
              height: 130,
              child: footer(),
            )

          ]
        ),
      ],
    ));

    return PdfApi.saveDocument(name: 'Medical Certificate - ${mc.patDetails.name}.pdf', pdf: pdf);
  }

  static Widget header() => Container(
    width: double.maxFinite,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children:[
        Text(
          "The LNM Institute of Information Technology",
          style: TextStyle(
            color: PdfColors.black,
            fontSize: 24,
            font: Font.timesBold(),
          )
        ),
        SizedBox(height: 10),
        Text(
          "Rupa ki Nangal, Post-Sumel, Via-Jamdoli\nJaipur, Rajasthan - 302031",
          style: TextStyle(
            color: PdfColors.black,
            fontSize: 18,
            font: Font.times(),
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 10),
        Container(
          width: double.maxFinite,
          height: 1, 
          color: PdfColors.black,
        )
      ]
    )
  );

  static Widget title() => Container(
    width: double.maxFinite,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children:[
        SizedBox(height: 10),
        Text(
          "Medical Certificate",
          style: TextStyle(
            color: PdfColors.black,
            fontSize: 25,
            font: Font.timesBold(),
          )
        ),
        SizedBox(height: 15),
      ]
    )
  );

  static Widget patBody(PatDetails pd) => Container(
    height: 125,
    width: double.maxFinite,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children:[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  "Patient:",
                  style: TextStyle(
                    color: PdfColors.black,
                    fontSize: 20,
                    font: Font.timesBold(),
                  )
                ), 
                SizedBox(width: 10),
                Text(
                  pd.name,
                  style: TextStyle(
                    color: PdfColors.black,
                    fontSize: 20,
                    font: Font.times(),
                  )
                ), 
              ]
            ),
            Row(
              children: [
                Text(
                  "Mobile:",
                  style: TextStyle(
                    color: PdfColors.black,
                    fontSize: 20,
                    font: Font.timesBold(),
                  )
                ), 
                SizedBox(width: 10),
                Text(
                  pd.mob,
                  style: TextStyle(
                    color: PdfColors.black,
                    fontSize: 20,
                    font: Font.times(),
                  )
                ), 
              ]
            ),
          ]
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  "Email:",
                  style: TextStyle(
                    color: PdfColors.black,
                    fontSize: 20,
                    font: Font.timesBold(),
                  )
                ), 
                SizedBox(width: 10),
                Text(
                  pd.email,
                  style: TextStyle(
                    color: PdfColors.black,
                    fontSize: 20,
                    font: Font.times(),
                  )
                ), 
              ]
            ),
            Row(
              children: [
                Text(
                  "Gender:",
                  style: TextStyle(
                    color: PdfColors.black,
                    fontSize: 20,
                    font: Font.timesBold(),
                  )
                ), 
                SizedBox(width: 10),
                Text(
                  pd.gender,
                  style: TextStyle(
                    color: PdfColors.black,
                    fontSize: 20,
                    font: Font.times(),
                  )
                ), 
              ]
            ),
          ]
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Text(
              "Age:",
              style: TextStyle(
                color: PdfColors.black,
                fontSize: 20,
                font: Font.timesBold(),
              )
            ), 
            SizedBox(width: 10),
            Text(
              pd.age,
              style: TextStyle(
                color: PdfColors.black,
                fontSize: 20,
                font: Font.times(),
              )
            ), 
          ]
        ),
        SizedBox(height: 10),
        Divider(),
        SizedBox(height: 10),
      ]
    )
  );

  static Widget certificate(MedCertRequests mc) => Container(
    height: 330,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children:[
        Row(
          children: [
            Text(
              "Doctor:",
              style: TextStyle(
                color: PdfColors.black,
                fontSize: 20,
                font: Font.timesBold(),
              )
            ), 
            SizedBox(width: 10),
            Text(
              "Dr. "+mc.doctor,
              style: TextStyle(
                color: PdfColors.black,
                fontSize: 20,
                font: Font.times(),
              )
            ), 
          ]
        ),
        SizedBox(height: 10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Reason for Certificate:",
              style: TextStyle(
                color: PdfColors.black,
                fontSize: 20,
                font: Font.timesBold(),
              )
            ), 
            SizedBox(width: 10),
            Text(
              mc.reason.substring(0, (mc.reason.length>35)?35:mc.reason.length).removemoji,
              style: TextStyle(
                color: PdfColors.black,
                fontSize: 20,
                font: Font.times(),
              )
            ), 
          ]
        ),
        if(mc.reason.length>35)
        Container(
          child:
            Text(
              '-'+mc.reason.substring(35).removemoji,
              style: TextStyle(
                color: PdfColors.black,
                fontSize: 20,
                font: Font.times(),
              ),
            ), 
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  "Certificate Issued From:",
                  style: TextStyle(
                    color: PdfColors.black,
                    fontSize: 20,
                    font: Font.timesBold(),
                  )
                ), 
                SizedBox(width: 10),
                Text(
                  mc.fromDate,
                  style: TextStyle(
                    color: PdfColors.black,
                    fontSize: 20,
                    font: Font.times(),
                  )
                ), 
                SizedBox(width: 10),
                Text(
                  "To:",
                  style: TextStyle(
                    color: PdfColors.black,
                    fontSize: 20,
                    font: Font.timesBold(),
                  )
                ), 
                SizedBox(width: 10),
                Text(
                  mc.toDate,
                  style: TextStyle(
                    color: PdfColors.black,
                    fontSize: 20,
                    font: Font.times(),
                  )
                ), 
              ]
            ),
          ]
        ),
        SizedBox(height: 30),
        Center(
          child: Text(
            "APPROVED",
            style: TextStyle(
              color: PdfColors.black,
              fontSize: 26,
              font: Font.timesBold(),
            ),
            textAlign: TextAlign.center,
          ),
        )
      ]
    )
  );

  static Widget footer() => Container(
    width: double.maxFinite,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children:[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Text(
                  "-----------------------",
                  style: TextStyle(
                    color: PdfColors.black,
                    fontSize: 20,
                    font: Font.timesBold(),
                  )
                ), 
                SizedBox(width: 10),
                Text(
                  "Medical Unit Seal",
                  style: TextStyle(
                    color: PdfColors.black,
                    fontSize: 20,
                    font: Font.times(),
                  )
                ), 
              ]
            ),
            Column(
              children: [
                Text(
                  "-----------------------",
                  style: TextStyle(
                    color: PdfColors.black,
                    fontSize: 20,
                    font: Font.timesBold(),
                  )
                ), 
                SizedBox(width: 10),
                Text(
                  "Doctor's Signature",
                  style: TextStyle(
                    color: PdfColors.black,
                    fontSize: 20,
                    font: Font.times(),
                  )
                ), 
              ]
            )
          ]
        ),
        SizedBox(height: 10),
        Divider(),
        SizedBox(height: 5),
        Text(
          "Medical Unit - LNMIIT, Jaipur",
          style: TextStyle(
            color: PdfColors.black,
            fontSize: 20,
            font: Font.timesBold(),
          )
        ),
        Text(
          "All rights reserved to LNMIIT.",
          style: TextStyle(
            color: PdfColors.black,
            fontSize: 18,
            font: Font.times(),
          ),
          textAlign: TextAlign.center,
        ),
      ]
    )
  );
}