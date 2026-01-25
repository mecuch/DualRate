import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/currency_det/currency_det_bloc.dart';
import '../../blocs/currency_det/currency_det_event.dart';
import '../../blocs/currency_det/currency_det_state.dart';
import '../../data/currency_det/currency_det_model.dart';
import '../../data/currency_det/currency_det_repository.dart';
import '../utils/colors.dart';
import '../utils/widgets.dart';

class CurrencyDetailsScreen extends StatelessWidget {
  const CurrencyDetailsScreen({
    required this.code,
    required this.name,
    required this.flag,
    super.key,
  });

  final String code;
  final String name;
  final String flag;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SmallText(text: name),
        backgroundColor: Colors.black,
        foregroundColor: ColorLoader.main_green,
        elevation: 4,
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (_) => CurrencyDetailsBloc(
          repository: CurrencyDetailsRepository(),
        )..add(CurrencyDetailsRequested(code: code, flag: flag)),
        child: BlocBuilder<CurrencyDetailsBloc, CurrencyDetailsState>(
          builder: (context, state) {
            if (state is CurrencyDetailsLoading ||
                state is CurrencyDetailsInitial) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is CurrencyDetailsFailure) {
              return Center(
                child: Text('Błąd: ${state.message}'),
              );
            }
            if (state is CurrencyDetailsLoaded) {
              return _CurrencyDetailsView(details: state.details);
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

class _CurrencyDetailsView extends StatelessWidget {
  const _CurrencyDetailsView({required this.details});

  final CurrencyDetailsModel details;

  String _formatMoney(double value) => value.toStringAsFixed(4);

  String _formatPercent(double value) => '${value.toStringAsFixed(2)}%';

  String _formatDate(DateTime date) {
    final local = date.toLocal();
    final month = local.month.toString().padLeft(2, '0');
    final day = local.day.toString().padLeft(2, '0');
    return '${local.year}-$month-$day';
  }

  @override
  Widget build(BuildContext context) {
    final change = details.change;
    final changeColor = change > 0
        ? Colors.green
        : change < 0
        ? Colors.red
        : Theme.of(context).colorScheme.onSurface;
    final changePrefix = change > 0 ? '+' : '';

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _HeaderCard(details: details),
        const SizedBox(height: 12),
        _SectionCard(
          title: 'Zmiana',
          rows: [
            _DetailsRowData(
              label: 'Zmiana (ostatni dzień)',
              value: '$changePrefix${_formatMoney(change)} PLN',
              valueColor: changeColor,
            ),
            _DetailsRowData(
              label: 'Zmiana % (ostatni dzień)',
              value: '$changePrefix${_formatPercent(details.changePercent)}',
              valueColor: changeColor,
            ),
            _DetailsRowData(
              label: 'Ostatnia aktualizacja',
              value: _formatDate(details.lastUpdated),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _SectionCard(
          title: 'Zakres (${details.daysRange} dni)',
          rows: [
            _DetailsRowData(
              label: 'Minimum',
              value: '${_formatMoney(details.minMid)} PLN',
            ),
            _DetailsRowData(
              label: 'Maksimum',
              value: '${_formatMoney(details.maxMid)} PLN',
            ),
            _DetailsRowData(
              label: 'Aktualny kurs',
              value: '${_formatMoney(details.latest.mid)} PLN',
            ),
          ],
        ),
        const SizedBox(height: 12),
        _SectionCard(
          title: 'Ostatnie notowania',
          rows: details.history
              .reversed
              .take(7)
              .map(
                (point) => _DetailsRowData(
              label: _formatDate(point.effectiveDate),
              value: '${_formatMoney(point.mid)} PLN',
            ),
          )
              .toList(),
        ),
      ],
    );
  }
}

class _HeaderCard extends StatelessWidget {
  const _HeaderCard({required this.details});

  final CurrencyDetailsModel details;

  String _formatMoney(double value) => value.toStringAsFixed(4);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Text(
              details.flag,
              style: const TextStyle(fontSize: 36),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    details.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    details.code,
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Text(
                  'Kurs',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${_formatMoney(details.latest.mid)} PLN',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({required this.title, required this.rows});

  final String title;
  final List<_DetailsRowData> rows;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1.5,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 12),
            ...rows
                .map(
                  (row) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: _DetailsRow(data: row),
              ),
            )
                .toList(),
          ],
        ),
      ),
    );
  }
}

class _DetailsRowData {
  const _DetailsRowData({
    required this.label,
    required this.value,
    this.valueColor,
  });

  final String label;
  final String value;
  final Color? valueColor;
}

class _DetailsRow extends StatelessWidget {
  const _DetailsRow({required this.data});

  final _DetailsRowData data;

  @override
  Widget build(BuildContext context) {
    final valueStyle = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: data.valueColor ?? Theme.of(context).colorScheme.onSurface,
    );

    return Row(
      children: [
        Expanded(
          child: Text(
            data.label,
            style: TextStyle(
              fontSize: 14,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Text(
          data.value,
          textAlign: TextAlign.end,
          style: valueStyle,
        ),
      ],
    );
  }
}