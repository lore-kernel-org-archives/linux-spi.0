Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=116.203.31.6
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792503285;
	b=WlnvadJ2B29up5mjIubPAb/Isypmj7d+Dh+ceKATE2CrYI1EEGS8+WBKIDH5sVvuXvtG
	 fm79249/G7tPqMN1MVoapII7NZVd41s6VrrWM0zb8dFtMKf7fO30M/TYhH+LTNykev6ar
	 Lli4Xi7k1yM50rHWjeNO2psewW1Lhw5kyojwrMV/z+q62nOLn3M1bcrJBKQgLVYL5lLtr
	 mGChNiMx6FKeKEcLKvhVhGeD9l2hwJiX2DeZ9+LycZ30KD8UCcX96ohOkKW4oK/VDcmom
	 D8Preuub7/Wqks56o0vdRNGu6q7tK+0YrOg0ocPYLbAzO/SsiY+HKtGROjluiLZZpEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792503285;
	h=DMARC-Filter:DKIM-Signature:X-secureTransport-forwarded:From:
	 Complaints-To:To:CC:Subject:Thread-Topic:Thread-Index:Date:Message-ID:
	 References:In-Reply-To:Accept-Language:Content-Language:
	 X-MS-Has-Attach:X-MS-TNEF-Correlator:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=lTF0a1BWo1WRyCO1Plz6IAaTuq5ujNdrBcn/XSxu1yU=;
	b=2cw9L3cU8F6U7sRVRoBcMvREJ/Maqjhk2HecZo6EqzFnor84OemYWz8bi2NVKgw9ZE6q
	 eo6NsiutFJvtGPO9qQpB9KWqx5cHxn4umLR4wj4+a323KogThN/IqlRqctzghvtlz0Y3s
	 xoKfor33P6vOih7KJmcGh6U8O8QiRKjgirKAes6jISGR3QIW+8w1FDnSnsz/gS0DGMOYR
	 pb4GLvIf4Dwly7DzZB0DQ5KQI07n/NQOekSy9Q6d1tNkratyCFboTCsON1qLRXGyyrmfi
	 q4lfggb5+uJlhCtdt//gqmSlHOIVBiUsXtaS4FeW88VfjYvCNQSLyBDNgdn1yOAvgDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=dh-electronics.com;
	spf=pass smtp.mailfrom=dh-electronics.com;
	dkim=pass header.d=dh-electronics.com header.i=@dh-electronics.com header.a=rsa-sha256 header.s=dhelectronicscom header.b=ltDx203P;
	arc=none smtp.remote-ip=116.203.31.6
