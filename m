Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A4D4B8DC9;
	Thu, 11 Jun 2026 17:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781199273; cv=none; b=Y7e0kNPe2j8gQ6WhzVdAfAcWJgKbUB4DFytE3fPzYSpZMWD/4MRKDXVyZ4JxC4ffVySKNwifi/2OHx5IltkNHoK9Nfb5h+XP9aji64TGdw7FY89fxyj4xA5otmG+qsk2qaK2v2e2PGVDRdKKWPBX7bkaeBZ2Yy1A2zEok5+Wa3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781199273; c=relaxed/simple;
	bh=MciWf+M20QPVtTaY40UDNHXUlrLT7qxgSUVPIX1y9sY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HYn/JAKu8Afogv+jnw+w7LQBy/J+BOLbKFF+LHpWSqaCYbqF978BAL74XaK0L/pQLnHeTPw5npyeWnlKQiVzLh7EXNX5/0/1nuOACnypUo/+b8HVw9HSiZNsGcX/QxAB7OG4S+1yb3g5pM7Nlk3HDZopYb8A2TatOEfTMVgm55E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WBGOLwOP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WBGOLwOP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80CB41F00893;
	Thu, 11 Jun 2026 17:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781199270;
	bh=GKHh+i98qXgSxoXMtEh8DwSS3JvwNP6esO4z1NwS6xM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WBGOLwOPKlQV6+sE9zz8JwaW+U6eQ41T1PaK4+OBs710o7wY/sz3qlenlWQgkh8dD
	 aCG+5Kp5ivhAeQ7yiguw217xqOzRHMDMbqF1DNHt8Zhenu5WIo5TXnzSCX2VMCGSm8
	 gU/MCaNbgGqO2nKYO1UKqbZA4u0O7n/TAC9A7WNkhIXNqmNblPqP4FiFNILC5nAes/
	 w56jKalmnmKxLWh9UsPQZCAZqUkMZJb7LP1/DMRhGCZQt4tWlV0yvT4qdApvYO64dE
	 ugtkv//iFm0fFAYCSCwndkfW/oMXDCwuDpX/SGvNHRV2dB1Imij6q8gqc+Nflu66J0
	 eiKiohCDZcmUQ==
Date: Thu, 11 Jun 2026 18:34:26 +0100
From: Conor Dooley <conor@kernel.org>
To: Chi-Wen Weng <cwweng.linux@gmail.com>
Cc: broonie@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, cwweng@nuvoton.com
Subject: Re: [PATCH v3 1/2] dt-bindings: spi: nuvoton,ma35d1-qspi: Add
 Nuvoton MA35D1 QSPI
Message-ID: <20260611-decoy-glamorous-81903a5fd1f9@spud>
References: <20260611091246.2070485-1-cwweng.linux@gmail.com>
 <20260611091246.2070485-2-cwweng.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="y2HC3MSDBPXqvEKI"
Content-Disposition: inline
In-Reply-To: <20260611091246.2070485-2-cwweng.linux@gmail.com>


--y2HC3MSDBPXqvEKI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 11, 2026 at 05:12:45PM +0800, Chi-Wen Weng wrote:
> From: Chi-Wen Weng <cwweng@nuvoton.com>
>=20
> Add a devicetree binding for the Quad SPI controller found in
> Nuvoton MA35D1 SoCs.
>=20
> The controller supports SPI memory devices such as SPI NOR and SPI NAND
> flashes. It has one register range, one clock input and one reset line,
> and supports up to two chip selects.
>=20
> Signed-off-by: Chi-Wen Weng <cwweng@nuvoton.com>
> ---
>  .../bindings/spi/nuvoton,ma35d1-qspi.yaml     | 62 +++++++++++++++++++
>  1 file changed, 62 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/nuvoton,ma35d1-=
qspi.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/spi/nuvoton,ma35d1-qspi.ya=
ml b/Documentation/devicetree/bindings/spi/nuvoton,ma35d1-qspi.yaml
> new file mode 100644
> index 000000000000..d3b36e612eb0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/nuvoton,ma35d1-qspi.yaml
> @@ -0,0 +1,62 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/spi/nuvoton,ma35d1-qspi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Nuvoton MA35D1 Quad SPI Controller
> +
> +maintainers:
> +  - Chi-Wen Weng <cwweng@nuvoton.com>
> +
> +allOf:
> +  - $ref: /schemas/spi/spi-controller.yaml#
> +
> +properties:
> +  compatible:
> +    const: nuvoton,ma35d1-qspi
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  resets:
> +    maxItems: 1
> +
> +  num-cs:
> +    maximum: 2

Missing a default of 2, unless you make the property required.
FWIW, your driver doesn't appear to read this value.

pw-bot: changes-requested

Cheers,
Conor.

> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - resets
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/clock/nuvoton,ma35d1-clk.h>
> +    #include <dt-bindings/reset/nuvoton,ma35d1-reset.h>
> +
> +    soc {
> +        #address-cells =3D <2>;
> +        #size-cells =3D <2>;
> +
> +        spi@40680000 {
> +            compatible =3D "nuvoton,ma35d1-qspi";
> +            reg =3D <0 0x40680000 0 0x100>;
> +            interrupts =3D <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
> +            clocks =3D <&clk QSPI0_GATE>;
> +            resets =3D <&sys MA35D1_RESET_QSPI0>;
> +            #address-cells =3D <1>;
> +            #size-cells =3D <0>;
> +        };
> +    };
> +
> --=20
> 2.25.1
>=20

--y2HC3MSDBPXqvEKI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCairxogAKCRB4tDGHoIJi
0t3XAP9qcUqAyCExrvNM+WH+fRqlgDWYgVPPEhDhcx5b6gpGFAEA8y09z/Esd2jw
HHAZ8eWuMulndEiQ+EbaDJydemUtwA4=
=JpZM
-----END PGP SIGNATURE-----

--y2HC3MSDBPXqvEKI--
