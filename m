Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586C636F42E
	for <linux-spi@vger.kernel.org>; Mon,  6 Apr 2026 12:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775480206; cv=none; b=tgye7A0bCuxldeZ/mFTarbxz2vRce/E5PjJpUwt+2cNJslXRFB2bImLeuYki+kzgTmTlW+lyY08xCZdNc8014dqU8cBSXHSjYMGChtaih2d86aA1HXkoYSthGdujKnsIzxuOHuCIhPjZi/gxhkItnTUu0efE7Rf7qu2BYQ8g6aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775480206; c=relaxed/simple;
	bh=GP2G3/1fvLQfORsXx6ZjCUCk5zUdzQ+VSvtg2MvhzeI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RXvO47Ac5pNajXD30P8krVGxOKheLcejCcV/ee7kr+L0htWb3cVmNwgzGOc12dM/TcLoyikT6KBSWzStKxsuwym69RqXDdIdNpFqgJoHkfzHfC52qssqW/72tHf4+Pgc2ndXQ2zUF6w3e2RJqxGUah8aw6DeiD8626ZOegMVVU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OiXtjd4y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OiXtjd4y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2A59C4CEF7;
	Mon,  6 Apr 2026 12:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775480206;
	bh=GP2G3/1fvLQfORsXx6ZjCUCk5zUdzQ+VSvtg2MvhzeI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OiXtjd4yNGY6+gzZ+Ou7a5NyY1pngNWyGPbSRoTLms8GgovfUd09xLVPbUZRfa3ou
	 zDSlUPj3V4eTGXl+4j3JSDDEPAILyd2ImRSci9X3+wGUL5erQUXyDQZET/M9fiQIfk
	 udwMk9w83jW7iEmo3CLeHdkkYnBvkfeegazdX8x8BsQ987Z37aaWMZI6xNT7dVTAt+
	 TgBJLbbUS/6RFAS4/qTbKkbJ5Kksa9CuUuMeJximduGQLzrJvlbApO2LgMCEb8JWLT
	 pV0QMyMN2c+oPxJ82vL9wDbY2iysR+uA65eL2HNqIVEtW9sNVliSqTcvvhMAHU7Vc1
	 MqvjGLe25RQlw==
Date: Mon, 6 Apr 2026 13:56:41 +0100
From: Mark Brown <broonie@kernel.org>
To: Pei Xiao <xiaopei01@kylinos.cn>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: gch981213@gmail.com, linux-spi@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 2/4] spi: uniphier: Simplify clock handling with
 devm_clk_get_enabled()
Message-ID: <b78ec8d7-feb9-4588-b51a-ced8d8a35a23@sirena.org.uk>
References: <cover.1775273351.git.xiaopei01@kylinos.cn>
 <ceacbce51039b10e13ec9317cd46ed2fb0354952.1775273351.git.xiaopei01@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="u4STaxXf5xtBgLcU"
Content-Disposition: inline
In-Reply-To: <ceacbce51039b10e13ec9317cd46ed2fb0354952.1775273351.git.xiaopei01@kylinos.cn>
X-Cookie: Does not include installation.


--u4STaxXf5xtBgLcU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 04, 2026 at 11:44:59AM +0800, Pei Xiao wrote:
> Replace devm_clk_get() followed by clk_prepare_enable() with
> devm_clk_get_enabled() for the clock. This removes the need for
> explicit clock enable and disable calls, as the managed API automatically
> handles clock disabling on device removal or probe failure.

