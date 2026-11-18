Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795024289;
	b=uLRU+seoTQ0q3mkphq1gxl9xJRZlesayvj+Gnml2CHW68jqucCwiS1Fe4m6dh8qeaxJt
	 ECdt2QEhbD5bV9rl3xVWLB8gY2bcfnPsVXsLw9OZjmXj6g2Jyw0iLY5VLFteLzmDb57ne
	 WNUM1xjTYRrh6D6jtk4HWKXwokA7KF9cxK1qAescKYpKoFGfEKc9qI6bTbD/6oF2pvY+r
	 4/+jnZvpwPmlBJN95ChJAqR06KzAHt75gBMLDVfS75ZheqQ8AHOIh9L/KKqAzlIqYw/Fc
	 GrBLjjOMRjNAvdGuyLGXS9ydYQBMtNrEbNmw8IAwnmViHmAeeqh90RYjLZG7EuE5/uA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795024289;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=o+cgd6FXlQYSkL/IwbSFxwMH8gELhgdiO8iMpkvLQHM=;
	b=5I0C7FfCcE5gXavw/SVO7sNWRp5IEHPndOdyJr756EEk3ebup6c8Utj0Jmh3zZrNy1Ls
	 FVVyDPRwWelLvEVbLQoEitTD6mGxe1g16a8xcz1KJDuUpaXWfotnUhHVMiFY9tyt0H6hJ
	 eo/nxp790j80mH3xBqeKoLIRVj+aVcCdXcZX0cd+7JFWdCWLG98yBuZC3BFZg3GCYrb5Y
	 LE8z+rm0VPZ3SmmbkukUOEEZc1To5K7qD4Boar4x/5EryW+mIFVf/gTyPfIxtolSYVHym
	 4Q36vB0ZClsl8OjusaDpsGt/wgcmKgDqbX84DIZEjCvhCQRQboAI9+TOwNxdXrxBj0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V0pWFrad;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E22606A331;
	Wed, 18 Nov 2026 17:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V0pWFrad
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 724C81F000C4;
	Wed, 18 Nov 2026 17:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795024288;
	bh=o+cgd6FXlQYSkL/IwbSFxwMH8gELhgdiO8iMpkvLQHM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=V0pWFrad+O0YKaWs6QQUI924D247no8qdDiOOVg4aO+V6kUgwJjIGyf/e7X5SZdqV
	 jE8vHQClg5xFHUznD+vpvsdq6uDTkwUVwQPl60yLDSaAKwV/2m5/9x5/YAQePPX11H
	 1SSIH7HaXPJ707hM//BiwSvuDA+nbSiA403jxMnjfCyNr6rBWBSpB061g+ppbwauj4
	 osNOd+IpAr9qrnakYyUae+4Lbyxv7JY6umG7i2CcIBepIrufi1ok61QqIr98byAj/A
	 ZV4naEz794HiU/3WXjkSwyqX+knelJRhLjunEr/bkdoqWxFy1kejuBePBDjZN93U4Y
	 YwrIFuLAB/s6A==
Date: Wed, 18 Nov 2026 17:51:22 +0000
From: Conor Dooley <conor@kernel.org>
To: Wang Yang <yang.wang@deepcomputing.io>
Cc: Yixun Lan <dlan@kernel.org>, Benson Leung <bleung@chromium.org>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Guenter Roeck <groeck@chromium.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Sandie Cao <sandie.cao@deepcomputing.io>,
	devicetree@vger.kernel.org, chrome-platform@lists.linux.dev,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
	broonie@kernel.org
Subject: Re: [PATCH 1/9] dt-bindings: bus: Add SpacemiT K3 eSPI controller
Message-ID: <20261118-backdrop-scrap-1bee34e06336@spud>
References: <20261118085742.1817536-1-yang.wang@deepcomputing.io>
 <20261118085742.1817536-2-yang.wang@deepcomputing.io>
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
	protocol="application/pgp-signature"; boundary="Zv9eLov9AwAreJlT"
Content-Disposition: inline
In-Reply-To: <20261118085742.1817536-2-yang.wang@deepcomputing.io>

--Zv9eLov9AwAreJlT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

+CC Mark, spi,

On Wed, Nov 18, 2026 at 04:57:34PM +0800, Wang Yang wrote:
> window, clocks, resets and link configuration. The EC uses this memory
> window rather than the ordinary SPI transfer interface.
>=20
> The controller implementation is carried as a separate prerequisite so
> that the hardware vendor can review it independently.
>=20
> Prepared with Codex assistance from the existing DC-linux EC support.
>=20
> Signed-off-by: Wang Yang <yang.wang@deepcomputing.io>
> ---
>  .../bindings/bus/spacemit,k3-espi.yaml        | 146 ++++++++++++++++++
>  1 file changed, 146 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/bus/spacemit,k3-esp=
i.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/bus/spacemit,k3-espi.yaml =
b/Documentation/devicetree/bindings/bus/spacemit,k3-espi.yaml
> new file mode 100644
> index 000000000..30985ee0a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/bus/spacemit,k3-espi.yaml
> @@ -0,0 +1,146 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/bus/spacemit,k3-espi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: SpacemiT K3 eSPI controller

