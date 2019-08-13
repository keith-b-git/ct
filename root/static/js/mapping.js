
 //   var geocoder = new mxn.Geocoder('openlayers',showLocation,alert('not found'));
   







function locate()
{
    address = new Object();
    address.street = document.getElementById('locationform').address1.value+' '+document.getElementById('locationform').address2.value+' '+document.getElementById('locationform').town.value+' '+document.getElementById('locationform').county.value+' '+document.getElementById('locationform').postcode.value;
//alert (document.getElementById('locationform').address1.value+','+document.getElementById('locationform').address2.value+','+document.getElementById('locationform').town.value+','+document.getElementById('locationform').postcode.value);

//    address.locality = document.getElementById('locationform').town.value;
 //   address.region = document.getElementById('locationform').county.value;
    address.country = document.getElementById('locationform').country.value;
	geocoder.geocode(address);
	
	}


function onConvertGridRef()
{
	var gr=document.getElementById('locationform').grid_ref.value;
	var osgb = new GT_OSGB();
	if (osgb.parseGridRef(gr))
	{
		var wgs84=osgb.getWGS84();
		document.getElementById('locationform').latitude.value = wgs84.latitude;
		document.getElementById('locationform').longitude.value = wgs84.longitude;
//		parent.showpoint();
	}
	else
	{
		document.getElementById('locationform').latitude.value = "n/a";
		document.getElementById('locationform').longitude.value = "n/a";
	}

}
function onConvertDecimal()
{
	var latitude=parseFloat(document.getElementById('locationform').latitude.value);
	var longitude=parseFloat(document.getElementById('locationform').longitude.value);
	var wgs84 = new GT_WGS84();
	wgs84.setDegrees(latitude, longitude);
	if (wgs84.isGreatBritain())
	{
		var osgb=wgs84.getOSGB();
		var gridref = osgb.getGridRef(5);
		document.getElementById('locationform').grid_ref.value = gridref;
	}
	else
	{
		document.getElementById('locationform').grid_ref.value = "outside GB";
	}

}
