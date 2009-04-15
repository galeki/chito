var s2uTab = function(tabContainer, eventType, initial){
  if (typeof tabContainer == 'string') tabContainer = document.getElementById(tabContainer);
  eventType = 'on' + eventType;

  var dts = tabContainer.getElementsByTagName('dt');
  var dds = tabContainer.getElementsByTagName('dd');
	var pp = initial;
	addClass(dts[pp], 'current');
	var dth = dts[pp].clientHeight;
	var ddh = dds[pp].clientHeight;

	tabContainer.style.height = dth + ddh + 'px';

	for (var i = 0; i < dts.length; ++i){
		if (i != initial) dds[i].style.display = 'none';
		(function(){
			var p = i;
			dts[p][eventType] = function(){
				if (p != pp){
					addClass(dts[p], 'current');
					removeClass(dts[pp], 'current');
					dds[p].style.display = 'block';
					dds[pp].style.display = 'none';
					ddh = dds[p].clientHeight;
					tabContainer.style.height = dth + ddh + 'px';
				}
				pp = p;
				return false;
			}
		})();
	}
	if (ielt7){
		for (var i = 1; i < dts.length; ++i){
			tabContainer.insertBefore(dts[i], dds[0]) 
		}
		if (dts[initial + 1]) dts[initial + 1][eventType]();
		else dts[initial - 1][eventType]();
		dts[initial][eventType]();
	}
}

var ielt7 = document.all && navigator.userAgent.indexOf('MSIE 7') < 0 && !window.opera;

var hasClass = function(ele,cls) {
	return ele.className.match(new RegExp('(\\s|^)'+cls+'(\\s|$)'));
}
var addClass = function(ele,cls) {
	if (!this.hasClass(ele,cls)) ele.className += " "+cls;
}
var removeClass = function(ele,cls) {
	if (hasClass(ele,cls)) {
		var reg = new RegExp('(\\s|^)'+cls+'(\\s|$)');
		ele.className=ele.className.replace(reg,' ');
	}
}
