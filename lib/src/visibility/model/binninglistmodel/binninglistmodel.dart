import 'package:jaguar_serializer/jaguar_serializer.dart';
part 'binninglistmodel.jser.dart';

class BinningListModel {
  @Alias("partType")
  String mPartType;
  @Alias("actorTypeId")
  String mActorTypeId;
  @Alias("quantity")
  int mQuantity;
  @Alias("balanceToBin")
  int mBalanceToBin;
  @Alias("invoiceNumber")
  String mInvoiceNumber;
  @Alias("isLabelGen")
  bool mLabelGen;
  @Alias("accountsMasterId")
  String mAccountsMasterId;
  @Alias("orderMasterId")
  String mOrderMasterId;
  @Alias("partsInOrderId")
  String mPartsInOrderId;
  @Alias("partsMasterId")
  String mPartsMasterId;
  @Alias("partNumber")
  String mPartNumber;
  @Alias("stockTypeCode")
  String mStockTypeCode;
  @Alias("orderCreatedDate")
  String mOrderCreatedDate;
  @Alias("orderSerialNo")
  String mOrderSerialNo;

  BinningListModel({
        this.mOrderCreatedDate,
        this.mStockTypeCode,
        this.mPartNumber,
        this.mPartsMasterId,
        this.mPartsInOrderId,
        this.mOrderMasterId,
        this.mAccountsMasterId,
        this.mLabelGen,
        this.mInvoiceNumber,
        this.mBalanceToBin,
        this.mQuantity,
        this.mActorTypeId,
        this.mPartType
        });
}

@GenSerializer()
class BinningListModelSerializer extends Serializer<BinningListModel>
    with _$BinningListModelSerializer {}