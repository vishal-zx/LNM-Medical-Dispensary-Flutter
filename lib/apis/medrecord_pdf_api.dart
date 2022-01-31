import 'dart:io';
import 'package:lnm_medical_dispensary/apis/pdf_api.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';
import '../models/med_record.dart';
import '../pages/doctor/view_pat_history.dart';
class PdfMedRecordApi {
  static Future<File> generate(MedRec medRec) async {
    final pdf = Document();
    pdf.addPage(MultiPage(
      build: (context) => [
        Column(
          children: [
            header(),
            title(),
            patBody(medRec.patDetails),
            prescBody(medRec.patHis),
            
            pw.Container(
              height: 130,
              child: footer(),
            )

          ]
        ),
      ],
    ));

    return PdfApi.saveDocument(name: 'Medical Record - ${medRec.patHis.patient}.pdf', pdf: pdf);
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
        pw.Container(
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
          "Medical Record",
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
        pw.Divider(),
        SizedBox(height: 10),
      ]
    )
  );

  static Widget prescBody(PatHistory ph) => Container(
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
              "Dr. "+ph.doctor,
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
              "Reason (by Patient):",
              style: TextStyle(
                color: PdfColors.black,
                fontSize: 20,
                font: Font.timesBold(),
              )
            ), 
            SizedBox(width: 10),
            Text(
              ph.reason,
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  "Appointment Date:",
                  style: TextStyle(
                    color: PdfColors.black,
                    fontSize: 20,
                    font: Font.timesBold(),
                  )
                ), 
                SizedBox(width: 10),
                Text(
                  ph.dateTime.substring(0,10),
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
                  "Time:",
                  style: TextStyle(
                    color: PdfColors.black,
                    fontSize: 20,
                    font: Font.timesBold(),
                  )
                ), 
                SizedBox(width: 10),
                Text(
                  ph.dateTime.substring(11),
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
              "Prescription:",
              style: TextStyle(
                color: PdfColors.black,
                fontSize: 20,
                font: Font.timesBold(),
              )
            ), 
            SizedBox(width: 10),
            Text(
              ph.prescription.substring(0, (ph.prescription.length>42)?42:ph.prescription.length),
              style: TextStyle(
                color: PdfColors.black,
                fontSize: 20,
                font: Font.times(),
              ),
            ), 
          ]
        ),
        if(ph.prescription.length>42)
        Container(
          child:
            Text(
              '-'+ph.prescription.substring(42),
              style: TextStyle(
                color: PdfColors.black,
                fontSize: 20,
                font: Font.times(),
              ),
            ), 
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Text(
              "Other Instructions:",
              style: TextStyle(
                color: PdfColors.black,
                fontSize: 20,
                font: Font.timesBold(),
              )
            ), 
            SizedBox(width: 10),
            Text(
              ph.instruction.substring(0, (ph.instruction.length>38)?38:ph.instruction.length),
              style: TextStyle(
                color: PdfColors.black,
                fontSize: 20,
                font: Font.times(),
              )
            ), 
          ]
        ),
        if(ph.instruction.length>38)
        Container(
          child:
            Text(
              '-'+ph.instruction.substring(38),
              style: TextStyle(
                color: PdfColors.black,
                fontSize: 20,
                font: Font.times(),
              ),
            ), 
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Text(
              "Refer to (if any):",
              style: TextStyle(
                color: PdfColors.black,
                fontSize: 20,
                font: Font.timesBold(),
              )
            ), 
            SizedBox(width: 10),
            Text(
              ph.refer.substring(0, (ph.refer.length>38)?38:ph.refer.length),
              style: TextStyle(
                color: PdfColors.black,
                fontSize: 20,
                font: Font.times(),
              )
            ), 
          ]
        ),
        if(ph.refer.length>38)
        Container(
          child:
            Text(
              '-'+ph.refer.substring(38),
              style: TextStyle(
                color: PdfColors.black,
                fontSize: 20,
                font: Font.times(),
              ),
            ), 
        ),
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
          mainAxisAlignment: MainAxisAlignment.end,
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
        pw.Divider(),
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