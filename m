From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: document broadcom qspi driver as broken
Date: Wed, 26 Jul 2017 17:24:33 +0100
Message-ID: <20170726162433.wwnnc2rxecemkjtf@sirena.org.uk>
References: <20170721220142.3400093-1-arnd@arndb.de>
 <CAC=U0a3jaNxRbScy27L+BFCs872F0kLAH80ieZNc7Uq6LwOyEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zgkkisnrlo6q5tsv"
Cc: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>,
        Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>,
        Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>,
        Hauke Mehrtens <hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAC=U0a3jaNxRbScy27L+BFCs872F0kLAH80ieZNc7Uq6LwOyEQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--zgkkisnrlo6q5tsv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 25, 2017 at 05:39:57PM -0400, Kamal Dasu wrote:
> Arnd, Cyrille,
>=20
> I am working on fixing spi-bcm-qspi.c as per Cyrill's suggestion as
> mentioned here : https://patchwork.kernel.org/patch/9624585/.
>  And remove the use of SPINOR_OP_READ* and there by remove need to
> include spi-nor.h.

That's great - any ETA?  I'm tempted to apply Arnd's patch for now to
help anyone who runs into problems with it, your fix could then revert
it when you've got a proper fix.

Please don't top post, reply in line with needed context.  This allows
readers to readily follow the flow of conversation and understand what
you are talking about and also helps ensure that everything in the
discussion is being addressed.

--zgkkisnrlo6q5tsv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAll4wkAACgkQJNaLcl1U
h9Ao2Af+PvNVHVr/z88fdWKukgL/fZjWcsovRbbZhkiiay89f5cAu1EyvYIMLpeF
FdwTwViGseHQVPVn0ELsHaQYl3jH+QQQhIjfMaZ4BdpW9sLTQhFgSc9CRyPI+Jb4
6RhesqdH58c0GjTmY1jTHwAHHi9NwnkNehvz0K0RhhlEM9nuy9oVSvWxpADsfwzy
UYY6feUY6p5KVhOhaXjadPLQreoZjzKHRRpe693qU656967A5JplO+03rxuBP57S
MPdDzr47SQ0Rp4E7qSgf35mHvhVQA0z1BbdXbbon0rs3TwMWJS/IVqBRPvUUe1Ir
NqUlMuTqeMnii6gWQGaA+7JI0ny1fQ==
=bY6I
-----END PGP SIGNATURE-----

--zgkkisnrlo6q5tsv--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
