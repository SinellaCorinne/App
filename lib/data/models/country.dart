
class MinimalCountry {
  final String name;
  final String code; // Ex: 'SN'
  final String dialCode; // Ex: '221'
  final String flag; // Drapeau emoji

  const MinimalCountry({
    required this.name,
    required this.code,
    required this.dialCode,
    required this.flag,
  });
}

// Liste de 10 pays africains (Exemple à adapter à vos besoins)
const List<MinimalCountry> minimalCountries = [
  MinimalCountry(name: 'Sénégal', code: 'SN', dialCode: '221', flag: '🇸🇳'),
  MinimalCountry(name: 'Côte d\'Ivoire', code: 'CI', dialCode: '225', flag: '🇨🇮'),
  MinimalCountry(name: 'Maroc', code: 'MA', dialCode: '212', flag: '🇲🇦'),
  MinimalCountry(name: 'Nigéria', code: 'NG', dialCode: '234', flag: '🇳🇬'),
  MinimalCountry(name: 'Ghana', code: 'GH', dialCode: '233', flag: '🇬🇭'),
  MinimalCountry(name: 'Cameroun', code: 'CM', dialCode: '237', flag: '🇨🇲'),
  MinimalCountry(name: 'Afrique du Sud', code: 'ZA', dialCode: '27', flag: '🇿🇦'),
  MinimalCountry(name: 'Kenya', code: 'KE', dialCode: '254', flag: '🇰🇪'),
  MinimalCountry(name: 'Algérie', code: 'DZ', dialCode: '213', flag: '🇩🇿'),
  MinimalCountry(name: 'Tunisie', code: 'TN', dialCode: '216', flag: '🇹🇳'),
];