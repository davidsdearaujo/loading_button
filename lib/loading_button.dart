library loading_button;

import 'package:flutter/material.dart';

class LoadingButton extends StatefulWidget {
  final Widget child;
  final bool isLoading;
  final void Function() onPressed;
  final Color backgroundColor;
  final BoxDecoration decoration;
  final Widget loadingWidget;

  const LoadingButton({
    Key key,
    this.child,
    this.onPressed,
    this.isLoading = false,
    this.backgroundColor,
    this.decoration,
    this.loadingWidget,
  }) : super(key: key);

  @override
  _LoadingButtonState createState() => _LoadingButtonState();
}

class _LoadingButtonState extends State<LoadingButton> {
  BoxDecoration decoration;
  Widget loadingWidget;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    decoration = widget.decoration ??
        BoxDecoration(
          color: widget.backgroundColor ?? Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(5),
        );

    loadingWidget = loadingWidget ??
        SizedBox(
          width: 25,
          height: 25,
          child: Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: widget.isLoading ? null : widget.onPressed,
        child: AnimatedContainer(
          padding: widget.isLoading
              ? EdgeInsets.all(10)
              : EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          duration: Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          decoration: widget.isLoading
              ? decoration.copyWith(borderRadius: BorderRadius.circular(100))
              : decoration,
          child: widget.isLoading ? loadingWidget : widget.child,
        ),
      ),
    );
  }
}
