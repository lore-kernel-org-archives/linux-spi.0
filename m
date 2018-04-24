From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] spi/bcm63xx-hspi: Enable the clock before calling
 clk_get_rate().
Date: Tue, 24 Apr 2018 18:32:53 +0100
Message-ID: <20180424173253.GF22073@sirena.org.uk>
References: <20180419130358.r7dva6owy2izyfus@agrajag.zerfleddert.de>
 <dfb9c72c-6289-a2ea-c3d4-c59f5e3c799c@broadcom.com>
 <20180424161605.GA17825@er01809n.ebgroup.elektrobit.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="z0eOaCaDLjvTGF2l"
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jonas Gorski <jonas.gorski@gmail.com>,
        ldv-project@linuxtesting.org, sil2review@lists.osadl.org
To: Stefan Potyra <Stefan.Potyra@elektrobit.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180424161605.GA17825@er01809n.ebgroup.elektrobit.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--z0eOaCaDLjvTGF2l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 24, 2018 at 06:16:05PM +0200, Stefan Potyra wrote:

> +	ret =3D clk_prepare_enable(clk);
> +	if (ret)
> +		return ret;
> +
>  	rate =3D clk_get_rate(clk);
>  	if (!rate) {
>  		struct clk *pll_clk =3D devm_clk_get(dev, "pll");
> @@ -364,10 +368,6 @@ static int bcm63xx_hsspi_probe(struct platform_devic=
e *pdev)
>  			return -EINVAL;
>  	}
> =20
> -	ret =3D clk_prepare_enable(clk);
> -	if (ret)
> -		return ret;
> -

We can return an error after the clock was enabled, this will leake the
clock if that happens.

--z0eOaCaDLjvTGF2l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlrfakUACgkQJNaLcl1U
h9D4bgf+J6y1UloIi6nrD3w10mYBHYTy/sHpIZUvMNIhg8AoJ8flP3t4TB4+djjJ
HOG0IqvjlBzc0kyyOgGBW97z3HvTvy+iZAQgHctjhVPspVLJQ4sZq0FAnkonEMpZ
2aEVaYvijzInM6ooUE0a//6BGPtyX3V4y2bMcqyWZGx9AS6J6WZJHEInSlPngq5s
+Zp1Wu0oHjPA6fsauACKbgWl5aheQy597RpksN6cNJMbvcxSsgZxHY7y2UG8s2Bl
kaqDkNh34qbGudLd+eWk8aWajMDm1UevFaNj4FfS1wXXBiGOT0YqVj6ezEr4Dgoq
1w93AHUEleTSljxo+WZp8rv6+4I90g==
=S6fH
-----END PGP SIGNATURE-----

--z0eOaCaDLjvTGF2l--
