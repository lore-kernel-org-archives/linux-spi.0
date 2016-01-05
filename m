From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 3/8] spi: core: add spi_message_dump and
 spi_transfer_dump
Date: Tue, 5 Jan 2016 19:11:32 +0000
Message-ID: <20160105191132.GQ6588@sirena.org.uk>
References: <1450807408-2422-1-git-send-email-kernel@martin.sperl.org>
 <1450807408-2422-4-git-send-email-kernel@martin.sperl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qd/SZIFVu+MYwfCR"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1450807408-2422-4-git-send-email-kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--qd/SZIFVu+MYwfCR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 22, 2015 at 06:03:23PM +0000, kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org wrote:
> From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
>=20
> This implements a means to dump a spi_message or spi_transfer.
>=20
> spi_loop_back_test requires a means to report on failed transfers
> (including payload data), so it makes use of this.
>=20
> Such a functionality can also be helpful during development of
> other drivers, so it has been exposed as a general facility.

It can definitely be useful but as Andy indicated memory coherency does
mean it can get fun actually using it reliably - you'd need to make sure
that both buffers are OK for the CPU to access otherwise it can give
misleading results...  Hrm.  Comments might be all that's needed here,
or flags to say which buffer contents to dump.  The flags might be most
sensible since for bidrectional transfers you'll quite often want to
dump only one direction at once when debugging.

--qd/SZIFVu+MYwfCR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWjBVjAAoJECTWi3JdVIfQWVEH/RxoJ4gftv7CK6rkYYqZp0ru
yuJxGa30j/gi0IzrGcflHExBXXPhwkCA+vf8EsALgWURyeATFPa7TdoBsOa1QLU/
JAHINYdWx0ikvRga9mum7RfotRj/co41v84riMosnZ6PSogVS8wQVyrsAQl0PzmX
BymgoZj5ChloxJBAxB4uqPqCL1ERWw770s45PsWFock/CGDzWNZs6nGPkSjM/fGR
Tw6tkfaf2Qrnt7Qqh40kh4rJuNkgacZiLsy9QalLNfvsn2WnID7U1JWdV/yj0g6U
UrmVwLF7aoEyWYBRqyqQcS1ZcVSabk9L5/a9L8k0TvlAp5/TFSKMzb4j25/JBAo=
=jlSR
-----END PGP SIGNATURE-----

--qd/SZIFVu+MYwfCR--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
