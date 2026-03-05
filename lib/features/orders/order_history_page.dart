import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:zencare/common/appbar.dart';
import 'package:zencare/common/footer.dart';
import 'package:zencare/core/api_config.dart';
import 'package:zencare/services/auth_service.dart';

/// Displays order history from order_history.php (token in query).
class OrderHistoryPage extends StatefulWidget {
  const OrderHistoryPage({super.key});

  @override
  State<OrderHistoryPage> createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage> {
  List<Map<String, dynamic>> _orders = [];
  Map<String, dynamic>? _pagination;
  bool _loading = true;
  String? _error;

  bool get _isMobile => MediaQuery.of(context).size.width < 768;

  @override
  void initState() {
    super.initState();
    _loadOrders();
  }

  Future<void> _loadOrders({int page = 1}) async {
    setState(() {
      _loading = true;
      _error = null;
    });
    final token = await AuthService.getToken();
    if (token == null || token.isEmpty) {
      setState(() {
        _loading = false;
        _error = 'Please log in to view order history.';
      });
      return;
    }
    try {
      final queryParams = {'page': '$page', 'limit': '20', ...AuthService.tokenQuery(token)};
      final uri = Uri.parse(ApiConfig.orderHistory).replace(queryParameters: queryParams);
      final res = await http.get(uri);
      if (!mounted) return;
      if (res.statusCode != 200) {
        setState(() {
          _loading = false;
          _error = 'Failed to load orders.';
        });
        return;
      }
      final data = json.decode(res.body) as Map<String, dynamic>?;
      if (data == null || data['status'] != 'success') {
        setState(() {
          _loading = false;
          _error = data?['message']?.toString() ?? 'Failed to load orders.';
        });
        return;
      }
      final inner = data['data'] as Map<String, dynamic>?;
      final orders = (inner?['orders'] as List?)?.cast<Map<String, dynamic>>() ?? [];
      final pagination = inner?['pagination'] as Map<String, dynamic>?;
      setState(() {
        _orders = orders;
        _pagination = pagination;
        _loading = false;
      });
    } catch (e) {
      if (mounted) {
        setState(() {
          _loading = false;
          _error = 'Error: $e';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.error_outline, size: 64, color: Colors.grey.shade400),
                        const SizedBox(height: 16),
                        Text(
                          _error!,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.grey.shade700),
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton(
                          onPressed: () => _loadOrders(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue.shade800,
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  ),
                )
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SafeArea(
                        bottom: false,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: _isMobile ? 16 : 50,
                            vertical: _isMobile ? 20 : 28,
                          ),
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 800),
                            child: _orders.isEmpty
                                ? _buildEmptyState(context)
                                : Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      Text(
                                        'Order History',
                                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                      const SizedBox(height: 24),
                                      RefreshIndicator(
                                        onRefresh: () => _loadOrders(page: 1),
                                        color: Colors.blue.shade800,
                                        child: ListView.separated(
                                          shrinkWrap: true,
                                          physics: const NeverScrollableScrollPhysics(),
                                          itemCount: _orders.length + (_hasPagination ? 1 : 0),
                                          separatorBuilder: (_, __) => const SizedBox(height: 16),
                                          itemBuilder: (context, index) {
                                            if (index == _orders.length) {
                                              return _buildPagination(context);
                                            }
                                            return _OrderCard(order: _orders[index]);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                          ),
                        ),
                      ),
                      Footer(),
                    ],
                  ),
                ),
    );
  }

  bool get _hasPagination {
    final totalPages = (_pagination?['total_pages'] as num?)?.toInt() ?? 1;
    return totalPages > 1;
  }

