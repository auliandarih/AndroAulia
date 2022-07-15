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

  //PERKIRAAN
  final String tampil_perkiraan         = Domain().domainku + "perkiraan_tampil_semua.php";
  final String tampil_perkiraan_perakun = Domain().domainku + "perkiraan_tampil_perakun.php";

  //AKUN
  final String tampil_akun = Domain().domainku + "akun_tampil_semua.php";

  //PENGAJUAN
  final String tambah_pengajuan       = Domain().domainku + "pengajuan_tambah.php";
  final String tampil_pengajuan       = Domain().domainku + "pengajuan_tampilsemua.php";
  final String tampil_pengajuanuser   = Domain().domainku + "pengajuan_tampiluser.php";
  final String tampil_pengajuanevent  = Domain().domainku + "pengajuan_tampil_perevent.php";
  final String tampil_perpengajuan    = Domain().domainku + "pengajuan_tampil_perno.php";
}