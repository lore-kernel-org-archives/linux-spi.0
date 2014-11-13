From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V2 2/2] spi: Add driver for IMG SPFI controller
Date: Thu, 13 Nov 2014 17:44:05 +0000
Message-ID: <20141113174405.GJ3815@sirena.org.uk>
References: <1415848096-20079-1-git-send-email-abrestic@chromium.org>
 <1415848096-20079-3-git-send-email-abrestic@chromium.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KFqA3NAzXT9iu/Yo"
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	James Hartley <James.Hartley-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>,
	Ezequiel Garcia <Ezequiel.Garcia-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1415848096-20079-3-git-send-email-abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org


--KFqA3NAzXT9iu/Yo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2014 at 07:08:16PM -0800, Andrew Bresticker wrote:

> +#ifdef CONFIG_PM_SLEEP
> +static int img_spfi_suspend(struct device *dev)
> +{
> +	struct spi_master *master =3D dev_get_drvdata(dev);
> +
> +	return spi_master_suspend(master);
> +}

This should really be checking that the device is runtime suspended and
disabling the clocks if not, if nothing else someone might be running
with !CONFIG_RUNTIME_PM. =20

One of these days we'll get runtime and system PM playing more
frictionlessly but not today.

--KFqA3NAzXT9iu/Yo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUZO3kAAoJECTWi3JdVIfQtLwH/RvmbswLLjnV97UEwcv5mbmt
O1MtBjlqfg64Ls6llZYSAjq1gInOzM4An3Wn36zEcHaYYRKiLLQPB5NO1qouTpVD
c09Zm9le2W2Rkw2f10gXQLOPeKSev7meTEk/c7Rh0TBHV6XKrDUDHzNPu8Cw8MuV
4+PyU0Q3liBdOG5qJTuCz/rGSfsBIHa8sn805Z2iIn8yfKo62VYHkQtfydJJ/UZt
wFgrtzZ8bChJ2csOh9CSGweXEzBGFKvVBPPGizx7LOUUuj+AO0DjJxFh4wWRCigw
myq5IxLOhLJoG4IMVngxM2wRbvcjupBxrygeTfJPrF9v+K+aQGo+AYa8mlJG84U=
=TciD
-----END PGP SIGNATURE-----

--KFqA3NAzXT9iu/Yo--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
