// food_item_model.dart

class FoodItemModel {
  final String id;
  final String name;
  final String description;
  final String restaurantId;
  final String restaurantName;
  final String categoryId;
  final String categoryName;
  final double price;
  final double? discountedPrice;
  final double discountPercent;
  final List<String> images;
  final bool isVeg;
  final bool isVegan;
  final bool isJain;
  final bool isBestSeller;
  final bool isNew;
  final bool isSpicy;
  final int spiceLevel; // 0–3
  final bool isAvailable;
  final double rating;
  final int totalRatings;
  final int totalOrders;
  final int prepTimeMinutes;
  final int calories;
  final List<AddOnGroup> addOnGroups;
  final List<String> allergens;
  final List<String> tags;
  final NutritionInfo? nutrition;
  final String? badge; // "Chef's Special", "Limited", etc.
  final DateTime createdAt;
  final DateTime updatedAt;

  const FoodItemModel({
    required this.id,
    required this.name,
    required this.description,
    required this.restaurantId,
    required this.restaurantName,
    required this.categoryId,
    required this.categoryName,
    required this.price,
    this.discountedPrice,
    this.discountPercent = 0,
    this.images = const [],
    this.isVeg = true,
    this.isVegan = false,
    this.isJain = false,
    this.isBestSeller = false,
    this.isNew = false,
    this.isSpicy = false,
    this.spiceLevel = 0,
    this.isAvailable = true,
    this.rating = 0.0,
    this.totalRatings = 0,
    this.totalOrders = 0,
    this.prepTimeMinutes = 20,
    this.calories = 0,
    this.addOnGroups = const [],
    this.allergens = const [],
    this.tags = const [],
    this.nutrition,
    this.badge,
    required this.createdAt,
    required this.updatedAt,
  });

  // ── Computed ──────────────────────────────────────────────────
  bool get hasDiscount => discountedPrice != null && discountedPrice! < price;
  double get effectivePrice => discountedPrice ?? price;
  double get savedAmount => price - effectivePrice;
  String get thumbnail => images.isNotEmpty ? images.first : '';
  bool get hasAddOns => addOnGroups.isNotEmpty;
  String get spiceLevelLabel =>
      ['Mild', 'Medium', 'Hot', 'Extra Hot'].elementAtOrNull(spiceLevel) ??
      'Mild';

  // ── fromJson ──────────────────────────────────────────────────
  factory FoodItemModel.fromJson(Map<String, dynamic> j) => FoodItemModel(
    id: j['id'] as String,
    name: j['name'] as String,
    description: j['description'] as String? ?? '',
    restaurantId: j['restaurant_id'] as String,
    restaurantName: j['restaurant_name'] as String,
    categoryId: j['category_id'] as String,
    categoryName: j['category_name'] as String,
    price: (j['price'] as num).toDouble(),
    discountedPrice: j['discounted_price'] != null
        ? (j['discounted_price'] as num).toDouble()
        : null,
    discountPercent: (j['discount_percent'] as num?)?.toDouble() ?? 0,
    images: j['images'] is List ? List<String>.from(j['images']) : [],
    isVeg: j['is_veg'] as bool? ?? true,
    isVegan: j['is_vegan'] as bool? ?? false,
    isJain: j['is_jain'] as bool? ?? false,
    isBestSeller: j['is_best_seller'] as bool? ?? false,
    isNew: j['is_new'] as bool? ?? false,
    isSpicy: j['is_spicy'] as bool? ?? false,
    spiceLevel: j['spice_level'] as int? ?? 0,
    isAvailable: j['is_available'] as bool? ?? true,
    rating: (j['rating'] as num?)?.toDouble() ?? 0.0,
    totalRatings: j['total_ratings'] as int? ?? 0,
    totalOrders: j['total_orders'] as int? ?? 0,
    prepTimeMinutes: j['prep_time_minutes'] as int? ?? 20,
    calories: j['calories'] as int? ?? 0,
    addOnGroups:
        (j['add_on_groups'] as List<dynamic>?)
            ?.map((e) => AddOnGroup.fromJson(e))
            .toList() ??
        [],
    allergens: List<String>.from(j['allergens'] ?? []),
    tags: List<String>.from(j['tags'] ?? []),
    nutrition: j['nutrition'] != null
        ? NutritionInfo.fromJson(j['nutrition'])
        : null,
    badge: j['badge'] as String?,
    createdAt: DateTime.parse(j['created_at']),
    updatedAt: DateTime.parse(j['updated_at']),
  );

