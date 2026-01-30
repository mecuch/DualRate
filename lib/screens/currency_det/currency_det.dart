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
      backgroundColor: ColorLoader.main_green,
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
    final changePrefix = change > 0 ? '+' : '';

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _HeaderCard(details: details),
        const SizedBox(height: 12),
        _SectionCard(
          title: 'Change',
          rows: [
            _DetailsRowData(
              label: 'Change - last day',
              value: '$changePrefix${_formatMoney(change)} PLN',
            ),
            _DetailsRowData(
              label: 'Change % - last day)',
              value: '$changePrefix${_formatPercent(details.changePercent)}',
            ),
            _DetailsRowData(
              label: 'Last update:',
              value: _formatDate(details.lastUpdated),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _SectionCard(
          title: 'Exchange range (${details.daysRange} days)',
          rows: [
            _DetailsRowData(
              label: 'Min',
              value: '${_formatMoney(details.minMid)} PLN',
            ),
            _DetailsRowData(
              label: 'Max',
              value: '${_formatMoney(details.maxMid)} PLN',
            ),
            _DetailsRowData(
              label: 'Exchange rate',
              value: '${_formatMoney(details.latest.mid)} PLN',
            ),
          ],
        ),
        const SizedBox(height: 12),
        _SectionCard(
          title: 'Last quotes',
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
      color: ColorLoader.main_black,
      elevation: 7,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Image.asset(details.flag,
            width: 45, height: 45,),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  VerySmallTextWhite(text: details.name),
                  const SizedBox(height: 4),
                  VerySmallTextWhite(text: details.code)
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const VerySmallTextWhite(text: "Exchange rate"),
                const SizedBox(height: 4),
                VerySmallTextWhite(text: '${_formatMoney(details.latest.mid)} PLN')
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
      color: ColorLoader.main_black,
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            VerySmallTextWhite(text: title),
            const SizedBox(height: 12),
            ...rows
                .map(
                  (row) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: _DetailsRow(data: row),
              ),
            )
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
  });

  final String label;
  final String value;
}

class _DetailsRow extends StatelessWidget {
  const _DetailsRow({required this.data});

  final _DetailsRowData data;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: VerySmallTextWhite(text: data.label)
        ),
        const SizedBox(width: 12),
        VerySmallTextWhite(text: data.value)
      ],
    );
  }
}