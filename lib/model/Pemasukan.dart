class Pemasukan{
  int id;
  String nama, kategori, jumlah_pemasukan, tanggal_pemasukan, keterangan;

  Pemasukan({this.id, this.nama, this.kategori, this.jumlah_pemasukan, this.tanggal_pemasukan, this.keterangan});

  factory Pemasukan.fromJson(Map<String, dynamic> json){
    return Pemasukan(
      id: json['id'],
      nama: json['nama'],
      jumlah_pemasukan: json['jumlah_pemasukan'],
      tanggal_pemasukan: json['tanggal_pemasukan'],
      keterangan: json['keterangan'],
    );
  }
}