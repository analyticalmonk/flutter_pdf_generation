import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

createLedgerPdf({
  String companyName,
  String partyName,
  String startDate,
  String endDate,
  List<List<String>> ledgerList,
  // String openingBalance,
  // String closingBalance,
  // String totalCreditWithoutClosingBalance,
  // String totalDebitWithoutClosingBalance,
  // String totalCredit,
  // String totalDebit
}) {
  final pdf = Document();
  pdf.addPage(
    MultiPage(
      pageFormat:
          PdfPageFormat.letter.copyWith(marginBottom: 1.5 * PdfPageFormat.cm),
      crossAxisAlignment: CrossAxisAlignment.start,
      header: (Context context) {
        if (context.pageNumber == 1) {
          return Header(
            level: 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(companyName, textScaleFactor: 2),
                SizedBox(height: 10),
                Text(partyName, textScaleFactor: 2),
                Text('Ledger Account', textScaleFactor: 1.5),
                SizedBox(height: 20),
                Text('$startDate to $endDate', textScaleFactor: 1.5),
              ],
            ),
          );
        }
        return Container(
          alignment: Alignment.centerRight,
          margin: const EdgeInsets.only(bottom: 3.0 * PdfPageFormat.mm),
          padding: const EdgeInsets.only(bottom: 3.0 * PdfPageFormat.mm),
          decoration: const BoxDecoration(
              border:
                  BoxBorder(bottom: true, width: 0.5, color: PdfColors.grey)),
          child: Column(
            children: <Widget>[
              Container(
                child: Text(companyName),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('$partyName   Ledger Account: $startDate to $endDate'),
                  Text('Page ${context.pageNumber}'),
                ],
              ),
              Table.fromTextArray(context: context, data: [
                [
                  'Date',
                  'Particulars',
                  'Vch Type',
                  'Vch No.',
                  'Debit',
                  'Credit'
                ],
              ]),
            ],
          ),
        );
      },
      footer: (Context context) {
        return Container(
            alignment: Alignment.centerRight,
            margin: const EdgeInsets.only(top: 1.0 * PdfPageFormat.cm),
            child: Text('Page ${context.pageNumber} of ${context.pagesCount}',
                style: Theme.of(context)
                    .defaultTextStyle
                    .copyWith(color: PdfColors.grey)));
      },
      build: (Context context) => <Widget>[
        SizedBox(height: 30),
        // Ledger entry table
        // Table.fromTextArray(
        //   context: context,
        //   data: [
        //     ['Date', 'Particulars', 'Vch Type', 'Vch No.', 'Debit', 'Credit'],
        //   ],
        // ),
        Table.fromTextArray(
          context: context,
          data: ledgerList,
        ),
        SizedBox(height: 30),
        Padding(padding: const EdgeInsets.all(10)),
      ],
    ),
  );
  return pdf;
}

createInvoicePdf() {
  final pdf = Document();
  pdf.addPage(
    MultiPage(
      pageFormat:
          PdfPageFormat.letter.copyWith(marginBottom: 1.5 * PdfPageFormat.cm),
      crossAxisAlignment: CrossAxisAlignment.start,
      header: (Context context) {
        if (context.pageNumber == 1) {
          return null;
        }
        return Container(
            alignment: Alignment.centerRight,
            margin: const EdgeInsets.only(bottom: 3.0 * PdfPageFormat.mm),
            padding: const EdgeInsets.only(bottom: 3.0 * PdfPageFormat.mm),
            decoration: const BoxDecoration(
                border:
                    BoxBorder(bottom: true, width: 0.5, color: PdfColors.grey)),
            child: Text('TallyAssist',
                style: Theme.of(context)
                    .defaultTextStyle
                    .copyWith(color: PdfColors.grey)));
      },
      footer: (Context context) {
        return Container(
            alignment: Alignment.centerRight,
            margin: const EdgeInsets.only(top: 1.0 * PdfPageFormat.cm),
            child: Text('Page ${context.pageNumber} of ${context.pagesCount}',
                style: Theme.of(context)
                    .defaultTextStyle
                    .copyWith(color: PdfColors.grey)));
      },
      build: (Context context) => <Widget>[
        Header(
          level: 0,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('GST Invoice', textScaleFactor: 2),
                // PdfLogo()
              ]),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    border: BoxBorder(
                      bottom: true,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Paragraph(text: 'ABCD Industries'),
                      Paragraph(text: 'Khasra No 1234/1 & 166/2'),
                      Paragraph(text: 'XYZ, DEF Road'),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: BoxBorder(
                      top: true,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Paragraph(text: 'Buyer'),
                      Paragraph(text: 'X Agencies, Narnia'),
                      Paragraph(text: '1234/5, Chowk Hat, D'),
                      Paragraph(text: 'Distt Jumper (Maharashtra)'),
                      Paragraph(text: 'GSTIN/UIN: XXXXXX99XXXXX'),
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              child: GridView(
                crossAxisCount: 2,
                childAspectRatio: 0.3,
                children: <Widget>[
                  gridChild('Invoice No.', '19/20/NK/0192'),
                  gridChild('Dated', '5-Feb-2020'),
                  gridChild('Delivery Notes', ''),
                  gridChild('Mode/Terms of Payment', ''),
                  gridChild('Suppliers Ref', ''),
                  gridChild('Other Reference(s)', ''),
                  gridChild('Buyers order no', ''),
                  gridChild('Dated', ''),
                  gridChild('Despatch Document No', ''),
                  gridChild('Delivery Note Date', ''),
                  gridChild('Despatched through', ''),
                  gridChild('Destination', ''),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 30),
        Table.fromTextArray(context: context, data: const <List<String>>[
          [
            'SI No.',
            'Description of Goods',
            'HSN/SAC',
            'Quantity',
            'Rate',
            'per',
            'Disc%',
            'Amount'
          ],
          [
            '1',
            'PARAM LURE REFILL FRUIT FLY (O) (PACK)',
            '3808',
            '10 Pack (100 Pcs)',
            '180.00',
            'Pack',
            '',
            '1,800.00'
          ],
          ['', 'CGST- MH (27)', '', '', '', '', '', '162.00'],
          ['', 'Total', '', '10 Pack', '', '', '', 'Rs. 2,124.00']
        ]),
        SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Company PAN:'),
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: BoxBorder(
                    top: true,
                    left: true,
                    right: true,
                    bottom: true,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('For ABCD Pvt Ltd'),
                    SizedBox(height: 25),
                    Text('Authorised Signatory'),
                  ],
                ),
              ),
            ),
          ],
        ),
        Padding(padding: const EdgeInsets.all(10)),
      ],
    ),
  );
  return pdf;
}

gridChild(String text1, String text2) {
  return Container(
    alignment: Alignment.center,
    decoration: BoxDecoration(
      border: BoxBorder(
        left: true,
        right: true,
        top: true,
        bottom: true,
      ),
    ),
    child: Column(
      children: <Widget>[
        Text(text1),
        Text(text2),
      ],
    ),
  );
}
