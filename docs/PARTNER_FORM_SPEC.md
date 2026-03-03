# ZEN CARE – Service Partner Registration Form (Reference)

The **Become a Partner** flow opens the partner registration form. The form should be hosted at the URL configured in `PartnerRegistrationPage.partnerFormUrl` (e.g. `https://zencareservice.com/partner-registration`) and should include the sections below. This doc is for backend/web form implementation.

## Form sections (high level)

1. **Basic Information** – Full name, mobile (OTP verified), alternate mobile, email, DOB, gender, photograph  
2. **Address Details** – Current/permanent address, city, district, state, pincode, landmark, serviceable areas (dropdown from approved zones)  
3. **Service Category** – Primary category (Beauty & Salon, Spa & Wellness, Home Cleaning, Plumbing, Electrical, Appliance Repair, Other), sub-services  
4. **Professional Details** – Experience, certifications, training institute, previous company, tools/equipment, ZEN CARE kit, working days, time slots  
5. **KYC & Compliance** – Aadhaar, PAN, police verification, GST (if any), bank details, cancelled cheque  
6. **Financial & Agreement** – Commission %, TDS, weekly payout, agreement checkbox, digital signature  
7. **Policy & Compliance** – Min rating, cancellation/penalty, non-circumvention, code of conduct  
8. **Emergency & Reference** – Emergency contact, reference person  
9. **Declaration** – Criminal record, competitor platforms, self-employment, background verification consent  
10. **Final Consent** – Single mandatory checkbox:

- ☐ **I Agree & Confirm**  
  I hereby declare that: all information provided is true and correct; I have read and understood the ZEN CARE Service Partner Agreement; I agree to the commission structure, payout cycle, penalties, and platform policies; I understand that I am an independent service partner and not an employee of ZEN CARE; I consent to background verification and document validation; I agree to comply with all platform updates and operational guidelines issued by ZEN CARE from time to time.

## Phase 1 serviceable pincodes (for dropdown)

Adoni_518301, Anathapur-515401, Bethancharla_518599, Banganapally-518124, Dhone-518222, Dharmavaram-515671, Gooty-515401, Hindupur-515201, Kurnool-518001, Nandyal-518501, Kodmur-518464, Pathikonda-518380, Tadipatri-515411, Guntakal-515801, Pamidi-515775, Yemiginur-518360.
