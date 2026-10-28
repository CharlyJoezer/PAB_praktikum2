import 'package:flutter/foundation.dart';

/// Padanan ProfilViewModel.kt: menampung nama dan program studi.
/// State disimpan di sini, bukan di setiap layar.
class ProfilViewModel extends ChangeNotifier {
  String _nama = 'Mahasiswa Universitas Mulia';
  final String _prodi = 'Informatika';

  // Hanya bisa dibaca dari luar (setara "private set" di Kotlin)
  String get nama => _nama;
  String get prodi => _prodi;

  void ubahNama(String input) {
    _nama = input;
    notifyListeners(); // beri tahu UI agar tampilan diperbarui
  }
}
