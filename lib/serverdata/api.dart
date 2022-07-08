import 'domain.dart';

class myUrl{

  //LOGIN
  final String user_login   = Domain().domainku + "user_login.php";
  final String user_tambah  = Domain().domainku + "user_tambah.php";
  final String user_profil  = Domain().domainku + "user_profil.php";
  final String user_tampil  = Domain().domainku + "user_tampil_semua.php";

  //EVENT
  final String tampil_event     = Domain().domainku + "event_tampil_semua.php";
  final String tampil_perevent  = Domain().domainku + "event_tampil_perevent.php";
  final String tambah_event     = Domain().domainku + "event_tambah.php";
  final String hapus_event      = Domain().domainku + "event_hapus.php";

  //AKUN & PERKIRAAN
  final String tampil_akun = Domain().domainku + "perkiraan_tampil_semua.php";

  //PENGAJUAN
  final String tambah_pengajuan = Domain().domainku + "pengajuan_tambah.php";
  final String tampil_pengajuan = Domain().domainku + "pengajuan_tampilsemua.php";
  final String tampil_peruser = Domain().domainku + "pengajuan_tampiluser.php";
}