From: Schrempf Frieder <frieder.schrempf@kontron.De>
Subject: Re: [PATCH v4 01/10] spi: Add a driver for the Freescale/NXP QuadSPI
 controller
Date: Tue, 13 Nov 2018 13:56:53 +0000
Message-ID: <134abbb1-57fb-0450-3087-8d28609c36b3@kontron.de>
References: <1541601809-16950-1-git-send-email-frieder.schrempf@kontron.de>
 <1541601809-16950-2-git-send-email-frieder.schrempf@kontron.de>
 <VI1PR04MB57269B88E1A064F6429D410999C20@VI1PR04MB5726.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "richard@nod.at" <richard@nod.at>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        David Wolfe <david.wolfe@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Prabhakar Kushwaha <prabhakar.kushwaha@nxp.com>,
        "Han Xu" <han.xu@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "Frieder Schrempf" <frieder.schrempf@exceet.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <VI1PR04MB57269B88E1A064F6429D410999C20@VI1PR04MB5726.eurprd04.prod.outlook.com>
Content-Language: en-US
Content-ID: <907125CF1118794283A47AA55D5C04EE@snt-world.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

SGkgWW9nZXNoLA0KDQpPbiAxMy4xMS4xOCAwOToyMiwgWW9nZXNoIE5hcmF5YW4gR2F1ciB3cm90
ZToNClsuLi5dDQo+PiArDQo+PiArc3RhdGljIHZvaWQgZnNsX3FzcGlfcmVhZF9haGIoc3RydWN0
IGZzbF9xc3BpICpxLCBjb25zdCBzdHJ1Y3QNCj4+ICtzcGlfbWVtX29wICpvcCkgew0KPj4gKwkv
Kg0KPj4gKwkgKiBXZSB3YW50IHRvIGF2b2lkIG5lZWRpbmcgdG8gaW52YWxpZGF0ZSB0aGUgY2Fj
aGUgYnkgaXNzdWVpbmcNCj4+ICsJICogYSByZXNldCB0byB0aGUgQUhCIGFuZCBTZXJpYWwgRmxh
c2ggZG9tYWluLCBhcyB0aGlzIG5lZWRzDQo+PiArCSAqIHRpbWUuIFNvIHdlIGNoYW5nZSB0aGUg
YWRkcmVzcyBvbiBlYWNoIHJlYWQgdG8gdHJpZ2dlciBhbg0KPj4gKwkgKiBhY3R1YWwgcmVhZCBv
cGVyYXRpb24gb24gdGhlIGZsYXNoLiBUaGUgYWN0dWFsIGFkZHJlc3MgZm9yDQo+PiArCSAqIHRo
ZSBmbGFzaCBtZW1vcnkgaXMgc2V0IGJ5IHByb2dyYW1taW5nIHRoZSBMVVQuDQo+PiArCSAqLw0K
PiBBcyBkaXNjdXNzZWQgcHJldmlvdXNseSwgcGxlYXNlIGdvIGF3YXkgd2l0aCB0aGlzIGhhY2sg
YW5kIHVzZSBBSEIgYnVzIGludmFsaWRhdGlvbiBtZXRob2Qgd2l0aCBzbWFsbGVyIHRpbWVvdXQg
dmFsdWUuDQo+IA0KPiBJIHdvdWxkIHN0YXJ0IGRvaW5nIHZhbGlkYXRpb24gb2YgdGhpcyBwYXRj
aCBzZXJpZXMgZnJvbSBuZXh0IHZlcnNpb24gb253YXJkLiBBcyB5b3UgaGF2ZSBtZW50aW9uZWQg
aW4gb3RoZXIgbWFpbCBkaXNjdXNzaW9uIGFib3V0IGlzc3VlIGluIHRoZSBicmVhayBjb25kaXRp
b24gZm9yIGZ1bmN0aW9uICBmc2xfcXNwaV9yZWFkbF9wb2xsX3RvdXQoKS4NCg0KVGhhbmsgeW91
IGZvciB5b3VyIGNvbW1lbnRzLiBJIGp1c3Qgc2VudCB2NSB3aXRoIHNvbWUgZml4ZXMsIGluY2x1
ZGluZyANCmZpeGVkIGZzbF9xc3BpX3JlYWRsX3BvbGxfdG91dCgpLg0KDQpJIGFsc28gcmVtb3Zl
ZCB0aGUgaGFjayBhYm92ZSBhbmQgSSdtIHByb3Blcmx5IHJlc2V0dGluZyB0aGUgQUhCIGRvbWFp
biANCm5vdy4gSSdtIHVzaW5nIGEgMXVzIGRlbGF5IGp1c3QgbGlrZSBpbiB0aGUgb2xkIGRyaXZl
ci4gSW4gbXkgdGVzdHMgdGhlIA0KcGVyZm9ybWFuY2UgaW1wYWN0IHdhcyB2ZXJ5IHNtYWxsICh+
MiUpIGFuZCBpdCBkaWRuJ3QgZ2V0IGJldHRlciB3aGVuIA0KdXNpbmcgbmRlbGF5Lg0KDQpUaGFu
a3MsDQpGcmllZGVy
