From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: Applied "spi: dw: explicitly free IRQ handler in
 dw_spi_remove_host()" to the spi tree
Date: Sat, 24 Oct 2015 01:18:10 +0900
Message-ID: <20151023161810.GH29919@sirena.org.uk>
References: <E1ZpP0f-0000MP-5w@finisterre>
 <1445586058.22669.55.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9jHkwA2TBA/ec6v+"
Cc: stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1445586058.22669.55.camel-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--9jHkwA2TBA/ec6v+
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 23, 2015 at 10:40:58AM +0300, Andy Shevchenko wrote:
> On Fri, 2015-10-23 at 08:11 +0900, Mark Brown wrote:
> > The patch

> > =A0=A0=A0spi: dw: explicitly free IRQ handler in dw_spi_remove_host()

> This one seems incomplete.

> Yes, we already have a fix=A002f20387e1bc in your tree.

This *appears* to be the same commit you are following up on (please
always include human readable descriptions)

> This makes free_irq() call duplicate. Please, remove it from your tree
> or do the revert.

Are you saying that you have realised that your patch is broken since
sending it?  I've dropped this commit...

--9jHkwA2TBA/ec6v+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWKl3BAAoJECTWi3JdVIfQJg0H/1QUvf9+18j6rOL2EOEhWMKy
3cXluDQwfRNOY0du1BESnDm9nnySsmJ8hkdOQiZhZZFw6/lTswBqsXKuS4fql3/v
vwwpWkK7WjbLYPUNLL0IgWVm5zJIkiOC1Wr3glv/VmdOsDWpCy9/iNdYYveca1xA
JPc7rZ01VLfpsOwA2fjs0oJb0OiMraXRZ7NEPiW7nWwFhlzDTS7BGuIXsDTzN0vT
7NkJgcihh/2mvqouBCA2kW1NfBdwaniCBg8uMvnGp+g18yCsPzU98cnrVUk967hC
gVOy3izaNn7tXRL1bthR9UH8JxNJOyiOElxgzPAay2ZVcw2HyPneHDUFyO1gVtc=
=iVvz
-----END PGP SIGNATURE-----

--9jHkwA2TBA/ec6v+--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
