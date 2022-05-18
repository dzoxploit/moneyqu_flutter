class Pemasukans{
  int id,jumlah_pemasukan;
  String nama, kategori, tanggal_pemasukan, keterangan;

  Pemasukans({this.id, this.nama, this.kategori, this.jumlah_pemasukan, this.tanggal_pemasukan, this.keterangan});

  factory Pemasukans.fromJson(Map<String, dynamic> json){
    return Pemasukans(
      id: json['id'],
      nama: json['nama'],
      jumlah_pemasukan: json['jumlah_pemasukan'],
      tanggal_pemasukan: json['tanggal_pemasukan'],
      keterangan: json['keterangan'],
    );
  }
  Map<String, dynamic> toJson() => {
    'id': id,
    'nama': nama,
    'kategori': kategori,
    'jumlah_pemasukan': jumlah_pemasukan,
    'tanggal_pemasukan': tanggal_pemasukan,
    'keterangan': keterangan
  };
}