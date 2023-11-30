// ignore_for_file: unused_local_variable
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:oneclickshop/repository/address/address_repository.dart';

import '../../model/address/address.dart';

part 'address_event.dart';
part 'address_state.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  AddressRepository addressRepository = AddressRepository();
  AddressBloc() : super(AddressInitial()) {
    on<FetchsAddress>((event, emit) async {
      var token = event.token;
      try {
        emit(AddressLoading());
        List<AddressModel> responsebody =
            await addressRepository.getAddressAll(token);
        print("list = ${responsebody.length}");
        emit(AddressCompleted(addresslist: responsebody));
      } catch (error) {
        emit(AddressError(error: error.toString()));
      }
    });

    on<ADDAddress>((event, emit) async {
      var token = event.token;
      var contactname = event.contactname;
      var street = event.street;
      var province = event.province;
      try {
        List<AddressModel>? listadd = state.iteamaddress;
        var responsebody = await addressRepository.addAddress(
            token, contactname, street, province);
        listadd!.add(responsebody);
        emit(AddressLoading());
        emit(AddressCompleted(addresslist: listadd, address: responsebody));
      } catch (error) {
        emit(AddressError(error: error.toString()));
      }
    });

    on<UpdateAddress>((event, emit) async {
      var token = event.token;
      var contactname = event.contactname;
      var street = event.street;
      var province = event.province;
      var addressID = event.addressId;

      try {
        List<AddressModel>? listadd = state.iteamaddress;
        print("iteamlist = ${state.iteamaddress?.length}");
        print("listadd = ${listadd?.length}");
        AddressModel responsebody = await addressRepository.updateAddress(
          token,
          contactname,
          street,
          province,
          addressID,
        );
        print("ready");
        state.iteamaddress!.forEach((element) {
          if (element.thumbnail == true) {
            element.thumbnail = false;
          }
          if (element.id == int.parse(addressID)) {
            print("id match");
            int index = state.iteamaddress!.indexOf(element);
            listadd?.removeAt(index);
            listadd?.insert(index, responsebody);
          }
        });
        emit(AddressLoading());
        emit(AddressCompleted(addresslist: listadd , address: responsebody));
      } catch (error) {
        emit(AddressError(error: error.toString()));
      }
    });

    on<RemoveAddress>((event, emit) async {
      var token = event.token;
      var addressID = event.addressID;
      var isremove = false;
      int index = -1;
      try {
        List<AddressModel>? listadd = state.iteamaddress;
        print("iteamlist = ${state.iteamaddress?.length}");
        print("listadd = ${listadd?.length}");
        state.iteamaddress!.forEach((element) {
          if (element.id == int.parse(addressID)) {
            print("id match");
            isremove = true;
            index = state.iteamaddress!.indexOf(element);
          }
        });

        if(isremove){
         await addressRepository.deleteAddress(token.toString(),addressID.toString(),);
         listadd?.removeAt(index);
         emit(AddressLoading());
        }  
        emit(AddressCompleted(addresslist: listadd));
      } catch (error) {
        emit(AddressError(error: error.toString()));
      }
    });



  }
}
