From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 02/11] spi: fsl-espi: remove unneeded check for
 SPI_QE_CPU_MODE
Date: Thu, 6 Oct 2016 17:45:43 +0200
Message-ID: <20161006154543.rxlrc3sumejozpcg@sirena.org.uk>
References: <5b98be38-17a2-79a2-14da-fb2bb6f8820f@gmail.com>
 <20608368-44e6-21f8-d970-5ade9990ce59@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6narcofgn5rsqisq"
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20608368-44e6-21f8-d970-5ade9990ce59-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--6narcofgn5rsqisq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Oct 02, 2016 at 02:22:48PM +0200, Heiner Kallweit wrote:
> SPI_QE_CPU_MODE doesn't exist for ESPI and is set by of_mpc8xxx_spi_probe
> based on DT property "mode". This property is not defined for ESPI,
> see Documentation/devicetree/bindings/spi/fsl-spi.txt
> Therefore remove the check.

Shouldn't we be warning if we encounter a DT that has this set since it
probably indicates that something went wrong?

--6narcofgn5rsqisq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAABCAAGBQJX9nGmAAoJECTWi3JdVIfQ0qYH/Agrv2OQhPsjCLcGoTqArVHd
oUYj/thuxnU181ChRjD4SRYWFCGZBXwTfHwzcuGhbM41Mbv5iQgtOQJefOxMjoZ8
CC6Hk1EKCYC0DlgBOhPuIhPJFn0yAUmYl0ueZBm1yRfRuVhePHZOrupzVIA+M76e
Yx0zGyE8+1DRnUqp7mYO7PrMd2SgatlxAOFUpCvpqRdF2OVhfbwmwuz/4HI0SIQt
BPtqgQ9WyCeXIZrJSWx05elwi/fCfJp7jTClLTnTp1KoDBNP+h2CTp0lQ37JUCNW
EdO+9lsQocFaslFJRqxSP+2LBWqxGf2oxD5dw0OYDiWPMLGUKopfiq4bYXtlCuM=
=KHue
-----END PGP SIGNATURE-----

--6narcofgn5rsqisq--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
