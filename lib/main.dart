import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'profil_view_model.dart';

void main() {
  runApp(
    // ViewModel dibuat sekali di level atas, sehingga dipakai bersama semua layar
    ChangeNotifierProvider(
      create: (_) => ProfilViewModel(),
      child: const AplikasiProfil(),
    ),
  );
}

class AplikasiProfil extends StatelessWidget {
  const AplikasiProfil({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navigasi Profil Mahasiswa',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.indigo, useMaterial3: true),
      // Tiga route: beranda, profil, matakuliah
      initialRoute: '/beranda',
      routes: {
        '/beranda': (_) => const LayarBeranda(),
        '/profil': (_) => const LayarProfil(),
        '/matakuliah': (_) => const LayarMataKuliah(),
      },
    );
  }
}

// ---------------- Layar 1: Beranda ----------------
class LayarBeranda extends StatelessWidget {
  const LayarBeranda({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ProfilViewModel>();
    return Scaffold(
      appBar: AppBar(title: const Text('Beranda')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Beranda',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text('Halo, ${vm.nama}'),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/profil'),
              child: const Text('Buka Profil'),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------- Layar 2: Profil ----------------
class LayarProfil extends StatefulWidget {
  const LayarProfil({super.key});

  @override
  State<LayarProfil> createState() => _LayarProfilState();
}

class _LayarProfilState extends State<LayarProfil> {
  late final TextEditingController _namaCtrl;

  @override
  void initState() {
    super.initState();
    // Isi awal diambil dari ViewModel
    _namaCtrl = TextEditingController(
      text: context.read<ProfilViewModel>().nama,
    );
  }

  @override
  void dispose() {
    _namaCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ProfilViewModel>();
    return Scaffold(
      appBar: AppBar(title: const Text('Profil')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Profil Mahasiswa',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _namaCtrl,
              onChanged: vm.ubahNama, // setiap ketikan disimpan ke ViewModel
              decoration: const InputDecoration(
                labelText: 'Nama',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            Text('Program studi: ${vm.prodi}'),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/matakuliah'),
              child: const Text('Detail Mata Kuliah'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Kembali'),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------- Layar 3: Detail Mata Kuliah ----------------
class LayarMataKuliah extends StatelessWidget {
  const LayarMataKuliah({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detail Mata Kuliah')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Pemrograman Aplikasi Bergerak',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text('Topik: Flutter dan Android'),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Kembali'),
            ),
          ],
        ),
      ),
    );
  }
}
