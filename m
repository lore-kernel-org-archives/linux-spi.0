From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: spidev_test: add option to continously transfer data
Date: Mon, 20 Mar 2017 17:30:15 +0000
Message-ID: <20170320173015.ogglmi2nr24xkphj@sirena.org.uk>
References: <1490017535-31546-1-git-send-email-fisaksen@baylibre.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kz5qgw5wnzow2jlv"
Cc: nsekhar-l0cyMroinI0@public.gmane.org, khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Frode Isaksen <fisaksen-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1490017535-31546-1-git-send-email-fisaksen-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--kz5qgw5wnzow2jlv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 20, 2017 at 02:45:35PM +0100, Frode Isaksen wrote:

> +	for (i=0; i < len; i++)

Coding style...  otherwise this looks good.

--kz5qgw5wnzow2jlv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAljQEaYACgkQJNaLcl1U
h9CqCgf8C5d8OgB1C78/ly/wJhB/XVG+HJmFV+9CT/ccL4qdwmvgaGPjgQw4gr91
Y7F6BdSc4bqhZZCooLdraN/zEh5DF5dRzSvg5nOW666pAZ4kF0+8C8NyQoDswesK
W6E6Yff0Qzjq+rgalXR/gGdugmZUQ5X4E5rz7rVuesng4b/wqviO3ANEtxSbvHaZ
z+LsuWRx99nipR5oZBskCrm7vvJMoYrh2ZLWClN8fFeR5CtKlmTAke16z7w2Nz+G
px8NcArhAUKZhVh04uupi95V57H0l+m+lkVLfZYOuBLeGVI3Q6QXNmX1sUffi67u
clJWZYRc5oJLlUrmK/+WNH6EoQPeVg==
=pjtC
-----END PGP SIGNATURE-----

--kz5qgw5wnzow2jlv--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
