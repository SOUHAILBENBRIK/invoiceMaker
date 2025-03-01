import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:open_filex/open_filex.dart';
import 'package:quick_invoice/model/business.dart';
import 'package:quick_invoice/model/invoice.dart';

class InvoicePdfGenerator {
  final Business company;
  final InvoiceModel invoice;

  InvoicePdfGenerator({required this.company, required this.invoice});

  Future<void> generateInvoicePdf() async {
    final pdf = pw.Document();

    // Load custom fonts
    final robotoRegular = pw.Font.ttf(await rootBundle.load('assets/fonts/Roboto-Regular.ttf'));
    final robotoBold = pw.Font.ttf(await rootBundle.load('assets/fonts/Roboto-Bold.ttf'));

    // Create an invoice layout using the custom font
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // Company Info and Logo
              pw.Align(
                alignment: pw.Alignment.center,
                child: pw.Text('Invoice 0${invoice.invoiceNumber.split("INV")[1]}', style: pw.TextStyle(fontSize: 18, font: robotoRegular)),
              ),
              pw.SizedBox(height: 20),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  _buildCompanyInfo(robotoBold, robotoRegular),
                  if (company.image != null)
                    pw.Image(pw.MemoryImage(company.image!), width: 80, height: 80),
                ],
              ),
              pw.SizedBox(height: 20),
              
              // Client Info
              _buildClientInfo(robotoBold, robotoRegular),

              pw.SizedBox(height: 20),

              // Invoice Info
              _buildInvoiceInfo(robotoBold, robotoRegular),

              pw.SizedBox(height: 20),

              // Table for Items
              _buildInvoiceItemsTable(robotoBold, robotoRegular),

              pw.SizedBox(height: 30),
              pw.Align(
                alignment: pw.Alignment.centerRight,
                child: pw.Text('Discount:  ${invoice.discount}%', style: pw.TextStyle(fontSize: 18, font: robotoRegular)),
              ),
              pw.SizedBox(height: 10),
              // Total Amount
              pw.Align(
                alignment: pw.Alignment.centerRight,
                child: pw.Text('Total:  ${invoice.total} ${invoice.currency.abbreviation}', style: pw.TextStyle(fontSize: 18, font: robotoBold)),
              ),
            ],
          );
        },
      ),
    );

    // Save PDF and open it
    await savePdfAndOpen(pdf,invoice.invoiceNumber);
  }

  pw.Widget _buildCompanyInfo(pw.Font bold, pw.Font regular) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(company.name, style: pw.TextStyle(fontSize: 20, font: bold)),
        if (company.description != null && company.description!.isNotEmpty)
          pw.Text(company.description!, style: pw.TextStyle(font: regular)),
        if (company.address != null && company.address!.isNotEmpty)
          pw.Text(company.address!, style: pw.TextStyle(font: regular)),
        if (company.phone != null && company.phone!.isNotEmpty)
          pw.Text('Phone: ${company.phone}', style: pw.TextStyle(font: regular)),
        if (company.email != null && company.email!.isNotEmpty)
          pw.Text('Email: ${company.email}', style: pw.TextStyle(font: regular)),
      ],
    );
  }

  pw.Widget _buildClientInfo(pw.Font bold, pw.Font regular) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text('Invoice To:', style: pw.TextStyle(fontSize: 18, font: bold)),
        pw.Text(invoice.clientName.name, style: pw.TextStyle(font: regular)),
        pw.Text(invoice.clientName.address, style: pw.TextStyle(font: regular)),
        pw.Text('Phone: ${invoice.clientName.phone}', style: pw.TextStyle(font: regular)),
        pw.Text('Email: ${invoice.clientName.email}', style: pw.TextStyle(font: regular)),
      ],
    );
  }

  pw.Widget _buildInvoiceInfo(pw.Font bold, pw.Font regular) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text('Invoice #: ${invoice.invoiceNumber}', style: pw.TextStyle(font: regular)),
        pw.Text('Invoice Date: ${invoice.invoiceDate.split("T")[0]}', style: pw.TextStyle(font: regular)),
        pw.Text('Due Date: ${invoice.invoiceDue.split("T")[0]}', style: pw.TextStyle(font: regular)),
        pw.Text('Note: ${invoice.note.isEmpty?"No description":invoice.note}', style: pw.TextStyle(font: regular)),
      ],
    );
  }

  pw.Widget _buildInvoiceItemsTable(pw.Font bold, pw.Font regular) {
    return pw.TableHelper.fromTextArray(
      headers: ['Item', 'Quantity', 'Unit Price', 'Total'],
      data: invoice.items.map((item) {
        return [
          item.name,
          item.count.toString(),
          '${invoice.currency.abbreviation} ${item.price}',
          '${invoice.currency.abbreviation} ${item.count * item.price}',
        ];
      }).toList(),
      headerStyle: pw.TextStyle(font: bold),
      cellStyle: pw.TextStyle(font: regular),
    );
  }

  Future<void> savePdfAndOpen(pw.Document pdf ,String invoiceNumber) async {
    try {
      final outputDir = await getApplicationDocumentsDirectory();
      final filePath = '${outputDir.path}/$invoiceNumber.pdf';
      final file = File(filePath);

      // Save the document as a file
      await file.writeAsBytes(await pdf.save());

      // Open the PDF file
      await OpenFilex.open(filePath);
    } catch (e) {
      print('Error saving or opening PDF: $e');
    }
  }
}
