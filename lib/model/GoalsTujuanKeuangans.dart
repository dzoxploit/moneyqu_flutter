class GoalsTujuankeuangans{
  int id,nominal;
  String nama_goals_tujuan_keuangan,created_at;

  GoalsTujuankeuangans({this.id,this.nama_goals_tujuan_keuangan,this.nominal, this.created_at});

  factory GoalsTujuankeuangans.fromJson(Map<String, dynamic> json){
    return GoalsTujuankeuangans(
      id: json['id'],
      nama_goals_tujuan_keuangan: json['nama_goals_tujuan_keuangan'],
      created_at: json['created_at']
    );
  }
  Map<String, dynamic> toJson() => {
    'id': id,
    'nama_goals_tujuan_keuangan': nama_goals_tujuan_keuangan,
    'nominal':nominal,
    'created_at':created_at,
  };
}