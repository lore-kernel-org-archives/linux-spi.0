Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792434214;
	b=cOK6ncL+fh0v3Kjg2t0pKMzvgQLjrpQ/mvhQlGe0Nn3YrNcC0dFOEdDaYUJVxVSlmoeL
	 V1tzzo4FBsql0vkd2eppc+UGp5JaAkJgO1SwiHeCdWmJ/VEWSbhUVLkoOsGpWy/TEc3Xr
	 7C2ROYEHaZv1N04mU7kzYexyQOgUdmCIbTjpm6CpIaoXwrxIeWNwCm60xWWceBBEc6Xmf
	 XCvo9m+uUDe3e04HqE/QtSncba5qrhwRhwg/PVyQwTzoCOT6QgrAYSUfzExzjLMQ6mcNg
	 +2kPQ8BxXEX73lVUFlz8gJVsrQsZchKxD7zIbmPFpEXgUljCEB11NrjX3l8SdZhndIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792434214;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=KVcP3Tm43vHzjc1i2DamdCuBWvYxe1E0JfYpGwyuP7A=;
	b=gJNDC2QXbOjOhjTqohlcvvDVqiK0sfQ/FQzGwYMeWkiF9gNyJ+cVK8Im2bB6k0yQrYAv
	 7IOeOq3mZn9ryo+PpJJVpOk/eiH3PfkRjdLYhBt4rgOG0RF7Sx2gP6M1DvL1l8Fv01sW6
	 2W5ZYteEhMXKhCc7QODu6IGpcxsJ8YQRahnhSQHfRJXRXpP/YPbFLYmIrVpatktyVjYm/
	 6sM+V6lPnr7m2108BfAnCSDIfWnaBk8nsbut2YLLWl0Q26RMJ27HKbKcym2EcBHjyJKkj
	 Z6iSiG/mmwqz8btHlAY05w7M2NO7x4HjUd7a2GsO4fsFOwMpAW95/R8CEKp1bafSd4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tv0cBOFP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB31E606A31A;
	Mon, 19 Oct 2026 18:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tv0cBOFP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4963F1F000C4;
	Mon, 19 Oct 2026 18:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792434213;
	bh=KVcP3Tm43vHzjc1i2DamdCuBWvYxe1E0JfYpGwyuP7A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Tv0cBOFP+3ltqFO1lPQ5pNq5YKLNFaqXGD31GhJVJZZvdaJLv3vXs20QqMBkAvckj
	 y6bINwjob8gbD2UmjFLPDxrHWPP6Mx2SiYKzm0J5K6QBD9rvyl/cBasZdkjLFZeHb5
	 M3KAJqqYTAUjX8xIN5dnN9pPKnhc0cEczMIPXW7qNlEBKjglIKN2BiO135IlAjbjC2
	 GqgeLuAqIOG+F+woXYiTxoIlTa9uPToWuHEPLczmAW63ZktqfQunRZZ52wdnEgmlx9
	 QUXat/4TpdaFa7kWWOZdZjKdBl9OAYWyOvweJZMYLQoXe5C202hBX5pByWKcPeN7lm
	 jWJUqoslVdmqQ==
Date: Mon, 19 Oct 2026 19:23:27 +0100
From: Conor Dooley <conor@kernel.org>
To: Marek Vasut <marex@nabladev.com>
Cc: Christoph Niedermaier <cniedermaier@dh-electronics.com>,
	Frank.Li@oss.nxp.com, imx@lists.linux.dev,
	Guenter Roeck <linux@roeck-us.net>,
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
Message-ID: <20261019-cycling-unnatural-c1adbfb5c9d9@spud>
References: <20261016205718.877668-1-Frank.Li@oss.nxp.com>
 <e7095176-44b8-4838-8443-2e515d34cb25@nabladev.com>
 <20261018-freeway-twitch-e813208aa9af@spud>
 <fd15f846-94d4-44d8-a42d-5f13a7b18794@nabladev.com>
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Q3td6Zy/xdoBJifD"
Content-Disposition: inline
In-Reply-To: <fd15f846-94d4-44d8-a42d-5f13a7b18794@nabladev.com>

