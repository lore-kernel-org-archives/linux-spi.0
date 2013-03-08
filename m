From: "Yang, Wenyou" <Wenyou.Yang@atmel.com>
Subject: RE: [PATCH v6 01/16] spi/spi-atmel: fix probing failure after
 xfer->speed_hz set
Date: Fri, 8 Mar 2013 09:43:49 +0000
Message-ID: <B256D81BAE5131468A838E5D7A24364149720050@penmbx02>
References: <1362626715-6549-1-git-send-email-wenyou.yang@atmel.com>
 <1362626815-6628-1-git-send-email-wenyou.yang@atmel.com>
 <51388575.4050506@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Cc: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"richard.genoud@gmail.com" <richard.genoud@gmail.com>,
	"Lin, JM" <JM.Lin@atmel.com>,
	"Ferre, Nicolas" <Nicolas.FERRE@atmel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"grant.likely@secretlab.ca" <grant.likely@secretlab.ca>,
	"spi-devel-general@lists.sourceforge.net"
	<spi-devel-general@lists.sourceforge.net>,
	"plagnioj@jcrosoft.com" <plagnioj@jcrosoft.com>
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <51388575.4050506@cogentembedded.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

SGksIFNlcnFlaSwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTZXJn
ZWkgU2h0eWx5b3YgW21haWx0bzpzZXJnZWkuc2h0eWx5b3ZAY29nZW50ZW1iZWRkZWQuY29tXQ0K
PiBTZW50OiAyMDEzxOoz1MI3yNUgMjA6MTgNCj4gVG86IFlhbmcsIFdlbnlvdQ0KPiBDYzogbGlu
dXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyByaWNoYXJkLmdlbm91ZEBnbWFpbC5j
b207IExpbiwgSk07DQo+IEZlcnJlLCBOaWNvbGFzOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwu
b3JnOyBncmFudC5saWtlbHlAc2VjcmV0bGFiLmNhOw0KPiBzcGktZGV2ZWwtZ2VuZXJhbEBsaXN0
cy5zb3VyY2Vmb3JnZS5uZXQ7IHBsYWduaW9qQGpjcm9zb2Z0LmNvbQ0KPiBTdWJqZWN0OiBSZTog
W1BBVENIIHY2IDAxLzE2XSBzcGkvc3BpLWF0bWVsOiBmaXggcHJvYmluZyBmYWlsdXJlIGFmdGVy
DQo+IHhmZXItPnNwZWVkX2h6IHNldA0KPiANCj4gSGVsbG8uDQo+IA0KPiBPbiAwNy0wMy0yMDEz
IDc6MjYsIFdlbnlvdSBZYW5nIHdyb3RlOg0KPiANCj4gPiBjb21taXQ6IDA1OWI4ZmZlZWU1YjQy
Nzk0OTg3MmJiNmVkNWRiNWFlMDc4ODA1NGUNCj4gDQo+ICAgICBQbGVhc2UgYWxzbyBzcGVjaWZ5
IHRoZSBzdW1tYXJ5IGxpbmUgb2YgdGhhdCBjb21taXQgaW4gcGFyZW5zIChvciBob3dldmVyDQo+
IHlvdSBsaWtlKS4NClRoYW5rcyBmb3IgeW91ciBzdWdnZXN0aW9uLg0KDQo+IA0KPiA+IGNhdXNl
IHRoZSBhdG1lbCBzcGkgcHJvYmluZyBmYWlsdXJlLg0KPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBX
ZW55b3UgWWFuZyA8d2VueW91LnlhbmdAYXRtZWwuY29tPg0KPiA+IENjOiBzcGktZGV2ZWwtZ2Vu
ZXJhbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQNCj4gPiBDYzogbGludXgta2VybmVsQHZnZXIua2Vy
bmVsLm9yZw0KPiANCj4gV0JSLCBTZXJnZWkNCg0KQmVzdCBSZWdhcmRzLA0KV2VueW91IFlhbmcN
Cg==
