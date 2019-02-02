From: <Tudor.Ambarus@microchip.com>
Subject: Re: [PATCH v3 08/13] spi: atmel-quadspi: drop unused and NOP transfer
 macros
Date: Sat, 2 Feb 2019 08:46:38 +0000
Message-ID: <0e266a16-2f84-e1c3-440f-55105dd0c0be@microchip.com>
References: <20190202040653.1217-1-tudor.ambarus@microchip.com>
 <20190202040653.1217-9-tudor.ambarus@microchip.com>
 <20190202081338.01056dce@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: <broonie@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <Cyrille.Pitchen@microchip.com>,
        <bugalski.piotr@gmail.com>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>
To: <bbrezillon@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190202081338.01056dce@bbrezillon>
Content-Language: en-US
Content-ID: <5B6E79892AFBFB4DAE576B1B50674CEB@namprd11.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

DQoNCk9uIDAyLzAyLzIwMTkgMDk6MTMgQU0sIEJvcmlzIEJyZXppbGxvbiB3cm90ZToNCj4gT24g
U2F0LCAyIEZlYiAyMDE5IDA0OjA3OjMzICswMDAwDQo+IDxUdWRvci5BbWJhcnVzQG1pY3JvY2hp
cC5jb20+IHdyb3RlOg0KPiANCj4+IEZyb206IFR1ZG9yIEFtYmFydXMgPHR1ZG9yLmFtYmFydXNA
bWljcm9jaGlwLmNvbT4NCj4+DQo+PiBSZW1vdmUgTk9QIHdoZW4gc2V0dGluZyByZWFkIHRyYW5z
ZmVyIHR5cGUuIFJlbW92ZSB1c2VsZXNzDQo+PiBzZXR0aW5nIG9mIHdyaXRlIHRyYW5zZmVyIHR5
cGUgd2hlbg0KPj4gb3AtPmRhdGEuZGlyID09IFNQSV9NRU1fREFUQV9JTiAmJiAhb3AtPmRhdGEu
bmJ5dGVzLg0KPj4NCj4+IFFTUElfSUZSX1RGUlRZUF9UUlNGUl9XUklURSBpcyBzcGVjaWZpYyBq
dXN0IHRvIHNhbWE1ZDIgcXNwaSwNCj4+IHJlbmFtZSBpdCB0byBRU1BJX0lGUl9TQU1BNUQyX1dS
SVRFX1RSU0ZSLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IFR1ZG9yIEFtYmFydXMgPHR1ZG9yLmFt
YmFydXNAbWljcm9jaGlwLmNvbT4NCj4+IC0tLQ0KPj4gdjM6IG5ldyBwYXRjaA0KPj4NCj4+ICBk
cml2ZXJzL3NwaS9hdG1lbC1xdWFkc3BpLmMgfCAxMiArKystLS0tLS0tLS0NCj4+ICAxIGZpbGUg
Y2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCA5IGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL3NwaS9hdG1lbC1xdWFkc3BpLmMgYi9kcml2ZXJzL3NwaS9hdG1lbC1xdWFk
c3BpLmMNCj4+IGluZGV4IGQyNmQ0Y2QwZTM2Yi4uYmZhNWY1ZTkyZDk2IDEwMDY0NA0KPj4gLS0t
IGEvZHJpdmVycy9zcGkvYXRtZWwtcXVhZHNwaS5jDQo+PiArKysgYi9kcml2ZXJzL3NwaS9hdG1l
bC1xdWFkc3BpLmMNCj4+IEBAIC0xMTMsMTEgKzExMyw3IEBADQo+PiAgI2RlZmluZSBRU1BJX0lG
Ul9PUFRMXzRCSVQgICAgICAgICAgICAgICgyIDw8IDgpDQo+PiAgI2RlZmluZSBRU1BJX0lGUl9P
UFRMXzhCSVQgICAgICAgICAgICAgICgzIDw8IDgpDQo+PiAgI2RlZmluZSBRU1BJX0lGUl9BRERS
TCAgICAgICAgICAgICAgICAgIEJJVCgxMCkNCj4+IC0jZGVmaW5lIFFTUElfSUZSX1RGUlRZUF9N
QVNLICAgICAgICAgICAgR0VOTUFTSygxMywgMTIpDQo+PiAtI2RlZmluZSBRU1BJX0lGUl9URlJU
WVBfVFJTRlJfUkVBRCAgICAgICgwIDw8IDEyKQ0KPj4gLSNkZWZpbmUgUVNQSV9JRlJfVEZSVFlQ
X1RSU0ZSX1JFQURfTUVNICAoMSA8PCAxMikNCj4+IC0jZGVmaW5lIFFTUElfSUZSX1RGUlRZUF9U
UlNGUl9XUklURSAgICAgKDIgPDwgMTIpDQo+PiAtI2RlZmluZSBRU1BJX0lGUl9URlJUWVBfVFJT
RlJfV1JJVEVfTUVNICgzIDw8IDEzKQ0KPj4gKyNkZWZpbmUgUVNQSV9JRlJfU0FNQTVEMl9XUklU
RV9UUlNGUglCSVQoMTMpDQo+IA0KPiBDYW4geW91IGRlZmluZSBRU1BJX0lGUl9URlJUWVBfTUVN
IChiaXQgMTIpIGV2ZW4gaWYgaXQncyBub3QgdXNlZCB5ZXQ/DQoNClNob3VsZG4ndCBiZSBpbnRy
b2R1Y2VkIHdpdGggdGhlIGRpciBtYXAgc3VwcG9ydD8NCg==
