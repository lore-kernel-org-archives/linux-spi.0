From: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [RFC PATCH 2/2] mtd: m25p80: Use the SPI mem direct API to
 possibly improve performances
Date: Thu, 7 Jun 2018 17:23:45 +0200
Message-ID: <20180607172345.507e028e@xps13>
References: <20180601143603.4047-1-boris.brezillon@bootlin.com>
 <20180601143603.4047-3-boris.brezillon@bootlin.com>
 <20180607170824.6c32bfc3@xps13>
 <20180607171846.462e6639@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: Vignesh R <vigneshr@ti.com>, Richard Weinberger <richard@nod.at>,
 Cyrille Pitchen <cyrille.pitchen@microchip.com>, linux-spi@vger.kernel.org,
 Marek Vasut <marek.vasut@gmail.com>, Mark Brown <broonie@kernel.org>,
 linux-mtd@lists.infradead.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Brian Norris <computersforpeace@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>
To: Boris Brezillon <boris.brezillon@bootlin.com>
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <20180607171846.462e6639@bbrezillon>
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

SGkgQm9yaXMsCgpPbiBUaHUsIDcgSnVuIDIwMTggMTc6MTg6NDYgKzAyMDAsIEJvcmlzIEJyZXpp
bGxvbgo8Ym9yaXMuYnJlemlsbG9uQGJvb3RsaW4uY29tPiB3cm90ZToKCj4gT24gVGh1LCA3IEp1
biAyMDE4IDE3OjA4OjI0ICswMjAwCj4gTWlxdWVsIFJheW5hbCA8bWlxdWVsLnJheW5hbEBib290
bGluLmNvbT4gd3JvdGU6Cj4gCj4gPiBIaSBCb3JpcywKPiA+IAo+ID4gT24gRnJpLCAgMSBKdW4g
MjAxOCAxNjozNjowMyArMDIwMCwgQm9yaXMgQnJlemlsbG9uCj4gPiA8Ym9yaXMuYnJlemlsbG9u
QGJvb3RsaW4uY29tPiB3cm90ZToKPiA+ICAgCj4gPiA+IE1ha2UgdXNlIG9mIHRoZSBTUEkgbWVt
IGRpcmVjdCBtYXBwaW5nIEFQSS4KPiA+ID4gCj4gPiA+IFNpZ25lZC1vZmYtYnk6IEJvcmlzIEJy
ZXppbGxvbiA8Ym9yaXMuYnJlemlsbG9uQGJvb3RsaW4uY29tPgo+ID4gPiAtLS0KPiA+ID4gIGRy
aXZlcnMvbXRkL2RldmljZXMvbTI1cDgwLmMgfCAxNDkgKysrKysrKysrKysrKysrKysrKysrKysr
KystLS0tLS0tLS0tLS0tLS0tLQo+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDg5IGluc2VydGlvbnMo
KyksIDYwIGRlbGV0aW9ucygtKQo+ID4gPiAKPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbXRk
L2RldmljZXMvbTI1cDgwLmMgYi9kcml2ZXJzL210ZC9kZXZpY2VzL20yNXA4MC5jCj4gPiA+IGlu
ZGV4IDFkZDVmMDQyMGI1YS4uMjg1ZmM5NDExOGFlIDEwMDY0NAo+ID4gPiAtLS0gYS9kcml2ZXJz
L210ZC9kZXZpY2VzL20yNXA4MC5jCj4gPiA+ICsrKyBiL2RyaXZlcnMvbXRkL2RldmljZXMvbTI1
cDgwLmMKPiA+ID4gQEAgLTMxLDYgKzMxLDEwIEBACj4gPiA+ICBzdHJ1Y3QgbTI1cCB7Cj4gPiA+
ICAJc3RydWN0IHNwaV9tZW0JCSpzcGltZW07Cj4gPiA+ICAJc3RydWN0IHNwaV9ub3IJCXNwaV9u
b3I7Cj4gPiA+ICsJc3RydWN0IHsKPiA+ID4gKwkJc3RydWN0IHNwaV9tZW1fZGlybWFwX2Rlc2Mg
KndyaXRlOwo+ID4gPiArCQlzdHJ1Y3Qgc3BpX21lbV9kaXJtYXBfZGVzYyAqcmVhZDsKPiA+ID4g
Kwl9IGRpcm1hcDsKPiA+ID4gIH07ICAgIAo+ID4gCj4gPiBXaGlsZSByZWFkaW5nIHRoaXMgcGF0
Y2ggSSB3YXMgYSBiaXQgY29uZnVzZWQgd2l0aCB0aGlzIG5hbWluZy4gWW91Cj4gPiByZWZlciB0
aGVzZSBkZXNjcmlwdG9ycyBhcyAnZmxhc2gtPmRpcm1hcC0+cmVhZC93cml0ZScgd2hpY2ggaXMK
PiA+IGNvbmZ1c2luZyBhcyB0aGlzIGlzIG5vdCBhIGZ1bmN0aW9uIGJ1dCBhIGRlc2NyaXB0b3Iu
IFBhc3Npbmcgc3VjaAo+ID4gdmFyaWFibGUgdG8gYSBmdW5jdGlvbiBjYWxsZWQgc3BpX21lbWVf
ZGlybWFwX3JlYWQvd3JpdGUoKSBpcyBhbHNvCj4gPiBjb25mdXNpbmcgSU1ITyAoc2VlIGJlbG93
KS4KPiA+IAo+ID4gV291bGQgeW91IG1pbmQgcmVuYW1pbmcgdGhlbSB3aXRoIHNvbWV0aGluZyBs
aWtlICJyZWFkL3dyaXRlX2Rlc2MiPyAgCj4gCj4gU3VyZS4gSG93IGFib3V0IHJkZXNjIGFuZCB3
ZGVzYyB0byBrZWVwIHRoZSBuYW1lcyBzaG9ydD8KPiAKClN1cmUsIGl0J3MganVzdCB0byBhdm9p
ZCBoYXZpbmcgZGVzY3JpcHRvcnMgbmFtZWQgYWZ0ZXIgYWN0aW9ucyAuCgpNaXF1w6hsCgoKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51
eCBNVEQgZGlzY3Vzc2lvbiBtYWlsaW5nIGxpc3QKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcv
bWFpbG1hbi9saXN0aW5mby9saW51eC1tdGQvCg==
