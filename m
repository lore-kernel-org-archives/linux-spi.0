From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3] spi: master driver to enable RTC on ICPDAS LP-8841
Date: Tue, 23 Feb 2016 06:27:38 +0900
Message-ID: <20160222212738.GH18327@sirena.org.uk>
References: <1456105630-28914-1-git-send-email-ynvich@gmail.com>
 <1456142265-12925-1-git-send-email-ynvich@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="nJFBJCcSkptt2CoF"
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
	<devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"open list:SPI SUBSYSTEM" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Sergei Ianovich <ynvich-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1456142265-12925-1-git-send-email-ynvich-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--nJFBJCcSkptt2CoF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 22, 2016 at 02:57:42PM +0300, Sergei Ianovich wrote:

Please don't send new patches in the middle of old threads, it makes it
hard to find what the current versions of things are.

>    v2..v3 to fix Mark Brown review comments
>    * drop dependencies in Kconfig

No, what I was asking you to do was to change where the || COMPILE_TEST
was grouped.  It is good to hide things from users where they clearly
can't use the driver, that's what COMPILE_TEST is for.

--nJFBJCcSkptt2CoF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWy31JAAoJECTWi3JdVIfQgi0H/j5eOAsim8Xo1KG2I3bjJW7Z
jkroSD2JTfa4F2hJmcZZaj2SniCwZUvZ0nVIZcjhYiAkQIw76Bqtu6OOFLerytgV
GKHOBmj+OGxRi3NRzuPdEYM50rOAHBAc96L5HOvdMJAOP8WmwqsYk4JgymCa+yJ6
kAjAQEkRR2a+4kFjq7ExYYPNQcPkVq7LzTc5A1GehQ4tC/7cRP2025+OoNkYe/d2
bgRFQlaoA5CnhJR5aE3waPV+lPpshoMjFy53ZykMjRD0nTmJVDcyctfn0HI/X4q8
nj7854GPlsjjR4wD/KBqb9z0yyLZlPdMSG4on9LOqNlDXonvvLhACwaz18cuSgc=
=zhk5
-----END PGP SIGNATURE-----

--nJFBJCcSkptt2CoF--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
