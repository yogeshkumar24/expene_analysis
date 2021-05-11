class ExpensesInfo {
  String _id;
  String _itemName;
  String _category;
  int _amount;
  String _date;
  String _notes;
  String _imageUrl;

  ExpensesInfo(
      {
        String id,
        String itemName,
        String category,
        int amount,
        String date,
        String notes,
        String imageUrl}) {

    this._id = id;
    this._itemName = itemName;
    this._category = category;
    this._amount = amount;
    this._date = date;
    this._notes = notes;
    this._imageUrl = imageUrl;
  }

  String get id => _id;
  set id(String id) => _id = id;
  String get itemName => _itemName;
  set itemName(String itemName) => _itemName = itemName;
  String get category => _category;
  set category(String category) => _category = category;
  int get amount => _amount;
  set amount(int amount) => _amount = amount;
  String get date => _date;
  set date(String date) => _date = date;
  String get notes => _notes;
  set notes(String notes) => _notes = notes;
  String get imageUrl => _imageUrl;
  set imageUrl(String imageUrl) => _imageUrl = imageUrl;

  ExpensesInfo.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _itemName = json['ItemName'];
    _category = json['category'];
    _amount = json['amount'];
    _date = json['date'];
    _notes = json['notes'];
    _imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['ItemName'] = this._itemName;
    data['category'] = this._category;
    data['amount'] = this._amount;
    data['date'] = this._date;
    data['notes'] = this._notes;
    data['imageUrl'] = this._imageUrl;
    return data;
  }
}