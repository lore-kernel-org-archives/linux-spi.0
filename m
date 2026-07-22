Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D3946EF8C;
	Wed, 22 Jul 2026 16:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784738788; cv=none; b=YyUk+n7SW/VIa/ORi/e5nBf4DVGgjWS3LcHTiD29iwxh+rfqu9NVIvoiK/dqkqjbgUi2hNsMC2/KMNiOC5cFOq4xWj2x0KGEDuj+cfZ2L4P9+CnGtxzsg9/0wsk652OuR3yiiBICfk21585tIBQBPHpiL0hRHjmTqyLOqYHr2oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784738788; c=relaxed/simple;
	bh=wy9889ywZyXjB8TSkRKsFnyt1F8rIxKEnnNuJ4OM0YQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DjUmwtTyePBDcDW2AOCjqVLYpdGdyM/IgeA/+nrI/m6//j7wn4zHJQ1DTNpRNxIYAMMBpNy1csosC2oHe+WI/nVDqm+HHWG6bKJoDVNG8buunKaJlSlHTmUWG49LWLLJRy5qFAog3j32m0YYSCTwUggebDKMUQVdkDOjM8nBdqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cnxW2ckT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cnxW2ckT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4934B1F000E9;
	Wed, 22 Jul 2026 16:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784738777;
	bh=1AsC7BFG5mj92FJSoHowKooJs6gEPFD7nWYs6mjDbh0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cnxW2ckTw/3C5NxLkORl5zEfiqs3MuVpK71LXlX/M3EOPYsLP4fEOP5TG3KFwmZwL
	 eXHbOns5sAw1gmrYHWLYxMzIJdRONeyyvIbd1rVKus/sJoBQ7iK1bKd6k+c+qvgZGU
	 Hc2HeW6o7Ex9GmPXO8x8WiJSQj98rj/KqpSOIIZeZpNiJ1sTS23LnrNC/H+aUIaSY9
	 oBilkqgwShMHwo1Y3GD2NInFd15JkDWknwaWMOC4XUTA3B05w2+xyXA5Ixpb8FuRwh
	 Tj/WMuZWZEQ06ZuHY36i8inF0GtRb5lX2xnHo2mxmw4bNIE0t81fkWFLzqSrzTHAM3
	 0ywAdQNCIO/aQ==
Date: Wed, 22 Jul 2026 17:46:12 +0100
From: Conor Dooley <conor@kernel.org>
To: han.xu@oss.nxp.com
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Haibo Chen <haibo.chen@nxp.com>,
	Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
	Han Xu <han.xu@nxp.com>
Subject: Re: [PATCH v2 1/3] spi: dt-bindings: nxp,imx94-xspi: add DMA
 properties
Message-ID: <20260722-divinity-urethane-da0cab030adb@spud>
References: <20260721-xspi_dma_upstream-v2-0-9e19d80e7762@nxp.com>
 <20260721-xspi_dma_upstream-v2-1-9e19d80e7762@nxp.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uzpimjthc/PatwgU"
Content-Disposition: inline
In-Reply-To: <20260721-xspi_dma_upstream-v2-1-9e19d80e7762@nxp.com>

--uzpimjthc/PatwgU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 21, 2026 at 04:01:42PM -0500, han.xu@oss.nxp.com wrote:
> From: Han Xu <han.xu@nxp.com>
>=20
> Add dmas and dma-names to describe TX and RX DMA channels for the i.MX94
> XSPI controller.
>=20
> Signed-off-by: Han Xu <han.xu@nxp.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

> ---
>  Documentation/devicetree/bindings/spi/nxp,imx94-xspi.yaml | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/spi/nxp,imx94-xspi.yaml b/=
Documentation/devicetree/bindings/spi/nxp,imx94-xspi.yaml
> index 16a0598c6d033..ccf841f194c06 100644
> --- a/Documentation/devicetree/bindings/spi/nxp,imx94-xspi.yaml
> +++ b/Documentation/devicetree/bindings/spi/nxp,imx94-xspi.yaml
> @@ -30,6 +30,16 @@ properties:
>        - const: base
>        - const: mmap
> =20
> +  dmas:
> +    items:
> +      - description: Transmit DMA
> +      - description: Receive DMA
> +
> +  dma-names:
> +    items:
> +      - const: tx
> +      - const: rx
> +
>    interrupts:
>      items:
>        - description: interrupt for EENV0
>=20
> --=20
> 2.34.1
>=20

--uzpimjthc/PatwgU
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCamDz1AAKCRB4tDGHoIJi
0gBjAQDDaTVY/p3HfrZwRPlKeI6O0mHfuCHsA7jzs8i8/hBsHQEAn37K39nj07xY
j6UCwmnMPTvle1FzwgbmdqflUB0/0Ao=
=Wa/1
-----END PGP SIGNATURE-----

--uzpimjthc/PatwgU--
