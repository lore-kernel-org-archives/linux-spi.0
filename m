From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH, V4, 5/5] mtd: m25p80: Let m25p80_read() fallback to spi
 transfer
Date: Wed, 22 Jun 2016 17:08:02 +0100
Message-ID: <20160622160802.GR28202@sirena.org.uk>
References: <1466197433-11290-1-git-send-email-kdasu.kdev@gmail.com>
 <1466197433-11290-5-git-send-email-kdasu.kdev@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="h5TCuzcqTWZxfGfk"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
	bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, vikram.prakash-dY08KVG/lbpWk0Htik3J/w@public.gmane.org,
	andy.fung-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, jon.mason-dY08KVG/lbpWk0Htik3J/w@public.gmane.org
To: Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1466197433-11290-5-git-send-email-kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--h5TCuzcqTWZxfGfk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 17, 2016 at 05:03:53PM -0400, Kamal Dasu wrote:
> In m25p80_read() even though spi_flash_read() is supported
> by some drivers, under certain circumstances like unaligned
> buffer, address or address range limitations on certain SoCs
> let it fallback to core spi reads. Such drivers are expected
> to return -EAGAIN so that the m25p80_read() uses standard
> spi transfer.

This is a patch to the MTD subsystem, you need to send it to the MTD
maintainers as covered in SubmittingPatches.

--h5TCuzcqTWZxfGfk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXarfhAAoJECTWi3JdVIfQzAwH+QFSiZbGzQJr563T0hU8UuLK
qNCeeNjRxpTNkcJEz1CqxWdPxiO3TL0nLSED/K3XvgzlsL9bcAAtxe8rAwYhzpNh
xGXnWQEW9fx3azLXbq4n7wYax2keaDMYj/xa665Wurmi8V6Eo1DLmd5rd6y69u7w
wiCJ5sd4JRmxWwRozWW6oXkMF0/SMo0fGvmxtzzKNaN7t6zmeB2cTcsukJY5Ufc9
aB8vJ3ay+BD+ves4WP8PUBarcL92lN7X7XUMzQgcXZIUuMsEVWVSLqjvzvV9RSWc
cAkxasSm8gWLtk2kEXtSdC8zYMMORjUFHRJ3O7basAn1pKhH7RAkbXIhqRmmzWA=
=qWbe
-----END PGP SIGNATURE-----

--h5TCuzcqTWZxfGfk--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
