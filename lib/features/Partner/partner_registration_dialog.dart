import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:zencare/core/api_config.dart';
import 'package:zencare/services/serviceable_areas_service.dart';

void _showPartnerSuccessAlert(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      title: const Text('Registration Submitted'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(message),
          const SizedBox(height: 16),
          const Text('We will contact you soon.', style: TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(ctx).pop(),
          child: const Text('OK'),
        ),
      ],
    ),
  );
}

void showPartnerRegistrationDialog(BuildContext context) {
  showDialog(
    context: context,
    useSafeArea: true,
    builder: (context) => Dialog(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 600, maxHeight: MediaQuery.of(context).size.height * 0.9),
        child: PartnerRegistrationDialog(),
      ),
    ),
  );
}

class PartnerRegistrationDialog extends StatefulWidget {
  @override
  State<PartnerRegistrationDialog> createState() => _PartnerRegistrationDialogState();
}

class _PartnerRegistrationDialogState extends State<PartnerRegistrationDialog> {
  final _formKey = GlobalKey<FormState>();
  final _scrollController = ScrollController();
  List<ServiceableArea> _areas = [];
  bool _loadingAreas = true;
  bool _submitting = false;

  final fullName = TextEditingController();
  final mobile = TextEditingController();
  final alternateMobile = TextEditingController();
  final email = TextEditingController();
  final dob = TextEditingController();
  final currentAddress = TextEditingController();
  final permanentAddress = TextEditingController();
  final city = TextEditingController();
  final district = TextEditingController();
  final state = TextEditingController();
  final landmark = TextEditingController();
  final experience = TextEditingController();
  final trainingInstitute = TextEditingController();
  final previousCompany = TextEditingController();
  final timeSlots = TextEditingController();
  final accountHolderName = TextEditingController();
  final bankName = TextEditingController();
  final accountNumber = TextEditingController();
  final ifsc = TextEditingController();
  final emergencyName = TextEditingController();
  final emergencyMobile = TextEditingController();
  final referenceName = TextEditingController();
  final referenceMobile = TextEditingController();
  final digitalSignature = TextEditingController();

  String? _selectedGender;
  String? _selectedServiceablePincode;
  String? _selectedCategory;
  String? _serviceableAreasError;
  bool ownTools = false;
  bool purchaseKit = false;
  bool commissionAccept = false;
  bool tdsAccept = false;
  bool weeklyPayoutAccept = false;
  bool agreementAccept = false;
  bool ratingAccept = false;
  bool cancellationPolicyAccept = false;
  bool nonCircumventionAccept = false;
  bool codeOfConductAccept = false;
  bool criminalRecord = false;
  bool competitorPlatform = false;
  bool selfEmploymentDeclaration = false;
  bool backgroundVerificationConsent = false;
  bool finalConsent = false;

  /// Primary services list for partner form (Primary Category dropdown).
  static const List<String> partnerFormServices = [
    'AC Service',
    'Refrigerator Repair',
    'Home Cleaning',
    'Salon',
    'Pest Control',
    'Washing Machine Repair',
    'Chimney Repair',
    'Water Purifier',
    'Carpenter Service',
  ];

  @override
  void initState() {
    super.initState();
    _loadAreas();
  }

  Future<void> _loadAreas() async {
    setState(() {
      _loadingAreas = true;
      _serviceableAreasError = null;
    });
    final result = await fetchServiceableAreasWithError();
    if (mounted) setState(() {
      _areas = result.areas;
      _serviceableAreasError = result.error;
      _loadingAreas = false;
      if (result.areas.isNotEmpty && _selectedServiceablePincode == null) {
        _selectedServiceablePincode = result.areas.first.pincode;
      }
    });
  }

