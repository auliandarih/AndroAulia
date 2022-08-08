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
  final String tampil_pengajuan_belum = Domain().domainku + "pengajuan_tampil_belum.php";
  final String tampil_pengajuan_sudah = Domain().domainku + "pengajuan_tampil_sudah.php";
  final String konfirmasi_pengajuan   = Domain().domainku + "pengajuan_konfirmasi.php";
  final String tolak_pengajuan        = Domain().domainku + "pengajuan_ditolak.php";
  final String tampil_ditolak         = Domain().domainku + "pengajuan_tampil_ditolak.php";
  final String hapus_pengajuan        = Domain().domainku + "pengajuan_hapus.php";

  //JABATAN
  final String tampil_jabatan    = Domain().domainku + "jabatan_tampil.php";

  //REALISASI
  final String tampil_realisasi           = Domain().domainku + "realisasi_tampil.php";
  final String tampil_realisasi_pengajuan = Domain().domainku + "realisasi_perpengajuan.php";
  final String tambah_realisasi           = Domain().domainku + "realisasi_tambah.php";
}