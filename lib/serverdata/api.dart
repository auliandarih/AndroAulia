import 'domain.dart';

class myUrl{

  //LOGIN
  final String akun_login   = Domain().domainku + "user_login.php";
  final String akun_tambah  = Domain().domainku + "user_tambah.php";
  final String akun_profil  = Domain().domainku + "user_profil.php";

  //EVENT
  final String tampil_event     = Domain().domainku + "event_tampil_semua.php";
  final String tampil_perevent  = Domain().domainku + "event_tampil_perevent.php";
  final String tambah_event     = Domain().domainku + "event_tambah.php";
  final String hapus_event      = Domain().domainku + "event_hapus.php";

  //AKUN & PERKIRAAN
  final String tampil_akun   = Domain().domainku + "akun_tampil_semua.php";
}