  // ── toJson ────────────────────────────────────────────────────
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'description': description,
    'restaurant_id': restaurantId,
    'restaurant_name': restaurantName,
    'category_id': categoryId,
    'category_name': categoryName,
    'price': price,
    'discounted_price': discountedPrice,
    'discount_percent': discountPercent,
    'images': images,
    'is_veg': isVeg,
    'is_vegan': isVegan,
    'is_jain': isJain,
    'is_best_seller': isBestSeller,
    'is_new': isNew,
    'is_spicy': isSpicy,
    'spice_level': spiceLevel,
    'is_available': isAvailable,
    'rating': rating,
    'total_ratings': totalRatings,
    'total_orders': totalOrders,
    'prep_time_minutes': prepTimeMinutes,
    'calories': calories,
    'add_on_groups': addOnGroups.map((e) => e.toJson()).toList(),
    'allergens': allergens,
    'tags': tags,
    'nutrition': nutrition?.toJson(),
    'badge': badge,
    'created_at': createdAt.toIso8601String(),
    'updated_at': updatedAt.toIso8601String(),
  };

  // ── copyWith ──────────────────────────────────────────────────
  FoodItemModel copyWith({
    String? id,
    String? name,
    String? description,
    String? restaurantId,
    String? restaurantName,
    String? categoryId,
    String? categoryName,
    double? price,
    double? discountedPrice,
    double? discountPercent,
    List<String>? images,
    bool? isVeg,
    bool? isVegan,
    bool? isJain,
    bool? isBestSeller,
    bool? isNew,
    bool? isSpicy,
    int? spiceLevel,
    bool? isAvailable,
    double? rating,
    int? totalRatings,
    int? totalOrders,
    int? prepTimeMinutes,
    int? calories,
    List<AddOnGroup>? addOnGroups,
    List<String>? allergens,
    List<String>? tags,
    NutritionInfo? nutrition,
    String? badge,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => FoodItemModel(
    id: id ?? this.id,
    name: name ?? this.name,
    description: description ?? this.description,
    restaurantId: restaurantId ?? this.restaurantId,
    restaurantName: restaurantName ?? this.restaurantName,
    categoryId: categoryId ?? this.categoryId,
    categoryName: categoryName ?? this.categoryName,
    price: price ?? this.price,
    discountedPrice: discountedPrice ?? this.discountedPrice,
    discountPercent: discountPercent ?? this.discountPercent,
    images: images ?? this.images,
    isVeg: isVeg ?? this.isVeg,
    isVegan: isVegan ?? this.isVegan,
    isJain: isJain ?? this.isJain,
    isBestSeller: isBestSeller ?? this.isBestSeller,
    isNew: isNew ?? this.isNew,
    isSpicy: isSpicy ?? this.isSpicy,
    spiceLevel: spiceLevel ?? this.spiceLevel,
    isAvailable: isAvailable ?? this.isAvailable,
    rating: rating ?? this.rating,
    totalRatings: totalRatings ?? this.totalRatings,
    totalOrders: totalOrders ?? this.totalOrders,
    prepTimeMinutes: prepTimeMinutes ?? this.prepTimeMinutes,
    calories: calories ?? this.calories,
    addOnGroups: addOnGroups ?? this.addOnGroups,
    allergens: allergens ?? this.allergens,
    tags: tags ?? this.tags,
    nutrition: nutrition ?? this.nutrition,
    badge: badge ?? this.badge,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );

  @override
  String toString() =>
      'FoodItemModel(id: $id, name: $name, price: $effectivePrice)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is FoodItemModel && other.id == id;

  @override
  int get hashCode => id.hashCode;
}

// ─────────────────────────────────────────────────
//  ADD-ON GROUP  e.g. "Choose Size", "Extra Toppings"
// ─────────────────────────────────────────────────
class AddOnGroup {
  final String id;
  final String name;
  final bool isRequired;
  final int minSelect;
  final int maxSelect;
  final List<AddOnItem> items;

  const AddOnGroup({
    required this.id,
    required this.name,
    this.isRequired = false,
    this.minSelect = 0,
    this.maxSelect = 1,
    this.items = const [],
  });

  factory AddOnGroup.fromJson(Map<String, dynamic> j) => AddOnGroup(
    id: j['id'] as String,
    name: j['name'] as String,
    isRequired: j['is_required'] as bool? ?? false,
    minSelect: j['min_select'] as int? ?? 0,
    maxSelect: j['max_select'] as int? ?? 1,
    items:
        (j['items'] as List<dynamic>?)
            ?.map((e) => AddOnItem.fromJson(e))
            .toList() ??
        [],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'is_required': isRequired,
    'min_select': minSelect,
    'max_select': maxSelect,
    'items': items.map((e) => e.toJson()).toList(),
  };
}

// ─────────────────────────────────────────────────
//  ADD-ON ITEM  e.g. "Large +₹40", "Extra Cheese +₹20"
// ─────────────────────────────────────────────────
class AddOnItem {
  final String id;
  final String name;
  final double price;
  final bool isDefault;
  final bool isAvailable;

  const AddOnItem({
    required this.id,
    required this.name,
    this.price = 0,
    this.isDefault = false,
    this.isAvailable = true,
  });

  factory AddOnItem.fromJson(Map<String, dynamic> j) => AddOnItem(
    id: j['id'] as String,
    name: j['name'] as String,
    price: (j['price'] as num?)?.toDouble() ?? 0,
    isDefault: j['is_default'] as bool? ?? false,
    isAvailable: j['is_available'] as bool? ?? true,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'price': price,
    'is_default': isDefault,
    'is_available': isAvailable,
  };
}

// ─────────────────────────────────────────────────
//  NUTRITION INFO
// ─────────────────────────────────────────────────
class NutritionInfo {
  final double calories;
  final double protein;
  final double carbs;
  final double fat;
  final double fiber;
  final double sugar;
  final double sodium;

  const NutritionInfo({
    this.calories = 0,
    this.protein = 0,
    this.carbs = 0,
    this.fat = 0,
    this.fiber = 0,
    this.sugar = 0,
    this.sodium = 0,
  });

  factory NutritionInfo.fromJson(Map<String, dynamic> j) => NutritionInfo(
    calories: (j['calories'] as num?)?.toDouble() ?? 0,
    protein: (j['protein'] as num?)?.toDouble() ?? 0,
    carbs: (j['carbs'] as num?)?.toDouble() ?? 0,
    fat: (j['fat'] as num?)?.toDouble() ?? 0,
    fiber: (j['fiber'] as num?)?.toDouble() ?? 0,
    sugar: (j['sugar'] as num?)?.toDouble() ?? 0,
    sodium: (j['sodium'] as num?)?.toDouble() ?? 0,
  );

  Map<String, dynamic> toJson() => {
    'calories': calories,
    'protein': protein,
    'carbs': carbs,
    'fat': fat,
    'fiber': fiber,
    'sugar': sugar,
    'sodium': sodium,
  };
}
