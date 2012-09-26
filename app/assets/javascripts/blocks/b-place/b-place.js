$(document).ready(function() {
  $('a.js-place-happydev').click(function() {
    myMap.setCenter(new DG.GeoPoint(73.3248460943341,54.97891767527),15.5);
  });
  $('a.js-place-rail-station').click(function() {
    if (! myMap.balloons.getDefaultGroup().contains(stationBalloon)) { myMap.balloons.add(stationBalloon); }
    if (! myMap.markers.getDefaultGroup().contains(stationMarker)) { myMap.markers.add(stationMarker); }

    stationBalloon.show();
    stationMarker.show();
    if (myMap.balloons.getDefaultGroup().contains(hotelBalloon)) { hotelBalloon.hide(); }
    if (myMap.markers.getDefaultGroup().contains(hotelMarker)) { hotelMarker.hide(); }
    myMap.setCenter(new DG.GeoPoint(73.384812,54.94006),15.5);
  });

  $('a.js-place-hotel').click(function() {
    if (! myMap.balloons.getDefaultGroup().contains(hotelBalloon)) { myMap.balloons.add(hotelBalloon); }
    if (! myMap.markers.getDefaultGroup().contains(hotelMarker)) { myMap.markers.add(hotelMarker); }

    hotelBalloon.show();
    hotelMarker.show();
    if (myMap.balloons.getDefaultGroup().contains(stationBalloon)) { stationBalloon.hide(); }
    if (myMap.markers.getDefaultGroup().contains(stationMarker)) { stationMarker.hide(); }
    myMap.setCenter(new DG.GeoPoint(73.318706,55.013735),15.5)
  });
});
