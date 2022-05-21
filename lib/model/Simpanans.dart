class Simpanans{
  int id,jumlah_simpanan, status;
  String deskripsi, nama_tujuan_simpanan, nama_jenis_simpanan;

  Simpanans({this.id, this.deskripsi, this.nama_jenis_simpanan, this.jumlah_simpanan, this.nama_tujuan_simpanan, this.status});

  factory Simpanans.fromJson(Map<String, dynamic> json){
    return Simpanans(
      id: json['id'],
      deskripsi: json['deskripsi'],
      jumlah_simpanan: json['jumlah_simpanan'],
      nama_jenis_simpanan: json['nama_jenis_simpanan'],
      nama_tujuan_simpanan: json['nama_tujuan_simpanan'],
      status: json['status'],
    );
  }
  Map<String, dynamic> toJson() => {
    'id': id,
    'deskripsi': deskripsi,
    'jumlah_simpanan': jumlah_simpanan,
    'nama_jenis_simpanan': nama_jenis_simpanan,
    'nama_tujuan_simpanan': nama_tujuan_simpanan,
    'status': status
  };
}