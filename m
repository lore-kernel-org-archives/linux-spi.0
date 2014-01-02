From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] spi: clps711x: Driver refactor
Date: Thu, 2 Jan 2014 18:25:49 +0000
Message-ID: <20140102182549.GF31886@sirena.org.uk>
References: <1388556568-10973-1-git-send-email-shc_work@mail.ru>
 <1388583851.810843204@f301.i.mail.ru>
 <20140101150737.GR31886@sirena.org.uk>
 <201401021846.23488.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8ysciihHaYDTQsg3"
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <201401021846.23488.arnd-r2nGTMty4D4@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--8ysciihHaYDTQsg3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 02, 2014 at 06:46:23PM +0100, Arnd Bergmann wrote:

> I definitely agree with what you say, but please note that Alexander is
> the only person who ever sends clps711x patches, so there is not much
> hope of collaboration. I also suspect he's the only one who would

There's stuff been going in from the people who do generic cleanups and
updates.

> suffer from accidental breakage, especially since the existing driver
> is not used anywhere upstream (no instance of platform data, and no
> DT support).

Right.  On the other hand I really don't want to get into setting bad
precedents that people then use when they complain that I actually want
to review their code, that's just going to be more miserable in the long
run.

There were also some things in there that I really did want to review
properly but I wasn't entirely sure what they were actually supposed to
be doing.  Getting things split up with better changelogs will make that
review much more tractable, it might even be immediately obvious what is
going on.

--8ysciihHaYDTQsg3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSxa8qAAoJELSic+t+oim90LcP/17SD1U+9r15RQ6hC5LNvF2X
szIne9n7fAU+PcVcCn2oktkWIW87eLOq3ppuBfZzmAv7Wnu9VZgJuPN2QBP10Ipy
hHa+Zu8tmsQYqGyTEJ9Wk3mmfvBjXOz0ccIs/6Mu+CqIYOwMrUxrG/JZJAe9F/rc
ItiRfe1NnlvDSBFH7v/rAJOMrGb+OBe2GMlXZtQ1X4J8YTssS+0qSHz1d4miu6sN
J8lsy8v4HEkuLBrjxT0vdGBZNTH4U/L8pughZ5ydxzrsX0CSZc18HEiMZG5dSJ0w
TjqDv0Z2J7eO2PLZ/V92F+0gQ0jcE+9M4jGn+fkyDkB6Bb1B5O6+8rhnkdjV0FWq
YfkeNZajYRbAd4IuB3JUudOu++jIdxqjwsmFK/zbC0d6HnPUHq4vko53WASy+lCj
Q3OdteuwML656JeiTRnNrzMGk1K9cAuGFUvJnngntR4TweMjkwZki0TSQURMBWzS
KNnueRgvW+QUD7dubv7SVP/CAJQ+eH7WDu+/5HWBM3MjUjgjSQgUdy01uqo7oN5v
6cPsT7/EwTS2PKzNqnnsP6D4GeP0jb7lU+JYylw+srv7/Yiu+9c4fJrwpdvj7xcN
uVVlrWwokwp/h1c4NaF4BwNEitc3JnpHxu3CJ9YG1YSnW792XZNvbMXQQIih1UCj
0uAspeL2deHyRBf0UtpZ
=tIEz
-----END PGP SIGNATURE-----

--8ysciihHaYDTQsg3--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
