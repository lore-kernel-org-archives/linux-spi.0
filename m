From: Schrempf Frieder <frieder.schrempf@kontron.de>
Subject: Re: [PATCH v6 1/9] ARM: dts: Reflect change of FSL QSPI driver and
 remove unused properties
Date: Tue, 27 Nov 2018 14:51:07 +0000
Message-ID: <145763f0-1e5c-3886-a11f-b37677715989@kontron.de>
References: <1543314174-28580-1-git-send-email-frieder.schrempf@kontron.de>
 <1543314174-28580-2-git-send-email-frieder.schrempf@kontron.de>
 <20181127110134.7xdwo7ird44qj2ih@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: Mark Rutland <mark.rutland@arm.com>,
        "yogeshnarayan.gaur@nxp.com" <yogeshnarayan.gaur@nxp.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "david.wolfe@nxp.com" <david.wolfe@nxp.com>,
        Li Yang <leoyang.li@nxp.com>,
        "richard@nod.at" <richard@nod.at>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        "han.xu@nxp.com" <han.xu@nxp.com>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
To: =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?=
        <u.kleine-koenig@pengutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181127110134.7xdwo7ird44qj2ih@pengutronix.de>
Content-Language: en-US
Content-ID: <5841465BB16FB44B85413D4E8E3104D8@snt-world.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

SGkgVXdlLA0KDQpJIGFjY2lkZW50YWxseSByZXBsaWVkIHRvIHRoZSBNVEQgbGlzdCBvbmx5LCBt
aXNzaW5nIHRoZSBvdGhlciANCnJlY2lwaWVudHMsIGVhcmxpZXIgdG9kYXkuIFNvIGhlcmUgY29t
ZXMgdGhlIHJlcGx5IGFnYWluLg0KDQpPbiAyNy4xMS4xOCAxMjowMSwgVXdlIEtsZWluZS1Lw7Zu
aWcgd3JvdGU6DQo+IEhlbGxvLA0KPiANCj4gT24gVHVlLCBOb3YgMjcsIDIwMTggYXQgMTA6MjQ6
MTlBTSArMDAwMCwgU2NocmVtcGYgRnJpZWRlciB3cm90ZToNCj4+IFRoZSBGU0wgUVNQSSBkcml2
ZXIgd2lsbCBiZSBtb3ZlZCB0byB0aGUgU1BJIGZyYW1ld29yayBhbmQgaXQgdGhlbg0KPj4gYWN0
cyBhcyBhIFNQSSBjb250cm9sbGVyLiBUaGVyZWZvcmUgdGhlIHN1Ym5vZGVzIG5lZWQgdG8gc2V0
DQo+PiBzcGktW3J4L3R4XS1idXMtd2lkdGggPSA8ND4sIHNvIHF1YWQgbW9kZSBpcyB1c2VkIGp1
c3QgYXMgYmVmb3JlLg0KPj4NCj4+IEFsc28gdGhlIHByb3BlcnRpZXMgJ2J1cy1udW0nLCAnZnNs
LHNwaS1udW0tY2hpcHNlbGVjdHMnIGFuZA0KPj4gJ2ZzbCxzcGktZmxhc2gtY2hpcHNlbGVjdHMn
IHdlcmUgbmV2ZXIgcmVhZCBieSB0aGUgZHJpdmVyIGFuZA0KPj4gY2FuIGJlIHJlbW92ZWQuDQo+
Pg0KPj4gVGhlICdyZWcnIHByb3BlcnRpZXMgYXJlIGFkanVzdGVkIHRvIHJlZmxlY3Qgd2hhdCBi
dXMgYW5kDQo+PiBjaGlwc2VsZWN0IHRoZSBmbGFzaCBpcyBjb25uZWN0ZWQgdG8sIGFzIHRoZSBu
ZXcgZHJpdmVyIG5lZWRzDQo+PiB0aGlzIGluZm9ybWF0aW9uLg0KPj4NCj4+IFRoZSBwcm9wZXJ0
eSAnZnNsLHFzcGktaGFzLXNlY29uZC1jaGlwJyBpcyBub3QgbmVlZGVkIGFueW1vcmUNCj4+IGFu
ZCB3aWxsIGJlIHJlbW92ZWQgYWZ0ZXIgdGhlIG9sZCBkcml2ZXIgd2FzIGRpc2FibGVkIHRvIGF2
b2lkDQo+PiBicmVha2luZyBsczEwMjFhLW1veGEtdWMtODQxMGEuZHRzLg0KPj4NCj4+IFNpZ25l
ZC1vZmYtYnk6IEZyaWVkZXIgU2NocmVtcGYgPGZyaWVkZXIuc2NocmVtcGZAa29udHJvbi5kZT4N
Cj4gDQo+IGRvIHdlIG5lZWQgdG8gY2hhbmdlIHRoZSBiaW5kaW5nIGRvY3VtZW50IGFjY29yZGlu
Z2x5Pw0KDQpCaW5kaW5ncyBhcmUgY2hhbmdlZCBoZXJlOiBodHRwczovL3BhdGNod29yay5vemxh
YnMub3JnL3BhdGNoLzEwMDM3NjEvDQoNClRoYW5rcywNCkZyaWVkZXI=
