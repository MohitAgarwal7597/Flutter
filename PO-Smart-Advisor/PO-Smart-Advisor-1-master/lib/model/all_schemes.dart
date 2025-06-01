enum Compounding { annually, quarterly, monthly, none }

class AllSchemes {
  AllSchemes(
      {required this.title,
      required this.subtitle,
      required this.minAmount,
      required this.maxAmount,
      required this.breakEarlyInterest,
      required this.interest,
      this.compunding,
      this.maxThroughCheque,
      required this.lockin,
      required this.description,
      required this.period,
      required this.compoudingPeriod});
  final String title;
  final String subtitle;
  final double minAmount;
  final double maxAmount;
  final double? maxThroughCheque;
  final int lockin;
  final int period;
  final Compounding? compunding;
  final String description;
  final double interest;
  final int compoudingPeriod;
  final double breakEarlyInterest;
  static List<AllSchemes> schemes = [
    AllSchemes(
        title: 'NSC',
        compunding: Compounding.none,
        subtitle: 'Nation Saving Certificate',
        minAmount: 10000,
        maxAmount: 1000000,
        description:
            ' National Saving Certificate  National Saving Certificate',
        breakEarlyInterest: 4.0,
        interest: 7.7,
        lockin: 3,
        period: 60,
        compoudingPeriod: 12),
    AllSchemes(
        title: 'TD - 1 Year',
        compunding: Compounding.none,
        subtitle: 'Term Deposit',
        description: 'National Saving Certificate',
        minAmount: 1000,
        maxAmount: 1000000,
        breakEarlyInterest: 4.0,
        interest: 6.9,
        lockin: 6,
        period: 12,
        compoudingPeriod: 12),
    AllSchemes(
        title: 'TD - 2 Year',
        subtitle: 'Term Deposit',
        compunding: Compounding.none,
        minAmount: 1000,
        description: 'National Saving Certificate',
        maxAmount: 1000000,
        breakEarlyInterest: 4.0,
        interest: 7.0,
        lockin: 6,
        compoudingPeriod: 6,
        period: 24),
    AllSchemes(
        title: 'TD - 3 Year',
        compunding: Compounding.none,
        subtitle: 'Term Deposit',
        minAmount: 1000,
        maxAmount: 1000000,
        description: 'National Saving Certificate',
        breakEarlyInterest: 4.0,
        compoudingPeriod: 12,
        interest: 7.10,
        lockin: 6,
        period: 36),
    AllSchemes(
        title: 'TD - 5 Year',
        subtitle: 'Term Deposit',
        compunding: Compounding.none,
        minAmount: 1000,
        description: 'National Saving Certificate',
        maxAmount: 1000000,
        breakEarlyInterest: 4.0,
        interest: 7.5,
        compoudingPeriod: 12,
        lockin: 6,
        period: 60),
    AllSchemes(
        title: 'MIS',
        subtitle: 'Kishan Vikas Patra',
        description: 'National Saving Certificate',
        compunding: Compounding.none,
        minAmount: 10000,
        maxAmount: 1000000,
        breakEarlyInterest: 4.0,
        interest: 7.4,
        compoudingPeriod: 12,
        lockin: 3,
        period: 60),
    AllSchemes(
        compunding: Compounding.none,
        title: 'KVP',
        description: 'National Saving Certificate',
        subtitle: 'Kishan Vikas Patra',
        minAmount: 10000,
        maxAmount: double.infinity,
        breakEarlyInterest: 4.0,
        interest: 7.6,
        compoudingPeriod: 12,
        lockin: 30,
        period: 115),
    AllSchemes(
        title: 'RD',
        compunding: Compounding.none,
        subtitle: 'Recurring Deposit',
        minAmount: 100,
        maxAmount: 20000,
        description: 'National Saving Certificate',
        maxThroughCheque: double.infinity,
        breakEarlyInterest: 4.0,
        interest: 6.7,
        compoudingPeriod: 12,
        lockin: 6,
        period: 60),
    AllSchemes(
        title: 'PPF',
        minAmount: 500,
        breakEarlyInterest: 4.0,
        maxAmount: double.infinity,
        period: 90,
        description: 'National Saving Certificate',
        maxThroughCheque: double.infinity,
        lockin: 180,
        compoudingPeriod: 12,
        interest: 7.1,
        compunding: Compounding.annually,
        subtitle: 'Public Provident Fund'),
    AllSchemes(
        title: 'SSY',
        minAmount: 250,
        lockin: 168,
        breakEarlyInterest: 4.0,
        maxAmount: double.infinity,
        compoudingPeriod: 12,
        period: 90,
        maxThroughCheque: double.infinity,
        interest: 8.2,
        description: 'National Saving Certificate',
        compunding: Compounding.annually,
        subtitle: 'Sukanya Samriddhi Yojana'),
    AllSchemes(
        title: 'SCSS',
        breakEarlyInterest: 4.0,
        maxAmount: double.infinity,
        period: 90,
        maxThroughCheque: double.infinity,
        compoudingPeriod: 12,
        description: 'National Saving Certificate',
        minAmount: 1000,
        lockin: 60,
        interest: 8.2,
        compunding: Compounding.quarterly,
        subtitle: 'Senior Citizen Saving AllSchemes'),
    AllSchemes(
        title: 'SB',
        minAmount: 50,
        lockin: 0,
        description: 'National Saving Certificate',
        breakEarlyInterest: 4.0,
        compoudingPeriod: 3,
        maxAmount: double.infinity,
        period: 90,
        maxThroughCheque: double.infinity,
        interest: 4.0,
        compunding: Compounding.none,
        subtitle: 'Savings Bank'),
  ];
}

