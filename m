From: "Yang, Wenyou" <Wenyou.Yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH v7 03/14] spi/spi-atmel: add physical base address
Date: Tue, 2 Apr 2013 05:49:50 +0000
Message-ID: <B256D81BAE5131468A838E5D7A24364150E8B33C@penmbx01>
References: <1363678866-3567-1-git-send-email-wenyou.yang@atmel.com>
	<1363679016-3761-1-git-send-email-wenyou.yang@atmel.com>
	<20130401134147.GV18636@opensource.wolfsonmicro.com>
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
In-Reply-To: <20130401134147.GV18636-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
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
OiAyMDEzxOo01MIxyNUgMjE6NDINCj4gVG86IFlhbmcsIFdlbnlvdQ0KPiBDYzogbGludXgtYXJt
LWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBncmFudC5saWtlbHlAc2VjcmV0bGFiLmNhOw0K
PiByaWNoYXJkLmdlbm91ZEBnbWFpbC5jb207IHBsYWduaW9qQGpjcm9zb2Z0LmNvbTsgRmVycmUs
IE5pY29sYXM7IExpbiwgSk07DQo+IHNwaS1kZXZlbC1nZW5lcmFsQGxpc3RzLnNvdXJjZWZvcmdl
Lm5ldDsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENI
IHY3IDAzLzE0XSBzcGkvc3BpLWF0bWVsOiBhZGQgcGh5c2ljYWwgYmFzZSBhZGRyZXNzDQo+IA0K
PiBPbiBUdWUsIE1hciAxOSwgMjAxMyBhdCAwMzo0MzozNlBNICswODAwLCBXZW55b3UgWWFuZyB3
cm90ZToNCj4gDQo+ID4gKysrIGIvZHJpdmVycy9zcGkvc3BpLWF0bWVsLmMNCj4gPiBAQCAtMTk2
LDYgKzE5Niw3IEBAIHN0cnVjdCBhdG1lbF9zcGlfY2FwcyB7ICBzdHJ1Y3QgYXRtZWxfc3BpIHsN
Cj4gPiAgCXNwaW5sb2NrX3QJCWxvY2s7DQo+ID4NCj4gPiArCXJlc291cmNlX3NpemVfdAkJcGh5
YmFzZTsNCj4gPiAgCXZvaWQgX19pb21lbQkJKnJlZ3M7DQo+ID4gIAlpbnQJCQlpcnE7DQo+ID4g
IAlzdHJ1Y3QgY2xrCQkqY2xrOw0KPiANCj4gVGhpcyBsb29rcyBsaWtlIHRoZSB3cm9uZyB0eXBl
Pw0KDQpJIGRvdWJsZSBjaGVja2VkLg0KDQpUaGUgdHlwZSAnIHJlc291cmNlX3NpemVfdCAnIGlz
IGRlZmluZWQgaW4gaW5jbHVkZS9saW51eC8gdHlwZXMuaCBhcyBiZWxvdywNCg0KdHlwZWRlZiBw
aHlzX2FkZHJfdCByZXNvdXJjZV9zaXplX3Q7DQoNCkkgdGhpbmsgaXQgaXMgT0suDQoNCkJlc3Qg
UmVnYXJkcywNCldlbnlvdSBZYW5nDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KT3duIHRoZSBGdXR1
cmUtSW50ZWwoUikgTGV2ZWwgVXAgR2FtZSBEZW1vIENvbnRlc3QgMjAxMwpSaXNlIHRvIGdyZWF0
bmVzcyBpbiBJbnRlbCdzIGluZGVwZW5kZW50IGdhbWUgZGVtbyBjb250ZXN0LiBDb21wZXRlIApm
b3IgcmVjb2duaXRpb24sIGNhc2gsIGFuZCB0aGUgY2hhbmNlIHRvIGdldCB5b3VyIGdhbWUgb24g
U3RlYW0uIAokNUsgZ3JhbmQgcHJpemUgcGx1cyAxMCBnZW5yZSBhbmQgc2tpbGwgcHJpemVzLiBT
dWJtaXQgeW91ciBkZW1vIApieSA2LzYvMTMuIGh0dHA6Ly9hbHRmYXJtLm1lZGlhcGxleC5jb20v
YWQvY2svMTIxMjQtMTc2OTYxLTMwMzY3LTIKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18Kc3BpLWRldmVsLWdlbmVyYWwgbWFpbGluZyBsaXN0CnNwaS1kZXZl
bC1nZW5lcmFsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldApodHRwczovL2xpc3RzLnNvdXJjZWZvcmdl
Lm5ldC9saXN0cy9saXN0aW5mby9zcGktZGV2ZWwtZ2VuZXJhbAo=
