From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 5/6] spi: octeon: Split driver into Octeon specific and
 common parts
Date: Sun, 24 Jul 2016 21:54:16 +0100
Message-ID: <20160724205416.GA6345@sirena.org.uk>
References: <cover.1469174814.git.jglauber@cavium.com>
 <edfc55f3653fedd5e13a8bd1282e089b269a4e61.1469174814.git.jglauber@cavium.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="DocE+STaALJfprDB"
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	"Steven J. Hill" <steven.hill-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>,
	David Daney <david.daney-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
To: Jan Glauber <jglauber-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <edfc55f3653fedd5e13a8bd1282e089b269a4e61.1469174814.git.jglauber-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jul 23, 2016 at 12:42:54PM +0200, Jan Glauber wrote:

> +	dev_info(&pdev->dev, "OCTEON SPI bus driver\n");

This is just noise, remove it.

--DocE+STaALJfprDB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXlSr3AAoJECTWi3JdVIfQMWsH/iVDqnSA4b1bxEz0a/q+SdZW
6asSwzuwpc6A5cBvMiW9KAuGGVtjJUuZbvOFiV25SWddEeqllBOHG9MQvCmQP7Ou
9jM6B4kFO81zGTyupc/HaIypOeOo0HC5Bsn1e1oOxS9dqCkTqDv9NWeUFmyO4Gn3
sVK2V4osikTYIQ8K0cTyHbtzWPR5qJ2VOyCqAdUMJt0lZcJcyUSFj2L3YlJUV2sx
YWyH8VBPKMwfi/pjULGs/GMMgw/vShfMeIHZ+kwFwqCZdig6HULswRRL3nxwNXvd
zoRnFVjecOxRveWa90jwvrxJGym22sol3XMibmSavln03kdzr9AMd5yw8vwyeOk=
=+kob
-----END PGP SIGNATURE-----

--DocE+STaALJfprDB--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
