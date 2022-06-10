class Tujuankeuangans{
  int id,nominal,nominal_goals,percentage_goals,status_tujuan_keuangan;
  String kategori,nama,nama_hutang,nama_simpanan,tanggal;

  Tujuankeuangans({this.id,this.nama,this.nominal,this.nominal_goals,this.percentage_goals,this.kategori,this.nama_hutang,this.nama_simpanan,this.tanggal,this.status_tujuan_keuangan});

  factory Tujuankeuangans.fromJson(Map<String, dynamic> json){
    return Tujuankeuangans(
        id: json['id'],
        nama: json['nama'],
        nominal: json['nominal'],
        nominal_goals: json['nominal_goals'],
        percentage_goals: json['percentage_goals'],
        nama_hutang: json['nama_hutang'],
        nama_simpanan: json['nama_simpanan'],
        tanggal: json['tanggal'],
        status_tujuan_keuangan: json['status_tujuan_keuangan'],
    );
  }
  Map<String, dynamic> toJson() => {
    'id': id,
    'nama': nama,
    'nominal':nominal,
    'nominal_goals': nominal_goals,
    'percentage_goals': percentage_goals,
    'nama_hutang': nama_hutang,
    'nama_simpanan': nama_simpanan,
    'tanggal': tanggal,
    'status_tujuan_keuangan': status_tujuan_keuangan,
  };
}