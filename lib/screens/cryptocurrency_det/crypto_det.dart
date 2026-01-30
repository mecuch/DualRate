import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/crypto_det/crypto_det_bloc.dart';
import '../../blocs/crypto_det/crypto_det_event.dart';
import '../../blocs/crypto_det/crypto_det_state.dart';
import '../../data/crypto_det/crypto_det_model.dart';
import '../../data/crypto_det/crypto_det_repository.dart';
import '../utils/colors.dart';
import '../utils/widgets.dart';

class CryptoCurrencyDetails extends StatelessWidget {
  const CryptoCurrencyDetails({
    required this.coinId,
    required this.cryptoName,
    super.key,
  });

  final String coinId;
  final String cryptoName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorLoader.main_green,
      appBar: AppBar(
          title: SmallText(text: cryptoName),
          backgroundColor: Colors.black,
          foregroundColor: ColorLoader.main_green,
          elevation: 4,
          centerTitle: true
      ),
      body: BlocProvider(
        create: (_) => CryptoDetailsBloc(
          repository: CryptoDetailsRepository(),
        )..add(CryptoDetailsRequested(coinId)),
        child: BlocBuilder<CryptoDetailsBloc, CryptoDetailsState>(
          builder: (context, state) {
            if (state is CryptoDetailsLoading ||
                state is CryptoDetailsInitial) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is CryptoDetailsFailure) {
              return Center(
                child: VerySmallText(text: 'Błąd: ${state.message}'),
              );
            }
            if (state is CryptoDetailsLoaded) {
              final details = state.details.isNotEmpty
                  ? state.details.first
                  : null;
              if (details == null) {
                return const Center(
                  child: VerySmallText(text: 'No specific data!.'),
                );
              }
              return _CryptoDetailsView(details: details);
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

class _CryptoDetailsView extends StatelessWidget {
  const _CryptoDetailsView({required this.details});

  final CryptoDetailsModel details;

  String _formatMoney(double value) => value.toStringAsFixed(2);

  String _formatPercent(double value) => '${value.toStringAsFixed(2)}%';

  String _formatDate(DateTime? date) {
    if (date == null) {
      return '-';
    }
    final local = date.toLocal();
    final month = local.month.toString().padLeft(2, '0');
    final day = local.day.toString().padLeft(2, '0');
    final hour = local.hour.toString().padLeft(2, '0');
    final minute = local.minute.toString().padLeft(2, '0');
    return '${local.year}-$month-$day $hour:$minute';
  }

  @override
  Widget build(BuildContext context) {
    final rows = <_DetailsRowData>[
      _DetailsRowData(label: 'ID', value: details.id),
      _DetailsRowData(label: 'Symbol', value: details.symbol),
      _DetailsRowData(label: 'Name', value: details.name),
      _DetailsRowData(label: 'Rank', value: details.rank.toString()),
      _DetailsRowData(
        label: 'Price (PLN)',
        value: '${_formatMoney(details.pricePln)} PLN',
      ),
      _DetailsRowData(
        label: 'Price (USD)',
        value: '${_formatMoney(details.priceUsd)} USD',
      ),
      _DetailsRowData(
        label: 'Market cap (PLN)',
        value: '${_formatMoney(details.marketCapPln)} PLN',
      ),
      _DetailsRowData(
        label: 'Volume 24h (PLN)',
        value: '${_formatMoney(details.volume24hPln)} PLN',
      ),
      _DetailsRowData(
        label: 'Fluctuation 24h',
        value: _formatPercent(details.change24hPercent),
      ),
      _DetailsRowData(
        label: 'ATH (PLN)',
        value: '${_formatMoney(details.athPln)} PLN',
      ),
      _DetailsRowData(label: 'Data ATH', value: _formatDate(details.athDate)),
      _DetailsRowData(
        label: 'Last update:',
        value: _formatDate(details.lastUpdated),
      ),
    ];

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemBuilder: (context, index) => _DetailsRow(data: rows[index]),
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemCount: rows.length,
    );
  }
}

class _DetailsRowData {
  const _DetailsRowData({required this.label, required this.value});

  final String label;
  final String value;
}

class _DetailsRow extends StatelessWidget {
  const _DetailsRow({required this.data});

  final _DetailsRowData data;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: ColorLoader.main_black,
      elevation: 3.5,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Expanded(
              child:VerySmallTextWhite(text: data.label)
            ),
            const SizedBox(width: 12),
            Expanded(
              child: VerySmallTextWhite(text: data.value)
            ),
          ],
        ),
      ),
    );
  }
}