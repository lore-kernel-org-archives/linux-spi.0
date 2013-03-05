From: "Manjunathappa, Prakash" <prakash.pm@ti.com>
Subject: RE: [PATCH v2 1/4] spi/davinci: add DT binding documentation
Date: Tue, 5 Mar 2013 13:45:46 +0000
Message-ID: <A73F36158E33644199EB82C5EC81C7BC3EA4856F@DBDE01.ent.ti.com>
References: <1362401955-9616-1-git-send-email-prakash.pm@ti.com>
 <1362401955-9616-2-git-send-email-prakash.pm@ti.com>
 <6918845.dALXSKksQd@wuerfel>
 <A73F36158E33644199EB82C5EC81C7BC3EA4854E@DBDE01.ent.ti.com>
 <5135F316.6030007@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: Arnd Bergmann <arnd@arndb.de>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"spi-devel-general@lists.sourceforge.net"
	<spi-devel-general@lists.sourceforge.net>,
	"davinci-linux-open-source@linux.davincidsp.com"
	<davinci-linux-open-source@linux.davincidsp.com>,
	"linux@arm.linux.org.uk" <linux@arm.linux.org.uk>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"devicetree-discuss@lists.ozlabs.org"
	<devicetree-discuss@lists.ozlabs.org>,
	"rob.herring@calxeda.com" <rob.herring@calxeda.com>,
	"grant.likely@secretlab.ca" <grant.likely@secretlab.ca>,
	"Karicheri, Muralidharan" <m-karicheri2@ti.com>,
	"rob@landley.net" <rob@landley.net>, "hs@denx.de" <hs@denx.de>
To: "Nori, Sekhar" <nsekhar@ti.com>
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <5135F316.6030007@ti.com>
Content-Language: en-US
Sender: linux-doc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

T24gVHVlLCBNYXIgMDUsIDIwMTMgYXQgMTg6NTg6NTQsIE5vcmksIFNla2hhciB3cm90ZToNCj4g
DQo+IA0KPiBPbiAzLzUvMjAxMyA2OjI2IFBNLCBNYW5qdW5hdGhhcHBhLCBQcmFrYXNoIHdyb3Rl
Og0KPiA+IEhpIEFybmQsDQo+ID4gDQo+ID4gT24gTW9uLCBNYXIgMDQsIDIwMTMgYXQgMjE6NTk6
MTYsIEFybmQgQmVyZ21hbm4gd3JvdGU6DQo+ID4+IE9uIE1vbmRheSAwNCBNYXJjaCAyMDEzIDE4
OjI5OjEyIE1hbmp1bmF0aGFwcGEsIFByYWthc2ggd3JvdGU6DQo+ID4+PiBkaWZmIC0tZ2l0IGEv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NwaS9zcGktZGF2aW5jaS50eHQgYi9E
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc3BpL3NwaS1kYXZpbmNpLnR4dA0KPiA+
Pj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gPj4+IGluZGV4IDAwMDAwMDAuLmE2MmQ3YTgNCj4g
Pj4+IC0tLSAvZGV2L251bGwNCj4gPj4+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9zcGkvc3BpLWRhdmluY2kudHh0DQo+ID4+PiBAQCAtMCwwICsxLDUxIEBADQo+ID4+
PiArRGF2aW5jaSBTUEkgY29udHJvbGxlciBkZXZpY2UgYmluZGluZ3MNCj4gPj4+ICsNCj4gPj4+
ICtSZXF1aXJlZCBwcm9wZXJ0aWVzOg0KPiA+Pj4gKy0gI2FkZHJlc3MtY2VsbHM6IG51bWJlciBv
ZiBjZWxscyByZXF1aXJlZCB0byBkZWZpbmUgYSBjaGlwIHNlbGVjdA0KPiA+Pj4gKwlhZGRyZXNz
IG9uIHRoZSBTUEkgYnVzLiBTaG91bGQgYmUgc2V0IHRvIDEuDQo+ID4+PiArLSAjc2l6ZS1jZWxs
czogc2hvdWxkIGJlIHplcm8uDQo+ID4+PiArLSBjb21wYXRpYmxlOg0KPiA+Pj4gKwktICJ0aSxk
bTY0NHgtc3BpIiBmb3IgU1BJIHVzZWQgc2ltaWxhciB0byB0aGF0IG9uIERNNjQ0eCBTb0MgZmFt
aWx5DQo+ID4+PiArCS0gInRpLGRhOHh4LXNwaSIgZm9yIFNQSSB1c2VkIHNpbWlsYXIgdG8gdGhh
dCBvbiBEQTh4eCBTb0MgZmFtaWx5DQo+ID4+DQo+ID4+IEluIGdlbmVyYWwsIHlvdSBzaG91bGQg
YXZvaWQgd2lsZGNhcmRzIGluICJjb21wYXRpYmxlIiBwcm9wZXJ0aWVzLg0KPiA+PiBCZXR0ZXIg
dXNlIHRoZSBudW1iZXIgb2YgdGhlIGZpcnN0IGNoaXAgdGhhdCBpbnRyb2R1Y2VkIHRoZSBzcGVj
aWZpYw0KPiA+PiB2ZXJzaW9uIG9mIHRoZSBkZXZpY2UuDQo+ID4+DQo+ID4gDQo+ID4gQ29ycmVj
dCwgd2lsbCBhY2NvbW1vZGF0ZSB0aGlzIGNoYW5nZS4NCj4gDQo+IEJ1dCBub3RlIHRoYXQgdGhp
cyBwYXRjaCBpcyBqdXN0IGRvY3VtZW50aW5nIGJpbmRpbmdzIGFscmVhZHkgYWNjZXB0ZWQNCj4g
YW5kIHBhcnQgb2Yga2VybmVsLiBZb3UgcHJvYmFibHkgbmVlZCBhbm90aGVyIHBhdGNoIHdoaWNo
IGZpeGVzIHRoZQ0KPiBpbmNvcnJlY3QgYmluZGluZ3MgYW5kIHRoaXMgb25lIGNhbiB0aGVuIGRv
Y3VtZW50IGluIGZpeGVkIGJpbmRpbmdzLg0KPiANCg0KQ29ycmVjdCBTZWtoYXIgSSBtZWFudCB0
aGUgc2FtZS4gSSB3aWxsIGhhdmUgcGF0Y2ggZm9yIGRyaXZlciB0byBhY2NvbW1vZGF0ZQ0KYWJv
dmUgY2hhbmdlIGFuZCBhIHBhdGNoIGZvciBtaXNzaW5nIGJpbmRpbmcgZG9jdW1lbnQuDQoNClRo
YW5rcywNClByYWthc2gNCg0KPiBUaGFua3MsDQo+IFNla2hhcg0KPiANCg0K
