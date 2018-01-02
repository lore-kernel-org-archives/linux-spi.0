From: Trent Piepho <tpiepho-cgc2CodaaHDQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 2/3] dt-bindings: mtd: atmel-quadspi: add an optional
 property 'dmacap,memcpy'
Date: Tue, 2 Jan 2018 19:18:58 +0000
Message-ID: <1514920738.26695.171.camel@impinj.com>
References: <cover.1514087323.git.cyrille.pitchen@wedev4u.fr>
         <143542c61ca674d53da4985bbabc142e8e6ebefc.1514087323.git.cyrille.pitchen@wedev4u.fr>
         <20171226232330.trljk2ofyvu4ly3n@rob-hp-laptop>
         <0149ba05-64b1-2739-e61f-78d5170775fb@wedev4u.fr>
         <20180102102234.GG2612@rfolt0960.corp.atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: "nicolas.ferre-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org" <nicolas.ferre-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>,
        "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
        "radu.pirea-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org" <radu.pirea-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>,
        "linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org" <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>,
        "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>,
        "computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        "boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org"
        <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
        "vigneshr-l0cyMroinI0@public.gmane.org" <vigneshr-l0cyMroinI0@public.gmane.org>,
        "marek.vasut-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <marek.vasut-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        "richard-/L3Ra7n9ekc@public.gmane.org" <r
To: "cyrille.pitchen-yU5RGvR974pGWvitb5QawA@public.gmane.org" <cyrille.pitchen-yU5RGvR974pGWvitb5QawA@public.gmane.org>,
        "ludovic.desroches-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org" <ludovic.desroches-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20180102102234.GG2612-fC2aZbRiGnsAAwgTK2POJVCF2YAvjlIb@public.gmane.org>
Content-Language: en-US
Content-ID: <3810E1B0D4C84545933E0F2072FEFB05-+1mpgTUVCH2cE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

T24gVHVlLCAyMDE4LTAxLTAyIGF0IDExOjIyICswMTAwLCBMdWRvdmljIERlc3JvY2hlcyB3cm90
ZToNCj4gT24gV2VkLCBEZWMgMjcsIDIwMTcgYXQgMTA6NDA6MDBQTSArMDEwMCwgQ3lyaWxsZSBQ
aXRjaGVuIHdyb3RlOg0KPiANCj4gPiBPciBtYXliZSBubyBjaGFuZ2UgYXQgYWxsIGlzIHJlcXVp
cmVkIGF0IHRoZSBhdF94ZG1hYy5jIGRyaXZlciBzaWRlOiB3ZQ0KPiA+IGp1c3QgZG9uJ3QgY2Fy
ZSBhYm91dCB0aGUgcHJvdmlkZWQgZmxhZ3MgaW4gdGhlICJkbWFzIiBwcm9wZXJ0eSwgZXNwZWNp
YWxseQ0KPiA+IHRoZSAicGVyaXBoZXJhbCBpZCIuIFRoZXkgd291bGQgYmUgaWdub3JlZCBhbnl3
YXkgd2hlbiB0aGUgYXRtZWwtcXVhZHNwaS5jDQo+ID4gZHJpdmVyIGxhdGVyIGNhbGxzIGRtYWVu
Z2luZV9wcmVwX2RtYV9tZW1jcHkoKS4gU28gSSBjb3VsZCBzaW1wbHkgc2V0IHRoZQ0KPiA+IGRt
YSBjZWxscyB0byAwIGluIHRoZSBkZXZpY2UtdHJlZT8NCj4gPiANCj4gPiBMdWRvdmljLCB3aGF0
IGRvIHlvdSB0aGluayBhYm91dCB0aGF0ID8NCj4gDQo+IEl0IG1heSB3b3JrIGJ1dCBJIHdvbid0
IGRvIHRoaXMuIFVzdWFsbHksIGNoYW5uZWxzIHJlcXVlc3RlZCB0aHJvdWdoIHRoZSB4bGF0ZQ0K
PiBmdW5jdGlvbiBoYXZlIHVzdWFsbHkgdGhlaXIgY2FwYWlibGl0aWVzIHNldCB0byBETUFfU0xB
VkUgYW5kIG5vdCBETUFfTUVNQ1BZLg0KPiBJbiB0aGUgYXRfeGRtYWMgY2FzZSwgaXQgd29uJ3Qg
YmUgYW4gaXNzdWUgYnV0IGlmIHlvdSBoYXZlIGEgY29udHJvbGxlcg0KPiB3aGljaCBoYXMgY2hh
bm5lbHMgd2hpY2ggY2FuIHN1cHBvcnQgb25seSBtZW0tdG8tbWVtIG9yIHBlcmlwaGVyYWwsIGl0
DQo+IHdvbid0IHdvcmsuDQoNCk1heWJlIG9uZSBjb3VsZCBjcmVhdGUgYW4gIkFUOTFfWERNQUNf
RFRfIiBtYWNybyB0byBpbmRpY2F0ZSBhIG1lbWNweQ0KY2hhbm5lbC4gIFRoZXJlIGFyZSBzdGls
bCB1bnVzZWQgYml0cyBmb3IgYW5vdGhlciBmbGFnLiAgSXQgYWxzbyBsb29rcw0KbGlrZSBhdF94
ZG1hIHVzZXMgcGVyaXBoZXJhbCBpZCAweDNmIGZvciBtZW1jcHkgdHJhbnNmZXJzICh3aWxsIHRo
YXQNCndvcmsgd2l0aCBtZW1jcHkgRE1BIG9uIG11bHRpcGxlIGNoYW5uZWxzIGF0IHRoZSBzYW1l
IHRpbWU/KS4gIFNvDQpwZXJoYXBzIHBlcmlkIDB4M2YgY291bGQgYmUgdGhlIGluZGljYXRpb24g
b2Ygd2FudGluZyBhIG1lbWNweSBjaGFubmVsLA0KcmF0aGVyIHRoYW4gYW5vdGhlciBmbGFnIGJp
dC4gIEJ1dCBob3dldmVyIGl0J3MgZG9uZSwgb25lIHdyaXRlczoNCg0KZG1hcyA9IDwmZG1hMCBB
VDkxX1hETUFDX0RUX01FTUNQWT47IGRtYS1uYW1lcyA9ICJyeC10eCI7DQoNCkkgdGhpbmsgb25l
IGNvdWxkIGhhdmUgdGhlIHF1YWRzcGkgZHJpdmVyIGF1dG9tYXRpY2FsbHkgZmlsbCBpbiB0aGUg
ZG1hDQpjZWxsIGluIHRoZSBkbWEgc3BlY2lmaWVyIGlmIGl0IGlzIG5vdCBwcmVzZW50IGluIHRo
ZSBkZXZpY2UgdHJlZS4gIFNvDQpvbmUgY291bGQgd3JpdGUgImRtYXMgPSA8JmRtYTA+IiBhbmQg
dGhlIGRyaXZlciBhZGRzIHRoZQ0KQVQ5MV9YRE1BQ19EVF9NRU1DUFkgY2VsbCBiZWZvcmUgeGxh
dGluZy4gIEknbSBub3Qgc3VyZSBpZiB0aGF0J3MgYQ0KZ29vZCBpZGVhIG9yIG5vdC4=
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
