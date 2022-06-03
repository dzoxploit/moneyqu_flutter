class Tujuankeuangans{
  int id,no_tagihan,jumlah_tagihan,status_tagihan,status_tagihan_lunas;
  String nama_tagihan, kategori, no_rekening ,kode_bank,deksripsi,tanggal_tagihan,tanggal_tagihan_lunas;

  Tujuankeuangans({this.id, this.no_tagihan,this.jumlah_tagihan,this.status_tagihan,this.status_tagihan_lunas, this.nama_tagihan, this.kategori, this.no_rekening ,this.kode_bank,this.deksripsi,this.tanggal_tagihan,this.tanggal_tagihan_lunas});

  factory Tujuankeuangans.fromJson(Map<String, dynamic> json){
    return Tujuankeuangans(
        id: json['id'],
        nama_tagihan: json['nama_tagihan'],
        kategori: json['kategori'],
        no_rekening: json['no_rekening'],
        no_tagihan: json['no_tagihan'],
        kode_bank: json['kode_bank'],
        deksripsi: json['deksripsi'],
        jumlah_tagihan: json['jumlah_tagihan'],
        status_tagihan: json['status_tagihan'],
        tanggal_tagihan: json['tanggal_tagihan'],
        status_tagihan_lunas: json['status_tagihan_lunas'],
        tanggal_tagihan_lunas: json['tanggal_tagihan_lunas']
    );
  }
  Map<String, dynamic> toJson() => {
    'id': id,
    'nama_tagihan': nama_tagihan,
    'kategori': kategori,
    'no_rekening': no_rekening,
    'no_tagihan': no_tagihan,
    'kode_bank': kode_bank,
    'deksripsi': deksripsi,
    'jumlah_tagihan': jumlah_tagihan,
    'status_tagihan': status_tagihan,
    'tanggal_tagihan': tanggal_tagihan,
    'status_tagihan_lunas': status_tagihan_lunas,
    'tanggal_tagihan_lunas': tanggal_tagihan_lunas,
  };
}