
// function initMap(mapData) {
//     const map = new google.maps.Map(document.getElementById("map"), {
//       zoom: 4,
//       center: { lat: mapDetails[1].lat, lng: mapDetails[1].lng },
//     });

//     mapDetails = JSON.parse(mapData);
//     console.log(mapDetails.length)

//     // const infoBox = createContentString(mapDetails);

//     // for (let i = 0; i < mapDetails.length; ++i) {
//     //   var marker = new google.maps.Marker({
//     //       position: {lat: mapDetails[i].lat, lng: mapDetails[i].lng},
//     //       map,
//     //   });

//     //   attachMarker(marker, infoBox[i]);
//     // }
    
// }
 
// function createContentString(mapDetails){
//   var contentString = []
//   for (let i = 0; i < mapDetails.length; ++i){
//     var content =
//     '<div id="content">' +
//     '<div id="siteNotice">' +
//     "</div>" +
//     '<h3 id="firstHeading" class="firstHeading">Building Location Details</h3>' +
//     '<div id="bodyContent">' +
//     "<h5>Location of the Building: " + mapDetails[i].address + "</h5>" + 
//     "<h5>Number of floors in the building: " + mapDetails[i].map + "</h5>" + 
//     "<h5>Client name: " + mapDetails[i].floor + "</h5>" + 
//     "<h5>Number of Batteries: " + mapDetails[i].batteries + "</h5>" + 
//     "<h5>Number of Columns: " + mapDetails[i].columns + "</h5>" + 
//     "<h5>Number of Elevators: " + mapDetails[i].elevators + "</h5>" + 
//     "<h5>Full name of technical contact: " + mapDetails[i].technical_contact + "</h5>" + 
//     "</div>" +
//     "</div>";

//     contentString.push(content);
//   }
//   return contentString;

// }
//   // Attaches an info window to a marker with the provided message. When the
//   // marker is clicked, the info window will open with the secret message.
// function attachMarker(marker, contentString) {
//   const infowindow = new google.maps.InfoWindow({
//       content: contentString,
//   });

//   marker.addListener("click", () => {
//       infowindow.open(marker.get("map"), marker);
//   });
// }

// function initMap() {
//   const uluru = { lat: -25.363, lng: 131.044 };
//   const map = new google.maps.Map(document.getElementById("map"), {
//     zoom: 4,
//     center: uluru,
//   });
//   const contentString =
//     '<div id="content">' +
//     '<div id="siteNotice">' +
//     "</div>" +
//     '<h1 id="firstHeading" class="firstHeading">Uluru</h1>' +
//     '<div id="bodyContent">' +
//     "<p><b>Uluru</b>, also referred to as <b>Ayers Rock</b>, is a large " +
//     "sandstone rock formation in the southern part of the " +
//     "Northern Territory, central Australia. It lies 335&#160;km (208&#160;mi) " +
//     "south west of the nearest large town, Alice Springs; 450&#160;km " +
//     "(280&#160;mi) by road. Kata Tjuta and Uluru are the two major " +
//     "features of the Uluru - Kata Tjuta National Park. Uluru is " +
//     "sacred to the Pitjantjatjara and Yankunytjatjara, the " +
//     "Aboriginal people of the area. It has many springs, waterholes, " +
//     "rock caves and ancient paintings. Uluru is listed as a World " +
//     "Heritage Site.</p>" +
//     '<p>Attribution: Uluru, <a href="https://en.wikipedia.org/w/index.php?title=Uluru&oldid=297882194">' +
//     "https://en.wikipedia.org/w/index.php?title=Uluru</a> " +
//     "(last visited June 22, 2009).</p>" +
//     "</div>" +
//     "</div>";
//   const infowindow = new google.maps.InfoWindow({
//     content: contentString,
//   });
//   const marker = new google.maps.Marker({
//     position: uluru,
//     map,
//     title: "Uluru (Ayers Rock)",
//   });

//   marker.addListener("click", () => {
//     infowindow.open({
//       anchor: marker,
//       map,
//       shouldFocus: false,
//     });
//   });
// }