--Q3td6Zy/xdoBJifD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 18, 2026 at 11:38:09PM +0200, Marek Vasut wrote:
> On 10/18/26 9:37 PM, Conor Dooley wrote:
> > On Sat, Oct 17, 2026 at 12:01:55AM +0200, Marek Vasut wrote:
> > > On 10/16/26 10:57 PM, Frank.Li@oss.nxp.com wrote:
> > > > From: Frank Li <Frank.Li@nxp.com>
> > > >=20
> > > > The dh,dhcom-board SPI device uses spi-cpha and spi-cpol properties,
> > > > which are not permitted by the trivial-devices schema. Move it to a
> > > > dedicated binding file that references spi-peripheral-props.yaml and
> > > > explicitly allows those SPI mode properties.
> > > >=20
> > > > Fixes below CHECK_DTBS warnings:
> > > >     arch/arm/boot/dts/nxp/imx/imx6ull-dhcor-maveo-box.dtb: spidev@0=
 (dh,dhcom-board): 'spi-cpha', 'spi-cpol' do not match any of the regexes: =
'^pinctrl-[0-9]+$'
> > > >           from schema $id: http://devicetree.org/schemas/trivial-de=
vices.yaml
> > >=20
> > > How come this did not trigger until now ?
> > >=20
> > > > Assisted-by: LLM
> > > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > > ---
> > > >    .../bindings/spi/dh,dhcom-board.yaml          | 46 +++++++++++++=
++++++
> > > >    .../devicetree/bindings/trivial-devices.yaml  |  2 -
> > > >    2 files changed, 46 insertions(+), 2 deletions(-)
> > > >    create mode 100644 Documentation/devicetree/bindings/spi/dh,dhco=
m-board.yaml
> > > >=20
> > > > diff --git a/Documentation/devicetree/bindings/spi/dh,dhcom-board.y=
aml b/Documentation/devicetree/bindings/spi/dh,dhcom-board.yaml
> > > > new file mode 100644
> > > > index 0000000000000..ed213cbe9b04c
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/spi/dh,dhcom-board.yaml
> > > > @@ -0,0 +1,46 @@
> > > > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: http://devicetree.org/schemas/spi/dh,dhcom-board.yaml#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: DH electronics GmbH on-board CPLD trivial SPI device
> > >=20
> > > This does not look quite right, since compatible this is used only on:
> > >=20
> > > arch/arm/boot/dts/imx6ull-dhcor-maveo-box.dts
> > >=20
> > >         model =3D "DH electronics i.MX6ULL DHCOR on maveo box";
> > >         compatible =3D "marantec,imx6ull-dhcor-maveo-box",
> > > "dh,imx6ull-dhcor-som",
> > >=20
> > > So the whole
> > >=20
> > >         spidev@0 {
> > >                 compatible =3D "dh,dhcom-board";
> > >                 reg =3D <0>;
> > >                 spi-cpha;
> > >                 spi-cpol;
> > >                 spi-max-frequency =3D <54000000>;
> > >         };
> > >=20
> > > Should probably use a different compatible.
> > >=20
> > > Christoph, what device is this on this board ?
> > >=20
> > > (and this change should only be applied with RB from Christoph, I do =
not
> > > have the hardware so I cannot tell what it really is)
> > >=20
> > > > +maintainers:
> > > > +  - Marek Vasut <marex@denx.de>
> > >=20
> > > @nabladev.com
> > >=20
> > > > +  - Frank Li <Frank.Li@nxp.com>
> > > > +
> > > > +allOf:
> > > > +  - $ref: spi-peripheral-props.yaml
> > > > +
> > > > +properties:
> > > > +  compatible:
> > > > +    const: dh,dhcom-board
> > > > +
> > > > +  reg:
> > > > +    maxItems: 1
> > > > +
> > > > +  spi-cpha: true
> > > > +
> > > > +  spi-cpol: true
> > >=20
> > > Wouldn't it make more sense to allow those properties for trivial SPI
> > > devices in general ?
> >=20
> > If the device requires them (which it probably does?), then standalone
> > makes sense to actually set that requirement.
>=20
> All right.
>=20
> But in any case, the compatible string should likely be fixed here, this
> does not seem right. The dh,dhcom-board was describing some CPLD/FPGA on =
one
> of the evalboards.

Ye I don't disagree there. "dhcom-board" seems not nearly specific
enough about what the device is.

--Q3td6Zy/xdoBJifD
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCatZgHwAKCRB4tDGHoIJi
0rmdAP9dlbIEJr7TjRmPgZBJHo5qL8Bu9Y3JkjzxPA8xK60a2AD/d014Gqp+79+C
icNtSqiO9uK1vJ6NyVujv8UqXWv52gc=
=qhcD
-----END PGP SIGNATURE-----

--Q3td6Zy/xdoBJifD--
