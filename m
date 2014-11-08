From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] spi: add support for DLN-2 USB-SPI adapter
Date: Sat, 8 Nov 2014 10:46:06 +0000
Message-ID: <20141108104606.GH2722@sirena.org.uk>
References: <1415364314-30320-1-git-send-email-laurentiu.palcu@intel.com>
 <1415364314-30320-2-git-send-email-laurentiu.palcu@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="h3LYUU6HlUDSAOzy"
Cc: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Johan Havold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Octavian Purdila <octavian.purdila-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Laurentiu Palcu <laurentiu.palcu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1415364314-30320-2-git-send-email-laurentiu.palcu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--h3LYUU6HlUDSAOzy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 07, 2014 at 02:45:13PM +0200, Laurentiu Palcu wrote:

> +static int dln2_spi_transfer_one_message(struct spi_master *master,
> +					 struct spi_message *msg)

It's a bit sad not to do transfer_one() but it's reasonable not to
because of the fun way /CS is being set.

> +	ret = dln2_spi_get_speed_range(dln2,
> +					   &master->min_speed_hz,
> +					   &master->max_speed_hz);

Strange indentation here.

> +static int dln2_spi_remove(struct platform_device *pdev)
> +{
> +	struct spi_master *master = spi_master_get(platform_get_drvdata(pdev));
> +	struct dln2_spi *dln2 = spi_master_get_devdata(master);
> +
> +	if (dln2_spi_enable(dln2, false) < 0)
> +		dev_err(&pdev->dev, "Failed to disable SPI module\n");
> +
> +	spi_master_put(master);

You shouldn't need this _put(), it's defeating the purpose of having the
devm_ registration.

--h3LYUU6HlUDSAOzy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUXfRtAAoJECTWi3JdVIfQeKgH/AzPYlV/+iFcPfPOiXEKPXzr
GmURLOB+FzvIiV4sFHglMMJAdroggxqWJQrEB5PUKxOxtNS7RSBlqa18Nq7rBio9
N0+p6uf7iiaxPYxL7sy2Wy7VdVl9cqAXdUiGrmbB7VJVyHp9DvMYhWKX87SChLL6
lePUJwT9Wjb2CXURx4wl+MdZONJccHs9UINTbOiDHPKpK9TdQkE9m2SNguth0VgN
BRi/kSmdBWh7TQPaqj1RJbpA3JO6yZh0nc0jSTJtuABOgsfGZcRQneiuJhRdQbIO
xHiP8AtCitMahd5sgpDfLLlBeUf47VJ4zVzMsGrqVoa7jAoW6K5ZyQ9CXSSPCmo=
=RriI
-----END PGP SIGNATURE-----

--h3LYUU6HlUDSAOzy--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
