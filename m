From: "Yang, Wenyou" <Wenyou.Yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH v7 06/14] spi/spi-atmel: add flag to controller data for
	lock operations
Date: Wed, 3 Apr 2013 05:09:53 +0000
Message-ID: <B256D81BAE5131468A838E5D7A24364150E8CC7B@penmbx01>
References: <1363678866-3567-1-git-send-email-wenyou.yang@atmel.com>
	<1363679163-3897-1-git-send-email-wenyou.yang@atmel.com>
	<20130401134613.GY18636@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Cc: "richard.genoud-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <richard.genoud-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Lin,
	JM" <JM.Lin-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, "Ferre, Nicolas" <Nicolas.FERRE-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	"plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org" <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20130401134613.GY18636-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

SGksIE1hcmssDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWFyayBC
cm93biBbbWFpbHRvOmJyb29uaWVAb3BlbnNvdXJjZS53b2xmc29ubWljcm8uY29tXQ0KPiBTZW50
OiAyMDEzxOo01MIxyNUgMjE6NDYNCj4gVG86IFlhbmcsIFdlbnlvdQ0KPiBDYzogbGludXgtYXJt
LWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBncmFudC5saWtlbHlAc2VjcmV0bGFiLmNhOw0K
PiByaWNoYXJkLmdlbm91ZEBnbWFpbC5jb207IHBsYWduaW9qQGpjcm9zb2Z0LmNvbTsgRmVycmUs
IE5pY29sYXM7IExpbiwgSk07DQo+IHNwaS1kZXZlbC1nZW5lcmFsQGxpc3RzLnNvdXJjZWZvcmdl
Lm5ldDsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENI
IHY3IDA2LzE0XSBzcGkvc3BpLWF0bWVsOiBhZGQgZmxhZyB0byBjb250cm9sbGVyIGRhdGEgZm9y
IGxvY2sNCj4gb3BlcmF0aW9ucw0KPiANCj4gT24gVHVlLCBNYXIgMTksIDIwMTMgYXQgMDM6NDY6
MDNQTSArMDgwMCwgV2VueW91IFlhbmcgd3JvdGU6DQo+IA0KPiA+ICtzdGF0aWMgdm9pZCBhdG1l
bF9zcGlfbG9jayhzdHJ1Y3QgYXRtZWxfc3BpICphcykgew0KPiA+ICsJCXNwaW5fbG9ja19pcnFz
YXZlKCZhcy0+bG9jaywgYXMtPmZsYWdzKTsgfQ0KPiANCj4gQ29kaW5nIHN0eWxlLg0KSSB3aWxs
IGNoYW5nZSBpdCBpbiBuZXh0IHZlcnNpb24uDQoNCj4gDQo+ID4gLQlzcGluX3VubG9jaygmYXMt
PmxvY2spOw0KPiA+ICsJYXRtZWxfc3BpX3VubG9jayhhcyk7DQo+ID4gIAltc2ctPmNvbXBsZXRl
KG1zZy0+Y29udGV4dCk7DQo+ID4gLQlzcGluX2xvY2soJmFzLT5sb2NrKTsNCj4gPiArCWF0bWVs
X3NwaV9sb2NrKGFzKTsNCj4gDQo+IFRoaXMgcmVwbGFjZXMgbm9uLWlycXNhdmUgdmVyc2lvbnMg
d2l0aCBpcnFzYXZlIHZlcnNpb25zIG9mIHRoZSBsb2NrLg0KPiBJcyB0aGlzIHNhZmUvY29ycmVj
dD8gIElmIGl0IGlzIEknZCBoYXZlIGV4cGVjdGVkIHNvbWUgc29ydCBvZiBtZW50aW9uIG9mIGl0
IGluIHRoZQ0KPiBjb21taXQgbG9nLg0KSSB3aWxsIGFkZCBzb21lIGNvbW1pdCBsb2cuDQoNCkJl
c3QgUmVnYXJkcywNCldlbnlvdSBZYW5nDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KTWluaW1pemUg
bmV0d29yayBkb3dudGltZSBhbmQgbWF4aW1pemUgdGVhbSBlZmZlY3RpdmVuZXNzLgpSZWR1Y2Ug
bmV0d29yayBtYW5hZ2VtZW50IGFuZCBzZWN1cml0eSBjb3N0cy5MZWFybiBob3cgdG8gaGlyZSAK
dGhlIG1vc3QgdGFsZW50ZWQgQ2lzY28gQ2VydGlmaWVkIHByb2Zlc3Npb25hbHMuIFZpc2l0IHRo
ZSAKRW1wbG95ZXIgUmVzb3VyY2VzIFBvcnRhbApodHRwOi8vd3d3LmNpc2NvLmNvbS93ZWIvbGVh
cm5pbmcvZW1wbG95ZXJfcmVzb3VyY2VzL2luZGV4Lmh0bWwKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18Kc3BpLWRldmVsLWdlbmVyYWwgbWFpbGluZyBsaXN0
CnNwaS1kZXZlbC1nZW5lcmFsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldApodHRwczovL2xpc3RzLnNv
dXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby9zcGktZGV2ZWwtZ2VuZXJhbAo=
