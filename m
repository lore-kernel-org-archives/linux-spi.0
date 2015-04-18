From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V2] spi: bcm2835: enabling polling mode for transfers
 shorter than 30us
Date: Sat, 18 Apr 2015 12:53:43 +0100
Message-ID: <20150418115343.GI26185@sirena.org.uk>
References: <1428340592-3196-1-git-send-email-kernel@martin.sperl.org>
 <20150410185132.GU6023@sirena.org.uk>
 <F35B7C71-1917-40AE-BA42-CB3E63B877EF@martin.sperl.org>
 <20150415185824.GU6023@sirena.org.uk>
 <262B0C8C-7728-458E-8748-06F79251BE0C@martin.sperl.org>
 <20150418104202.GA26185@sirena.org.uk>
 <54169601-55F7-464C-8A0E-ABF833C0F3BA@martin.sperl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Q59ABw34pTSIagmi"
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <54169601-55F7-464C-8A0E-ABF833C0F3BA-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--Q59ABw34pTSIagmi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 18, 2015 at 01:12:02PM +0200, Martin Sperl wrote:

> Well that is why I have implemented the 1s timeout patch,
> which you have already merged (145367baa492246).=20

> If you think that timeout of 1 second is too long, then we can change
> it to something more acceptable, but it should be in the order of
> 100ms or more to avoid those =E2=80=9Cfalse=E2=80=9D positives due to hig=
h cpu load
> that the original code showed.

As I've said several times now 1s seems far too long for a busy wait,
the driver should fall back to something that sleeps after an initial
busy wait (once it's clear we're over time).

--Q59ABw34pTSIagmi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVMkXGAAoJECTWi3JdVIfQfrEH/3eZwSBqE0Xtfj6OjJI+zemd
9J97lEHFkmmayyylAPuUBjjfeHYi04Tpr9/z5K3YV9jwG9iORB1Gpfn94dKJBLaL
0I1lvrypmc8nLQu60F0sajPoy+mIK4ZxGbSN6MSoDIVvWmtl2KUTWhJuqlhWby4+
/3H/kj1WGuJkWJthrTtJUevlOVAMkA0v0ZRmQtfKlj40EY12ckPsYEajKnoxVpki
DaGrBgIpzboNWZcUWw7kBgN8DHYpM/bdau/jMG2UP4HTwfmxjPZv7T+Yy67BZPKu
hMCAmsqBr6JynqBhWed9PIeq2rffh1egwyapncbsUfJ18M6j5lj9NOAuR1gIjjc=
=++jL
-----END PGP SIGNATURE-----

--Q59ABw34pTSIagmi--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
