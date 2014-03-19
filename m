From: "Yang, Wenyou" <Wenyou.Yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH 2/7] spi: atmel: Let spi core validate Tx/Rx buffers for
 non-zero length transfer
Date: Wed, 19 Mar 2014 04:01:51 +0000
Message-ID: <B256D81BAE5131468A838E5D7A2436417301250E@penmbx01>
References: <1395201227.16346.1.camel@phoenix>
 <1395201313.16346.3.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1395201313.16346.3.camel@phoenix>
Content-Language: en-US
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQXhlbCBMaW4gW21haWx0
bzpheGVsLmxpbkBpbmdpY3MuY29tXQ0KPiBTZW50OiBXZWRuZXNkYXksIE1hcmNoIDE5LCAyMDE0
IDExOjU1IEFNDQo+IFRvOiBNYXJrIEJyb3duDQo+IENjOiBZYW5nLCBXZW55b3U7IGxpbnV4LXNw
aUB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogW1BBVENIIDIvN10gc3BpOiBhdG1lbDogTGV0
IHNwaSBjb3JlIHZhbGlkYXRlIFR4L1J4IGJ1ZmZlcnMgZm9yDQo+IG5vbi16ZXJvIGxlbmd0aCB0
cmFuc2Zlcg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQXhlbCBMaW4gPGF4ZWwubGluQGluZ2ljcy5j
b20+DQpBY2tlZC1ieTogV2VueW91LllhbmcgPHdlbnlvdS55YW5nQGF0bWVsLmNvbT4NCj4gLS0t
DQo+ICBkcml2ZXJzL3NwaS9zcGktYXRtZWwuYyB8IDUgLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2Vk
LCA1IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvc3BpL3NwaS1hdG1l
bC5jIGIvZHJpdmVycy9zcGkvc3BpLWF0bWVsLmMgaW5kZXgNCj4gYmRhOTYxZS4uYzU0NDkyYiAx
MDA2NDQNCj4gLS0tIGEvZHJpdmVycy9zcGkvc3BpLWF0bWVsLmMNCj4gKysrIGIvZHJpdmVycy9z
cGkvc3BpLWF0bWVsLmMNCj4gQEAgLTEwNjUsMTEgKzEwNjUsNiBAQCBzdGF0aWMgaW50IGF0bWVs
X3NwaV9vbmVfdHJhbnNmZXIoc3RydWN0DQo+IHNwaV9tYXN0ZXIgKm1hc3RlciwNCj4gDQo+ICAJ
YXMgPSBzcGlfbWFzdGVyX2dldF9kZXZkYXRhKG1hc3Rlcik7DQo+IA0KPiAtCWlmICghKHhmZXIt
PnR4X2J1ZiB8fCB4ZmVyLT5yeF9idWYpICYmIHhmZXItPmxlbikgew0KPiAtCQlkZXZfZGJnKCZz
cGktPmRldiwgIm1pc3Npbmcgcnggb3IgdHggYnVmXG4iKTsNCj4gLQkJcmV0dXJuIC1FSU5WQUw7
DQo+IC0JfQ0KPiAtDQo+ICAJaWYgKHhmZXItPmJpdHNfcGVyX3dvcmQpIHsNCj4gIAkJYXNkID0g
c3BpLT5jb250cm9sbGVyX3N0YXRlOw0KPiAgCQliaXRzID0gKGFzZC0+Y3NyID4+IDQpICYgMHhm
Ow0KPiAtLQ0KPiAxLjguMy4yDQo+IA0KPiANCg0K
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
