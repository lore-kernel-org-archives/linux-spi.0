From: Chris Brandt <Chris.Brandt-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Subject: RE: [PATCH] spi: rspi: Increase accuracy of bit rate for RZ
Date: Mon, 29 Aug 2016 16:21:38 +0000
Message-ID: <SG2PR06MB1165A5B9BD0ACFE5E34D4F708AE10@SG2PR06MB1165.apcprd06.prod.outlook.com>
References: <1470404163-27427-1-git-send-email-chris.brandt@renesas.com>
 <CAMuHMdWVvZLWvVVzHMr+5--PAJkGx0r-Z1=eCiGJddcY6aDNLA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Linux-Renesas <linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>,
        Daniel Palmer <danieruru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAMuHMdWVvZLWvVVzHMr+5--PAJkGx0r-Z1=eCiGJddcY6aDNLA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-US
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

SGkgR2VlcnQsDQoNCk9uIE1vbiwgQXVnIDI5LCAyMDE2LCBHZWVydCBVeXR0ZXJob2V2ZW4gd3Jv
dGU6DQo+IEkgYmVsaWV2ZSB0aGlzIGFwcGxpZXMgbm90IG9ubHkgdG8gUlosIGJ1dCB0byBhbGwg
b3RoZXIgc3VwcG9ydGVkIFJTUEkgdmFyaWFudHM/DQo+IEhlbmNlIEkgdGhpbmsgaXQgc2hvdWxk
IGJlIG1hZGUgY29tbW9uLg0KDQpJIHdvdWxkIHRoaW5rIGl0IHdvdWxkIGJlIHRoZSBzYW1lIGZv
ciBhbGwgdGhlIG90aGVyIHBhcnRzIHdpdGggUlNQSS4NCg0KQ3VycmVudGx5IHRoZXJlIGFyZSAz
IHNlcGFyYXRlIGNvbmZpZyBmdW5jdGlvbnM6DQogLSByc3BpX3NldF9jb25maWdfcmVnaXN0ZXIN
CiAtIHJzcGlfcnpfc2V0X2NvbmZpZ19yZWdpc3Rlcg0KIC0gcXNwaV9zZXRfY29uZmlnX3JlZ2lz
dGVyDQoNCkJ5ICJjb21tb24iLCBkbyB5b3UgbWVhbjoNCkEpIGFkZCB0aGUgc2FtZSBjb2RlIHRv
IGVhY2ggb2YgdGhlIG90aGVyIDIgZnVuY3Rpb25zPw0KICAgICAoaWUsIGNvbW1vbiBmdW5jdGlv
bmFsaXR5IGZvciBhbGwgZGV2aWNlKQ0KDQpCKSBtYWtlIHNvbWUgbmV3IGZ1bmN0aW9uL21hY3Jv
IHRoYXQgYWxsIGNvbmZpZyBmdW5jdGlvbnMgY2FsbD8NCiAgICAgKGllLCBzYW1lIGNvZGUgZm9y
IHNldHRpbmcgdGhlIHJlZ2lzdGVyIGJpdHMpDQoNCg0KTm90ZTogSSBvbmx5IHJlYWxseSBoYXZl
IGEgUlovQSBwbGF0Zm9ybSwgc28gSSBjYW4ndCByZWFsbHkgdGVzdCBpdCBvbiBhbnkgb3RoZXIg
ZGV2aWNlcyAob3RoZXIgdGhhbiBqdXN0IGxvb2tpbmcgaW4gdGhlIGhhcmR3YXJlIG1hbnVhbHMp
DQoNCkNocmlzDQoNCg0K
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
