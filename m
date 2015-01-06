From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: fsl-(e)spi: Support compile as module
Date: Tue, 6 Jan 2015 12:01:44 +0000
Message-ID: <20150106120144.GY2634@sirena.org.uk>
References: <1420538586-15867-1-git-send-email-esben.haabendal@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+0KmLy8UubQqhxHi"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Esben Haabendal <eha-/iRVSOupHO4@public.gmane.org>
To: esben.haabendal-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1420538586-15867-1-git-send-email-esben.haabendal-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--+0KmLy8UubQqhxHi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 06, 2015 at 11:03:06AM +0100, esben.haabendal-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org wrote:

> -#ifdef CONFIG_SPI_FSL_SPI
> +#if defined(CONFIG_SPI_FSL_SPI) || defined(CONFIG_SPI_FSL_SPI_MODULE)

This should use IS_ENABLED().

--+0KmLy8UubQqhxHi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUq86nAAoJECTWi3JdVIfQ84wIAIPOGKLGORndCrmRLXI7Niiv
bTF+A3h9piw+RYsfdjG4aZ04tNIdsOUVVvhUIn2bRQ7CJRNQJy14B/l+cScrSVUi
CBmKusi6QbKLV/7GhBauwEcSlX89bo3BlQTwXWGSOTgnRXZsEJcmtIzN+GpNYOS/
BdXVoCxod0JyN3vhkU9pYxsfmEFgds7aFi3GH6yjlEnBT2emniug+1CBOgaE5CH4
WaCh0NhPipj1kno1YnwlyatV5dFHL8JWNCgvH6D5Fa5flyxwwQSaLU1EV73h9JQ4
QGXARQH2T8e/I24PtjSc0lKRukzqtr+jZnDfhUNWfoAFqPZbpOaqokPNhyZeMgk=
=HslY
-----END PGP SIGNATURE-----

--+0KmLy8UubQqhxHi--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
