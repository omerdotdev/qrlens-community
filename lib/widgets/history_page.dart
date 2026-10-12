import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qrlens_community/data/history_store.dart';
import 'package:qrlens_community/data/models/qrcode_model.dart';
import 'package:qrlens_community/utils/utils.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List<QRCode>? _items;

  @override
  void initState() {
    super.initState();
    _reload();
  }

  Future<void> _reload() async {
    final items = await HistoryStore.load();
    if (mounted) setState(() => _items = items);
  }

  @override
  Widget build(BuildContext context) {
    final items = _items;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan history'),
        actions: [
          if (items != null && items.isNotEmpty)
            IconButton(
              tooltip: 'Clear history',
              icon: const Icon(Icons.delete_sweep),
              onPressed: () async {
                await HistoryStore.clear();
                await _reload();
              },
            ),
        ],
      ),
      body: items == null
          ? const Center(child: CircularProgressIndicator())
          : items.isEmpty
          ? const Center(child: Text('No scans yet'))
          : ListView.separated(
              itemCount: items.length,
              separatorBuilder: (_, _) => const Divider(height: 1),
              itemBuilder: (context, i) {
                final code = items[i];
                return ListTile(
                  title: Text(
                    code.qrString,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    '${code.type.toLowerCase()} · '
                    '${DateTime.fromMicrosecondsSinceEpoch(code.id)}',
                  ),
                  onTap: () {
                    Clipboard.setData(ClipboardData(text: code.qrString));
                    Utils.showSnackBarWith(
                      context,
                      'Copied',
                      Icons.copy_rounded,
                    );
                  },
                  trailing: IconButton(
                    tooltip: 'Delete',
                    icon: const Icon(Icons.close),
                    onPressed: () async {
                      await HistoryStore.remove(code.id);
                      await _reload();
                    },
                  ),
                );
              },
            ),
    );
  }
}
