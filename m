From: "Yang, Wenyou" <Wenyou.Yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH v6 01/16] spi/spi-atmel: fix probing failure after
	xfer->speed_hz set
Date: Tue, 7 May 2013 01:11:17 +0000
Message-ID: <B256D81BAE5131468A838E5D7A24364154238AF5@penmbx02>
References: <1362626715-6549-1-git-send-email-wenyou.yang@atmel.com>
	<1362626815-6628-1-git-send-email-wenyou.yang@atmel.com>
	<CAGhQ9VwW18LXY5Jn0FUFCaAzKxP1W3QADG=JBp9JbgaAwo=F2Q@mail.gmail.com>
	<B256D81BAE5131468A838E5D7A24364154236AB5@penmbx02>
	<CACQ1gAhZO3stjrwf5SiZf7jOO8T5bAJZiz97M7+7vwFmk2e65g@mail.gmail.com>
	<5182414F.1000201@atmel.com>
	<20130506103105.GB13472@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Cc: Richard Genoud <richard.genoud-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Joachim Eastwood <manabian-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	"spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	"plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org" <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, "Lin,
	JM" <JM.Lin-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "Ferre, Nicolas" <Nicolas.FERRE-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20130506103105.GB13472-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
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

SGksIE1hcmsNCg0KPiBGcm9tOiBNYXJrIEJyb3duIFttYWlsdG86YnJvb25pZUBrZXJuZWwub3Jn
XQ0KPiBTZW50OiAyMDEzxOo11MI2yNUgMTg6MzENCj4gVG86IEZlcnJlLCBOaWNvbGFzDQo+IENj
OiBncmFudC5saWtlbHlAc2VjcmV0bGFiLmNhOyBHcmFudCBMaWtlbHk7IFJpY2hhcmQgR2Vub3Vk
OyBZYW5nLCBXZW55b3U7DQo+IEpvYWNoaW0gRWFzdHdvb2Q7IGxpbnV4LWFybS1rZXJuZWxAbGlz
dHMuaW5mcmFkZWFkLm9yZzsNCj4gcGxhZ25pb2pAamNyb3NvZnQuY29tOyBMaW4sIEpNOyBzcGkt
ZGV2ZWwtZ2VuZXJhbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQ7DQo+IGxpbnV4LWtlcm5lbEB2Z2Vy
Lmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NiAwMS8xNl0gc3BpL3NwaS1hdG1l
bDogZml4IHByb2JpbmcgZmFpbHVyZSBhZnRlcg0KPiB4ZmVyLT5zcGVlZF9oeiBzZXQNCj4gDQo+
IE9uIFRodSwgTWF5IDAyLCAyMDEzIGF0IDEyOjM0OjU1UE0gKzAyMDAsIE5pY29sYXMgRmVycmUg
d3JvdGU6DQo+IA0KPiA+IENhbiB5b3UgdGVsbCB1cyBpZiB0aGlzIFNQSSBwYXRjaCB3aWxsIGJl
IG1lcmdlZCB1cHN0cmVhbSB1c2luZyBvbmUgb2YNCj4gPiB5b3VyIHBhdGhzPw0KPiANCj4gSSBo
YXZlIG5vIGlkZWEgd2hhdCBwYXRjaCB0aGlzIGlzIGJ1dCBpZiBpdCdzIG5vdCBpbiBteSB0cmVl
IC1uZXh0IGl0J3MgdW5saWtlbHkgdG8gYmUNCj4gbWVyZ2VkLg0KVGhpcyBpcyBkcm9wcGVkIHBh
dGNoLCBubyBuZWVkIHRvIGJlIG1lcmdlZC4NCg0KV2UgdGVzdGVkIEF0bWVsIHNwaSBpbiB5b3Vy
IHRyZWUtbmV4dCAsIGJ1dCBpdCBkb2Vzbid0IHdvcmssIHRoZSByZWFzb24gaXMgdGhlIEpvYWNo
aW0gRWFzdHdvb2QncyBwYXRjaCBpcyBub3QgaW5jbHVkZWQuIA0KaHR0cHM6Ly9wYXRjaHdvcmsu
a2VybmVsLm9yZy9wYXRjaC8yMTY1MzAxLw0Kd2hpY2ggSm9hY2hpbSBzYWlkIHRoYXQgR3JhbnQg
c2FpZCBoZSBhcHBsaWVkLg0KDQpUaGFua3MNCg0KQmVzdCBSZWdhcmRzLA0KV2VueW91IFlhbmcN
Ci0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpMZWFybiBHcmFwaCBEYXRhYmFzZXMgLSBEb3dubG9hZCBG
UkVFIE8nUmVpbGx5IEJvb2sKIkdyYXBoIERhdGFiYXNlcyIgaXMgdGhlIGRlZmluaXRpdmUgbmV3
IGd1aWRlIHRvIGdyYXBoIGRhdGFiYXNlcyBhbmQgCnRoZWlyIGFwcGxpY2F0aW9ucy4gVGhpcyAy
MDAtcGFnZSBib29rIGlzIHdyaXR0ZW4gYnkgdGhyZWUgYWNjbGFpbWVkIApsZWFkZXJzIGluIHRo
ZSBmaWVsZC4gVGhlIGVhcmx5IGFjY2VzcyB2ZXJzaW9uIGlzIGF2YWlsYWJsZSBub3cuIApEb3du
bG9hZCB5b3VyIGZyZWUgYm9vayB0b2RheSEgaHR0cDovL3Auc2YubmV0L3NmdS9uZW90ZWNoX2Qy
ZF9tYXkKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Kc3Bp
LWRldmVsLWdlbmVyYWwgbWFpbGluZyBsaXN0CnNwaS1kZXZlbC1nZW5lcmFsQGxpc3RzLnNvdXJj
ZWZvcmdlLm5ldApodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby9z
cGktZGV2ZWwtZ2VuZXJhbAo=
