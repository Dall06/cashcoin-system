import 'package:cc_flutter_mobile/config/design_spacings.dart';
import 'package:cc_flutter_mobile/config/palette.dart';
import 'package:cc_flutter_mobile/data/model/transaction.dart';
import 'package:cc_flutter_mobile/presentation/screens/status/widgets/list_card.dart';
import 'package:flutter/material.dart';
import 'custom_toggle_buttons.dart';

class ListViewTransactions extends StatefulWidget {
  final List<TransactionUser> transactions;
  final String code;

  ListViewTransactions({
    this.transactions,
    this.code,
  });

  @override
  _ListViewTransactionsState createState() => _ListViewTransactionsState();
}

class _ListViewTransactionsState extends State<ListViewTransactions> {
  List<bool> _isSelected = [true, false, false];

  void _setOption(int index) {
    setState(() {
      for (int i = 0; i < _isSelected.length; i++) {
        if (i != index) {
          _isSelected[i] = false;
        }
        if (i == index) {
          _isSelected[i] = true;
        }
      }
    });
  }

  Widget _buildList(List<TransactionUser> transactions, String code) {
    List<Widget> _toRenderList = [];

    if (_isSelected[0] == true) {
      transactions.forEach((transaction) {
        if (transaction.transactionUserType == 'Transfer' &&
            transaction.transactionDetail.origin.code == code) {
          _toRenderList.add(ListCard(
              transactionType: transaction.transactionUserType,
              transactionStatus: transaction.transactionUserStatus,
              concept: transaction.transactionDetail.concept,
              quantity: transaction.transactionDetail.order.quantity,
              from: 'ME',
              date: transaction.transactionDetail.order.date,
              to: transaction.transactionDetail.destination.code));
        }
        if (transaction.transactionUserType == 'Deposit' &&
            transaction.transactionDetail.destination.code == code) {
          _toRenderList.add(ListCard(
              transactionType: transaction.transactionUserType,
              transactionStatus: transaction.transactionUserStatus,
              concept: transaction.transactionDetail.concept,
              quantity: transaction.transactionDetail.order.quantity,
              from: transaction.transactionDetail.origin.code,
              date: transaction.transactionDetail.order.date,
              to: 'ME'));
        }
      });
    } else if (_isSelected[1] == true) {
      transactions.forEach((transaction) {
        if (transaction.transactionUserType == 'Transfer' &&
            transaction.transactionDetail.origin.code == code) {
          _toRenderList.add(ListCard(
              transactionType: transaction.transactionUserType,
              transactionStatus: transaction.transactionUserStatus,
              concept: transaction.transactionDetail.concept,
              quantity: transaction.transactionDetail.order.quantity,
              from: 'ME',
              date: transaction.transactionDetail.order.date,
              to: transaction.transactionDetail.destination.code));
        }
      });
    } else if (_isSelected[2] == true) {
      transactions.forEach((transaction) {
        if (transaction.transactionUserType == 'Deposit' &&
            transaction.transactionDetail.destination.code == code) {
          _toRenderList.add(ListCard(
              transactionType: transaction.transactionUserType,
              transactionStatus: transaction.transactionUserStatus,
              concept: transaction.transactionDetail.concept,
              quantity: transaction.transactionDetail.order.quantity,
              from: transaction.transactionDetail.origin.code,
              date: transaction.transactionDetail.order.date,
              to: 'ME'));
        }
      });
    }

    return ListView(
      children: _toRenderList,
    );
  }

  @override
  Widget build(BuildContext context) {
    var height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    var space = height > 650 ? DesignSpacings.spaceM : DesignSpacings.spaceS;

    return Container(
      height: height - 480,
      child: Column(
        children: [
          Card(
            margin: EdgeInsets.only(bottom: 25),
            color: Palette.lightBlack,
            elevation: 4,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            child: Container(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Filters',
                    style: TextStyle(
                        color: Colors.white60,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                  CustomToggleButtons(
                    setOption: _setOption,
                    isSelected: _isSelected,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: space,
          ),
          Expanded(
            child: Theme(
                data: ThemeData(
                  accentColor: Palette.lightGreen,
                ),
                child: _buildList(widget.transactions, widget.code),
              ),
          ),
        ],
      ),
    );
  }
}
