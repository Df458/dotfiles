// ==UserScript== 
// @name           Pixiv Lazy plus
// @namespace      pixivlazyplus
// @description    provide a direct link to original image ([s] link).
// @version        0.9.0.6
// @include        http://www.pixiv.net/*
// @grant          GM_getValue
// @grant          GM_setValue
// @grant          GM_xmlhttpRequest
// @grant          GM_log
// ==/UserScript==
// version 0.9.0.6 - fix cookie issue
// version 0.9.0.5 - fix ugoira link again
// version 0.9.0.4 - restore MangaFull function 
// version 0.9.0.3 - fix clearing accessToken logic, add function to check if accessToken is still valid
// version 0.9.0.2 - fix ugoira link
// version 0.9.0.1 - disable MangaFull since pixiv checks referer for full size manga pages now.
// version 0.9 - upgrade to OAuth API + Pixiv Public API
// version 0.8.14.1 - fix new medium page layout
// version 0.8.13 - fix image response lazy link position
// version 0.8.12 - fix mypage right side lazy links
// version 0.8.11 - fix double links in medium page
// version 0.8.10 - fix double links in medium page
// version 0.8.9 - append [U] link after canvas
// version 0.8.8 - fix loading big manga URL bug introduced in 0.8.7
// version 0.8.7 - fix loading big manga URL in with PNG format
// version 0.8.6 - fix modifying big manga URL in manga page
// version 0.8.5 - fix preloading new manga URL format
// version 0.8.4 - fix detecting URL new format
// version 0.8.3 - fix detecting URL new format
// version 0.8.2 - fix detecting URL new format
// version 0.8.1 - fix detecting ugoira in prev/next
// version 0.8.0 - add ability for downloading ugoira as zip
// version 0.7.9 - fix for no profile image
// version 0.7.8 - fix for spapi return value changes
// version 0.7.7 - change [s] to [M](go directly to manga page) for manga links
// version 0.7.6 - fix prev/next [s] link
// version 0.7.5 - fix new manga page
// version 0.7.4 - fix modified images
// version 0.7.3 - fix missing session ID when it is not the end of cookie
// version 0.7.2 - fix comma in tags breaking parsing logic
// version 0.7.1 - fix iPhone API by supplying session ID
// version 0.7 - work with new sample images with iPhone API, fix old manga
// version 0.6.1 - preload manga images
// version 0.6 - change manga mode to big images
// version 0.5 - remove [b] link, add stylish style class
// version 0.4 - updated to filter new thumbnails
// version 0.3 - fix a bug, hat-tip to syosyo
// version 0.2 - updated on 2008-06-25
var pixivlink_run = 0;
var isNewManga = 1;
var postProcImg = new Array();
var preloadImg = new Array();
var Imgs = new Array();
var sessID = (/PHPSESSID=[^;]*?(?=;|$)/.exec(document.cookie) || "");
var accessToken = GM_getValue("accessToken","");
var oauthUserName = GM_getValue("userName","");
var oauthPassword = GM_getValue("passWord","");
var mangaFormat = 'jpg';

/*
String.prototype.splitCSV = function(sep) {
  for (var foo = this.split(sep = sep || ","), x = foo.length - 1, tl; x >= 0; x--) {
    if (foo[x].replace(/"\s+$/, '"').charAt(foo[x].length - 1) == '"') {
      if ((tl = foo[x].replace(/^\s+"/, '"')).length > 1 && tl.charAt(0) == '"') {
        foo[x] = foo[x].replace(/^\s*"|"\s*$/g, '').replace(/""/g, '"');
      } else if (x) {
        foo.splice(x - 1, 2, [foo[x - 1], foo[x]].join(sep));
      } else foo = foo.shift().split(sep).concat(foo);
    } else foo[x].replace(/""/g, '"');
  } return foo;
};*/

function createCookie(cookietext,days) {
    if (days) {
        var date = new Date();
        date.setTime(date.getTime()+(days*24*60*60*1000));
        var expires = "; expires="+date.toGMTString();
    }
    else var expires = "";
    document.cookie = cookietext+expires+"; path=/";
}

