class Pengeluarans{
  int id,jumlah_pengeluaran;
  String nama, nama_hutang, kategori, tanggal_pengeluaran, keterangan;

  Pengeluarans({this.id, this.nama,this.nama_hutang,this.kategori, this.jumlah_pengeluaran, this.tanggal_pengeluaran, this.keterangan});

  factory Pengeluarans.fromJson(Map<String, dynamic> json){
    return Pengeluarans(
      id: json['id'],
      nama: json['nama'],
      kategori: json['kategori'],
      nama_hutang: json['nama_hutang'],
      jumlah_pengeluaran: json['jumlah_pengeluaran'],
      tanggal_pengeluaran: json['tanggal_pengeluaran'],
      keterangan: json['keterangan'],
    );
  }
  Map<String, dynamic> toJson() => {
    'id': id,
    'nama': nama,
    'kategori': kategori,
    'jumlah_pengeluaran': jumlah_pengeluaran,
    'tanggal_pengeluaran': tanggal_pengeluaran,
    'keterangan': keterangan
  };
}