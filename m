From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 1/3] spi: spidev: fix the check for spidev in dt
Date: Mon, 27 Jun 2016 21:36:17 +0100
Message-ID: <20160627203617.GI17217@sirena.org.uk>
References: <cover.1467053363.git.hramrach@gmail.com>
 <0123f28025f0a29a0771a43397ad14259a2094b7.1467053363.git.hramrach@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="IbA9xpzOQlG26JSn"
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <0123f28025f0a29a0771a43397ad14259a2094b7.1467053363.git.hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--IbA9xpzOQlG26JSn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 27, 2016 at 09:02:30PM +0200, Michal Suchanek wrote:

> Also the spidev id match table is not compiled when !CONFIG_OF

To repeat what I said last time we have stub defines for this stuff for
a reason.

> This does not work if you manage to convince the kernel to bind spidev
> on a node that has some other random compatible which is not "spidev".

...which is only possible if the other problematic changes in this
series are merged so as I was suggesting last time this needs to be
pushed to the end of the series.

--IbA9xpzOQlG26JSn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXcY4/AAoJECTWi3JdVIfQFyEH/iPz0zZiWEVl7mKo0oMeLpte
0Dr7wGrdBH0gPH0jsqNbtgoKUv65eAdDHvjj7vrEjAZp4BH9sC4b6BBOvFrZufi6
WgVM5V8KgLZcl5pzsm2oDDwavJi7eNU2K2RbQ0y+8Bji05ronELn/MtiS1a8uc7S
+HGk02QC7GUmwpJcMSTr9amJ5J1ub4V88xWvv4MHt3dHNud7gcEotZedR4CV6TRr
Y2ow/sQmVLKZJWlfSwmKQppZWylNWJ52hPARlEvDDNL7LqzH8R8KtOi9q8F6lLiN
PRkcLtNMXmTtDlxyzPQ6AAE0nZYBXUHzgSuXEd944KF9p0GxU8pX9Se9cZv9/7g=
=07JM
-----END PGP SIGNATURE-----

--IbA9xpzOQlG26JSn--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
