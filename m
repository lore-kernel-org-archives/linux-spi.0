From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v6 5/8] spi: imx: allow only WML aligned transfers to use
 DMA
Date: Tue, 15 Dec 2015 18:27:10 +0000
Message-ID: <20151215182710.GD5727@sirena.org.uk>
References: <1449557030-27525-1-git-send-email-anton.bondarenko.sama@gmail.com>
 <1449557030-27525-6-git-send-email-anton.bondarenko.sama@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="unl2YYqPcAwXdP9c"
Cc: b38343@freescale.com, s.hauer@pengutronix.de,
	linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	vladimir_zapolskiy@mentor.com, jiada_wang@mentor.com
To: Anton Bondarenko <anton.bondarenko.sama@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1449557030-27525-6-git-send-email-anton.bondarenko.sama@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--unl2YYqPcAwXdP9c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 08, 2015 at 07:43:47AM +0100, Anton Bondarenko wrote:

> Also removing change introduced in f6ee9b582d2db652497b73c1f117591dfb6d3a90
> since this change only fix usecases with transfer size from 33 to 128 bytes
> and doesn't fix 129 bytes and bigger.

This is a bug fix for stable but it's randomly in the middle of the
patch series so I can't apply it as such :(  Please send this as a bug
fix suitable for sending to Linus.

Please also include human readable descriptions of things like commits
and issues being discussed in e-mail in your mails, this makes them much
easier for humans to read especially when they have no internet access.
I do frequently catch up on my mail on flights or while otherwise
travelling so this is even more pressing for me than just being about
making things a bit easier to read.

--unl2YYqPcAwXdP9c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWcFt9AAoJECTWi3JdVIfQ3AIH/3w6ayNJPB6JM9lXp3joo+3b
LjlXaPMe+R5JNi3GK//WPN2NyyN752LIUNQN3VcYUV6rTQiTlNqLOLDC1GsscP7m
Tf37yjmWbrubk52i9HefnJkNwf1+EohUnc5DyowV72AEKQ9fRUmGPA65tNdEWQK8
/dbhpCpogLWIzWmT8WSbcW/DiL4bnivYsShAH5hrgi4NCTppKGsHYrHWGNXSv/kB
ZTxXP3Kvd53LGrQFW3aqAAlBgpCa9GYhf/a2N90RukzxYB/RYPgBnCl5dtJT6bQC
cjtQJ32S07pj4uBgproo+/TZsB30E/6ajwBN1eqsrx87LPDm3KuMQ1wzF1KgvIo=
=+57w
-----END PGP SIGNATURE-----

--unl2YYqPcAwXdP9c--