  @override
  void dispose() {
    fullName.dispose();
    mobile.dispose();
    alternateMobile.dispose();
    email.dispose();
    dob.dispose();
    currentAddress.dispose();
    permanentAddress.dispose();
    city.dispose();
    district.dispose();
    state.dispose();
    landmark.dispose();
    experience.dispose();
    trainingInstitute.dispose();
    previousCompany.dispose();
    timeSlots.dispose();
    accountHolderName.dispose();
    bankName.dispose();
    accountNumber.dispose();
    ifsc.dispose();
    emergencyName.dispose();
    emergencyMobile.dispose();
    referenceName.dispose();
    referenceMobile.dispose();
    digitalSignature.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    if (!finalConsent) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please accept the final consent to proceed.')),
      );
      return;
    }
    setState(() => _submitting = true);
    try {
      final body = {
        'full_name': fullName.text.trim(),
        'mobile': mobile.text.trim(),
        'alternate_mobile': alternateMobile.text.trim().isEmpty ? null : alternateMobile.text.trim(),
        'email': email.text.trim(),
        'dob': dob.text.trim().isEmpty ? null : dob.text.trim(),
        'gender': _selectedGender,
        'current_address': currentAddress.text.trim().isEmpty ? null : currentAddress.text.trim(),
        'permanent_address': permanentAddress.text.trim().isEmpty ? null : permanentAddress.text.trim(),
        'city': city.text.trim().isEmpty ? null : city.text.trim(),
        'district': district.text.trim().isEmpty ? null : district.text.trim(),
        'state': state.text.trim().isEmpty ? null : state.text.trim(),
        'pincode': _selectedServiceablePincode,
        'landmark': landmark.text.trim().isEmpty ? null : landmark.text.trim(),
        'serviceable_areas': _selectedServiceablePincode != null ? [_selectedServiceablePincode] : null,
        'primary_category': _selectedCategory,
        'experience': experience.text.trim().isEmpty ? null : experience.text.trim(),
        'training_institute': trainingInstitute.text.trim().isEmpty ? null : trainingInstitute.text.trim(),
        'previous_company': previousCompany.text.trim().isEmpty ? null : previousCompany.text.trim(),
        'own_tools': ownTools,
        'purchase_kit': purchaseKit,
        'time_slots': timeSlots.text.trim().isEmpty ? null : timeSlots.text.trim(),
        'account_holder_name': accountHolderName.text.trim().isEmpty ? null : accountHolderName.text.trim(),
        'bank_name': bankName.text.trim().isEmpty ? null : bankName.text.trim(),
        'account_number': accountNumber.text.trim().isEmpty ? null : accountNumber.text.trim(),
        'ifsc': ifsc.text.trim().isEmpty ? null : ifsc.text.trim(),
        'commission_accept': commissionAccept,
        'tds_accept': tdsAccept,
        'weekly_payout_accept': weeklyPayoutAccept,
        'agreement_accept': agreementAccept,
        'digital_signature': digitalSignature.text.trim().isEmpty ? null : digitalSignature.text.trim(),
        'rating_accept': ratingAccept,
        'cancellation_policy_accept': cancellationPolicyAccept,
        'non_circumvention_accept': nonCircumventionAccept,
        'code_of_conduct_accept': codeOfConductAccept,
        'emergency_name': emergencyName.text.trim().isEmpty ? null : emergencyName.text.trim(),
        'emergency_mobile': emergencyMobile.text.trim().isEmpty ? null : emergencyMobile.text.trim(),
        'reference_name': referenceName.text.trim().isEmpty ? null : referenceName.text.trim(),
        'reference_mobile': referenceMobile.text.trim().isEmpty ? null : referenceMobile.text.trim(),
        'criminal_record': criminalRecord,
        'competitor_platform': competitorPlatform,
        'self_employment_declaration': selfEmploymentDeclaration,
        'background_verification_consent': backgroundVerificationConsent,
        'final_consent': true,
      };
      final res = await http.post(
        Uri.parse(ApiConfig.partnerRegister),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(body),
      );
      if (!mounted) return;
      final data = json.decode(res.body);
      if (res.statusCode >= 200 && res.statusCode < 300) {
        Navigator.of(context).pop();
        _showPartnerSuccessAlert(context, data['message']?.toString() ?? 'Partner registration submitted successfully.');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(data['message'] ?? 'Submission failed.'), backgroundColor: Colors.red),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Network error: $e'), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Become a Partner'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                controller: _scrollController,
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _section('Basic Information', [
                      _textField(fullName, 'Full Name (as per Aadhaar) *', validator: (v) => v == null || v.trim().isEmpty ? 'Required' : null),
                      _textField(mobile, 'Mobile Number *', keyboard: TextInputType.phone, validator: (v) => v == null || v.trim().isEmpty ? 'Required' : null),
                      _textField(alternateMobile, 'Alternate Mobile'),
                      _textField(email, 'Email ID *', keyboard: TextInputType.emailAddress, validator: (v) => v == null || v.trim().isEmpty ? 'Required' : null),
                      _textField(dob, 'Date of Birth'),
                      _dropdown('Gender', _selectedGender, ['Male', 'Female', 'Other'], (v) => setState(() => _selectedGender = v)),
                    ]),
                    _section('Address', [
                      _textField(currentAddress, 'Current Residential Address', maxLines: 2),
                      _textField(permanentAddress, 'Permanent Address', maxLines: 2),
                      _textField(city, 'City'),
                      _textField(district, 'District'),
                      _textField(state, 'State'),
                      _textField(landmark, 'Landmark'),
                      const SizedBox(height: 8),
                      Text('Serviceable Areas (approved zones)', style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500)),
                      const SizedBox(height: 4),
                      if (_loadingAreas)
                        const Padding(padding: EdgeInsets.symmetric(vertical: 8), child: LinearProgressIndicator())
                      else if (_areas.isEmpty) ...[
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.info_outline, size: 18, color: Colors.grey.shade600),
                                  const SizedBox(width: 8),
                                  Expanded(child: Text(_serviceableAreasError ?? 'No serviceable areas loaded. Check connection or try again.', style: TextStyle(fontSize: 13, color: Colors.grey.shade700))),
                                  TextButton(onPressed: _loadAreas, child: const Text('Retry')),
                                ],
                              ),
                              if (_serviceableAreasError != null)
                                Padding(
                                  padding: const EdgeInsets.only(top: 6),
                                  child: Text('API: ${ApiConfig.serviceableAreas}', style: TextStyle(fontSize: 11, color: Colors.grey.shade500), overflow: TextOverflow.ellipsis),
                                ),
                            ],
                          ),
                        ),
                      ] else
                        DropdownButtonFormField<String>(
                          value: _selectedServiceablePincode,
                          decoration: _inputDecoration('Select area (Name - Pincode)'),
                          isExpanded: true,
                          items: _areas
                              .map((a) => DropdownMenuItem<String>(
                                    value: a.pincode,
                                    child: Text(a.label, overflow: TextOverflow.ellipsis),
                                  ))
                              .toList(),
                          onChanged: (v) => setState(() => _selectedServiceablePincode = v),
                        ),
                    ]),
                    _section('Service & Professional', [
                      _dropdown('Primary Category', _selectedCategory, partnerFormServices, (v) => setState(() => _selectedCategory = v)),
                      _textField(experience, 'Years of Experience'),
                      _textField(trainingInstitute, 'Training Institute Name'),
                      _textField(previousCompany, 'Previous Company / Self-employed'),
                      _textField(timeSlots, 'Available Time Slots'),
                      _checkbox('Do you have your own tools & equipment?', ownTools, (v) => setState(() => ownTools = v)),
                      _checkbox('Willing to purchase ZEN CARE kit/uniform?', purchaseKit, (v) => setState(() => purchaseKit = v)),
                    ]),
                    _section('Bank Details', [
                      _textField(accountHolderName, 'Account Holder Name'),
                      _textField(bankName, 'Bank Name'),
                      _textField(accountNumber, 'Account Number'),
                      _textField(ifsc, 'IFSC Code'),
                    ]),
                    _section('Agreement & Policy', [
                      _checkbox('Commission % Acceptance', commissionAccept, (v) => setState(() => commissionAccept = v)),
                      _checkbox('TDS Deduction Consent', tdsAccept, (v) => setState(() => tdsAccept = v)),
                      _checkbox('Weekly Payout Acceptance', weeklyPayoutAccept, (v) => setState(() => weeklyPayoutAccept = v)),
                      _checkbox('Agreement Acceptance', agreementAccept, (v) => setState(() => agreementAccept = v)),
                      _textField(digitalSignature, 'Digital Signature (Draw/Type Name)'),
                      _checkbox('Minimum Rating Requirement', ratingAccept, (v) => setState(() => ratingAccept = v)),
                      _checkbox('Cancellation & Penalty Policy', cancellationPolicyAccept, (v) => setState(() => cancellationPolicyAccept = v)),
                      _checkbox('Non-Circumvention Clause', nonCircumventionAccept, (v) => setState(() => nonCircumventionAccept = v)),
                      _checkbox('Code of Conduct', codeOfConductAccept, (v) => setState(() => codeOfConductAccept = v)),
                    ]),
                    _section('Emergency & Reference', [
                      _textField(emergencyName, 'Emergency Contact Name'),
                      _textField(emergencyMobile, 'Emergency Contact Number', keyboard: TextInputType.phone),
                      _textField(referenceName, 'Reference Person Name'),
                      _textField(referenceMobile, 'Reference Contact Number', keyboard: TextInputType.phone),
                    ]),
                    _section('Declaration', [
                      _checkbox('Any Criminal Record?', criminalRecord, (v) => setState(() => criminalRecord = v)),
                      _checkbox('Working with competitor platforms?', competitorPlatform, (v) => setState(() => competitorPlatform = v)),
                      _checkbox('Declaration of Self-Employment', selfEmploymentDeclaration, (v) => setState(() => selfEmploymentDeclaration = v)),
                      _checkbox('Consent for Background Verification', backgroundVerificationConsent, (v) => setState(() => backgroundVerificationConsent = v)),
                    ]),
                    _section('Final Consent', [
                      _checkbox(
                        'I Agree & Confirm: All information is true; I have read the ZEN CARE Service Partner Agreement; I agree to commission, payout, penalties; I am an independent partner; I consent to background verification and platform updates.',
                        finalConsent,
                        (v) => setState(() => finalConsent = v),
                      ),
                    ]),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submitting ? null : _submit,
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue.shade800, padding: const EdgeInsets.symmetric(vertical: 14)),
                  child: _submitting ? const SizedBox(height: 24, width: 24, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white)) : const Text('Submit Registration'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _section(String title, List<Widget> children) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          ...children,
        ],
      ),
    );
  }

  Widget _textField(TextEditingController c, String label, {TextInputType? keyboard, int maxLines = 1, String? Function(String?)? validator}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: c,
        decoration: _inputDecoration(label),
        keyboardType: keyboard,
        maxLines: maxLines,
        validator: validator,
      ),
    );
  }

  InputDecoration _inputDecoration([String? label]) {
    return InputDecoration(
      labelText: label,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
    );
  }

  Widget _dropdown(String label, String? value, List<String> options, ValueChanged<String?> onChanged) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: DropdownButtonFormField<String>(
        value: value,
        decoration: _inputDecoration(label),
        items: options.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
        onChanged: onChanged,
      ),
    );
  }

  Widget _checkbox(String label, bool value, ValueChanged<bool> onChanged) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: CheckboxListTile(
        title: Text(label, style: const TextStyle(fontSize: 14)),
        value: value,
        onChanged: (v) => onChanged(v ?? false),
        controlAffinity: ListTileControlAffinity.leading,
        contentPadding: EdgeInsets.zero,
      ),
    );
  }
}
