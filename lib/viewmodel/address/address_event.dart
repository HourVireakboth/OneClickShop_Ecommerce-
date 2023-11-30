// ignore_for_file: must_be_immutable

part of 'address_bloc.dart';

abstract class AddressEvent extends Equatable {
  const AddressEvent();
  @override
  List<Object> get props => [];
}

class FetchsAddress extends AddressEvent {
  var token;
  FetchsAddress({this.token});
}

class ADDAddress extends AddressEvent {
  var token;
  var contactname;
  var street;
  var province;
  ADDAddress({this.token, this.contactname, this.street, this.province});
}

class UpdateAddress extends AddressEvent {
  var token;
  var contactname;
  var street;
  var province;
  var addressId;
  UpdateAddress(
      {this.token,
      this.contactname,
      this.street,
      this.province,
      this.addressId});
}

class RemoveAddress extends AddressEvent {
  var token;
  var addressID;
  RemoveAddress({this.token,this.addressID});
}
