Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E337E3F7A9A;
	Thu, 24 Sep 2026 17:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790270937; cv=none; b=ekHTD7aB9cHoH7XkJAugA6nQ6B4B5gpKqxRJdj0YZAZKROQDnjRd9qewQbWxNJn5XHHJFyC86Am4cXEadqIzxz0hUOFf28QOkqX8FyFl9k8/Gpx0bdeTL92qjdr69zvz0f/yqUEknwiOX2f7D6R+5ZvgKvI85ffaFuZdoE7X2nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790270937; c=relaxed/simple;
	bh=kN/YLPWiRx9gp5E8il2s/nWBMNzMrRwIsb7Q6U5tL/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RCPqrKiR1ELIJVLaexjegKx3U5Jh8KbSIP1zIZhEPJ71it+DyKJbZG9uMK8K58pjGU3XByJ2VW/4Cw/swhiFh/EFdyGcp2dcp6kg2M8eFfNdq/Olhc1l6m7MowTM8fSfEQp6yWPqvth9Q52QlbetwxSeF7MjF9NG2i1thSyekRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BGx005Gd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BGx005Gd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF3321F000FF;
	Thu, 24 Sep 2026 17:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790270935;
	bh=HS6m04rT3dOvoL5x89+MtBS0pBgWi1yvccw8gpPQtuk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BGx005GdlIlQyudQ3+InR44vBRLyWtMrFpW0ok1xe5xh0z41MLv6BY/xnAsCvAdx9
	 CaCM5KZpJGUK9g5ASRub06TkGcCGuXz2emECuei+BOaeeQIdQgHuJi9OyP5BxJGOOu
	 l9lSWMxrYVNufHoRn61XaIGels3P6tGxDaY4zjq3VybLW3uUm+2Vmr2pDKP1FJ8qYe
	 /ENyDmcR2m8tS8Yz8b94LIU2f1g1yV+kZt82K6NrRq+NAcVm44+MnfF4SnRu+iBP9o
	 xs/x7lgGEKcci/p5PwP1o+IibSeUiQPssyXzbyTYTMP+G3z6h6oXuGoHvOXSMlIhEY
	 7+L0HWA1fzntw==
Date: Thu, 24 Sep 2026 18:28:50 +0100
From: Conor Dooley <conor@kernel.org>
To: Tim Kuo <Tim.Kuo@mediatek.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Steven Liu <Steven.Liu@mediatek.com>,
	Sky Huang <Skylake.Huang@mediatek.com>
Subject: Re: [PATCH 1/2] dt-bindings: spi: mediatek: add mediatek,spi-ipm-v59
 compatible
Message-ID: <20260924-patriot-stipend-764fd2d3593a@spud>
References: <20260924031211.2199921-1-Tim.Kuo@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="DO88kflOB9JUgeoi"
Content-Disposition: inline
In-Reply-To: <20260924031211.2199921-1-Tim.Kuo@mediatek.com>

--DO88kflOB9JUgeoi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 24, 2026 at 11:12:10AM +0800, Tim Kuo wrote:
> The IPM v59 SPI IP differs from earlier IPM designs, most visibly in the
> tick delay field of SPI_CMD_REG, so it needs its own fallback compatible
> rather than reusing "mediatek,spi-ipm".
>=20
> Signed-off-by: Tim Kuo <Tim.Kuo@mediatek.com>
> ---
>  .../devicetree/bindings/spi/mediatek,spi-mt65xx.yaml         | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.ya=
ml b/Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml
> index 3bf3eb1f8728..08a3497b03dc 100644
> --- a/Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml
> +++ b/Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml
> @@ -39,6 +39,10 @@ properties:
>                - mediatek,mt7988-spi-single
>                - mediatek,mt8188-spi-ipm
>            - const: mediatek,spi-ipm
> +      - items:
> +          - enum:
> +              - mediatek,mtxxxx-spi

NAK to anything like this with wildcards. Put a real device here please.
pw-bot: changes-requested

> +          - const: mediatek,spi-ipm-v59
>        - items:
>            - enum:
>                - mediatek,mt8196-spi
> @@ -55,7 +59,6 @@ properties:
>                - mediatek,mt8135-spi
>                - mediatek,mt8173-spi
>                - mediatek,mt8183-spi
> -
>    reg:
>      maxItems: 1
> =20
> --=20
> 2.45.2
>=20

--DO88kflOB9JUgeoi
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCarVd0gAKCRB4tDGHoIJi
0lbXAP99qejd5aXdHbNXFotyiWbXU2pBSVj475K+swxGScOm2QD6AoVaFfs7Dugz
8SX/SSAPox6qrQZkU8IyXBtgE0Eoogk=
=NBrN
-----END PGP SIGNATURE-----

--DO88kflOB9JUgeoi--
