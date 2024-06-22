import 'package:datn_npq/anonymus/anonymus_screen.dart';
import 'package:datn_npq/screens/home_screen.dart';
import 'package:datn_npq/screens/login_screen.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/auth_cubit.dart';

class BaseScreen extends StatefulWidget {
  final Widget Function(BuildContext ctx) builder;
  const BaseScreen({
    Key? key,
    required this.builder,
  }) : super(key: key);

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listenWhen: (previous, current) {
        return previous != current;
      },
      listener: (context, state) {
        if (state is UnAuthenticated) {
          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => AnonymusScreen()), (route) => false);
        }
        if (state is Authenticated) {
          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => HomeScreen()), (route) => false);
        }
      },
      child: BaseScreenBuilder(builder: widget.builder),
    );
  }
}

class BaseScreenBuilder extends StatefulWidget {
  final Widget Function(BuildContext ctx) builder;
  const BaseScreenBuilder({
    Key? key,
    required this.builder,
  }) : super(key: key);

  @override
  State<BaseScreenBuilder> createState() => _BaseScreenBuilderState();
}

class _BaseScreenBuilderState extends State<BaseScreenBuilder> {
  final FocusNode focusNode = FocusNode();

  @override
  void dispose() {
    super.dispose();
    focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        focusNode.unfocus();
      },
      child: Focus(
        focusNode: focusNode,
        child: widget.builder(context),
      ),
    );
  }
}
