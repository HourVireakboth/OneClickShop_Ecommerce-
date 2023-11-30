// ignore_for_file: must_be_immutable

part of 'address_bloc.dart';

abstract class AddressState extends Equatable {
  List<AddressModel>? iteamaddress = [];
  AddressState({this.iteamaddress});
  @override
  List<Object> get props => [];
}

class AddressInitial extends AddressState {}

class AddressLoading extends AddressState {}

class AddressCompleted extends AddressState {
  List<AddressModel>? addresslist = [];
  AddressModel? address;
  AddressCompleted({this.addresslist,this.address}) : super(iteamaddress: addresslist);
}

class AddressError extends AddressState {
  var error;
  AddressError({this.error});
}
