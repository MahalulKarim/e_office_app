// To parse this JSON data, do
//
//     final articleCategories = articleCategoriesFromJson(jsonString);

import 'dart:convert';

List<ArticleCategories> articleCategoriesFromJson(String str) =>
    List<ArticleCategories>.from(
        json.decode(str).map((x) => ArticleCategories.fromJson(x)));

String articleCategoriesToJson(List<ArticleCategories> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ArticleCategories {
  ArticleCategories({
    this.id,
    this.count,
    this.description,
    this.link,
    this.name,
    this.slug,
    this.taxonomy,
    this.parent,
    this.meta,
    this.yoastHead,
    this.yoastHeadJson,
    this.links,
  });

  int? id;
  int? count;
  String? description;
  String? link;
  String? name;
  String? slug;
  Taxonomy? taxonomy;
  int? parent;
  List<dynamic>? meta;
  String? yoastHead;
  YoastHeadJson? yoastHeadJson;
  Links? links;

  factory ArticleCategories.fromJson(Map<String, dynamic> json) =>
      ArticleCategories(
        id: json["id"],
        count: json["count"],
        description: json["description"],
        link: json["link"],
        name: json["name"],
        slug: json["slug"],
        taxonomy: taxonomyValues.map[json["taxonomy"]]!,
        parent: json["parent"],
        meta: json["meta"] == null
            ? []
            : List<dynamic>.from(json["meta"]!.map((x) => x)),
        yoastHead: json["yoast_head"],
        yoastHeadJson: json["yoast_head_json"] == null
            ? null
            : YoastHeadJson.fromJson(json["yoast_head_json"]),
        links: json["_links"] == null ? null : Links.fromJson(json["_links"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "count": count,
        "description": description,
        "link": link,
        "name": name,
        "slug": slug,
        "taxonomy": taxonomyValues.reverse[taxonomy],
        "parent": parent,
        "meta": meta == null ? [] : List<dynamic>.from(meta!.map((x) => x)),
        "yoast_head": yoastHead,
        "yoast_head_json": yoastHeadJson?.toJson(),
        "_links": links?.toJson(),
      };
}

class Links {
  Links({
    this.self,
    this.collection,
    this.about,
    this.wpPostType,
    this.curies,
    this.up,
  });

  List<About>? self;
  List<About>? collection;
  List<About>? about;
  List<About>? wpPostType;
  List<Cury>? curies;
  List<Up>? up;

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        self: json["self"] == null
            ? []
            : List<About>.from(json["self"]!.map((x) => About.fromJson(x))),
        collection: json["collection"] == null
            ? []
            : List<About>.from(
                json["collection"]!.map((x) => About.fromJson(x))),
        about: json["about"] == null
            ? []
            : List<About>.from(json["about"]!.map((x) => About.fromJson(x))),
        wpPostType: json["wp:post_type"] == null
            ? []
            : List<About>.from(
                json["wp:post_type"]!.map((x) => About.fromJson(x))),
        curies: json["curies"] == null
            ? []
            : List<Cury>.from(json["curies"]!.map((x) => Cury.fromJson(x))),
        up: json["up"] == null
            ? []
            : List<Up>.from(json["up"]!.map((x) => Up.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "self": self == null
            ? []
            : List<dynamic>.from(self!.map((x) => x.toJson())),
        "collection": collection == null
            ? []
            : List<dynamic>.from(collection!.map((x) => x.toJson())),
        "about": about == null
            ? []
            : List<dynamic>.from(about!.map((x) => x.toJson())),
        "wp:post_type": wpPostType == null
            ? []
            : List<dynamic>.from(wpPostType!.map((x) => x.toJson())),
        "curies": curies == null
            ? []
            : List<dynamic>.from(curies!.map((x) => x.toJson())),
        "up": up == null ? [] : List<dynamic>.from(up!.map((x) => x.toJson())),
      };
}

class About {
  About({
    this.href,
  });

  String? href;

  factory About.fromJson(Map<String, dynamic> json) => About(
        href: json["href"],
      );

  Map<String, dynamic> toJson() => {
        "href": href,
      };
}

class Cury {
  Cury({
    this.name,
    this.href,
    this.templated,
  });

  Name? name;
  Href? href;
  bool? templated;

  factory Cury.fromJson(Map<String, dynamic> json) => Cury(
        name: nameValues.map[json["name"]]!,
        href: hrefValues.map[json["href"]]!,
        templated: json["templated"],
      );

  Map<String, dynamic> toJson() => {
        "name": nameValues.reverse[name],
        "href": hrefValues.reverse[href],
        "templated": templated,
      };
}

enum Href { HTTPS_API_W_ORG_REL }

final hrefValues =
    EnumValues({"https://api.w.org/{rel}": Href.HTTPS_API_W_ORG_REL});

enum Name { WP }

final nameValues = EnumValues({"wp": Name.WP});

class Up {
  Up({
    this.embeddable,
    this.href,
  });

  bool? embeddable;
  String? href;

  factory Up.fromJson(Map<String, dynamic> json) => Up(
        embeddable: json["embeddable"],
        href: json["href"],
      );

  Map<String, dynamic> toJson() => {
        "embeddable": embeddable,
        "href": href,
      };
}

enum Taxonomy { CATEGORY }

final taxonomyValues = EnumValues({"category": Taxonomy.CATEGORY});

class YoastHeadJson {
  YoastHeadJson({
    this.title,
    this.robots,
    this.canonical,
    this.ogLocale,
    this.ogType,
    this.ogTitle,
    this.ogUrl,
    this.ogSiteName,
    this.twitterCard,
    this.schema,
  });

  String? title;
  Robots? robots;
  String? canonical;
  OgLocale? ogLocale;
  OgType? ogType;
  String? ogTitle;
  String? ogUrl;
  OgSiteName? ogSiteName;
  TwitterCard? twitterCard;
  Schema? schema;

  factory YoastHeadJson.fromJson(Map<String, dynamic> json) => YoastHeadJson(
        title: json["title"],
        robots: json["robots"] == null ? null : Robots.fromJson(json["robots"]),
        canonical: json["canonical"],
        ogLocale: ogLocaleValues.map[json["og_locale"]]!,
        ogType: ogTypeValues.map[json["og_type"]]!,
        ogTitle: json["og_title"],
        ogUrl: json["og_url"],
        ogSiteName: ogSiteNameValues.map[json["og_site_name"]]!,
        twitterCard: twitterCardValues.map[json["twitter_card"]]!,
        schema: json["schema"] == null ? null : Schema.fromJson(json["schema"]),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "robots": robots?.toJson(),
        "canonical": canonical,
        "og_locale": ogLocaleValues.reverse[ogLocale],
        "og_type": ogTypeValues.reverse[ogType],
        "og_title": ogTitle,
        "og_url": ogUrl,
        "og_site_name": ogSiteNameValues.reverse[ogSiteName],
        "twitter_card": twitterCardValues.reverse[twitterCard],
        "schema": schema?.toJson(),
      };
}

enum OgLocale { ID_ID }

final ogLocaleValues = EnumValues({"id_ID": OgLocale.ID_ID});

enum OgSiteName { TANGAN_ANGIE }

final ogSiteNameValues = EnumValues({"Di Kantor": OgSiteName.TANGAN_ANGIE});

enum OgType { ARTICLE }

final ogTypeValues = EnumValues({"article": OgType.ARTICLE});

class Robots {
  Robots({
    this.index,
    this.follow,
    this.maxSnippet,
    this.maxImagePreview,
    this.maxVideoPreview,
  });

  Index? index;
  Follow? follow;
  MaxSnippet? maxSnippet;
  MaxImagePreview? maxImagePreview;
  MaxVideoPreview? maxVideoPreview;

  factory Robots.fromJson(Map<String, dynamic> json) => Robots(
        index: indexValues.map[json["index"]]!,
        follow: followValues.map[json["follow"]]!,
        maxSnippet: maxSnippetValues.map[json["max-snippet"]]!,
        maxImagePreview: maxImagePreviewValues.map[json["max-image-preview"]]!,
        maxVideoPreview: maxVideoPreviewValues.map[json["max-video-preview"]]!,
      );

  Map<String, dynamic> toJson() => {
        "index": indexValues.reverse[index],
        "follow": followValues.reverse[follow],
        "max-snippet": maxSnippetValues.reverse[maxSnippet],
        "max-image-preview": maxImagePreviewValues.reverse[maxImagePreview],
        "max-video-preview": maxVideoPreviewValues.reverse[maxVideoPreview],
      };
}

enum Follow { FOLLOW }

final followValues = EnumValues({"follow": Follow.FOLLOW});

enum Index { INDEX }

final indexValues = EnumValues({"index": Index.INDEX});

enum MaxImagePreview { MAX_IMAGE_PREVIEW_LARGE }

final maxImagePreviewValues = EnumValues(
    {"max-image-preview:large": MaxImagePreview.MAX_IMAGE_PREVIEW_LARGE});

enum MaxSnippet { MAX_SNIPPET_1 }

final maxSnippetValues =
    EnumValues({"max-snippet:-1": MaxSnippet.MAX_SNIPPET_1});

enum MaxVideoPreview { MAX_VIDEO_PREVIEW_1 }

final maxVideoPreviewValues =
    EnumValues({"max-video-preview:-1": MaxVideoPreview.MAX_VIDEO_PREVIEW_1});

class Schema {
  Schema({
    this.context,
    this.graph,
  });

  String? context;
  List<Graph>? graph;

  factory Schema.fromJson(Map<String, dynamic> json) => Schema(
        context: json["@context"],
        graph: json["@graph"] == null
            ? []
            : List<Graph>.from(json["@graph"]!.map((x) => Graph.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "@context": context,
        "@graph": graph == null
            ? []
            : List<dynamic>.from(graph!.map((x) => x.toJson())),
      };
}

class Graph {
  Graph({
    this.type,
    this.id,
    this.name,
    this.url,
    this.sameAs,
    this.logo,
    this.image,
    this.description,
    this.publisher,
    this.potentialAction,
    this.inLanguage,
    this.isPartOf,
    this.breadcrumb,
    this.itemListElement,
  });

  GraphType? type;
  String? id;
  String? name;
  String? url;
  List<String>? sameAs;
  Logo? logo;
  Breadcrumb? image;
  Description? description;
  Breadcrumb? publisher;
  List<PotentialAction>? potentialAction;
  InLanguage? inLanguage;
  Breadcrumb? isPartOf;
  Breadcrumb? breadcrumb;
  List<ItemListElement>? itemListElement;

  factory Graph.fromJson(Map<String, dynamic> json) => Graph(
        type: graphTypeValues.map[json["@type"]]!,
        id: json["@id"],
        name: json["name"],
        url: json["url"],
        sameAs: json["sameAs"] == null
            ? []
            : List<String>.from(json["sameAs"]!.map((x) => x)),
        logo: json["logo"] == null ? null : Logo.fromJson(json["logo"]),
        image:
            json["image"] == null ? null : Breadcrumb.fromJson(json["image"]),
        description: descriptionValues.map[json["description"]]!,
        publisher: json["publisher"] == null
            ? null
            : Breadcrumb.fromJson(json["publisher"]),
        potentialAction: json["potentialAction"] == null
            ? []
            : List<PotentialAction>.from(json["potentialAction"]!
                .map((x) => PotentialAction.fromJson(x))),
        inLanguage: inLanguageValues.map[json["inLanguage"]]!,
        isPartOf: json["isPartOf"] == null
            ? null
            : Breadcrumb.fromJson(json["isPartOf"]),
        breadcrumb: json["breadcrumb"] == null
            ? null
            : Breadcrumb.fromJson(json["breadcrumb"]),
        itemListElement: json["itemListElement"] == null
            ? []
            : List<ItemListElement>.from(json["itemListElement"]!
                .map((x) => ItemListElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "@type": graphTypeValues.reverse[type],
        "@id": id,
        "name": name,
        "url": url,
        "sameAs":
            sameAs == null ? [] : List<dynamic>.from(sameAs!.map((x) => x)),
        "logo": logo?.toJson(),
        "image": image?.toJson(),
        "description": descriptionValues.reverse[description],
        "publisher": publisher?.toJson(),
        "potentialAction": potentialAction == null
            ? []
            : List<dynamic>.from(potentialAction!.map((x) => x.toJson())),
        "inLanguage": inLanguageValues.reverse[inLanguage],
        "isPartOf": isPartOf?.toJson(),
        "breadcrumb": breadcrumb?.toJson(),
        "itemListElement": itemListElement == null
            ? []
            : List<dynamic>.from(itemListElement!.map((x) => x.toJson())),
      };
}

class Breadcrumb {
  Breadcrumb({
    this.id,
  });

  String? id;

  factory Breadcrumb.fromJson(Map<String, dynamic> json) => Breadcrumb(
        id: json["@id"],
      );

  Map<String, dynamic> toJson() => {
        "@id": id,
      };
}

enum Description { YOUR_IT_SOLUTION_PARTNER }

final descriptionValues = EnumValues(
    {"Your IT Solution Partner": Description.YOUR_IT_SOLUTION_PARTNER});

enum InLanguage { ID }

final inLanguageValues = EnumValues({"id": InLanguage.ID});

class ItemListElement {
  ItemListElement({
    this.type,
    this.position,
    this.name,
    this.item,
  });

  ItemListElementType? type;
  int? position;
  String? name;
  String? item;

  factory ItemListElement.fromJson(Map<String, dynamic> json) =>
      ItemListElement(
        type: itemListElementTypeValues.map[json["@type"]]!,
        position: json["position"],
        name: json["name"],
        item: json["item"],
      );

  Map<String, dynamic> toJson() => {
        "@type": itemListElementTypeValues.reverse[type],
        "position": position,
        "name": name,
        "item": item,
      };
}

enum ItemListElementType { LIST_ITEM }

final itemListElementTypeValues =
    EnumValues({"ListItem": ItemListElementType.LIST_ITEM});

class Logo {
  Logo({
    this.type,
    this.id,
    this.inLanguage,
    this.url,
    this.contentUrl,
    this.width,
    this.height,
    this.caption,
  });

  LogoType? type;
  String? id;
  InLanguage? inLanguage;
  String? url;
  String? contentUrl;
  int? width;
  int? height;
  Caption? caption;

  factory Logo.fromJson(Map<String, dynamic> json) => Logo(
        type: logoTypeValues.map[json["@type"]]!,
        id: json["@id"],
        inLanguage: inLanguageValues.map[json["inLanguage"]]!,
        url: json["url"],
        contentUrl: json["contentUrl"],
        width: json["width"],
        height: json["height"],
        caption: captionValues.map[json["caption"]]!,
      );

  Map<String, dynamic> toJson() => {
        "@type": logoTypeValues.reverse[type],
        "@id": id,
        "inLanguage": inLanguageValues.reverse[inLanguage],
        "url": url,
        "contentUrl": contentUrl,
        "width": width,
        "height": height,
        "caption": captionValues.reverse[caption],
      };
}

enum Caption { TANGANANGIE }

final captionValues = EnumValues({"Di Kantor": Caption.TANGANANGIE});

enum LogoType { IMAGE_OBJECT }

final logoTypeValues = EnumValues({"ImageObject": LogoType.IMAGE_OBJECT});

class PotentialAction {
  PotentialAction({
    this.type,
    this.target,
    this.queryInput,
  });

  PotentialActionType? type;
  dynamic target;
  QueryInput? queryInput;

  factory PotentialAction.fromJson(Map<String, dynamic> json) =>
      PotentialAction(
        type: potentialActionTypeValues.map[json["@type"]]!,
        target: json["target"],
        queryInput: queryInputValues.map[json["query-input"]]!,
      );

  Map<String, dynamic> toJson() => {
        "@type": potentialActionTypeValues.reverse[type],
        "target": target,
        "query-input": queryInputValues.reverse[queryInput],
      };
}

enum QueryInput { REQUIRED_NAME_SEARCH_TERM_STRING }

final queryInputValues = EnumValues({
  "required name=search_term_string":
      QueryInput.REQUIRED_NAME_SEARCH_TERM_STRING
});

class TargetClass {
  TargetClass({
    this.type,
    this.urlTemplate,
  });

  TargetType? type;
  UrlTemplate? urlTemplate;

  factory TargetClass.fromJson(Map<String, dynamic> json) => TargetClass(
        type: targetTypeValues.map[json["@type"]]!,
        urlTemplate: urlTemplateValues.map[json["urlTemplate"]]!,
      );

  Map<String, dynamic> toJson() => {
        "@type": targetTypeValues.reverse[type],
        "urlTemplate": urlTemplateValues.reverse[urlTemplate],
      };
}

enum TargetType { ENTRY_POINT }

final targetTypeValues = EnumValues({"EntryPoint": TargetType.ENTRY_POINT});

enum UrlTemplate { HTTPS_DIENGCYBER_COM_S_SEARCH_TERM_STRING }

final urlTemplateValues = EnumValues({
  "https://diengcyber.com/?s={search_term_string}":
      UrlTemplate.HTTPS_DIENGCYBER_COM_S_SEARCH_TERM_STRING
});

enum PotentialActionType { SEARCH_ACTION, READ_ACTION }

final potentialActionTypeValues = EnumValues({
  "ReadAction": PotentialActionType.READ_ACTION,
  "SearchAction": PotentialActionType.SEARCH_ACTION
});

enum GraphType { ORGANIZATION, WEB_SITE, COLLECTION_PAGE, BREADCRUMB_LIST }

final graphTypeValues = EnumValues({
  "BreadcrumbList": GraphType.BREADCRUMB_LIST,
  "CollectionPage": GraphType.COLLECTION_PAGE,
  "Organization": GraphType.ORGANIZATION,
  "WebSite": GraphType.WEB_SITE
});

enum TwitterCard { SUMMARY_LARGE_IMAGE }

final twitterCardValues =
    EnumValues({"summary_large_image": TwitterCard.SUMMARY_LARGE_IMAGE});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
