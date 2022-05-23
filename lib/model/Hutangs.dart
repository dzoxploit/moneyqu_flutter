class Hutangs{
  int id,jumlah_hutang,jumlah_hutang_dibayar,status_hutang;
  String nama_hutang, no_telepon, deksripsi,tanggal_hutang,tanggal_hutang_dibayar;

  Hutangs({this.id, this.nama_hutang, this.no_telepon, this.deksripsi, this.jumlah_hutang,this.tanggal_hutang, this.jumlah_hutang_dibayar, this.tanggal_hutang_dibayar,this.status_hutang});

  factory Hutangs.fromJson(Map<String, dynamic> json){
    return Hutangs(
      id: json['id'],
      nama_hutang: json['nama_hutang'],
      deksripsi: json['deksripsi'],
      no_telepon: json['no_telepon'],
      jumlah_hutang: json['jumlah_hutang'],
      tanggal_hutang: json['tanggal_hutang'],
      jumlah_hutang_dibayar: json['jumlah_hutang_dibayar'],
      tanggal_hutang_dibayar: json['tanggal_hutang_dibayar'],
      status_hutang: json['status_hutang']
    );
  }
  Map<String, dynamic> toJson() => {
    'id': id,
    'nama_hutang': nama_hutang,
    'deksripsi': deksripsi,
    'no_telepon': no_telepon,
    'jumlah_hutang': jumlah_hutang,
    'tanggal_hutang': tanggal_hutang,
    'jumlah_hutang_dibayar':jumlah_hutang_dibayar,
    'tanggal_hutang_dibayar': tanggal_hutang_dibayar,
    'status_hutang': status_hutang
  };
}