function doOAuth(obj) {
    var oauthUser, oauthPass, returnData;
    oauthUser = document.getElementById("oauthUsername").value;
    oauthPass = document.getElementById("oauthPassword").value;
    createCookie("PHPSESSID=",-1); // erase cookie first
    if(oauthUser && oauthPass) {
            GM_setValue("userName",oauthUser);
            GM_setValue("passWord",oauthPass);
            GM_xmlhttpRequest({
                url: 'https://oauth.secure.pixiv.net/auth/token',
                method: "POST",
                headers: {
                    Referer: "http://www.pixiv.net",
                    "Content-Type": "application/x-www-form-urlencoded"
                },
                data: "username="+oauthUser+"&password="+oauthPass+"&grant_type=password&client_id=bYGKuGVw91e0NMfPGp44euvGt59s&client_secret=HP3RmkgAmEGro0gn1x9ioawQE8WMfvLXDz3ZqxpK",
                onload: function (response) {
                    if (response.status == 200) {
                        returnData = JSON.parse(response.responseText);
                        accessToken = returnData.response.access_token;
                        GM_setValue("accessToken",accessToken);
                        alert("Login Sucessfully.");
                        createCookie(sessID,0); // restore cookie first
                        location.reload();
                    } else {
                        createCookie(sessID,0); // restore cookie first
                        alert("Login Failed!");
                    }
                }
            });
    }
}

function createOAuthLoginForm() {
var tmp, newHTML = document.createElement ('div');
newHTML.id = 'gmOAuthLoginFrm';
newHTML.style.position='absolute';
newHTML.style.backgroundColor='#fff';
newHTML.style.top='0';
newHTML.style.left='0';
newHTML.style.zIndex='100';
newHTML.appendChild(document.createTextNode('OAuth Login User: '));
tmp = document.createElement ('input');
tmp.id = 'oauthUsername';
tmp.type = 'text';
tmp.value = oauthUserName;
newHTML.appendChild(tmp);
newHTML.appendChild(document.createTextNode('Pass: '));
tmp = document.createElement ('input');
tmp.id = 'oauthPassword';
tmp.type = 'password';
tmp.value = oauthPassword;
newHTML.appendChild(tmp);
tmp = document.createElement ('input');
tmp.id = 'oauthSubmit';
tmp.type = 'button';
tmp.value='Login';
tmp.addEventListener("click", function(e){return doOAuth(e);}, false);
newHTML.appendChild(tmp);

document.body.appendChild (newHTML);
}

function checkTokenValid() {
        GM_xmlhttpRequest({
                url: 'https://public-api.secure.pixiv.net/v1/me.json',
                method: "GET",
                headers: {
                    Referer: "http://www.pixiv.net",
                    "Authorization": "Bearer " + accessToken,
                    "Cookie": sessID
            },
            onload: function (response) {
                if (response.status == 200) {
//GM_log(response.responseText);
/*                    var vals = JSON.parse(response.responseText);
                    if(vals.status == "success") {
                    }*/
                } else /*if (response.status == 400)*/ {
                    accessToken ="";
                    GM_setValue("accessToken",accessToken);
                    createOAuthLoginForm();
                }
            }
        });
}

function GetImageIDFromLink(imageLink) {
    var imgID = 0; // If lower 11319936 it means Manga does not have Big version

    var re = /\d+([_a-z0-9]+)?\.(jpe?g|gif|png)\??.*$|id=[0-9]+$/;
    var s = re.exec(imageLink);
    if (s && s.length > 0) {
        re = /\d+/;
        imgID = re.exec(s[0])[0];
    }
    return imgID;
}

function getElementsByClassName(matchClass) {
    var clselems = new Array();
    var elems = document.getElementsByTagName('*'), i;
    for (i in elems) {
        if((' ' + elems[i].className + ' ').indexOf(' ' + matchClass + ' ')
                > -1) {
            clselems.push(elems[i]);
        }
    }
    return clselems;
}