Received: from mx3.securetransport.de (mx3.securetransport.de [116.203.31.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68750606A31A;
	Tue, 20 Oct 2026 13:34:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68750606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dh-electronics.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dh-electronics.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=dh-electronics.com header.i=@dh-electronics.com header.a=rsa-sha256 header.s=dhelectronicscom header.b=ltDx203P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
	s=dhelectronicscom; t=1792503206;
	bh=lTF0a1BWo1WRyCO1Plz6IAaTuq5ujNdrBcn/XSxu1yU=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=ltDx203PEt5czqr6p+OuZ8/EmItrMOubS5IB9cXsSWhH61Ja9jwl9pqggE6Qt8tzS
	 EOSU9kYXjr4EHtXnbccLJch7z4qmqikJ8aCtG0E8Uka2bqwQ0TY+8PkbIlTw9VHGtV
	 ZoGyDmt6cXPMWU2MpAJEb8500+rX7NfxGCfZEjLzoeen5VDKuEgQ/mG7Ved+z2IVon
	 e+Rg2oy05EftyZ5rnH3/onFJW8PAzQTIk7BHdqt1Vb6ENGRCv+ZuVLVXN0AGFmcn2L
	 /vOI04SJpr+6ryLhO/1WDOjAxrimRxU7qerjf2ORIk5bT4ft558ZG/GDhAM9gtwv3j
	 509W4EU0b7yYA==
X-secureTransport-forwarded: yes
From: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Complaints-To: abuse@cubewerk.de
To: Conor Dooley <conor@kernel.org>, Marek Vasut <marex@nabladev.com>
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
Thread-Index: AQHdXhJ4wetEp3c+RUWeUdg1WJlLHbcAlj2AgAL8T4CAACG3gIABW++AgAFa0RA=
Date: Tue, 20 Oct 2026 13:33:24 +0000
Message-ID: <05e66d8f57a44c9aa87cac1c35e82184@dh-electronics.com>
References: <20261016205718.877668-1-Frank.Li@oss.nxp.com>
 <e7095176-44b8-4838-8443-2e515d34cb25@nabladev.com>
 <20261018-freeway-twitch-e813208aa9af@spud>
 <fd15f846-94d4-44d8-a42d-5f13a7b18794@nabladev.com>
 <20261019-cycling-unnatural-c1adbfb5c9d9@spud>
In-Reply-To: <20261019-cycling-unnatural-c1adbfb5c9d9@spud>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

From: Conor Dooley <conor@kernel.org>
Sent: Monday, October 19, 2026 8:23 PM
> On Sun, Oct 18, 2026 at 11:38:09PM +0200, Marek Vasut wrote:
> > On 10/18/26 9:37 PM, Conor Dooley wrote:
> > > On Sat, Oct 17, 2026 at 12:01:55AM +0200, Marek Vasut wrote:
> > > > On 10/16/26 10:57 PM, Frank.Li@oss.nxp.com wrote:
> > > > > From: Frank Li <Frank.Li@nxp.com>
> > > > >=20
> > > > > The dh,dhcom-board SPI device uses spi-cpha and spi-cpol properti=
es,
> > > > > which are not permitted by the trivial-devices schema. Move it to=
 a
> > > > > dedicated binding file that references spi-peripheral-props.yaml =
and
> > > > > explicitly allows those SPI mode properties.
> > > > >=20
> > > > > Fixes below CHECK_DTBS warnings:
> > > > >     arch/arm/boot/dts/nxp/imx/imx6ull-dhcor-maveo-box.dtb: spidev=
@0 (dh,dhcom-board): 'spi-cpha', 'spi-cpol' do not match any of the regexes=
: '^pinctrl-[0-9]+$'
> > > > >           from schema $id: http://devicetree.org/schemas/trivial-=
devices.yaml
> > > >=20
> > > > How come this did not trigger until now ?
> > > >=20
> > > > > Assisted-by: LLM
> > > > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > > > ---
> > > > >    .../bindings/spi/dh,dhcom-board.yaml          | 46 +++++++++++=
++++++++
> > > > >    .../devicetree/bindings/trivial-devices.yaml  |  2 -
> > > > >    2 files changed, 46 insertions(+), 2 deletions(-)
> > > > >    create mode 100644 Documentation/devicetree/bindings/spi/dh,dh=
com-board.yaml
> > > > >=20
> > > > > diff --git a/Documentation/devicetree/bindings/spi/dh,dhcom-board=
.yaml b/Documentation/devicetree/bindings/spi/dh,dhcom-board.yaml
> > > > > new file mode 100644
> > > > > index 0000000000000..ed213cbe9b04c
> > > > > --- /dev/null
> > > > > +++ b/Documentation/devicetree/bindings/spi/dh,dhcom-board.yaml
> > > > > @@ -0,0 +1,46 @@
> > > > > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > > > > +%YAML 1.2
> > > > > +---
> > > > > +$id: http://devicetree.org/schemas/spi/dh,dhcom-board.yaml#
> > > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > > +
> > > > > +title: DH electronics GmbH on-board CPLD trivial SPI device
> > > >=20
> > > > This does not look quite right, since compatible this is used only =
on:
> > > >=20
> > > > arch/arm/boot/dts/imx6ull-dhcor-maveo-box.dts
> > > >=20
> > > >         model =3D "DH electronics i.MX6ULL DHCOR on maveo box";
> > > >         compatible =3D "marantec,imx6ull-dhcor-maveo-box",
> > > > "dh,imx6ull-dhcor-som",
> > > >=20
> > > > So the whole
> > > >=20
> > > >         spidev@0 {
> > > >                 compatible =3D "dh,dhcom-board";
> > > >                 reg =3D <0>;
> > > >                 spi-cpha;
> > > >                 spi-cpol;
> > > >                 spi-max-frequency =3D <54000000>;
> > > >         };
> > > >=20
> > > > Should probably use a different compatible.
> > > >=20
> > > > Christoph, what device is this on this board ?

There is no device connected to these pins, only an extension connector.
The "dh,dhcom-board" device was used only to test the hardware and was
unfortunately forgotten to be removed. In the production version, no
device is connected to this interface. It should actually be removed.
Should I create a patch for this?

> > > > (and this change should only be applied with RB from Christoph, I d=
o not
> > > > have the hardware so I cannot tell what it really is)
> > > >=20
> > > > > +maintainers:
> > > > > +  - Marek Vasut <marex@denx.de>
> > > >=20
> > > > @nabladev.com
> > > >=20
> > > > > +  - Frank Li <Frank.Li@nxp.com>
> > > > > +
> > > > > +allOf:
> > > > > +  - $ref: spi-peripheral-props.yaml
> > > > > +
> > > > > +properties:
> > > > > +  compatible:
> > > > > +    const: dh,dhcom-board
> > > > > +
> > > > > +  reg:
> > > > > +    maxItems: 1
> > > > > +
> > > > > +  spi-cpha: true
> > > > > +
> > > > > +  spi-cpol: true
> > > >=20
> > > > Wouldn't it make more sense to allow those properties for trivial S=
PI
> > > > devices in general ?
> > >=20
> > > If the device requires them (which it probably does?), then standalon=
e
> > > makes sense to actually set that requirement.
> >=20
> > All right.
> >=20
> > But in any case, the compatible string should likely be fixed here, thi=
s
> > does not seem right. The dh,dhcom-board was describing some CPLD/FPGA o=
n one
> > of the evalboards.
>=20
> Ye I don't disagree there. "dhcom-board" seems not nearly specific
> enough about what the device is.

There isn't actually a user for this device, see above. It's only used down=
stream
at DH electronics for a connection to a PSoC chip. But even for this purpos=
e, it's
not being used correctly. What should we do now?

Regards
Christoph
