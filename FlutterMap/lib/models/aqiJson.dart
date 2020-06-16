
import 'dart:convert';

AqiJson aqiJsonFromJson(String str) => AqiJson.fromJson(json.decode(str));

String aqiJsonToJson(AqiJson data) => json.encode(data.toJson());

class AqiJson {
    String status;
    Data data;

    AqiJson({
        this.status,
        this.data,
    });

    factory AqiJson.fromJson(Map<String, dynamic> json) => AqiJson(
        status: json["status"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": data.toJson(),
    };
}

class Data {
    int aqi;
    int idx;
    List<Attribution> attributions;
    City city;
    String dominentpol;
    Map<String, Iaqi> iaqi;
    Time time;
    Debug debug;

    Data({
        this.aqi,
        this.idx,
        this.attributions,
        this.city,
        this.dominentpol,
        this.iaqi,
        this.time,
        this.debug,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        aqi: json["aqi"],
        idx: json["idx"],
        attributions: List<Attribution>.from(json["attributions"].map((x) => Attribution.fromJson(x))),
        city: City.fromJson(json["city"]),
        dominentpol: json["dominentpol"],
        iaqi: Map.from(json["iaqi"]).map((k, v) => MapEntry<String, Iaqi>(k, Iaqi.fromJson(v))),
        time: Time.fromJson(json["time"]),
        debug: Debug.fromJson(json["debug"]),
    );

    Map<String, dynamic> toJson() => {
        "aqi": aqi,
        "idx": idx,
        "attributions": List<dynamic>.from(attributions.map((x) => x.toJson())),
        "city": city.toJson(),
        "dominentpol": dominentpol,
        "iaqi": Map.from(iaqi).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
        "time": time.toJson(),
        "debug": debug.toJson(),
    };
}

class Attribution {
    String url;
    String name;
    String logo;

    Attribution({
        this.url,
        this.name,
        this.logo,
    });

    factory Attribution.fromJson(Map<String, dynamic> json) => Attribution(
        url: json["url"],
        name: json["name"],
        logo: json["logo"] == null ? null : json["logo"],
    );

    Map<String, dynamic> toJson() => {
        "url": url,
        "name": name,
        "logo": logo == null ? null : logo,
    };
}

class City {
    List<double> geo;
    String name;
    String url;

    City({
        this.geo,
        this.name,
        this.url,
    });

    factory City.fromJson(Map<String, dynamic> json) => City(
        geo: List<double>.from(json["geo"].map((x) => x.toDouble())),
        name: json["name"],
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "geo": List<dynamic>.from(geo.map((x) => x)),
        "name": name,
        "url": url,
    };
}

class Debug {
    DateTime sync;

    Debug({
        this.sync,
    });

    factory Debug.fromJson(Map<String, dynamic> json) => Debug(
        sync: DateTime.parse(json["sync"]),
    );

    Map<String, dynamic> toJson() => {
        "sync": sync.toIso8601String(),
    };
}

class Iaqi {
    double v;

    Iaqi({
        this.v,
    });

    factory Iaqi.fromJson(Map<String, dynamic> json) => Iaqi(
        v: json["v"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "v": v,
    };
}

class Time {
    DateTime s;
    String tz;
    int v;

    Time({
        this.s,
        this.tz,
        this.v,
    });

    factory Time.fromJson(Map<String, dynamic> json) => Time(
        s: DateTime.parse(json["s"]),
        tz: json["tz"],
        v: json["v"],
    );

    Map<String, dynamic> toJson() => {
        "s": s.toIso8601String(),
        "tz": tz,
        "v": v,
    };
}
