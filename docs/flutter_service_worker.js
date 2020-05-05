'use strict';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "index.html": "cc2e69891fdbc1b296853b09633d56d8",
"/": "cc2e69891fdbc1b296853b09633d56d8",
"main.dart.js": "7692bb8f42da1bffaad32fe5cbaee37e",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"manifest.json": "29366257ff6df8e1b779001ab768d170",
"assets/AssetManifest.json": "f718d5afa5799dbff9ced35059bacd90",
"assets/FontManifest.json": "5fa2baa1355ee1ffd882bec6ab6780c7",
"assets/LICENSE": "5f04484ce76c40979a51e0c5acdcd539",
"assets/packages/font_awesome_flutter/lib/fonts/fa-solid-900.ttf": "2aa350bd2aeab88b601a593f793734c0",
"assets/packages/font_awesome_flutter/lib/fonts/fa-regular-400.ttf": "2bca5ec802e40d3f4b60343e346cedde",
"assets/packages/font_awesome_flutter/lib/fonts/fa-brands-400.ttf": "5a37ae808cf9f652198acde612b5328d",
"assets/fonts/MaterialIcons-Regular.ttf": "56d3ffdef7a25659eab6a68a3fbfaf16",
"assets/assets/languages.json": "f4f87baa2933b0624c08385e6531cfb3",
"assets/assets/education.json": "53c059a0ac5f6e5ce0352067027f72a3",
"assets/assets/in.png": "c6e65d793756fdfc3e624c0d8294b3de",
"assets/assets/certificates.json": "7d32625fb281993b84afb9a498560f18",
"assets/assets/experience.json": "c5e004e31d81992ee28cb217e89940bf",
"assets/assets/photo.jpg": "2bfd615a0781e99e6595cc2e736a1ae6",
"assets/assets/skills.json": "3cb3a251b6bc98206ea6d0dbca1e0475"
};

self.addEventListener('activate', function (event) {
  event.waitUntil(
    caches.keys().then(function (cacheName) {
      return caches.delete(cacheName);
    }).then(function (_) {
      return caches.open(CACHE_NAME);
    }).then(function (cache) {
      return cache.addAll(Object.keys(RESOURCES));
    })
  );
});

self.addEventListener('fetch', function (event) {
  event.respondWith(
    caches.match(event.request)
      .then(function (response) {
        if (response) {
          return response;
        }
        return fetch(event.request);
      })
  );
});
