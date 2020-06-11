import 'package:flutter/material.dart';
import 'package:form_validation/form_validation.dart';
import 'package:form_floating_action_button/form_floating_action_button.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Validation Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _loading = false;

  void _onSubmit() async {
    setState(() => _loading = true);
    await Future.delayed(Duration(seconds: 3));
    _loading = false;
    if (mounted == true) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Builder(
        builder: (BuildContext context) => Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Required',
                  ),
                  validator: (String value) {
                    var validator = Validator(
                      validators: [RequiredValidator()],
                    );

                    return validator.validate(
                      context: context,
                      label: 'Required',
                      value: value,
                    );
                  },
                ),
                SizedBox(
                  height: 16.0,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                  ),
                  validator: (String value) {
                    var validator = Validator(
                      validators: [
                        RequiredValidator(),
                        EmailValidator(),
                      ],
                    );

                    return validator.validate(
                      context: context,
                      label: 'Email',
                      value: value,
                    );
                  },
                ),
                SizedBox(
                  height: 16.0,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Min 3 / Max 5 Length',
                  ),
                  validator: (String value) {
                    var validator = Validator(
                      validators: [
                        MaxLengthValidator(length: 5),
                        MinLengthValidator(length: 3),
                      ],
                    );

                    return validator.validate(
                      context: context,
                      label: 'Min 3 / Max 5 Length',
                      value: value,
                    );
                  },
                ),
              ],
            ),
          ),
          floatingActionButton: FormFloatingActionButton(
            loading: _loading,
            onSubmit: _onSubmit,
            onValidate: () async {
              var error = Form.of(context).validate();
              return error;
            },
          ),
        ),
      ),
    );
  }
}
