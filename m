From: Punnaiah Choudary Kalluri <punnaiah.choudary.kalluri-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Subject: RE: [RFC PATCH 1/2] spi: Add support for Zynq QSPI controller
Date: Thu, 10 Jul 2014 09:44:44 +0000
Message-ID: <bc4868b5-1b8a-44e1-af6a-595be5fd899b@BN1BFFO11FD058.protection.gbl>
References: <1404982207-4707-1-git-send-email-harinik@xilinx.com>
	<1404982207-4707-2-git-send-email-harinik@xilinx.com>
	<CAMuHMdXO-PkQ+07F=aZEjvH1Kh7uhWK8i3V9w+1aHvvtg7wDoQ@mail.gmail.com>
 <CAFcVECJ93Lw1MRVU-=zLRbB6To--zmAxz8OLObu=mhV84-FTNA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	"Mark Rutland" <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>,
	"Brian Norris" <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	=?utf-8?B?TWFyZWsgVmHFoXV0?= <marex-ynQEQJNshbs@public.gmane.org>,
	Artem Bityutskiy <artem.bityutskiy-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	"Geert Uytterhoeven" <geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>,
	Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
	Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>,
	Michal Simek <michals-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
To: Harini Katakam <harinikatakamlinux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAFcVECJ93Lw1MRVU-=zLRbB6To--zmAxz8OLObu=mhV84-FTNA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

SEkgR3JlZXQsDQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEhhcmluaSBL
YXRha2FtIFttYWlsdG86aGFyaW5pa2F0YWthbWxpbnV4QGdtYWlsLmNvbV0NCj5TZW50OiBUaHVy
c2RheSwgSnVseSAxMCwgMjAxNCAzOjAxIFBNDQo+VG86IEdlZXJ0IFV5dHRlcmhvZXZlbg0KPkNj
OiBNYXJrIEJyb3duOyBHcmFudCBMaWtlbHk7IFJvYiBIZXJyaW5nOyBQYXdlbCBNb2xsOyBNYXJr
IFJ1dGxhbmQ7IElhbg0KPkNhbXBiZWxsOyBLdW1hciBHYWxhOyBsaW51eC1zcGk7IGxpbnV4LWtl
cm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+ZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4
LWRvY0B2Z2VyLmtlcm5lbC5vcmc7IERhdmlkIFdvb2Rob3VzZTsNCj5CcmlhbiBOb3JyaXM7IE1h
cmVrIFZhxaF1dDsgQXJ0ZW0gQml0eXV0c2tpeTsgR2VlcnQgVXl0dGVyaG9ldmVuOyBTYXNjaGEN
Cj5IYXVlcjsgSmluZ29vIEhhbjsgU291cmF2IFBvZGRhcjsgTWljaGFsIFNpbWVrOyBQdW5uYWlh
aCBDaG91ZGFyeSBLYWxsdXJpDQo+U3ViamVjdDogUmU6IFtSRkMgUEFUQ0ggMS8yXSBzcGk6IEFk
ZCBzdXBwb3J0IGZvciBaeW5xIFFTUEkgY29udHJvbGxlcg0KPg0KPkhpIEdlZXJ0LA0KPg0KPk9u
IFRodSwgSnVsIDEwLCAyMDE0IGF0IDI6NDggUE0sIEdlZXJ0IFV5dHRlcmhvZXZlbg0KPjxnZWVy
dEBsaW51eC1tNjhrLm9yZz4gd3JvdGU6DQo+PiBIaSBIYXJpbmksDQo+Pg0KPj4gT24gVGh1LCBK
dWwgMTAsIDIwMTQgYXQgMTA6NTAgQU0sIEhhcmluaSBLYXRha2FtIDxoYXJpbmlrQHhpbGlueC5j
b20+DQo+d3JvdGU6DQo+Pj4gKyAgICAgICBtYXN0ZXItPmZsYWdzID0gU1BJX01BU1RFUl9RVUFE
X01PREU7DQo+Pg0KPj4gU1BJX01BU1RFUl9RVUFEX01PREUgaXMgbm90IG9uZSBvZiB0aGUgU1BJ
X01BU1RFUl8qIGRlZmluZXMNCj4+IGluIGluY2x1ZGUvbGludXgvc3BpL3NwaS5oPw0KPj4NCj4N
Cj5JJ20gc29ycnkgYWJvdXQgdGhhdC4gVGhhdCBmbGFnIGlzIHVudXNlZCAtIHdpbGwgcmVtb3Zl
IHRoaXMgc3RhdGVtZW50Lg0KPg0KPj4+ICsgICAgICAgbWFzdGVyLT5tb2RlX2JpdHMgPSBTUElf
Q1BPTCB8IFNQSV9DUEhBIHwgU1BJX1JYX0RVQUwgfA0KPlNQSV9SWF9RVUFEIHwNCj4+PiArICAg
ICAgICAgICAgICAgICAgICAgICAgICAgU1BJX1RYX0RVQUwgfCBTUElfVFhfUVVBRDsNCj4+DQo+
PiBZb3VyIGRyaXZlciBhZHZlcnRpc2VzIER1YWwvUXVhZCBTUEkgVHJhbnNmZXIgY2FwYWJpbGl0
aWVzLCBidXQgaXQgZG9lc24ndA0KPj4gY2hlY2sgc3BpX3RyYW5zZmVyLlt0cl14X25iaXRzPyBI
b3cgY2FuIGl0IGRldGVybWluZSB3aGVuIHRvIGVuYWJsZQ0KPkR1YWwvUXVhZD8NCj4+DQo+DQo+
SGVyZSB0aGUgZHJpdmVyIGlzIGp1c3QgZ2l2aW5nIGluZm9ybWF0aW9uIHRoYXQgdGhlIGNvbnRy
b2xsZXIgc3VwcG9ydCBpdC4NCj5UaGUgTVREIGxheWVyIGVuYWJsZXMgZHVhbC9xdWFkIGJhc2Vk
IG9uIHdoYXQgdGhlIGZsYXNoIHN1cHBvcnRzOyBxdWFkDQo+YmVpbmcgdGhlIGZpcnN0IHByaW9y
aXR5DQo+SSB1bmRlcnN0YW5kIHRoYXQgdGhlIHNwaSBjb3JlIHJlYWRzIHJ4LCB0eC1idXMtd2lk
dGggcHJvcGVydHkgYW5kDQo+bWFzdGVyIHN1cHBvcnQgZmxhZ3MgYW5kDQo+cGVyZm9ybXMgdGhl
IG5lY2Vzc2FyeSBjaGVja3MuDQoNCkp1c3QgdG8gYWRkLCB0aGUgenlucSBxc3BpIGNvbnRyb2xs
ZXIgd2lsbCBhdXRvbWF0aWNhbGx5IHNlbGVjdCB0aGUgSU8gbGluZXMgYmFzZWQNCk9uIHRoZSBm
bGFzaCBjb21tYW5kLiANCg0KUmVnYXJkcywNClB1bm5haWFoDQoNCj4NCj5SZWdhcmRzLA0KPkhh
cmluaQ0K
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