How is this "eSPI" different to the eSPI described in fsl,espi.yaml and
implemented by a driver in drivers/spi?

Cheers,
Conor.

> +
> +maintainers:
> +  - Yixun Lan <dlan@kernel.org>
> +
> +description: |
> +  The K3 eSPI controller connects the application processor to an embedd=
ed
> +  controller. Child registers are accessed through a peripheral shared-m=
emory
> +  window, translated by ranges. The controller manages clocks, resets and
> +  channel negotiation, including link recovery after an EC reboot.
> +
> +properties:
> +  compatible:
> +    const: spacemit,k3-espi
> +
> +  reg:
> +    maxItems: 1
> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 1
> +
> +  ranges:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: Serial clock source
> +      - description: Serial clock
> +      - description: Bus clock
> +
> +  clock-names:
> +    items:
> +      - const: sclk_src
> +      - const: sclk
> +      - const: mclk
> +
> +  resets:
> +    items:
> +      - description: Bus reset
> +      - description: Serial clock reset
> +
> +  pr-mem-base0:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: First peripheral memory translation base.
> +
> +  pr-mem-base1:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Second peripheral memory translation base.
> +
> +  operating-frequency:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Requested link clock frequency in MHz.
> +    enum: [20, 25, 33, 50, 66]
> +    default: 20
> +
> +  io-mode:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    description: Requested number of eSPI data lines.
> +    enum: [single, dual, quad]
> +    default: single
> +
> +  alert-mode:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    description: Use the shared IO1 line or the dedicated alert pin.
> +    enum: [io1, pin]
> +    default: io1
> +
> +  alert-type:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    description: Electrical mode of the dedicated alert pin.
> +    enum: [open-drain, push-pull]
> +    default: open-drain
> +
> +  watchdog-timeout:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Controller watchdog counter value.
> +    maximum: 65535
> +    default: 65535
> +
> +  crc-enable:
> +    type: boolean
> +    description: Enable link CRC checking.
> +
> +  auto-gating-enable:
> +    type: boolean
> +    description: Enable automatic controller clock gating.
> +
> +  peripheral-channel-enable:
> +    type: boolean
> +    description: Enable the peripheral channel.
> +
> +  vwire-channel-enable:
> +    type: boolean
> +    description: Enable the virtual-wire channel.
> +
> +  oob-channel-enable:
> +    type: boolean
> +    description: Enable the out-of-band channel.
> +
> +  flash-channel-enable:
> +    type: boolean
> +    description: Enable the flash access channel.
> +
> +patternProperties:
> +  '^ec@[0-9a-f]+$':
> +    $ref: /schemas/embedded-controller/google,cros-ec.yaml#
> +
> +required:
> +  - compatible
> +  - reg
> +  - '#address-cells'
> +  - '#size-cells'
> +  - ranges
> +  - clocks
> +  - clock-names
> +  - resets
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/spacemit,k3-clocks.h>
> +    #include <dt-bindings/reset/spacemit,k3-resets.h>
> +
> +    espi@cac8c000 {
> +        compatible =3D "spacemit,k3-espi";
> +        reg =3D <0xcac8c000 0x1000>;
> +        #address-cells =3D <1>;
> +        #size-cells =3D <1>;
> +        ranges =3D <0 0x84000000 0x1000>;
> +        clocks =3D <&syscon_apmu CLK_APMU_ESPI_SCLK_SRC>,
> +                 <&syscon_apmu CLK_APMU_ESPI_SCLK>,
> +                 <&syscon_apmu CLK_APMU_ESPI_MCLK>;
> +        clock-names =3D "sclk_src", "sclk", "mclk";
> +        resets =3D <&syscon_apmu RESET_APMU_ESPI_MCLK>,
> +                 <&syscon_apmu RESET_APMU_ESPI_SCLK>;
> +    };
>=20
> base-commit: 749a4de370409464cf8501ec5b2451df45c84eb4
> --=20
> 2.43.0

--Zv9eLov9AwAreJlT
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCav3lmgAKCRB4tDGHoIJi
0jB/AP9O0BLPsoWUE7dMhr0EDpdU1lzaH2KTolTIjBL2Cm+ewQD+M4KD2VV64sbA
lEwCFnGSePhuECv9+lh4Y4f3oO/0eQc=
=Wd0s
-----END PGP SIGNATURE-----

--Zv9eLov9AwAreJlT--
