class Piutangs{
  int id,jumlah_hutang,jumlah_piutang_dibayar,status_piutang;
  String nama_piutang, no_telepon, deksripsi,tanggal_piutang,tanggal_piutang_dibayar;

  Piutangs({this.id, this.nama_piutang, this.no_telepon, this.deksripsi, this.jumlah_hutang,this.tanggal_piutang, this.jumlah_piutang_dibayar, this.tanggal_piutang_dibayar,this.status_piutang});

  factory Piutangs.fromJson(Map<String, dynamic> json){
    return Piutangs(
        id: json['id'],
        nama_piutang: json['nama_piutang'],
        deksripsi: json['deksripsi'],
        no_telepon: json['no_telepon'],
        jumlah_hutang: json['jumlah_hutang'],
        tanggal_piutang: json['tanggal_hutang'],
        jumlah_piutang_dibayar: json['jumlah_piutang_dibayar'],
        tanggal_piutang_dibayar: json['tanggal_piutang_dibayar'],
        status_piutang: json['status_piutang']
    );
  }
  Map<String, dynamic> toJson() => {
    'id': id,
    'nama_piutang': nama_piutang,
    'deksripsi': deksripsi,
    'no_telepon': no_telepon,
    'jumlah_hutang': jumlah_hutang,
    'tanggal_piutang': tanggal_piutang,
    'jumlah_piutang_dibayar':jumlah_piutang_dibayar,
    'tanggal_piutang_dibayar': tanggal_piutang_dibayar,
    'status_piutang': status_piutang
  };
}