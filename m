From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi/pl022: Unprepare clocks while suspended
Date: Thu, 23 Jan 2014 12:18:28 +0000
Message-ID: <20140123121828.GF17314@sirena.org.uk>
References: <1390416154-3292-1-git-send-email-broonie@kernel.org>
 <CACRpkdYPR92BS2Fzkw+m40cu__ct6xcku8yV6mY=_4dQU61tvw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rn1GfcxwU9HQsMTB"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linaro-kernel <linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CACRpkdYPR92BS2Fzkw+m40cu__ct6xcku8yV6mY=_4dQU61tvw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--rn1GfcxwU9HQsMTB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 23, 2014 at 08:13:09AM +0100, Linus Walleij wrote:

> Maybe you should update the probe() and remove()
> runpaths to use the combined prepare_enable() &
> unprepare_disable() calls as well when you're at it?

Yes, someone should probably do that :)

--rn1GfcxwU9HQsMTB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS4QiRAAoJELSic+t+oim9pCMP/2lnYQ8q6Nk3TjT/86jkg/hI
7lY2tnPTxiacYI8JIuivmck426P9AXtvBCkeeHUWc6Wi7qMD1mG1J2KAH4VP8RU4
jYo0t88PaF0vnGGap3Ty66VP0/Sh84PSA+l6pSnaOMHi9FdWvnGZGHieD0qmH0gT
ACtTDIHRogUW8IQizkrJX3lbjGXU1UeaFPrG99DjklqUjK/3p8XW35wHnOQMbhoq
W7tBDpgLsoyorlvfHgcPU44ktqkg+0UrslAq65DGlYlPqF1z1jHJCZDdQkv4m57N
oGGLwzDY+v7YoXaq+mOp+912yDtOgQG+FDy8WaHhohHwBHC13TTtSA4Se812tj9m
+VB6RgY9NytKGiqzu5+rJu8JzUeMZRBRfHB2rK7YIgFS+jAElUfV/8YwpzS2bCF6
SGOx5EZrGUdXNQtCBxuZxxYqlr7TZ/mziNkzGuQ9KixwUSSipxCzR6Ar7AbI5GFd
896V+CLZcQfbmx2frIPInnSKKEgZUovTokFyesg7WS/K1qzsCAN4EESVpDqU4AFT
kX+/T5oGrzig+fSCDrF4CpzyvD/GlNEwySgBSwWK0TZrsMCiqJHR3arvh3wMn/2I
guwJDe0A3rZMnGg0Lc1qy5TKoUKH0jAHupy40Rl9B6gnngmNHCk4H9RGXREdN9GS
gGk3Eyt2I++4ldGFYs3l
=yODZ
-----END PGP SIGNATURE-----

--rn1GfcxwU9HQsMTB--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
