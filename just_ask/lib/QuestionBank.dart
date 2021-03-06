import 'package:flutter/material.dart';
import 'package:just_ask/screens/teacher/QuestionsView.dart';
import 'package:just_ask/screens/teacher/UpdateQuestionBankForm.dart';
import 'package:just_ask/screens/teacher/questions/MultipleChoiceQuestionForm.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:just_ask/services/cloud_storer.dart';

class QuestionBank extends StatefulWidget {
  String questionBankName;
  String questionBankId;

  QuestionBank({String questionBankName, String questionBankId}) {
    this.questionBankName = questionBankName;
    this.questionBankId = questionBankId;
  }

  @override
  _QuestionBankState createState() => _QuestionBankState();
}

class _QuestionBankState extends State<QuestionBank> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.questionBankName),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => QuestionsView(
                    questionBankName: widget.questionBankName,
                    questionBankId: widget.questionBankId)));
      },
      onLongPress: () {
        showDialog(
            context: context,
            builder: (context) {
              return UpdateQuestionBankForm(
                questionBankId: widget.questionBankId,
              );
            });
      },
      trailing: IconButton(
          icon: Icon(Icons.delete),
          onPressed: () async {
            await CloudStorer(
                    userID: Provider.of<User>(context, listen: false).uid)
                .deleteQuestionBank(widget.questionBankId);
          }),
    );
  }
}
