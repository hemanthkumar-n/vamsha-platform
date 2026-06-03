import '../domain/identity_claim.dart';

class FounderIdentityClaims {
  static const claims = <IdentityClaim>[
    // Prasad -> Hemanth
    IdentityClaim(
      sourceId: 'prasad',
      targetId: 'hemanth',
      type: ClaimType.parent,
    ),

    // Sudha Rani -> Hemanth
    IdentityClaim(
      sourceId: 'sudharani',
      targetId: 'hemanth',
      type: ClaimType.parent,
    ),

    // Hemanth <-> Divya
    IdentityClaim(
      sourceId: 'hemanth',
      targetId: 'divya',
      type: ClaimType.sibling,
    ),

    // Hemanth <-> Keerthi
    IdentityClaim(
      sourceId: 'hemanth',
      targetId: 'keerthi',
      type: ClaimType.spouse,
    ),

    // Hemanth -> Yuvan
    IdentityClaim(
      sourceId: 'hemanth',
      targetId: 'yuvan',
      type: ClaimType.parent,
    ),

    // Divya <-> Kamesh
    IdentityClaim(
      sourceId: 'divya',
      targetId: 'kamesh',
      type: ClaimType.spouse,
    ),
  ];
}
