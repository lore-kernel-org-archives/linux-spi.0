From: Trent Piepho <tpiepho-cgc2CodaaHDQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 4/4] spi: orion: Software control for inter-word delays
Date: Thu, 15 Feb 2018 17:18:08 +0000
Message-ID: <1518715087.25567.68.camel@impinj.com>
References: <bc8bf712358fbb000ea7e2ea9e1aec42b21988e6.1518704854.git.jan.kundrat@cesnet.cz>
         <475b63c52b17187089d3f2ecf8ff4b8c45a7e58b.1518704854.git.jan.kundrat@cesnet.cz>
         <20180215151907.GD8374@sirena.org.uk>
         <c5d27950-0d13-422c-afe9-990b4adad45a@cesnet.cz>
         <20180215154945.GF8374@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: "Chris.Packham-6g8wRflRTwXFdCa3tKVlE6U/zSkkHjvu@public.gmane.org"
        <Chris.Packham-6g8wRflRTwXFdCa3tKVlE6U/zSkkHjvu@public.gmane.org>,
        "m-karicheri2-l0cyMroinI0@public.gmane.org" <m-karicheri2-l0cyMroinI0@public.gmane.org>,
        "andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        "grygorii.strashko-l0cyMroinI0@public.gmane.org" <grygorii.strashko-l0cyMroinI0@public.gmane.org>,
        "gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org"
        <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
        "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "christophe.jaillet-39ZsbGIQGT5GWvitb5QawA@public.gmane.org" <christophe.jaillet-39ZsbGIQGT5GWvitb5QawA@public.gmane.org>,
        "geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org" <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
To: "broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        "jan.kundrat-xoNZbkdr4U2lVyrhU4qvOw@public.gmane.org" <jan.kundrat-xoNZbkdr4U2lVyrhU4qvOw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20180215154945.GF8374-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Content-Language: en-US
Content-ID: <F2DBAE7E0361514CBD1AD22831B286A9-+1mpgTUVCH2cE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

T24gVGh1LCAyMDE4LTAyLTE1IGF0IDE1OjQ5ICswMDAwLCBNYXJrIEJyb3duIHdyb3RlOg0KPiBP
biBUaHUsIEZlYiAxNSwgMjAxOCBhdCAwNDo0NTo1NVBNICswMTAwLCBKYW4gS3VuZHLDoXQgd3Jv
dGU6DQo+IA0KPiA+IE15IG1vc3QgaW1wb3J0YW50IHVzZSBjYXNlIGlzLCBob3dldmVyLCB0aGUg
dXNlcnNwYWNlLWZhY2luZyBzcGlkZXYsIGFuZCBpdHMNCj4gPiBpb2N0bCBjb21wbGljYXRlcyBz
dHVmZiBhIGJpdC4gVGhlIHJlbGV2YW50IHN0cnVjdCBoYXMgYSAxNmJpdCBwYWRkaW5nIG5vdw0K
PiA+ICh1c2VkIHRvIGJlIDMyYml0IHByaW9yIHRvIGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5v
cmcvcGF0Y2gvMzcxNTM5MS8pLiBJcw0KPiA+IGl0IE9LIHRvIHVzZSB0aGlzIHBhZGRpbmcgZm9y
IHRoaXMgZmVhdHVyZT8gT3Igc2hvdWxkIEkgcGVyaGFwcyBlYXQganVzdA0KPiA+IDhiaXRzIGFu
ZCBsaW1pdCB0aGUgZGVsYXlzIHRvIGFuIGFyYml0cmFyeSB2YWx1ZSBvZiAyNTV1cz8gT3Igc2hv
dWxkIEkgbm90DQo+ID4gY2FyZSBhYm91dCB0aGF0IG5vdyBhbmQgbGV0IHNvbWVib2R5IGVsc2Ug
Y29tZSB1cCB3aXRoIGFub3RoZXIgImJpZ2dlciINCj4gPiBpb2N0bCB3aGVuIHRoZXkgbmVlZCB0
aGF0IHNwYWNlPw0KPiANCj4gVWdoLiAgVXNpbmcgdGhlIHdob2xlIHBhZGRpbmcgaXMgcHJvYmFi
bHkgT0suDQoNClRoZXJlIGNvdWxkIGJlIGEgZmxhZyB0aGF0IHN3aXRjaGVzIGRlbGF5X3VzIGZy
b20gYmVpbmcgYSBwb3N0IHhmZXINCmRlbGF5IHRvIGJlaW5nIGEgcG9zdCB3b3JkIGRlbGF5LiBU
aGVuIG5vIG5lZWQgZmllbGQgbmVlZHMgdG8gYmUgYWRkZWQuDQogSWYgc29tZW9uZSB3YW50cyBi
b3RoIGEgcG9zdCB3b3JkIGFuZCBwb3N0IHhmZXIgZGVsYXkgaW4gdGhlIHNhbWUNCnhmZXIsIHRo
ZW4gdGhleSdsbCBqdXN0IG5lZWQgdG8gc3BsaXQgaXQsIHdoaWNoIHNob3VsZCBiZSBwb3NzaWJs
ZQ0Kc2luY2UgaXQgbXVzdCBiZSBsb25nZXIgdGhhbiBvbmUgd29yZCB0byBuZWVkIGEgZGVsYXkg
YWZ0ZXIgZWFjaCB3b3JkLg0KDQpOb3QgdGhhdCBncmVhdCBlaXRoZXIu
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
