import 'package:flutter/material.dart';

List stringSuggestions = [
  [
    'Açık hava sporları için uygun sayılabilir bir hava',
    'Bisiklet sürmek için uygun sayılabilir bir hava',
    'Açık havada yürüyüş yapmak için uygun sayılabilir bir hava',
    'Dışarıda piknik yapmak için uygun sayılabilir bir hava'
  ],
  [
    'Açık hava sporları için güzel bir hava',
    'Bisiklet sürmek için güzel bir hava',
    'Açık havada yürüyüş yapmak için güzel bir hava',
    'Dışarıda piknik yapmak için güzel bir hava',
  ],
  [
    'Açık hava sporları için iyi bir hava değil',
    'Bisiklet sürmek için iyi bir hava değil',
    'Açık havada yürüyüş yapmak için iyi bir hava değil',
    'Dışarıda piknik yapmak için iyi bir hava değil'
  ],
  [
    'Açık hava sporları için kötü bir hava',
    'Bisiklet sürmek için kötü bir hava',
    'Açık havada yürüyüş yapmak için kötü bir hava',
    'Dışarıda piknik yapmak için kötü bir hava'
  ],
  [
    'Açık hava sporları için çok kötü bir hava',
    'Bisiklet sürmek için çok kötü bir hava',
    'Açık havada yürüyüş yapmak için çok kötü bir hava',
    'Dışarıda piknik yapmak için çok kötü bir hava',
  ],
  [
    'Açık hava sporları için çok kötü bir hava',
    'Bisiklet sürmek için çok kötü bir hava',
    'Açık havada yürüyüş yapmak için çok kötü bir hava',
    'Dışarıda piknik yapmak için çok kötü bir hava',
  ]
];

List<Icon> iconList = [Icon(Icons.directions_run), Icon(Icons.motorcycle), Icon(Icons.directions_walk), Icon(Icons.shopping_basket)];

Map<String, String> map = {
    'Üsküdar':
        'https://api.waqi.info/feed/uskudar/?token=891351b0c50bf07574dddd0c24d86cd0fc37707a',
    'Şirinevler':
        'https://api.waqi.info/feed/@8159/?token=891351b0c50bf07574dddd0c24d86cd0fc37707a',
    'Mecidiyeköy':
        'https://api.waqi.info/feed/@8156/?token=891351b0c50bf07574dddd0c24d86cd0fc37707a',
    'Ümraniye':
        'https://api.waqi.info/feed/Ümraniye/?token=891351b0c50bf07574dddd0c24d86cd0fc37707a',
    'Başakşehir':
        'https://api.waqi.info/feed/Basaksehir/?token=891351b0c50bf07574dddd0c24d86cd0fc37707a',
    'Esenyurt':
        'https://api.waqi.info/feed/Esenyurt/?token=891351b0c50bf07574dddd0c24d86cd0fc37707a',
    'Sultanbeyli':
        'https://api.waqi.info/feed/Sultanbeyli/?token=891351b0c50bf07574dddd0c24d86cd0fc37707a',
    'Sultangazi':
        'https://api.waqi.info/feed/sultangazi/?token=891351b0c50bf07574dddd0c24d86cd0fc37707a',
    'Kağıthane':
        'https://api.waqi.info/feed/@8154/?token=891351b0c50bf07574dddd0c24d86cd0fc37707a',
    'Silivri':
        'https://api.waqi.info/feed/Silivri/?token=891351b0c50bf07574dddd0c24d86cd0fc37707a',
    'Şile':
        'https://api.waqi.info/feed/@8158/?token=891351b0c50bf07574dddd0c24d86cd0fc37707a',
    'Kandilli':
        'https://api.waqi.info/feed/@8155/?token=891351b0c50bf07574dddd0c24d86cd0fc37707a',
  };