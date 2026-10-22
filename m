Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=188.68.39.254
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792675481;
	b=Y+fBsaO+cEScx2GIXH77oqBdOhSH/rkUPZiOprvLdO7pp8H6++bfCX3jpF9XobOMq0OT
	 9O39qLianzdbexX1Ly9GdSpoJ7kgL4btGvJDyciOmQ+kCI68F2iZ20Hc5dwZ1JK2tCrS1
	 ggZzwWJuh1mr9RpJrxwN6EP/Q55BJrwd4KXDDqxcAGYG+I/aajB8o8iHRAeZvuUIqhsyU
	 LUKIRQ42fBWM6GIqMiV+iBrIHgoVhKikSAeDEfjXgCs0oWN9+PjYW7gdroh7ZRfphpxXw
	 DM+4qH3RYPIv2nmxctsia0GNxBohBctAxtOaH4pB56FspXgMXretLtfJYjoMsVMJXJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792675481;
	h=DMARC-Filter:DKIM-Signature:X-secureTransport-forwarded:From:
	 Complaints-To:To:CC:Subject:Thread-Topic:Thread-Index:Date:Message-ID:
	 References:In-Reply-To:Accept-Language:Content-Language:
	 X-MS-Has-Attach:X-MS-TNEF-Correlator:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=v05ZIqnku0GHaJKR3tI3adEDyHJ/1SXZvwlQME+SFNs=;
	b=lNhbPQsFoDeU3wzAu2y/YKwwjAHdtOJMb4+xqF57tNrpVDEkR4cNjdW/S1R/QqjExv6R
	 TJahUqYHz1oNFeI8MtHQvM2BBBwmA9fDWA2hIKqACWTB5vEupvM+QFTtbBd2WOB/A1V1z
	 AaKtdnHu6JvEDwl/3TSxsSngL0W5DmJC2tMR6a55doTPqVI05ZCbkus5reiQjZCoJJfHV
	 F3PQ91YkNREZXItD65p1sW8uvV/DLunOktvYzA6W0U49P5ujR47/V6Nkh8pPTcRHQjF9p
	 kB8XwQQlskzIyh1lfyntlgz5gVQK8inebE2uqKEKLXbSM5EbQjgRwuAAgjzoHjkU4xw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=dh-electronics.com;
	spf=pass smtp.mailfrom=dh-electronics.com;
	dkim=pass header.d=dh-electronics.com header.i=@dh-electronics.com header.a=rsa-sha256 header.s=dhelectronicscom header.b="ryxfwYS/";
	arc=none smtp.remote-ip=188.68.39.254
