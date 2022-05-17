class Index1{
  int calculation, pemasukan, pengeluaran, hutang, piutang;

  Index1({this.calculation, this.pemasukan, this.pengeluaran, this.hutang, piutang});

  factory Index1.fromJson(Map<String, dynamic> json){
    return Index1(
      calculation : json['calculation'],
      pemasukan: json['pemasukan'],
      pengeluaran: json['pengeluaran'],
      hutang: json['hutang'],
      piutang: json['piutang']
    );
  }
}