function pixivlink() {
    //alert(pixivlink_run);
    if (!pixivlink_run) pixivlink_run = 1;
    else return;
	if(!accessToken) createOAuthLoginForm();
	else checkTokenValid();
    var Items = document.getElementsByTagName('img');
    var rexa = /\?mode\=medium\&illust_id|\?mode\=big\&illust_id/;
    var rexb = /source.pixiv.net/;
    var rexc = /\/img-inf\//;
    var rexd = /\/mobile\//;
    var rexe = /\/c\//;
    for (var i = 0; i < Items.length; i++) {
        var imgR = Items[i];
        var aR = imgR.parentNode.parentNode;
        var aR2 = imgR.parentNode;
        var isThumbnail = ((' ' + aR2.className + ' ').indexOf(' _layout-thumbnail ') > -1) //&& ((' ' + aR2.className + ' ').indexOf(' ui-modal-trigger ') > -1)
//GM_log('aR2.className = "'+aR2.className+'", imgR.src='+imgR.src);
//GM_log('isThumbnail = '+isThumbnail);
        if (rexa.test(aR2.href)/* || isThumbnail*/) {
            aR = aR2;
        }
        if (rexa.test(aR.href) || isThumbnail) {
            var imgID = GetImageIDFromLink(imgR.src);
            var srcR = imgR.src.replace(/_s\.|_m\.|_100\.|_64x64\./i, ".");
//            var hrefR = aR.href.replace(/medium/i, "big");
            var tdR = aR.parentNode;
/*            var linkB = document.createElement('a');
            linkB.href = hrefR;
            linkB.target = '_blank';
            linkB.style.padding = '0 2px';
            linkB.className = '_pxlazy';
            linkB.appendChild(document.createTextNode('[b]'));
            tdR.appendChild(linkB);*/
//            tdR.appendChild(document.createTextNode(' '));
            if (!rexb.test(srcR) && Imgs.indexOf(imgID) == -1) {
                var linkS = document.createElement('a');
                linkS.href = srcR;
                linkS.target = '_blank';
                linkS.className = '_pxlazy _pxlazy_s';
                linkS.setAttribute('id', 'ill_' + imgID);
                linkS.appendChild(document.createTextNode('[s]'));
                if (aR2.tagName.toUpperCase() == 'DIV' && imgR.className.toLowerCase().indexOf('thumbnail') == -1) {
                    var targetelem = getElementsByClassName('works_display');
                    if(targetelem.length) {
                        targetelem[0].appendChild(linkS);
                    }
                } else {
                    tdR.appendChild(linkS);
                }
                if (rexc.test(imgR.src)||rexd.test(imgR.src)||rexe.test(imgR.src)) {
//GM_log("postProcImg.push("+imgID+")"+imgR.src);
                    postProcImg.push(imgID);
                }
                Imgs.push(imgID);
            }
        }
    }

    if (postProcImg.length > 0) {
        for (var x = 0; x < postProcImg.length; x++) {
            if(accessToken) GM_xmlhttpRequest({
                url: 'https://public-api.secure.pixiv.net/v1/works/' + postProcImg[x] + '.json?image_sizes=large',
                method: "GET",
                headers: {
                    Referer: "http://www.pixiv.net",
                    "Authorization": "Bearer " + accessToken,
                    "Cookie": sessID
                },
                onload: function (response) {
                    if (response.status == 200) {
                        var rexb = /source.pixiv.net/;
//                        var rexU = /\/c\//;
                        var rexU = /_ugoira/;
                        var rexe = /\/c\//;
                        var vals = JSON.parse(response.responseText);
                        /*var vtxt = '';
                        for(var x=0;x < vals.length;x++)
                            vtxt=vtxt+x+':'+vals[x]+"\n";
                            GM_log(vtxt);*/
                        if (vals.status == "success") {
                            var slnk, imgID, isRestricted;
                            isRestricted = rexb.test(vals.response[0].image_urls.large);
                            isUgoira = rexU.test(vals.response[0].image_urls.large);
//                            if (!isRestricted) {
//GM_log("imgID = vals[0]");
                                imgID = vals.response[0].id;
/*                            } else {
//GM_log("GetImageIDFromLink("+response.finalUrl+")");
                                imgID = GetImageIDFromLink(response.finalUrl);
                            }*/
                            slnk = document.getElementById('ill_' + imgID);
                            if (slnk) {
                                var goodSlink;
                                if (vals.response[0].is_manga) {
                                    goodSlink = 'http://www.pixiv.net/member_illust.php?mode=manga&illust_id=' + imgID;
                                    slnk.innerHTML = '[M]';
                                } else {
                                    var re = new RegExp('/' + imgID + '_.*$');
                                    if (isUgoira) {// grab zip!
//GM_log("isUgoira");
                                    slnk.innerHTML = '[U]';
                                        goodSlink = vals.response[0].image_urls.large.replace(/img-original/, 'img-zip-ugoira').replace(re, '/' + imgID + '_ugoira1920x1080.zip');
/*                                    } else if (rexe.test(vals[9])) {// new 480mw URL
//GM_log("480mw");
                                        goodSlink = vals[9].replace(/c\/480x960\//, '').replace(/img-master/, 'img-original').replace(re, '/' + vals[0] + '_p0.' + vals[2]);
                                    } else if (!isRestricted && !rexe.test(vals[9])) {// use 480mw instead
//GM_log("480mw");
                                        goodSlink = vals[9].replace(/mobile\//, '').replace(re, '/' + vals[0] + '.' + vals[2]);
                                    } else { //salvage from profile image
//GM_log("salvage");
                                        re = /\/[0-9_]+\..*$/;
                                        goodSlink = vals[29].replace(/mobile\//, '').replace(/profile\//, 'img/').replace(re, '/' + imgID + '.' + vals[2]);
*/
                                    } else {
                                        goodSlink = vals.response[0].image_urls.large;
                                    }
                                }
                                slnk.href = goodSlink;
								slnk.title=vals.response[0].reuploaded_time;
                                slnk.className = '_pxlazy _pxlazy_s _pxlazy_s_new';
                            }
                        }
                    } else if (response.status == 400) {
                        accessToken ="";
                        GM_setValue("accessToken",accessToken);
                    }
                }
            });
        }
    }

    var links = document.getElementsByTagName('a');
    var tagslink = /tags\.php\?tag=/;
    for (var i = 0; i < links.length; i++) {
        if (tagslink.test(links[i].href))
            links[i].href = links[i].href.replace("tags.php?tag=", "search.php?s_mode=s_tag_full&word=");
    }

    if (unsafeWindow.pixiv && unsafeWindow.pixiv.context.images) {
        var illustID = GetImageIDFromLink(unsafeWindow.pixiv.context.images[0]/*[0]*/);
        isNewManga = (illustID >= 11319936);
//GM_log("illustID="+illustID);
        
        GM_xmlhttpRequest({
                url: 'https://public-api.secure.pixiv.net/v1/works/' + illustID + '.json?image_sizes=large',
                method: "GET",
                headers: {
                    Referer: "http://www.pixiv.net",
                    "Authorization": "Bearer " + accessToken,
                    "Cookie": sessID
            },
            onload: function (response) {
                if (response.status == 200) {
GM_log(response.responseText);
                    var vals = JSON.parse(response.responseText);
                    var rexe = /\/c\//;
                    if(vals.status == "success") {
                        mangaFormat = vals.response[0].metadata.pages[0].image_urls.large.split('.').pop();
GM_log(mangaFormat);
                        /*var vtxt = '';
                        for(var x=0;x < vals.length;x++)
                            vtxt=vtxt+x+':'+vals[x]+"\n";
                            GM_log(vtxt);*/
//GM_log("2nd");
                        /*if (rexe.test(vals[9]))*/ mangaFull();
                    }
                } else if (response.status == 400) {
                    accessToken ="";
                    GM_setValue("accessToken",accessToken);
                }
            }
        });
        
        var rexe = /\/c\//;
//GM_log("isNewManga");
        //setTimeout(mangaFull,250);
//GM_log("2nd");
//        mangaFull();
    }
}