class DownloadForm {
  DownloadForm(
      {required this.title,
      required this.subtitle,
      required this.link,
      required this.tag});
  final String title;
  final String subtitle;
  final String link;
  final String tag;
  static List<DownloadForm> forms = [
    DownloadForm(
        tag: 'Saving Account Forms',
        title: 'Account Opening Form',
        subtitle: 'Open a new account RD, TD, MIS, PPF, KVP etc.',
        link:
            'https://drive.google.com/uc?export=download&id=14Td6CX02keMDsdOfke6m7meNgUgW0vw8'),
    DownloadForm(
        tag: 'Saving Account Forms',
        title: 'ATM or Intra Operable Netbanking_Mobile Banking Request Form',
        subtitle: 'ATM Card/Internet/Mobile/SMS Banking service request form',
        link:
            'https://drive.google.com/uc?export=download&id=1mzsDQ0htOUchJAdr9InyaKDkecHZUAeJ'),
    DownloadForm(
        tag: 'Saving Account Forms',
        title: 'Account Closing Form',
        subtitle: 'Close a account RD, TD, MIS, PPF, KVP etc.',
        link:
            'https://drive.google.com/uc?export=download&id=1FWd2x2LIkgpUs4PvVnzE5f7QxBhsy_Bf'),
    DownloadForm(
        tag: 'Saving Account Forms',
        title: 'Extension of RD',
        subtitle: 'To extend the maturity of RD Account for 5 years',
        link:
            'https://drive.google.com/uc?export=download&id=1iv4FxBZaAORtH3e0_4LNa8iwmDbSWCEj'),
    DownloadForm(
        tag: 'Saving Account Forms',
        title: 'Application for pleadging of form',
        subtitle:
            'Application for pledging of account under National Small Savings Scheme',
        link:
            'https://drive.google.com/uc?export=download&id=17UVl1LGNsUnI0m95dZcWHPkG_92crawf'),
    DownloadForm(
        tag: 'Saving Account Forms',
        title: 'Form-5 Application  for transfer of account',
        subtitle:
            'Application for transfer of account under National Savings Scheme',
        link:
            'https://drive.google.com/uc?export=download&id=1cJZGFU8vllzJUMQzGUbwsxqk9irUWjhn'),
    DownloadForm(
        tag: 'Saving Account Forms',
        title: 'Form-10 Applicaton  for change of nomination',
        subtitle:
            'Application for cancellation and variation of nomination in an account under National Savings Scheme',
        link:
            'https://drive.google.com/uc?export=download&id=1XzSYvu_G2QifY7wm44EtOp4bmXf1PftH'),
    DownloadForm(
        tag: 'Saving Account Forms',
        title: 'Form-13 Affidavit',
        subtitle: 'Affidavit',
        link:
            'https://drive.google.com/uc?export=download&id=1upxa1ImMHHSZxHGF60sK21O2YFRTDfta'),
    DownloadForm(
        tag: 'Saving Account Forms',
        title: 'KYC Form  Annexure II',
        subtitle: 'NEW/CHANGE KYC (Know Your Customer) Form',
        link:
            'https://drive.google.com/uc?export=download&id=1Hg08Bb0sY21XCknThJX9Zn7UVEmqTWoR'),
    DownloadForm(
        tag: 'Saving Account Forms',
        title: 'Legal Evidence',
        subtitle:
            'Application for settlement of an account of the deceased depositor by nominee or legal heirs under National (Small) Savings Scheme',
        link:
            'https://drive.google.com/uc?export=download&id=1w8YAwO1tXUzCnhlJzW9itEzaqn0XgoV1'),
    DownloadForm(
        tag: 'Saving Account Forms',
        title: 'Neft Rtgs Mandate Form',
        subtitle: 'NEFT/RTGS Mandate Form',
        link:
            'https://drive.google.com/uc?export=download&id=16sFeuhuQ3EyOFBhEsKv9gHuUX3aGxE35'),
    DownloadForm(
        tag: 'Saving Account Forms',
        title: 'Pay in Slip/ Deposit Slip)',
        subtitle: 'To deposit money in your account',
        link:
            'https://drive.google.com/uc?export=download&id=1Olekjl4PTUi6eBBlzAkuI7gTIE26Ujc9'),
    DownloadForm(
        tag: 'Saving Account Forms',
        title: 'Premature Closure of Account',
        subtitle: 'APPLICATION FOR PRE-MATURE CLOSURE OF ACCOUNT',
        link:
            'https://drive.google.com/uc?export=download&id=1TkvsaHXQmZ_mAYvLtaWjzeGw9gmxzKGu'),
    DownloadForm(
        tag: 'Saving Account Forms',
        title: 'SB-7  Withdrawal form',
        subtitle: 'WITHDRAWAL FORM',
        link:
            'https://drive.google.com/uc?export=download&id=1LVZG8VqdZvbV_mOEASYyh3TySvjlR6If'),
    DownloadForm(
        tag: 'Saving Account Forms',
        title: 'Loan/Withdrawl RD/PPF and SSA Account',
        subtitle: 'Application form for loan/withdrawl',
        link:
            'https://drive.google.com/uc?export=download&id=1mgCRNRFn8Ag2NjfH50C1vV_u541WYm'),
    DownloadForm(
        tag: 'Saving Account Forms',
        title: 'SB-41   Application for issue of Duplicate Passbook',
        subtitle: 'APPLICATION FOR ISSUE OF DUPLICATE PASS BOOK',
        link:
            'https://drive.google.com/uc?export=download&id=1cTDe26OccGV6sTuY--koe8anKI_03atA'),
    DownloadForm(
        tag: 'Saving Account Forms',
        title: 'SBCQE-4a   Application for  Fresh  Cheque  Book',
        subtitle: 'Requisition for fresh cheque book for Savings Account',
        link:
            'https://drive.google.com/uc?export=download&id=1ZoHll0O0AfD9o48rwX1jld_bpR7ZRESz'),
    DownloadForm(
        tag: 'PLI Form',
        title: 'Acknowledgement Slip Eng',
        subtitle: 'Acknowledgement Slip',
        link:
            'https://drive.google.com/uc?export=download&id=1PNJbpG1BUPspASIulX-0EMpQqKwVaTYO'),
    DownloadForm(
        tag: 'PLI Form',
        title: 'Death Claim Form',
        subtitle: 'Claim Application Form for PLI/RPLI (Death Cases)',
        link:
            'https://drive.google.com/uc?export=download&id=1r9P-WNsnL9q0Y7ZseeO9YKZfztQUInv0'),
    DownloadForm(
        tag: 'PLI Form',
        title: 'Maturity Claim Form',
        subtitle: 'CLAIM FORM FOR MATURITY/SURVIVAL BENEFIT OF PLI/RPLI POLICY',
        link:
            'https://drive.google.com/uc?export=download&id=10ZwsN7NnBDKRVDKLQ2BPjp-8dMr_Qg5z'),
    DownloadForm(
        tag: 'PLI Form',
        title: 'NominationForm',
        subtitle:
            'Request for Registration/ Change of Nomination in respect of PLI/ RPLI Policy',
        link:
            'https://drive.google.com/uc?export=download&id=1VIbjdJ0160TOYhlTHhKb8O0Z39U5tuHL'),
    DownloadForm(
        tag: 'PLI Form',
        title: 'Personal Bond of Indemnity',
        subtitle: 'LETTER OF INDEMNITY',
        link:
            'https://drive.google.com/uc?export=download&id=1N_h2x6lYiBtKH28oyYAy93go6Ozuqe1K'),
    DownloadForm(
        tag: 'PLI Form',
        title: 'PLI Proposal Form',
        subtitle: 'PROPOSAL FORM FOR POSTAL LIFE INSURANCE',
        link:
            'https://drive.google.com/uc?export=download&id=1dyzZsSlBTB0MTD5aEkYHve9m6Z3bYw8a'),
    DownloadForm(
        tag: 'PLI Form',
        title: 'Revival Application form',
        subtitle:
            'APPLICATION FOR REVIVAL OF POSTAL/ RURAL POSTAL LIFE INSURANCE POLICY',
        link:
            'https://drive.google.com/uc?export=download&id=1SG6NFKoi9zNWBZaYxledH-CdJFsGKLzm'),
    DownloadForm(
        tag: 'PLI Form',
        title: 'RPLI Proposal Form',
        subtitle: 'PROPOSAL FORM FOR RURAL POSTAL LIFE INSURANCE (RPLI)',
        link:
            'https://drive.google.com/uc?export=download&id=1IYq7C0bYE4hAKIBi792bomcEu9KH84A1'),
  ];
}
