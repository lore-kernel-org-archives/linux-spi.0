From: "Gupta, Pekon" <pekon@ti.com>
Subject: RE: [PATCH v5 1/8] mtd: spi-nor: copy the SPI NOR commands to a new
 header file
Date: Wed, 5 Mar 2014 07:24:21 +0000
Message-ID: <20980858CB6D3A4BAE95CA194937D5E73EAAFCDB@DBDE04.ent.ti.com>
References: <1393238262-8622-1-git-send-email-b32955@freescale.com>
 <201403042313.14353.marex@denx.de> <5316932C.5040405@freescale.com>
 <201403050443.19529.marex@denx.de> <5316B9F2.8050301@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: "angus.clark@st.com" <angus.clark@st.com>,
 "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
 "b44548@freescale.com" <b44548@freescale.com>,
 "broonie@linaro.org" <broonie@linaro.org>,
 "lee.jones@linaro.org" <lee.jones@linaro.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "b18965@freescale.com" <b18965@freescale.com>,
 "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "Poddar,
 Sourav" <sourav.poddar@ti.com>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>,
 "dwmw2@infradead.org" <dwmw2@infradead.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
To: Huang Shijie <b32955@freescale.com>, Marek Vasut <marex@denx.de>
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <5316B9F2.8050301@freescale.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

SGkgTWFyZWssIFNoaWppZSwNCg0KPkZyb206IEh1YW5nIFNoaWppZSBbbWFpbHRvOmIzMjk1NUBm
cmVlc2NhbGUuY29tXQ0KPg0KPuS6jiAyMDE05bm0MDPmnIgwNeaXpSAxMTo0MywgTWFyZWsgVmFz
dXQg5YaZ6YGTOg0KPj4gV2h5IGRpZG4ndCB5b3Uga2VlcCBpdCBsaWtlIHRoYXQ/IFdhcyB0aGVy
ZSBzb21lIHJlYXNvbiBmb3IgdGhhdCA/DQo+aHR0cDovL21hcmMuaW5mby8/bD1saW51eC1hcm0t
a2VybmVsJm09MTM4NTQ1MTgyMjMyMjIwJnc9NA0KPg0KPlBla29uIHN1Z2dlc3R0ZWQgIGRvIG5v
dCB0b3VjaCB0aGUgbTI1cDgwLmMuDQo+U28gaSBqdXN0IGNvcHkgdGhlc2UgY29tbWFuZHMgdG8g
YSBuZXcgaGVhZGVyLg0KPkFueXdheSwgaXQncyByZWFsbHkgbm90IGFuIGltcG9ydGFudCBpc3N1
ZSBmb3IgbWUuIDopDQo+DQpNeSBvcGluaW9uIHdhcyB0aGF0IHdlIHNob3VsZCBub3QgdG91Y2gg
bTI1cDgwLmMgYmVjYXVzZToNCigxKSAgQXMgbTI1cDgwIGlzIGFscmVhZHkgd29ya2luZyBmb3Ig
dmFyaW91cyB2ZW5kb3JzLiBTbyB1bmxlc3MgbXVsdGlwbGUNCiAgIHBsYXRmb3JtcyBzdGFydCB1
c2luZyBTUEkgTk9SIGZyYW1ld29yaywgbTI1cDgwLmMgc2hvdWxkIHJlbWFpbiB1bnRvdWNoZWQu
DQooMikgd2Ugc2hvdWxkIG5vdCBjbHV0dGVyIGhlYWRlciBmaWxlIHdpdGggdmVuZG9yIHNwZWNp
ZmljIG9wLWNvZGVzIGFzIHVzZWQgaW4gbTI1cDgwLg0KICAgSSB3YXMgb2YgdGhlIG9waW5pb24g
dGhhdCBpbnN0ZWFkIG9mIGhhcmQtY29kaW5nIHRoZSB2ZW5kb3Igc3BlY2lmaWMgaW5mbyBhcw0K
ICAgTUFDUk9zLCBzdWNoIGluZm9ybWF0aW9uIHNob3VsZCBiZSB0YWtlbiBmcm9tIERUIG9yIHBs
YXRmb3JtLWRhdGEuDQoNCkhvd2V2ZXIsIHRoaXMgd2FzIG15IHRob3VnaHQgZHVyaW5nIGluaXRp
YWwgdmVyc2lvbnMgb2YgU1BJIE5PUiBwYXRjaGVzLg0KQnV0IG5vdyBpZiB5b3UgdGhpbmsgdGhh
dCBTUEkgTk9SIGlzIHN0YWJsZSBlbm91Z2ggdGhhdCBzYW1lIGhlYWRlciBpbmZvDQpjYW4gYmUg
cmV1c2VkIHdpdGhvdXQgY29uZmxpY3RzLCB0aGVuIG5vIHByb2JsZW1zLg0KDQooQXBvbG9naWVz
IHRvIEh1YW5nIFNoaWppZSBmb3IgcmUtd29yayA6LSkgKS4NCg0Kd2l0aCByZWdhcmRzLCBwZWtv
bg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CkxpbnV4IE1URCBkaXNjdXNzaW9uIG1haWxpbmcgbGlzdApodHRwOi8vbGlzdHMuaW5mcmFkZWFk
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW10ZC8K
