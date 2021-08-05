import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'widgets/details_body.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({Key? key, required this.url}) : super(key: key);

  final String url;

  @override
  Widget build(BuildContext context) {
    const _popupMenuItems = ['Open in browser'];

    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton<String>(
            onSelected: _onClickPopupMenu,
            itemBuilder: (context) {
              return _popupMenuItems
                  .map(
                    (item) => PopupMenuItem<String>(
                      value: item,
                      child: Text(item),
                    ),
                  )
                  .toList();
            },
          ),
        ],
      ),
      body: DetailsBody(url: url),
    );
  }

  void _onClickPopupMenu(String value) {
    switch (value) {
      case 'Open in browser':
        _launchUrl();
        break;
      default:
    }
  }

  Future<void> _launchUrl() async {
    if (await canLaunch(url)) {
      await launch(url);
    }
  }
}
