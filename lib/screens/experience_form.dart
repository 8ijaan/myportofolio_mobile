import 'package:flutter/material.dart';

class ExperienceFormPage extends StatefulWidget {
  const ExperienceFormPage({super.key});

  @override
  State<ExperienceFormPage> createState() => _ExperienceFormPageState();
}

class _ExperienceFormPageState extends State<ExperienceFormPage> {
  final _formKey = GlobalKey<FormState>();

  String _experienceName = "";
  String _description = "";
  String _category = "Full-Time"; // default
  String _experienceImageLink = "";

  final _endDateController = TextEditingController();
  final _startDateController = TextEditingController();
  DateTime? _startDate;
  DateTime? _endDate;

  @override
  void dispose() {
    _endDateController.dispose();
    _startDateController.dispose();
    super.dispose();
  }

  final List<String> _categories = [
    'Full-Time',
    'Part-Time',
    'Internship',
    'Freelance',
    'Research',
    'Volunteer',
    'Other',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Add Experience Form')),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    maxLines: 5,
                    decoration: InputDecoration(
                      hintText: 'Nama Experience',
                      labelText: 'Nama Experience',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    onChanged: (String? value) {
                      setState(() {
                        _experienceName = value!;
                      });
                    },
                    validator: (String? value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Nama Experience tidak boleh kosong!";
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    maxLines: 5,
                    decoration: InputDecoration(
                      hintText: 'Deskripsi Experience',
                      labelText: 'Deskripsi Experience',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    onChanged: (String? value) {
                      setState(() {
                        _description = value!;
                      });
                    },
                    // validator: (String? value) {
                    //   if (value == null || value.trim().isEmpty) {
                    //     return "Deskripsi Experience tidak boleh kosong!";
                    //   }
                    // },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      hintText: 'Kategori Experience',
                      labelText: 'Kategori Experience',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    initialValue: _category,
                    items: _categories
                        .map(
                          (category) => DropdownMenuItem(
                            value: category,
                            child: Text(category),
                          ),
                        )
                        .toList(),
                    onChanged: (String? value) {
                      setState(() {
                        _category = value!;
                      });
                    },
                    validator: (String? value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Kategori Experience tidak boleh kosong!";
                      }
                    },
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: _startDateController,
                          readOnly:
                              true, // tidak bisa diketik, hanya lewat kalender
                          decoration: InputDecoration(
                            labelText: 'Tanggal Mulai',
                            hintText: 'Pilih tanggal',
                            suffixIcon: const Icon(Icons.calendar_today),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                          onTap: () async {
                            final picked = await showDatePicker(
                              context: context,
                              initialDate: _startDate ?? DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime.now(),
                            );
                            if (picked != null) {
                              setState(() {
                                _startDate = picked;
                                _startDateController.text =
                                    '${picked.day}/${picked.month}/${picked.year}';
                                if (_endDate != null &&
                                    _endDate!.isBefore(picked)) {
                                  _endDate = null;
                                  _endDateController.clear();
                                }
                              });
                            }
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: _endDateController,
                          readOnly:
                              true, // tidak bisa diketik, hanya lewat kalender
                          decoration: InputDecoration(
                            labelText: 'Tanggal Berakhir',
                            hintText: 'Pilih tanggal',
                            suffixIcon: const Icon(Icons.calendar_today),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                          onTap: () async {
                            final picked = await showDatePicker(
                              context: context,
                              initialDate:
                                  _endDate ?? _startDate ?? DateTime.now(),
                              firstDate: _startDate ?? DateTime(2000),
                              lastDate: DateTime.now(),
                            );
                            if (picked != null) {
                              setState(() {
                                _endDate = picked;
                                _endDateController.text =
                                    '${picked.day}/${picked.month}/${picked.year}';
                              });
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsetsGeometry.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Experience Image Link',
                      hintText: 'Experience Image Link',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    onChanged: (String? value) {
                    setState(() {
                      _experienceImageLink = value!;
                    });
                  },
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(Colors.indigo),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text(
                                  'Proyek berhasil ditambahkan!',
                                ),
                                content: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Nama Pengalaman: $_experienceName'),
                                      Text('Deskripsi: $_description'),
                                      Text('Kategori: $_category'),
                                      Text('Dimulai pada: $_startDate'),
                                      Text('Dimulai pada: $_endDate'),
                                      Text('Tautan: $_experienceImageLink'),
                                    ],
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    child: const Text('OK'),
                                    onPressed: () {
                                      Navigator.pop(context);
                                      _formKey.currentState!.reset();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      },
                      child: const Text(
                        "Save",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