function mangaFull() {
    Items = document.getElementsByTagName('img');
    var rexe = /\/img-/;
    for (var x = 0; x < unsafeWindow.pixiv.context.images.length; x++) {
        if (isNewManga) {
            if(rexe.test(unsafeWindow.pixiv.context.images[x]))
                unsafeWindow.pixiv.context.images[x]/*[0]*/ = unsafeWindow.pixiv.context.images[x]/*[0]*/.replace(/c\/1200x1200\//, '').replace(/img-master/, 'img-original').replace(/_p(\d+).*(\.[a-zA-Z\?\d]+)$/, "_p$1."+mangaFormat);
            else
                unsafeWindow.pixiv.context.images[x]/*[0]*/ = unsafeWindow.pixiv.context.images[x]/*[0]*/.replace(/_p(\d+\.[a-zA-Z\?\d]+)$/, "_big_p$1");
        }
        preloadImg.push(new Image());
        preloadImg[preloadImg.length - 1].src = unsafeWindow.pixiv.context.images[x]/*[0]*/;
    }

    for (var x = 0; x < Items.length; x++) {
        var datasrc = Items[x].getAttribute("data-src");
        if (datasrc) {
//GM_log("original-datasrc="+datasrc+" ,mangaFormat="+mangaFormat);
            if(rexe.test(datasrc))
                datasrc = datasrc.replace(/c\/1200x1200\//, '').replace(/img-master/, 'img-original').replace(/_p(\d+).*(\.[a-zA-Z\?\d]+)$/, "_p$1."+mangaFormat);
            else
                datasrc = datasrc.replace(/_p(\d+\.[a-zA-Z\?\d]+)$/, "_big_p$1");
//GM_log("new-datasrc="+datasrc+" ,mangaFormat="+mangaFormat);
        }
        Items[x].setAttribute("data-src", datasrc);
        if (isNewManga) {
//GM_log(x+".src="+Items[x].src);
            if(datasrc)
                Items[x].src = datasrc;
            else if(rexe.test(Items[x].src))
                Items[x].src = Items[x].src.replace(/c\/1200x1200\//, '').replace(/img-master/, 'img-original').replace(/_p(\d+).*(\.[a-zA-Z\?\d]+)$/, "_p$1$2");
            else
                Items[x].src = datasrc ? datasrc : Items[x].src.replace(/_p(\d+\.[a-zA-Z\?\d]+)$/, "_big_p$1");
        }
    }
}

window.addEventListener("load", pixivlink, true);