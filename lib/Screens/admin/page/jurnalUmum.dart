import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:AAccounting/serverdata/api.dart';
import 'package:flutter/material.dart';
import '../../../../constants.dart';
import '../../../../pallete.dart';
import 'appbar_menu.dart';

class JurnalUmum extends StatefulWidget {
  const JurnalUmum({Key? key}) : super(key: key);

  @override
  _JurnalUmumState createState() => _JurnalUmumState();
}

class _JurnalUmumState extends State<JurnalUmum> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBarMenu("Jurnal Umum"),
      body: SingleChildScrollView(
        child: PaginatedDataTable(
          rowsPerPage: _rowsPerPage,
          availableRowsPerPage: const <int>[5, 10, 20],
          onRowsPerPageChanged: (int? value) {
            if (value != null) {
              setState(() => _rowsPerPage = value);
            }
          },
          columns: kTableColumns,
          source: DessertDataSource(),
        ),
      )
    );
  }
}

const kTableColumns = <DataColumn>[
  DataColumn(
    label: Text('Tanggal'),
  ),
  DataColumn(
    label: Text('Transaksi'),
  ),
  DataColumn(
    label: Text('Debit'),
    numeric: true,
  ),
  DataColumn(
    label: Text('Kredit'),
    numeric: true,
  ),
];

class Dessert {
  Dessert(this.tanggal, this.transaksi, this.debit, this.kredit);
  final String tanggal;
  final String transaksi;
  final int debit;
  final int kredit;
  bool selected = false;
}

////// Data source class for obtaining row data for PaginatedDataTable.

class DessertDataSource extends DataTableSource {
  int _selectedCount = 0;
  final List<Dessert> _desserts = <Dessert>[
    Dessert('21/02/2022', 'Kas', 50000000, 0),
  ];

  @override
  DataRow? getRow(int index) {
    assert(index >= 0);
    if (index >= _desserts.length) return null;
    final Dessert dessert = _desserts[index];
    return DataRow.byIndex(
      index: index,
      selected: dessert.selected,
      onSelectChanged: (bool? value) {
        if (value == null) return;
        if (dessert.selected != value) {
          _selectedCount += value ? 1 : -1;
          assert(_selectedCount >= 0);
          dessert.selected = value;
          notifyListeners();
        }
      },
      cells: <DataCell>[
        DataCell(Text(dessert.tanggal)),
        DataCell(Text(dessert.transaksi)),
        DataCell(Text('Rp. ${dessert.debit}')),
        DataCell(Text('Rp. ${dessert.kredit}')),
      ],
    );
  }

  @override
  int get rowCount => _desserts.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}
