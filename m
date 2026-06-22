Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C982233956;
	Mon, 22 Jun 2026 19:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782157605; cv=none; b=MOL7nUPKSVeJNv0IeHVgAfcM5vhJ/A6BpP7LL4DrEMbQmET7dVnxngrE8p3DLiIiMHLV87cJ21jUV5NOWkQGb0iB6p3KI7jMrqzzInHT2eIPPHPGqxkllKCIxz5asQHwmnza+NxR792aNzPU+gf+z9nc0FAKrFwsKvI2yyu1wvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782157605; c=relaxed/simple;
	bh=kgwMBXGGvHy1EtVKvRTgShEaEM1atd0VxGwjFSma1EY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BLkE4NhOlu+QXZ3HDrrGf4AV9LCMF4jkXCatJo/2lOf0llfT+h/3MEYTv4hvvI3u+bt6J/QBRFWGLWDwFsrBbLU1Ioq2ASfdDJhyLpdIF0cQSHpysUcbxabKiWUtAJgfH+36Cee+eDv6rXL5QMIo1/BUu7HbFIq7xEQAworME88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iCM+BPJS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iCM+BPJS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2A721F000E9;
	Mon, 22 Jun 2026 19:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782157604;
	bh=iBmRIEo0Y3C537nc7m+qdd+Xo7/WqHEC+VjWqzHuMHk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iCM+BPJSYS2QMN3UtoBbVOX95l2Flr6TD/yiI8GOs3NGy+Rn3WiYq9chlfTsIZOgW
	 Y0218U+9VLmVogcC0MGI8TOk09omHOz8Dh7ENWjNy70OdK9kQdFXYQf6ZUDFf0JE/U
	 3vn8alKNYKf03Mfyl4S6FiNBFCAkMAeMKmQRDlvb0COhk887SM8XTHpU5fph5ecoEY
	 iSsiFsVXuDmVIBI1N1exHAGGNzzDyXgdIzJKgN2vFH1U+wNYtziSY/ErYlBWN3olSY
	 oG8CTscy4sBOiTzFtghzJAbBqaZ/k/TtHD2gx30uk0uT9qAJlYUm9ILX+dQLyekSim
	 Stl4jW1qW7d8Q==
Date: Mon, 22 Jun 2026 20:46:38 +0100
From: Conor Dooley <conor@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Santhosh Kumar K <s-k6@ti.com>, broonie@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, miquel.raynal@bootlin.com,
	richard@nod.at, vigneshr@ti.com, pratyush@kernel.org,
	mwalle@kernel.org, takahiro.kuwano@infineon.com,
	linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
	praneeth@ti.com, u-kumar1@ti.com, a-dutta@ti.com
Subject: Re: [PATCH v4 01/16] spi: dt-bindings: add
 spi-max-post-config-frequency property
Message-ID: <20260622-cartridge-foam-f3bdc9a1311f@spud>
References: <20260618073725.84733-1-s-k6@ti.com>
 <20260618073725.84733-2-s-k6@ti.com>
 <20260622-private-curly-fennec-7e1ad0@quoll>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ejSyi9hdaBgCwCQ8"
Content-Disposition: inline
In-Reply-To: <20260622-private-curly-fennec-7e1ad0@quoll>


--ejSyi9hdaBgCwCQ8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 22, 2026 at 11:14:32AM +0200, Krzysztof Kozlowski wrote:
> On Thu, Jun 18, 2026 at 01:07:10PM +0530, Santhosh Kumar K wrote:
> > Add spi-max-post-config-frequency, a generic uint32 property for SPI
> > peripherals that support two distinct clock rates: a conservative rate
> > always reachable without controller configuration, and a higher rate
> > reachable only after controller-side configuration such as PHY tuning.
> >=20
> > When both properties are present, spi-max-frequency gives the
> > conservative pre-configuration rate and spi-max-post-config-frequency
> > gives the higher post-configuration target.
> >=20
> > Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
> > ---
> >  .../devicetree/bindings/spi/spi-peripheral-props.yaml       | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/spi/spi-peripheral-props=
=2Eyaml b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
> > index 880a9f624566..ece86f65930f 100644
> > --- a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
> > +++ b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
> > @@ -45,6 +45,12 @@ properties:
> >      description:
> >        Maximum SPI clocking speed of the device in Hz.
> > =20
> > +  spi-max-post-config-frequency:
>=20
> -hz

Ah d'oh. I was hung up on matching the existing property that I didn't
include -hz in my original suggestion, sorry!

> https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/pr=
operty-units.yaml
>=20
> and you need maxItems: 1.
>=20
> Now, please take time and think if this should not be an array instead
> (maxItems: ...) to cover other possible cases, e.g. different tuning
> levels? IOW, having single spi-max-frequency turned out to be
> insufficient. You address that insufficiency with one more frequency,
> but what if this is going to be insufficient next month as well?
>=20
> I don't know, answer is rather for domain experts.
>=20
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description:
> > +      Maximum SPI clock frequency in Hz achievable post controller-side
> > +      configuration.
>=20
> Best regards,
> Krzysztof
>=20

--ejSyi9hdaBgCwCQ8
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCajmRHgAKCRB4tDGHoIJi
0umiAQCjDW5YPRvTWr8AmnJrT5KWog4MKK7CNWqLvCUUEmQq+QEA8S2hYQBmi9Pb
MYrjEqkaB0aZF/Os83V8DkGjn39+wQU=
=qY+b
-----END PGP SIGNATURE-----

--ejSyi9hdaBgCwCQ8--