  Widget _buildEmptyState(BuildContext context) {
    return Column(
      children: [
        Text(
          'Order History',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 48),
        Icon(Icons.receipt_long_outlined, size: 80, color: Colors.grey.shade300),
        const SizedBox(height: 20),
        Text(
          'No orders yet',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.grey.shade600),
        ),
        const SizedBox(height: 8),
        Text(
          'Your orders will appear here once you place them.',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey.shade500),
        ),
      ],
    );
  }

  Widget _buildPagination(BuildContext context) {
    final totalPages = (_pagination?['total_pages'] as num?)?.toInt() ?? 1;
    final currentPage = (_pagination?['page'] as num?)?.toInt() ?? 1;
    if (totalPages <= 1) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (currentPage > 1)
            TextButton(
              onPressed: () => _loadOrders(page: currentPage - 1),
              child: const Text('Previous'),
            ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Page $currentPage of $totalPages',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey.shade600),
            ),
          ),
          if (currentPage < totalPages)
            TextButton(
              onPressed: () => _loadOrders(page: currentPage + 1),
              child: const Text('Next'),
            ),
        ],
      ),
    );
  }
}

class _OrderCard extends StatelessWidget {
  final Map<String, dynamic> order;

  const _OrderCard({required this.order});

  @override
  Widget build(BuildContext context) {
    final orderId = order['order_id']?.toString() ?? '—';
    final amount = order['amount'];
    final status = order['status']?.toString() ?? '—';
    final paymentMode = order['payment_mode']?.toString() ?? '—';
    final orderDate = order['order_date']?.toString() ?? '—';
    final items = order['items'] is List ? order['items'] as List : <dynamic>[];
    final shipping = order['shipping_address'];

    final amountStr = amount is num ? amount.toStringAsFixed(2) : (amount?.toString() ?? '0.00');

    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(Icons.receipt_long, size: 22, color: Colors.blue.shade800),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Order #$orderId',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          orderDate,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey.shade600),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '₹$amountStr',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue.shade800,
                          ),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: _statusColor(status).withOpacity(0.12),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        status,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: _statusColor(status),
                            ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            if (paymentMode.isNotEmpty && paymentMode != '—') ...[
              const SizedBox(height: 12),
              Row(
                children: [
                  Icon(Icons.payment, size: 16, color: Colors.grey.shade600),
                  const SizedBox(width: 6),
                  Text('Payment: $paymentMode', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey.shade600)),
                ],
              ),
            ],
            if (items.isNotEmpty) ...[
              const SizedBox(height: 14),
              Divider(height: 1, color: Colors.grey.shade200),
              const SizedBox(height: 12),
              Text(
                'Items (${items.length})',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600, color: Colors.grey.shade700),
              ),
              const SizedBox(height: 6),
              ...items.take(5).map<Widget>((e) {
                final name = e is Map ? (e['name'] ?? e['title'] ?? e['product_name'])?.toString() ?? 'Item' : 'Item';
                final qty = e is Map ? (e['quantity'] ?? e['qty'])?.toString() : null;
                return Padding(
                  padding: const EdgeInsets.only(left: 4, top: 4),
                  child: Row(
                    children: [
                      Text('•', style: TextStyle(color: Colors.grey.shade500, fontSize: 14)),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          '$name${qty != null ? ' × $qty' : ''}',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                    ],
                  ),
                );
              }),
              if (items.length > 5)
                Padding(
                  padding: const EdgeInsets.only(left: 12, top: 4),
                  child: Text(
                    '... and ${items.length - 5} more',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey),
                  ),
                ),
            ],
            if (shipping != null && shipping is Map && shipping.isNotEmpty) ...[
              const SizedBox(height: 12),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.location_on_outlined, size: 16, color: Colors.grey.shade600),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      _formatAddress(Map<String, dynamic>.from(shipping)),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey.shade600),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Color _statusColor(String status) {
    final s = status.toLowerCase();
    if (s.contains('success') || s.contains('complete') || s.contains('delivered')) return Colors.green;
    if (s.contains('pending') || s.contains('processing')) return Colors.orange;
    if (s.contains('fail') || s.contains('cancel')) return Colors.red;
    return Colors.blue;
  }

  String _formatAddress(Map<String, dynamic> addr) {
    final parts = <String>[];
    for (final k in ['address', 'street', 'city', 'state', 'pincode']) {
      final v = addr[k]?.toString();
      if (v != null && v.isNotEmpty) parts.add(v);
    }
    return parts.isEmpty ? addr.toString() : parts.join(', ');
  }
}
