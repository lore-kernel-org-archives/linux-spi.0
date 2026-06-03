Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D993D522C;
	Wed,  3 Jun 2026 15:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780500271; cv=none; b=ni3W3AWkl1cmCEk8VuxQYj4aO7ekUOoVhryclSHz1FwJR8mriD8pcXaJJQ02vKjXi/xLJ/1PkUvyR7vkSIYoNLDJEMmtC7VnGuT+Rbh5G2jYBQhL+bZ9DxAJPtQnVj5XoEKPzP0LyyNlEYrxWK7yF3Fb5zFwdBzEs4uD0/1Dw/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780500271; c=relaxed/simple;
	bh=zo5Dz8ovc62ByM6P3PWKFIPchkqnIqVqSTT/9nFsr+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hEC9xT4JlWyS3SGDo1FZ3eBSRXcCN1JP8lnMrKctilTQvQphW5wINOctz6AiAtcEUHX4XO+pkka9+jh0dZLLVtj0J8id7qyw4OEZT9eeitPbv3vQas5bmbJCMaWNLrE03Zjbk6hBDJx55/r+ekPT/iiCOI5NDngdpROd0QKD8Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CY6046kz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CY6046kz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10DA81F00893;
	Wed,  3 Jun 2026 15:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780500270;
	bh=kjzxz0t6lEOZubRT0pRgqofvMBOODUDsEOG6BtNFkrY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CY6046kzgjy/4LzHpfa083N0szyRpUPGZ0I+Wk+DFOg7yHaruMmEgIArZyLfSHeRD
	 QE8DezpHY+8eYXp8keBkf6MFHUxwXX/IGsfFwnOrtQCasWpdF0OD18r+5OzF6/nf7J
	 al9s/eLoErKQcEmTNZZ7TLF7yG2vVJKCvS22nf8udkazLaY7SXnhIgHF8cxuXttyuy
	 kPBuM2EbwuS40xhnfS9TedanwKSCyKm7pGNKmCzXC0teyv3FJ7n7HFtMLE7Nlecbr5
	 qTRo7Oou0oTsl8qgpyiehMwNt3xKBdvz4oQHY/ixSJS7Q5brkXUYQawah9FNimLCYh
	 U7fh60Kdxx7zg==
Date: Wed, 3 Jun 2026 16:24:26 +0100
From: Conor Dooley <conor@kernel.org>
To: Chi-Wen Weng <cwweng.linux@gmail.com>
Cc: broonie@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, cwweng@nuvoton.com
Subject: Re: [PATCH 1/2] dt-bindings: spi: Add for Nuvoton MA35D1 SoC QSPI
 Controller
Message-ID: <20260603-daybed-absentee-1b64f5caabe0@spud>
References: <20260603043551.1062112-1-cwweng.linux@gmail.com>
 <20260603043551.1062112-2-cwweng.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dmNkohdYccTOM49Q"
Content-Disposition: inline
In-Reply-To: <20260603043551.1062112-2-cwweng.linux@gmail.com>


--dmNkohdYccTOM49Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 03, 2026 at 12:35:50PM +0800, Chi-Wen Weng wrote:
> Signed-off-by: Chi-Wen Weng <cwweng.linux@gmail.com>

Missing commit message for one, but why can't your Nuvoton mail be used
here?

Sashiko had two comments about resets and num-cs that looked valid.

> ---
>  .../bindings/spi/nuvoton,ma35d1-qspi.yaml     | 61 +++++++++++++++++++
>  1 file changed, 61 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/nuvoton,ma35d1-=
qspi.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/spi/nuvoton,ma35d1-qspi.ya=
ml b/Documentation/devicetree/bindings/spi/nuvoton,ma35d1-qspi.yaml
> new file mode 100644
> index 000000000000..f7b9cb52d8e5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/nuvoton,ma35d1-qspi.yaml
> @@ -0,0 +1,61 @@
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
> +  - $ref: spi-controller.yaml#
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
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/clock/nuvoton,ma35d1-clk.h>
> +
> +    soc {
> +        #address-cells =3D <2>;
> +        #size-cells =3D <2>;
> +
> +        spi@40680000 {
> +            compatible =3D "nuvoton,ma35d1-qspi";
> +            reg =3D <0x0 0x40680000 0x0 0x100>;
> +            interrupts =3D <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
> +            clocks =3D <&clk QSPI0_GATE>;
> +            #address-cells =3D <1>;
> +            #size-cells =3D <0>;
> +
> +            flash@0 {

Drop this flash node, it serves no purpose here.

pw-bot: changes-requested

Thanks,
Conor.

> +                compatible =3D "jedec,spi-nor";
> +                spi-max-frequency =3D <30000000>;
> +                reg =3D <0>;
> +                spi-rx-bus-width =3D <4>;
> +                spi-tx-bus-width =3D <1>;
> +            };
> +        };
> +    };
> +
> --=20
> 2.25.1
>=20

--dmNkohdYccTOM49Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaiBHKQAKCRB4tDGHoIJi
0kNbAQCOgW0doQKE85Sk4jtKfNxpQIdQUC339qiL0/5yHx1NEwD9E3D0JKa6xsRm
zY/qv1p/jXCiL28U4tfuyAiUS/355wA=
=J1hd
-----END PGP SIGNATURE-----

--dmNkohdYccTOM49Q--