Copying in the maintainers for the driver, you should generally copy
maintainers when posting patches (and to avoid large CC lists it's often
better to send patches per driver unless the series is actually related,
this one isn't).

> Remove the now-unnecessary clk_disable_unprepare() calls from the probe
> error path and the remove callback. Adjust error labels accordingly.
>=20
> Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
> ---
>  drivers/spi/spi-uniphier.c | 18 ++++--------------
>  1 file changed, 4 insertions(+), 14 deletions(-)
>=20
> diff --git a/drivers/spi/spi-uniphier.c b/drivers/spi/spi-uniphier.c
> index 9e1d364a6198..1b815ee2ed1b 100644
> --- a/drivers/spi/spi-uniphier.c
> +++ b/drivers/spi/spi-uniphier.c
> @@ -666,28 +666,24 @@ static int uniphier_spi_probe(struct platform_devic=
e *pdev)
>  	}
>  	priv->base_dma_addr =3D res->start;
> =20
> -	priv->clk =3D devm_clk_get(&pdev->dev, NULL);
> +	priv->clk =3D devm_clk_get_enabled(&pdev->dev, NULL);
>  	if (IS_ERR(priv->clk)) {
>  		dev_err(&pdev->dev, "failed to get clock\n");
>  		ret =3D PTR_ERR(priv->clk);
>  		goto out_host_put;
>  	}
> =20
> -	ret =3D clk_prepare_enable(priv->clk);
> -	if (ret)
> -		goto out_host_put;
> -
>  	irq =3D platform_get_irq(pdev, 0);
>  	if (irq < 0) {
>  		ret =3D irq;
> -		goto out_disable_clk;
> +		goto out_host_put;
>  	}
> =20
>  	ret =3D devm_request_irq(&pdev->dev, irq, uniphier_spi_handler,
>  			       0, "uniphier-spi", priv);
>  	if (ret) {
>  		dev_err(&pdev->dev, "failed to request IRQ\n");
> -		goto out_disable_clk;
> +		goto out_host_put;
>  	}
> =20
>  	init_completion(&priv->xfer_done);
> @@ -716,7 +712,7 @@ static int uniphier_spi_probe(struct platform_device =
*pdev)
>  	if (IS_ERR_OR_NULL(host->dma_tx)) {
>  		if (PTR_ERR(host->dma_tx) =3D=3D -EPROBE_DEFER) {
>  			ret =3D -EPROBE_DEFER;
> -			goto out_disable_clk;
> +			goto out_host_put;
>  		}
>  		host->dma_tx =3D NULL;
>  		dma_tx_burst =3D INT_MAX;
> @@ -766,9 +762,6 @@ static int uniphier_spi_probe(struct platform_device =
*pdev)
>  		host->dma_tx =3D NULL;
>  	}
> =20
> -out_disable_clk:
> -	clk_disable_unprepare(priv->clk);
> -
>  out_host_put:
>  	spi_controller_put(host);
>  	return ret;
> @@ -777,14 +770,11 @@ static int uniphier_spi_probe(struct platform_devic=
e *pdev)
>  static void uniphier_spi_remove(struct platform_device *pdev)
>  {
>  	struct spi_controller *host =3D platform_get_drvdata(pdev);
> -	struct uniphier_spi_priv *priv =3D spi_controller_get_devdata(host);
> =20
>  	if (host->dma_tx)
>  		dma_release_channel(host->dma_tx);
>  	if (host->dma_rx)
>  		dma_release_channel(host->dma_rx);
> -
> -	clk_disable_unprepare(priv->clk);
>  }
> =20
>  static const struct of_device_id uniphier_spi_match[] =3D {
> --=20
> 2.25.1
>=20

--u4STaxXf5xtBgLcU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmnTrYkACgkQJNaLcl1U
h9BANAf/dGJNmZSLngxXkP5KrH7SAaqgzVoQ8E7caLpgNcnt7eQ/XEPybZJXhU0k
FemXsGHiNndHMYJPmHlv459ASIGN4xCXLMhWW0pBXLgHJL/KMpLFPhgsd8jn6P+2
gmNCmv6+TKuIIatosm2lE5hxuIXSfcUMmy9ADjzwgqq6poQa1L+wzIDMUBs70V1O
bVIlMufK5Y0dZ+yFqqoYIvg8QH7100bphzKLsVwucjJGB41xg66giiSwz3AAztv8
wc6x0F22Zn6CJoNtr8KSnloNTgKc6/RDCx8eqgI9XbWrBgfBId3Ah2fdNbs5lOGp
aFMmpfwFV0RmuFWkF6+xOKUdl/N4qg==
=ndBj
-----END PGP SIGNATURE-----

--u4STaxXf5xtBgLcU--
