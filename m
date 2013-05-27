From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] spi: hspi: fixup long delay time
Date: Mon, 27 May 2013 08:17:54 -0400
Message-ID: <20130527121754.GB3660@sirena.org.uk>
References: <87li7fwgk8.wl%kuninori.morimoto.gx@renesas.com>
 <87d2si4cdn.wl%kuninori.morimoto.gx@renesas.com>
 <87bo824cbu.wl%kuninori.morimoto.gx@renesas.com>
 <20130525014739.GA28458@verge.net.au>
 <20130525143219.GE7660@sirena.org.uk>
 <20130526132848.GG11134@verge.net.au>
 <87k3ml8cgr.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gatW/ieO32f1wygP"
Cc: Simon Horman <horms@verge.net.au>,
	Grant Likely <grant.likely@linaro.org>,
	spi-devel-general@lists.sourceforge.net,
	Magnus <magnus.damm@gmail.com>,
	Linux-SH <linux-sh@vger.kernel.org>,
	Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87k3ml8cgr.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--gatW/ieO32f1wygP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, May 26, 2013 at 05:59:20PM -0700, Kuninori Morimoto wrote:
> Current HSPI driver is using msleep(20) on hspi_status_check_timeout(),
> but it was too long delay for SPI device.
> Bock-W board SPI access was too slow without this patch.
> This patch uses udelay(10) for it.

Applied, thanks.

--gatW/ieO32f1wygP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRo07vAAoJELSic+t+oim9oGYP/3IIF4sV7TQuAqQbzg9rvLIq
qQgr/LS5wpsB+XO84TU7IPqYqeeij4regIn217fSZbf8IQliQKjSR+hGVF3GtgxK
+wvhVSysbeQ9AOZpNQHNr4zXg6pct3kLoWLG+/lmK1C5rp7n1dPCnXMKiU543TmW
EN+Y8Q8sDMIKaQ3Kww7UqC0B92NP9YV5cKYpA5hVj+vaM3pXBF6fiN6buJIL/oij
JQoYBUlBV1P5ognpdZrz/jsFlD/SQl1MxyRpYc6oOkyBXT8/nhWmd433AyWV/B1E
w5MHi9AmZF4mmv8+KWWCBwJKxAMH3rU/YqWwM0McrIWH9WKOXoDRACQWtUzpUvCm
76H3nnCYbwbft5A+Juh1WJE37JAyc9NH/QMHGzXfMXL9N/VozH+yEiPgSKN7puB/
MEP3iu6TFjaogyAWO/F/gu0OOFBUl7tDoQN+wbc7Q5pMD6KaSG4uDmKkZruWXebk
wEyTR+GYsF3TS/QtbLEtJjC3i4e2f5eKCwa400u5nZOGgSkZew6QDfgYkVbOGYew
GiyWJNQCKBdUG7CvAdd7yELtqezit10wk2yFCzAN1RlqzDWLo25qnaIWmN/r5tui
/HKZFKXKzX/y1uSCxsSLA3f8TleQLRU2oBBQdWW/t7h7GSJIwyJzHU1JUeGj6bsT
zp0ttr4ktBtl5NjpyWjP
=226m
-----END PGP SIGNATURE-----

--gatW/ieO32f1wygP--
