From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] spi: davinci: fix SPI_NO_CS functionality
Date: Thu, 21 Aug 2014 13:10:15 -0500
Message-ID: <20140821181015.GL24407@sirena.org.uk>
References: <1408634706-5762-1-git-send-email-grygorii.strashko@ti.com>
 <1408634706-5762-2-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0OMWfJhzSPULbgPV"
Cc: santosh.shilimkar-l0cyMroinI0@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	m-karicheri2-l0cyMroinI0@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1408634706-5762-2-git-send-email-grygorii.strashko-l0cyMroinI0@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--0OMWfJhzSPULbgPV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 21, 2014 at 06:25:05PM +0300, Grygorii Strashko wrote:
> The driver should not touch CS lines if SPI_NO_CS flag is set.
> This patch fixes it as this functionality was broken accidentally
> by
> commit a88e34ea213e1b ("spi: davinci: add support to configure gpio cs through dt").

Applied, thanks.

--0OMWfJhzSPULbgPV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT9jYDAAoJELSic+t+oim9eKMP/j/lyigljtlU98/CTCHmNB5j
6FToZwhFwZgXTEUbPJOJu0brfir/FXZOXwG8RqgqUYQrXnm4MgAHli3lD4kNmkn8
zM+EsTl7wCJAJmJ7VX9KitXejQb7zmJ9T+gOgU/CUNsL7xdiEVGmgfX3jyycVe6k
ZlCI/eb6+XALF91/OoQqrKrRMX5EPzIlO11oaP7/iEIC+jP6WZ1OcNL/TurmfkiR
u4tfhpEe4Ax9ivlokcARXGOlw5kzqztRW2IrQoJgeyFDOAIiRMdAY49TchraQpzn
RzcWDbAfTs4/59525CX0lwsdKXqzyjrEortfLSvfsw7OhIvTxQsSue3cwRBfc5RZ
GT38e8/M3tALfH0lcDliE7Pw93qBMu4q3HGzDx+PqQcA9wzMN5uqJutAwHLgCAkh
a1wbblL+iRWlr+jlux0zrPxRzCqkkAvaNyU6e0U4mm337RlYoIjplc2EbC3m9//R
lA9P4VwLlJUk/jk94Oat3m8CSTNcgF48VwXfFc3pkYU08DUf0yZbuPamtEGRc8jO
Y4v9CaJsv6AK9ZfRaXDFz3Gwvs+euJFQez3tmZ0NROEktSA7wvR2ywMJrinVR3pa
kEyHJpe22FMCkgprbeQo2+foExklmgGOGOzY6mbZpgMTl+3VDJSg3bExkbWfYAfY
bA67ljmSmeHTNdGKaoHv
=UsNd
-----END PGP SIGNATURE-----

--0OMWfJhzSPULbgPV--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
