From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2] spi: omap2-mcspi: Add gpio_request and init CS
Date: Fri, 8 May 2015 19:55:20 +0100
Message-ID: <20150508185520.GJ2761@sirena.org.uk>
References: <1431109861-6853-1-git-send-email-mwelling@ieee.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="liqSWPDvh3eyfZ9k"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Welling <mwelling-EkmVulN54Sk@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1431109861-6853-1-git-send-email-mwelling-EkmVulN54Sk@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--liqSWPDvh3eyfZ9k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 08, 2015 at 01:31:01PM -0500, Michael Welling wrote:
> If GPIO chip select is specified, request the GPIO in the setup function
> and release it in the cleanup function.

Applied, thanks.

--liqSWPDvh3eyfZ9k
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVTQaYAAoJECTWi3JdVIfQwwAIAICU7unW+yAVyVyClZbyOyJP
WhRRA7n4kd7URNHs9vbBoPzrG0rPl28KOnO3z0ZUcUJVyFShb3irw+LXKFf3GMJC
qlDB/GBpYejyL2eN5R8Nj2UK5Z5/kJz+T8lgYgT2FFTmu0vJglphz7yKkkFS46FU
N3DC6J2Q/6q3XLXBqN778OOoFjQUVCB2Wm9dg799kj+Bwbhrst2DWfMdPwA5b2b4
rFhnnrji0+6DQfxxxyk2suND5BPdq2SFYB4sRlVrhut2CUfJpsHbvwZkiizwIFlG
GbxaqhbLLY5Q0W3Az4EF29PR4yvUcYd74CjZMQsJ9QeMd5puwvJ8bvP1USV4MiA=
=OSw2
-----END PGP SIGNATURE-----

--liqSWPDvh3eyfZ9k--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
