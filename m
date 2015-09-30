From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/2] spi: bitbang: switch to the generic implementation
 of transfer_one_message
Date: Wed, 30 Sep 2015 19:10:37 +0100
Message-ID: <20150930181036.GO15635@sirena.org.uk>
References: <560AFF89.5000907@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="lBqJz4CGKwlWe7/k"
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <560AFF89.5000907-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--lBqJz4CGKwlWe7/k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 29, 2015 at 11:15:53PM +0200, Heiner Kallweit wrote:
> Change the bitbang driver to use the generic implementation of
> transfer_one_message. This simplifies the bitbang driver code and
> provides benefits like the statistics in the generic implementation.

I'm missing patch 1 and/or a cover letter here - what is it and what are
the dependencies?

--lBqJz4CGKwlWe7/k
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWDCWcAAoJECTWi3JdVIfQqPQH/jdRwHrq+EsvmWYajRIqexFa
7rqBqu/4u2X3I1yndCBVCwcsPHOm6n5UvKi5v65Iz7r74V2H6ab9yQ55+USE9B+7
yVMXOwiZyGfp1eivL68Ifwe7690cfKCeOVvvVW5jwkb9W/as83y/0Rr+3ZnXxO0s
9WI/qIF04eoTSfJUiqhH2+WU5hE6WRozMhUxoeIJpUq6qZ0pN7FauxwtsiyCM8mQ
Uh3HpPEONHsq+jVJSvQALDct+/ulubUq3FBi3IenNFVf3k4afb6qm/4nO6ZTc0WB
XoDKU0fk68Z5IZywfFNpexJ2CU7GJsFSKhq83J/SHgFPl3PATmnWdclApOWOsRk=
=R3FT
-----END PGP SIGNATURE-----

--lBqJz4CGKwlWe7/k--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
