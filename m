From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/3] spi: mediatek: Add spi bus for Mediatek MT8173
Date: Fri, 8 May 2015 18:53:06 +0100
Message-ID: <20150508175306.GG2761@sirena.org.uk>
References: <1431075343-7887-1-git-send-email-leilk.liu@mediatek.com>
 <1431075343-7887-3-git-send-email-leilk.liu@mediatek.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+1TulI7fc0PCHNy3"
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>,
	Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>,
	Eddie Huang <eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>,
	Hongzhou Yang <hongzhou.yang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>,
	Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org,
	Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
To: leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1431075343-7887-3-git-send-email-leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--+1TulI7fc0PCHNy3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 08, 2015 at 04:55:42PM +0800, leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org wrote:
> From: Leilk Liu <leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
>=20
> This patch adds basic spi bus for MT8173.

Please try to only CC relevant people on patches, you've got a very
broad CC list here and I'm not sure I understand why everyone is on it.
Sending people irrelevant patches adds to the volume of mail people have
to handle which takes time away from other things.

> +config SPI_MT65XX
> +	tristate "MediaTek SPI controller"
> +	depends on ARCH_MEDIATEK || COMPILE_TEST
> +	select SPI_BITBANG

Unless your controller is geniunely bitbanging you shouldn't be using
the bitbang framework, modern drivers should implement set_cs() and
transfer_one() instead.  You should also be using the core helpers for
DMA mapping.

The driver looks basically good other than this, it shouldn't be too
much work (and ought to save you some code) to refactor to the modern
interfaces.

> +#define IDLE 0
> +#define INPROGRESS 1
> +#define PAUSED 2
> +
> +#define PACKET_SIZE 1024

You should namespace the constants you're using to avoid clashes with
headers.

> +static const struct of_device_id mtk_spi_of_match[] =3D {
> +	{ .compatible =3D "mediatek,mt6589-spi", .data =3D (void *)COMPAT_MT658=
9},
> +	{ .compatible =3D "mediatek,mt8173-spi", .data =3D (void *)COMPAT_MT817=
3},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, mtk_spi_of_match);

There were three compatible strings listed in the DT binding but only
two here.

> +	/*set the software reset bit in SPI_CMD_REG.*/

/* Spaces please */

> +static unsigned long mtk_get_device_prop(struct platform_device *pdev)
> +{
> +	const struct of_device_id *match;
> +
> +	match =3D of_match_node(mtk_spi_of_match, pdev->dev.of_node);
> +	return (unsigned long)match->data;
> +}

This wrapper doesn't seem to be doing a lot and will crash if we somehow
manage to get the driver loaded without a match (eg, if someone tries to
instantiate as a regular platform device).

> +	ret =3D clk_prepare_enable(mdata->clk);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "failed to enable clock (%d)\n", ret);
> +		goto err;
> +	}

I'd expect to see runtime PM callbacks to enable and disable this clock
in order to minimise power consumption.

--+1TulI7fc0PCHNy3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVTPgBAAoJECTWi3JdVIfQ1w8H/3hvZfa5cZV1niiOOz8VUzKE
bajMDrcI6pptir27kXkEqbvPnzdM2esDaD80IJZblj3y5+fEJ2ogzlLsO2uyOoHZ
lU1ebAU+YOueKBRhpodDbV/i3mlL8NAf1BlM3YImOdwalRRDxxXGpyGowkzp1AcU
AwguJZuBUSGeYEpuWZLOqgEEo/MxlCb46YMQ7Lcrvvd3X0yCDN4X5F2XTrpn5EE7
odrGz0qhsZsgDvvLBNDon1Rfr6qVdNTnXqtFluHge29bqyjjDrMOk9xTXLQ+0/my
exAfdhZ+C751HY0TfH/+9vwO5nLqlJBOyceHT7vo1oJleDBUOT1dfsS37MV0AjE=
=4+lo
-----END PGP SIGNATURE-----

--+1TulI7fc0PCHNy3--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