Received: from mx2.securetransport.de (mx2.securetransport.de [188.68.39.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A619606A329;
	Thu, 22 Oct 2026 13:24:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6A619606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dh-electronics.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dh-electronics.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=dh-electronics.com header.i=@dh-electronics.com header.a=rsa-sha256 header.s=dhelectronicscom header.b=ryxfwYS/
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
	s=dhelectronicscom; t=1792675417;
	bh=v05ZIqnku0GHaJKR3tI3adEDyHJ/1SXZvwlQME+SFNs=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=ryxfwYS/s+YzRNbUCr9JFnLUeC8x41M3pWi67C0Vp0cm2O7zhIaS0RY+oAdd/77lf
	 U7I+R8aVhAn2Q/qDqPT6EIl3AXfpgTKJmTnCx3et5aJpcamWV82UEN02Bjs3edcBXa
	 ZVMKm/SAyIPxBpH6B80fWQ0v7PxLYzMZROoSUl532EYH/Q6cAZbBQpNRbac2CRlHNC
	 CEyYS/ZoGsqFaE7xtEKRiphJF5t4Y/JOGjtJWA7nTqJ+wH/o/7Hxr2g2wZdeT5kL5D
	 bhkEauN0ElHtdyTzM43r77nQBs0RrCQlArdTI5iFXC3aiCpguH9UTmMfM6l6IfBKW9
	 MbpBuyPSSYBdw==
X-secureTransport-forwarded: yes
From: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Complaints-To: abuse@cubewerk.de
To: Marek Vasut <marex@nabladev.com>, Conor Dooley <conor@kernel.org>
CC: "Frank.Li@oss.nxp.com" <Frank.Li@oss.nxp.com>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, Guenter Roeck <linux@roeck-us.net>, Jonathan Cameron
	<jonathan.cameron@oss.qualcomm.com>, Frank Li <Frank.Li@nxp.com>, "Ashish
 Yadav" <ashish.yadav@infineon.com>, Colin Huang <u8813345@gmail.com>, "Sanman
 Pradhan" <psanman@juniper.net>, Thorsten Blum <blum@kernel.org>, Troy
 Mitchell <troy.mitchell@linux.dev>, Eddie James <eajames@linux.ibm.com>,
	Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>, "open list:SPI SUBSYSTEM"
	<linux-spi@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE
 TREE BINDINGS" <devicetree@vger.kernel.org>, kernel
	<kernel@dh-electronics.com>, open list <linux-kernel@vger.kernel.org>, "Mark
 Brown" <broonie@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Subject: RE: [PATCH 1/1] dt-bindings: spi: Add separate binding for
 dh,dhcom-board
Thread-Topic: [PATCH 1/1] dt-bindings: spi: Add separate binding for
 dh,dhcom-board
Thread-Index: AQHdXhJ4wetEp3c+RUWeUdg1WJlLHbcAlj2AgAL8T4CAACG3gIABW++AgAFa0RD///l1AIADLsHg
Date: Thu, 22 Oct 2026 13:23:33 +0000
Message-ID: <420d783dcdf44abf81d09931bd514b3f@dh-electronics.com>
References: <20261016205718.877668-1-Frank.Li@oss.nxp.com>
 <e7095176-44b8-4838-8443-2e515d34cb25@nabladev.com>
 <20261018-freeway-twitch-e813208aa9af@spud>
 <fd15f846-94d4-44d8-a42d-5f13a7b18794@nabladev.com>
 <20261019-cycling-unnatural-c1adbfb5c9d9@spud>
 <05e66d8f57a44c9aa87cac1c35e82184@dh-electronics.com>
 <087bdc09-cf57-444e-aa29-f977998b0024@nabladev.com>
In-Reply-To: <087bdc09-cf57-444e-aa29-f977998b0024@nabladev.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

RnJvbTogTWFyZWsgVmFzdXQgPG1hcmV4QG5hYmxhZGV2LmNvbT4NClNlbnQ6IFR1ZXNkYXksIE9j
dG9iZXIgMjAsIDIwMjYgNDo0MSBQTQ0KPj4+Pj4+PiArKysgYi9Eb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3Mvc3BpL2RoLGRoY29tLWJvYXJkLnlhbWwNCj4+Pj4+Pj4gQEAgLTAsMCAr
MSw0NiBAQA0KPj4+Pj4+PiArIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vbmx5
IE9SIEJTRC0yLUNsYXVzZQ0KPj4+Pj4+PiArJVlBTUwgMS4yDQo+Pj4+Pj4+ICstLS0NCj4+Pj4+
Pj4gKyRpZDogaHR0cDovL2RldmljZXRyZWUub3JnL3NjaGVtYXMvc3BpL2RoLGRoY29tLWJvYXJk
LnlhbWwjDQo+Pj4+Pj4+ICskc2NoZW1hOiBodHRwOi8vZGV2aWNldHJlZS5vcmcvbWV0YS1zY2hl
bWFzL2NvcmUueWFtbCMNCj4+Pj4+Pj4gKw0KPj4+Pj4+PiArdGl0bGU6IERIIGVsZWN0cm9uaWNz
IEdtYkggb24tYm9hcmQgQ1BMRCB0cml2aWFsIFNQSSBkZXZpY2UNCj4+Pj4+Pg0KPj4+Pj4+IFRo
aXMgZG9lcyBub3QgbG9vayBxdWl0ZSByaWdodCwgc2luY2UgY29tcGF0aWJsZSB0aGlzIGlzIHVz
ZWQgb25seSBvbjoNCj4+Pj4+Pg0KPj4+Pj4+IGFyY2gvYXJtL2Jvb3QvZHRzL2lteDZ1bGwtZGhj
b3ItbWF2ZW8tYm94LmR0cw0KPj4+Pj4+DQo+Pj4+Pj4gICAgICAgICAgbW9kZWwgPSAiREggZWxl
Y3Ryb25pY3MgaS5NWDZVTEwgREhDT1Igb24gbWF2ZW8gYm94IjsNCj4+Pj4+PiAgICAgICAgICBj
b21wYXRpYmxlID0gIm1hcmFudGVjLGlteDZ1bGwtZGhjb3ItbWF2ZW8tYm94IiwNCj4+Pj4+PiAi
ZGgsaW14NnVsbC1kaGNvci1zb20iLA0KPj4+Pj4+DQo+Pj4+Pj4gU28gdGhlIHdob2xlDQo+Pj4+
Pj4NCj4+Pj4+PiAgICAgICAgICBzcGlkZXZAMCB7DQo+Pj4+Pj4gICAgICAgICAgICAgICAgICBj
b21wYXRpYmxlID0gImRoLGRoY29tLWJvYXJkIjsNCj4+Pj4+PiAgICAgICAgICAgICAgICAgIHJl
ZyA9IDwwPjsNCj4+Pj4+PiAgICAgICAgICAgICAgICAgIHNwaS1jcGhhOw0KPj4+Pj4+ICAgICAg
ICAgICAgICAgICAgc3BpLWNwb2w7DQo+Pj4+Pj4gICAgICAgICAgICAgICAgICBzcGktbWF4LWZy
ZXF1ZW5jeSA9IDw1NDAwMDAwMD47DQo+Pj4+Pj4gICAgICAgICAgfTsNCj4+Pj4+Pg0KPj4+Pj4+
IFNob3VsZCBwcm9iYWJseSB1c2UgYSBkaWZmZXJlbnQgY29tcGF0aWJsZS4NCj4+Pj4+Pg0KPj4+
Pj4+IENocmlzdG9waCwgd2hhdCBkZXZpY2UgaXMgdGhpcyBvbiB0aGlzIGJvYXJkID8NCj4+DQo+
PiBUaGVyZSBpcyBubyBkZXZpY2UgY29ubmVjdGVkIHRvIHRoZXNlIHBpbnMsIG9ubHkgYW4gZXh0
ZW5zaW9uIGNvbm5lY3Rvci4NCj4+IFRoZSAiZGgsZGhjb20tYm9hcmQiIGRldmljZSB3YXMgdXNl
ZCBvbmx5IHRvIHRlc3QgdGhlIGhhcmR3YXJlIGFuZCB3YXMNCj4+IHVuZm9ydHVuYXRlbHkgZm9y
Z290dGVuIHRvIGJlIHJlbW92ZWQuIEluIHRoZSBwcm9kdWN0aW9uIHZlcnNpb24sIG5vDQo+PiBk
ZXZpY2UgaXMgY29ubmVjdGVkIHRvIHRoaXMgaW50ZXJmYWNlLiBJdCBzaG91bGQgYWN0dWFsbHkg
YmUgcmVtb3ZlZC4NCj4+IFNob3VsZCBJIGNyZWF0ZSBhIHBhdGNoIGZvciB0aGlzPw0KPiANCj4g
SW4gdGhhdCBjYXNlLCBJIHdvdWxkIHN1Z2dlc3QgdG8gcmVtb3ZlIHRoaXMgd2hvbGUgc3BpZGV2
QDAgZnJvbSB0aGlzIERUDQo+IHdpdGggcHJvcGVyIEZpeGVzOiB0YWcgLg0KPiANCj4gWy4uLl0N
Cj4gDQo+ID4+PiBCdXQgaW4gYW55IGNhc2UsIHRoZSBjb21wYXRpYmxlIHN0cmluZyBzaG91bGQg
bGlrZWx5IGJlIGZpeGVkIGhlcmUsIHRoaXMNCj4gPj4+IGRvZXMgbm90IHNlZW0gcmlnaHQuIFRo
ZSBkaCxkaGNvbS1ib2FyZCB3YXMgZGVzY3JpYmluZyBzb21lIENQTEQvRlBHQSBvbiBvbmUNCj4g
Pj4+IG9mIHRoZSBldmFsYm9hcmRzLg0KPiA+Pg0KPiA+PiBZZSBJIGRvbid0IGRpc2FncmVlIHRo
ZXJlLiAiZGhjb20tYm9hcmQiIHNlZW1zIG5vdCBuZWFybHkgc3BlY2lmaWMNCj4gPj4gZW5vdWdo
IGFib3V0IHdoYXQgdGhlIGRldmljZSBpcy4NCj4gPg0KPiA+IFRoZXJlIGlzbid0IGFjdHVhbGx5
IGEgdXNlciBmb3IgdGhpcyBkZXZpY2UsIHNlZSBhYm92ZS4gSXQncyBvbmx5IHVzZWQgZG93bnN0
cmVhbQ0KPiA+IGF0IERIIGVsZWN0cm9uaWNzIGZvciBhIGNvbm5lY3Rpb24gdG8gYSBQU29DIGNo
aXAuIEJ1dCBldmVuIGZvciB0aGlzIHB1cnBvc2UsIGl0J3MNCj4gPiBub3QgYmVpbmcgdXNlZCBj
b3JyZWN0bHkuIFdoYXQgc2hvdWxkIHdlIGRvIG5vdz8NCj4gSSB0aGluayB0aGlzIHBhdGNoIGNh
biBhbHNvIGJlIGRyb3BwZWQsIHRoZSBkaCxkaGNvbS1ib2FyZCB3b3VsZCBiZSBsZWZ0DQo+IGFz
IGEgbGVnYWN5IGNvbXBhdGlibGUgZm9yIHRoZSBDUExEL0ZQR0Egb24gdGhlIERIQ09NIFBESzIg
Ym9hcmQgKHdoZXJlDQo+IGl0IGlzIG5vdCBkZXNjcmliZWQgeWV0LCBidXQgc2hvdWxkIGJlKSAs
IGFuZCB0aGUgZGgtZGhjb20tYm9hcmQgc2hvdWxkDQo+IHJlbWFpbiBhIHRyaXZpYWwgZGV2aWNl
LCBzaW5jZSB0aGUgQ1BMRC9GUEdBIGlzIGNvbm5lY3RlZCB2aWEgc29tZQ0KPiBwYXJhbGxlbCBi
dXMgaWYgSSByZWNhbGwgaXQgcmlnaHQgPw0KDQpZZXMsIG9uIHRoZSBQREsyIHRoZSBDUExEL0ZQ
R0EgaXMgY29ubmVjdGVkIHZpYSBhIHBhcmFsbGVsIGJ1cy4NCg0KUmVnYXJkcw0KQ2hyaXN0b3Bo
DQo=
