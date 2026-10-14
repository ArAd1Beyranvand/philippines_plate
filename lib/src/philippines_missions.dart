import 'package:plate_core/plate_core.dart';

/// The first three digits of a diplomatic plate: the country or organisation
/// the vehicle belongs to, in the order the Philippines established relations.
///
/// Taken from the article's two tables (countries 001–075, organisations
/// 200–225). Code `036` is deliberately absent and refused: [name] throws for
/// it, [isRefused] is true for it, and [restriction] carries it into the
/// diplomatic spec so `plate_core` refuses it in the controller, the input
/// machine, the canvas and the validators. Nothing in this package will ever
/// store it.
abstract final class PhilippinesMissions {
  /// The error every layer shows for a refused code.
  static const String notFound = 'COUNTRY NOT FOUND';

  /// Codes no layer may store.
  static const List<String> refused = <String>['036'];

  /// The restriction on the diplomatic spec's `mission` register.
  static const PlateRestriction restriction = PlateRestriction(
    group: 'mission',
    values: refused,
    reason: notFound,
  );

  static bool isRefused(String code) => refused.contains(code);

  /// The mission for [code], or null for a code the list does not have.
  ///
  /// Throws [PlateRestrictionException] for a refused code: unlike an unknown
  /// one, a refused code is never a lookup miss a caller may shrug off.
  static String? name(String code) {
    if (isRefused(code)) throw const PlateRestrictionException(restriction);
    return _missions[code];
  }

  /// Every listed code and its mission, refused codes excluded.
  static Map<String, String> get all => Map.unmodifiable(_missions);

  static const Map<String, String> _missions = <String, String>{
    '001': 'Vatican City/Holy See',
    '002': 'Egypt',
    '003': 'Australia',
    '004': 'Belgium',
    '005': 'Brazil',
    '006': 'Chile',
    '007': 'Panama',
    '008': 'United Kingdom',
    '009': 'United States',
    '010': 'Colombia',
    '011': 'Ireland',
    '012': 'Denmark',
    '013': 'Austria',
    '014': 'Sweden',
    '015': 'France',
    '016': 'Italy',
    '017': 'Spain',
    '018': 'Norway',
    '019': 'Argentina',
    '020': 'South Korea',
    '021': 'Turkey',
    '022': 'Thailand',
    '023': 'Pakistan',
    '024': 'India',
    '025': 'Canada',
    '026': 'Indonesia',
    '027': 'Greece',
    '028': 'Netherlands',
    '029': 'Mexico',
    '030': 'Germany',
    '031': 'Laos',
    '032': 'Finland',
    '033': 'Japan',
    '034': 'Switzerland',
    '035': 'Myanmar',
    '037': 'Cambodia',
    '038': 'Sri Lanka',
    '039': 'Nigeria',
    '040': 'South Africa',
    '041': 'Iran',
    '042': 'European Union',
    '043': 'Malaysia',
    '044': 'New Zealand',
    '045': 'Venezuela',
    '046': 'Singapore',
    '047': 'Saudi Arabia',
    '048': 'Bangladesh',
    '049': 'Romania',
    '050': 'Poland',
    '051': 'Hungary',
    '052': 'Czech Republic',
    '053': 'United Arab Emirates',
    '054': 'Iraq',
    '055': 'Morocco',
    '056': 'China',
    '057': 'Papua New Guinea',
    '058': 'Russia',
    '059': 'Vietnam',
    '060': 'Kuwait',
    '061': 'Libya',
    '062': 'Oman',
    '063': 'Qatar',
    '064': 'Brunei',
    '065': 'Sovereign Military Order of Malta',
    '066': 'Palestine',
    '067': 'Palau',
    '068': 'Angola',
    '069': 'Timor-Leste',
    '070': 'Bahrain',
    '071': 'Yemen',
    '072': 'Ukraine',
    '073': 'Lebanon',
    '074': 'Jordan',
    '075': 'Kazakhstan',
    '200': 'Taipei Economic and Cultural Office in the Philippines',
    '201': 'United Nations',
    '202': 'UNICEF',
    '203': 'World Health Organization',
    '204': 'United Nations Industrial Development Organization',
    '205': 'Asian Development Bank',
    '206': 'World Trade Organization',
    '207': 'World Food Programme',
    '208': 'International Labour Organization',
    '209': 'United States Agency for International Development',
    '210': 'United Nations Information Centres',
    '211': 'United Nations Development Programme',
    '212': 'Food and Agriculture Organization',
    '213': 'International Monetary Fund',
    '214': 'United Nations High Commissioner for Refugees',
    '215': 'International Committee of the Red Cross',
    '216': 'International Finance Corporation',
    '217': 'World Bank',
    '218': 'Canadian International Development Agency',
    '219': 'Japan International Cooperation Agency',
    '220': 'United Nations Population Fund',
    '221': 'International Organization for Migration',
    '222': 'ASEAN Centre for Biodiversity',
    '223': 'International Rice Research Institute',
    '224': 'Japan Bank for International Cooperation',
    '225': 'Swedish International Development Cooperation Agency',
  };
}
