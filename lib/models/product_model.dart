import 'dart:convert';

class ProductModel {
  final int product_id;
  final String name;
  final int quantity;
  final String added_by;
  final int category_id;
  final int main_subcategory_id;
  final int shop_id;
  final String latitude;
  final String longitude;
  final String? user_id;
  final int num_of_sale;
  final String? brand_id;
  final String photos;
  final String thumbnail_img;
  final String featured_img;
  final String flash_deal_img;
  final String video_provider;
  final String video_link;
  final String tags;
  final String description;
  final int unit_price;
  final int purchase_price;
  final String choice_options;
  final String colors;
  final String variations;
  final int todays_deal;
  final int published;
  final int featured;
  final int current_stock;
  final String unit;
  final int discount;
  final String discount_type;
  final int tax;
  final String tax_type;
  final String shipping_type;
  final int shipping_cost;
  final String meta_title;
  final String meta_description;
  final String meta_img;
  final String pdf;
  final String slug;
  final int rating;
  ProductModel({
    required this.product_id,
    required this.name,
    required this.quantity,
    required this.added_by,
    required this.category_id,
    required this.main_subcategory_id,
    required this.shop_id,
    required this.latitude,
    required this.longitude,
    this.user_id,
    required this.num_of_sale,
    this.brand_id,
    required this.photos,
    required this.thumbnail_img,
    required this.featured_img,
    required this.flash_deal_img,
    required this.video_provider,
    required this.video_link,
    required this.tags,
    required this.description,
    required this.unit_price,
    required this.purchase_price,
    required this.choice_options,
    required this.colors,
    required this.variations,
    required this.todays_deal,
    required this.published,
    required this.featured,
    required this.current_stock,
    required this.unit,
    required this.discount,
    required this.discount_type,
    required this.tax,
    required this.tax_type,
    required this.shipping_type,
    required this.shipping_cost,
    required this.meta_title,
    required this.meta_description,
    required this.meta_img,
    required this.pdf,
    required this.slug,
    required this.rating,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'product_id': product_id,
      'name': name,
      'quantity': quantity,
      'added_by': added_by,
      'category_id': category_id,
      'main_subcategory_id': main_subcategory_id,
      'shop_id': shop_id,
      'latitude': latitude,
      'longitude': longitude,
      'user_id': user_id,
      'num_of_sale': num_of_sale,
      'brand_id': brand_id,
      'photos': photos,
      'thumbnail_img': thumbnail_img,
      'featured_img': featured_img,
      'flash_deal_img': flash_deal_img,
      'video_provider': video_provider,
      'video_link': video_link,
      'tags': tags,
      'description': description,
      'unit_price': unit_price,
      'purchase_price': purchase_price,
      'choice_options': choice_options,
      'colors': colors,
      'variations': variations,
      'todays_deal': todays_deal,
      'published': published,
      'featured': featured,
      'current_stock': current_stock,
      'unit': unit,
      'discount': discount,
      'discount_type': discount_type,
      'tax': tax,
      'tax_type': tax_type,
      'shipping_type': shipping_type,
      'shipping_cost': shipping_cost,
      'meta_title': meta_title,
      'meta_description': meta_description,
      'meta_img': meta_img,
      'pdf': pdf,
      'slug': slug,
      'rating': rating,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      product_id: map['product_id'] as int,
      name: map['name'] as String,
      quantity: map['quantity'] as int,
      added_by: map['added_by'] as String,
      category_id: map['category_id'] as int,
      main_subcategory_id: map['main_subcategory_id'] as int,
      shop_id: map['shop_id'] as int,
      latitude: map['latitude'] as String,
      longitude: map['longitude'] as String,
      user_id: map['user_id'] != null ? map['user_id'] as String : null,
      num_of_sale: map['num_of_sale'] as int,
      brand_id: map['brand_id'] != null ? map['brand_id'] as String : null,
      photos: map['photos'] as String,
      thumbnail_img: map['thumbnail_img'] as String,
      featured_img: map['featured_img'] as String,
      flash_deal_img: map['flash_deal_img'] as String,
      video_provider: map['video_provider'] as String,
      video_link: map['video_link'] as String,
      tags: map['tags'] as String,
      description: map['description'] as String,
      unit_price: map['unit_price'] as int,
      purchase_price: map['purchase_price'] as int,
      choice_options: map['choice_options'] as String,
      colors: map['colors'] as String,
      variations: map['variations'] as String,
      todays_deal: map['todays_deal'] as int,
      published: map['published'] as int,
      featured: map['featured'] as int,
      current_stock: map['current_stock'] as int,
      unit: map['unit'] as String,
      discount: map['discount'] as int,
      discount_type: map['discount_type'] as String,
      tax: map['tax'] as int,
      tax_type: map['tax_type'] as String,
      shipping_type: map['shipping_type'] as String,
      shipping_cost: map['shipping_cost'] as int,
      meta_title: map['meta_title'] as String,
      meta_description: map['meta_description'] as String,
      meta_img: map['meta_img'] as String,
      pdf: map['pdf'] as String,
      slug: map['slug'] as String,
      rating: map['rating'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
