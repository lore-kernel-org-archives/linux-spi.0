From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 0/8] spi: loopback-test: improvments and sharing dump
 code
Date: Tue, 5 Jan 2016 19:15:13 +0000
Message-ID: <20160105191513.GR6588@sirena.org.uk>
References: <1450807408-2422-1-git-send-email-kernel@martin.sperl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="JKGvNdIvrY8Ovf7Z"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1450807408-2422-1-git-send-email-kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--JKGvNdIvrY8Ovf7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 22, 2015 at 06:03:20PM +0000, kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org wrote:
> From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
>=20
> Move spi_message dump method into SPI-core and make use of
> this extended version of the dumping code in loopback-test.

This looks good apart from the memory coherency thing on the patch
moving things into the core - I'll apply what applies without a
dependency on that patch.

--JKGvNdIvrY8Ovf7Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWjBZAAAoJECTWi3JdVIfQDjsH/i18eBwqJlXWFwJtIs8a6Acl
Z3ie0dZhLYWqkaG7z/FhF3yUWMV+bnyab847d5hMZp4lhm97VlgKOgEvf38IWDa+
TM8yNZeRBpr5i3f0dOep1xgoBSadvF4XYcIPULsUq6RJuPbZVxToc7/8RsFOWOMr
Nv2s1D6gP4rf8CkCX5OsDUyLAtIofO9Mfv3cuRzZLvZX7SGBAZP86OZQayMJfIRf
NzHAn0VGApnmly9tbZK01NRyTPcRdaAOEKaZWIR0StmcTkE8M+xzJ0PPxdv0lJh5
ir6WdOb2yoIMvudezG6UD8NF7sNZMg7dwPCiSSGoHDEfZsm8AKrnmzplUVtmt/Q=
=B/4J
-----END PGP SIGNATURE-----

--JKGvNdIvrY8Ovf7Z--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
