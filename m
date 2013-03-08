From: "Yang, Wenyou" <Wenyou.Yang@atmel.com>
Subject: RE: [PATCH v5 01/16] spi/spi-atmel: fix master->num_chipselect
 wrongly set.
Date: Fri, 8 Mar 2013 00:59:43 +0000
Message-ID: <B256D81BAE5131468A838E5D7A2436414971AE03@penmbx02>
References: <1361861289-30332-1-git-send-email-wenyou.yang@atmel.com>
 <1361861289-30332-2-git-send-email-wenyou.yang@atmel.com>
 <20130302231535.8E6043E35BE@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Cc: "Ferre, Nicolas" <Nicolas.FERRE@atmel.com>,
	"plagnioj@jcrosoft.com" <plagnioj@jcrosoft.com>,
	"richard.genoud@gmail.com" <richard.genoud@gmail.com>,
	"Lin, JM" <JM.Lin@atmel.com>,
	"spi-devel-general@lists.sourceforge.net"
	<spi-devel-general@lists.sourceforge.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
To: Grant Likely <grant.likely@secretlab.ca>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130302231535.8E6043E35BE@localhost>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBHcmFudCBMaWtlbHkgW21haWx0
bzpnbGlrZWx5QHNlY3JldGxhYi5jYV0gT24gQmVoYWxmIE9mIEdyYW50IExpa2VseQ0KPiBTZW50
OiAyMDEzxOoz1MIzyNUgNzoxNg0KPiBUbzogWWFuZywgV2VueW91OyBsaW51eC1hcm0ta2VybmVs
QGxpc3RzLmluZnJhZGVhZC5vcmcNCj4gQ2M6IEZlcnJlLCBOaWNvbGFzOyBwbGFnbmlvakBqY3Jv
c29mdC5jb207IHJpY2hhcmQuZ2Vub3VkQGdtYWlsLmNvbTsgTGluLCBKTTsNCj4gWWFuZywgV2Vu
eW91OyBzcGktZGV2ZWwtZ2VuZXJhbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQ7DQo+IGxpbnV4LWtl
cm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NSAwMS8xNl0gc3Bp
L3NwaS1hdG1lbDogZml4IG1hc3Rlci0+bnVtX2NoaXBzZWxlY3QNCj4gd3JvbmdseSBzZXQuDQo+
IA0KPiBPbiBUdWUsIDI2IEZlYiAyMDEzIDE0OjQ3OjU0ICswODAwLCBXZW55b3UgWWFuZyA8d2Vu
eW91LnlhbmdAYXRtZWwuY29tPg0KPiB3cm90ZToNCj4gPiBpZiB0aGUgc3BpIHByb3BlcnR5ICJj
cy1ncGlvcyIgaXMgc2V0IGFzIGJlbG93Og0KPiA+DQo+ID4gCWNzLWdwaW9zID0gPDA+LCA8JnBp
b0MgMTEgMD4sIDwwPiwgPDA+Ow0KPiA+DQo+ID4gdGhlIG1hc3Rlci0+bnVtX2NoaXBzZWxlY3Qg
d2lsbCB3cm9uZ2x5IGJlIHNldCB0byAwLA0KPiA+IGFuZCB0aGUgc3BpIGZhaWwgdG8gcHJvYmUu
DQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBXZW55b3UgWWFuZyA8d2VueW91LnlhbmdAYXRtZWwu
Y29tPg0KPiA+IENjOiBzcGktZGV2ZWwtZ2VuZXJhbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQNCj4g
PiBDYzogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiANCj4gSSB0aGluayBJJ3ZlIGdv
dCB0aGlzIGJ1ZyBmaXhlZCBpbiB0aGUgY29yZSBzcGkgY29kZS4gR2l2ZSBpdCBhIGNvdXBsZQ0K
PiBvZiBkYXlzIGFuZCByZXRlc3Qgd2l0aCBsaW51eC1uZXh0Lg0KSGkgR3JhbnQsDQoNClllcywg
aW4gdjMuOS1yYzEgdGhpcyBidWcgZml4ZWQsIEkgcmV0ZXN0ZWQgb24gdjMuOS1yYzEuDQpCdXQg
b24gInNwaS9uZXh0IiBnaXQgdHJlZSwgaXQgc2hvdWxkIHRvIGFwcGx5IHRoaXMgcGF0Y2guDQoN
Ckkgc2VudCB0aGUgcGF0Y2hlcyB2ZXJzaW9uIDYsIGNvdWxkIHlvdSB0YWtlIGEgbG9vayB0aGVt
PyANClRoYW5rcyBhIGxvdCBmb3IgeW91ciB3b3JrLg0KDQo+IA0KPiBnLg0KDQpCZXN0IFJlZ2Fy
ZHMsDQpXZW55b3UgWWFuZw0K
