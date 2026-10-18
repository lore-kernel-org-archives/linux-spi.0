Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A2437FF4B;
	Sun, 18 Oct 2026 19:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792352257; cv=none; b=NKphgHzASe347MZOc/Ol5dk1dBetJjtaXgxOKsQ3VJ9sjm1t92VrM+SBU6PtoUSGLJzKL/OeboebgBeg5oga223tn0ddpkerF9IHDoZZw4LYt3CqdvyUqZWdcgVGkBpeVDOat6mvaRG9QEZKKtMFzXOoSlWWLcVTqO/QiF5CXu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792352257; c=relaxed/simple;
	bh=hWyphUOg7VVggGN5ibCi2ZgClSKjeBRDFRq58pI8Pf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l8ZClOY1+OXRTr9ah2/CA7ik4CiTbHIF9zV6h5i5jSGdjsRaFbC014JLsK14GwN/lBIwgQduHkX04xqnMR6YGNgMr3U81xu6mjwW6Suh7sapne4LlrnV5naqrCL0IDo/2Ezi5xKcIq8jqHDH8+4/vBPDJcebF2JatTe+Mjw0Wuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TyukweSz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TyukweSz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4FEB1F000C4;
	Sun, 18 Oct 2026 19:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792352255;
	bh=7aBv2cTg3vXrmEzBIKjR3qBMNhNd7G9cJp9HXCweTFE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TyukweSzzfyf9aI4t4fo11YGVI2ZIoKTyZ3JKHqQ9u6Kwy5kTulnA/xdw57Zg9J5D
	 MXd+YGf/SsHw8qo+/0P4Xpn1eYWSXqRgLvGDaAXJCE2RpitzMrklDqxzbjkZGnG5OI
	 QAGeyRjsPYUMj8Qz2+oaPaYZ8yJ3T/dRBNhZaA2Oiy9qGKJ4ZU/4qyuHDl2hzsJpqS
	 nxaoIPftINW8QaogkcsxfRYk1Qb06IU89BazfdhGEu8+6uTUg8lNcqEbDdpCpnKiAZ
	 ck7eP3hFOYsokKEbrevZWic3MNYRaIeKvHnV5FHq2EnlEDX8fYe+yeyNBh4qJhmNml
	 fDcl3e3XkyNZA==
Date: Sun, 18 Oct 2026 20:37:29 +0100
From: Conor Dooley <conor@kernel.org>
To: Marek Vasut <marex@nabladev.com>
Cc: Frank.Li@oss.nxp.com,
	Christoph Niedermaier <cniedermaier@dh-electronics.com>,
	imx@lists.linux.dev, Guenter Roeck <linux@roeck-us.net>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Frank Li <Frank.Li@nxp.com>,
	Ashish Yadav <ashish.yadav@infineon.com>,
	Colin Huang <u8813345@gmail.com>,
	Sanman Pradhan <psanman@juniper.net>,
	Thorsten Blum <blum@kernel.org>,
	Troy Mitchell <troy.mitchell@linux.dev>,
	Eddie James <eajames@linux.ibm.com>,
	Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>,
	"open list:SPI SUBSYSTEM" <linux-spi@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	"open list:DH ELECTRONICS DHSOM SOM AND BOARD SUPPORT" <kernel@dh-electronics.com>,
	open list <linux-kernel@vger.kernel.org>,
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH 1/1] dt-bindings: spi: Add separate binding for
 dh,dhcom-board
Message-ID: <20261018-freeway-twitch-e813208aa9af@spud>
References: <20261016205718.877668-1-Frank.Li@oss.nxp.com>
 <e7095176-44b8-4838-8443-2e515d34cb25@nabladev.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0TlYiEQJktn+9mNR"
Content-Disposition: inline
In-Reply-To: <e7095176-44b8-4838-8443-2e515d34cb25@nabladev.com>

--0TlYiEQJktn+9mNR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 17, 2026 at 12:01:55AM +0200, Marek Vasut wrote:
> On 10/16/26 10:57 PM, Frank.Li@oss.nxp.com wrote:
> > From: Frank Li <Frank.Li@nxp.com>
> >=20
> > The dh,dhcom-board SPI device uses spi-cpha and spi-cpol properties,
> > which are not permitted by the trivial-devices schema. Move it to a
> > dedicated binding file that references spi-peripheral-props.yaml and
> > explicitly allows those SPI mode properties.
> >=20
> > Fixes below CHECK_DTBS warnings:
> >    arch/arm/boot/dts/nxp/imx/imx6ull-dhcor-maveo-box.dtb: spidev@0 (dh,=
dhcom-board): 'spi-cpha', 'spi-cpol' do not match any of the regexes: '^pin=
ctrl-[0-9]+$'
> >          from schema $id: http://devicetree.org/schemas/trivial-devices=
=2Eyaml
>=20
> How come this did not trigger until now ?
>=20
> > Assisted-by: LLM
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >   .../bindings/spi/dh,dhcom-board.yaml          | 46 +++++++++++++++++++
> >   .../devicetree/bindings/trivial-devices.yaml  |  2 -
> >   2 files changed, 46 insertions(+), 2 deletions(-)
> >   create mode 100644 Documentation/devicetree/bindings/spi/dh,dhcom-boa=
rd.yaml
> >=20
> > diff --git a/Documentation/devicetree/bindings/spi/dh,dhcom-board.yaml =
b/Documentation/devicetree/bindings/spi/dh,dhcom-board.yaml
> > new file mode 100644
> > index 0000000000000..ed213cbe9b04c
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/spi/dh,dhcom-board.yaml
> > @@ -0,0 +1,46 @@
> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/spi/dh,dhcom-board.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: DH electronics GmbH on-board CPLD trivial SPI device
>=20
> This does not look quite right, since compatible this is used only on:
>=20
> arch/arm/boot/dts/imx6ull-dhcor-maveo-box.dts
>=20
>        model =3D "DH electronics i.MX6ULL DHCOR on maveo box";
>        compatible =3D "marantec,imx6ull-dhcor-maveo-box",
> "dh,imx6ull-dhcor-som",
>=20
> So the whole
>=20
>        spidev@0 {
>                compatible =3D "dh,dhcom-board";
>                reg =3D <0>;
>                spi-cpha;
>                spi-cpol;
>                spi-max-frequency =3D <54000000>;
>        };
>=20
> Should probably use a different compatible.
>=20
> Christoph, what device is this on this board ?
>=20
> (and this change should only be applied with RB from Christoph, I do not
> have the hardware so I cannot tell what it really is)
>=20
> > +maintainers:
> > +  - Marek Vasut <marex@denx.de>
>=20
> @nabladev.com
>=20
> > +  - Frank Li <Frank.Li@nxp.com>
> > +
> > +allOf:
> > +  - $ref: spi-peripheral-props.yaml
> > +
> > +properties:
> > +  compatible:
> > +    const: dh,dhcom-board
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  spi-cpha: true
> > +
> > +  spi-cpol: true
>=20
> Wouldn't it make more sense to allow those properties for trivial SPI
> devices in general ?

If the device requires them (which it probably does?), then standalone
makes sense to actually set that requirement.

--0TlYiEQJktn+9mNR
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCatUf+QAKCRB4tDGHoIJi
0otLAQDjNTrB0QcnnZX13hltR1wjzbb9ogEMJ8vbEfN8MshylQEAjmdZh9cncbbJ
5jdU+CjQgPrg1LVfGQA7dr49Xv0gCgQ=
=xCky
-----END PGP SIGNATURE-----

--0TlYiEQJktn+9mNR--
