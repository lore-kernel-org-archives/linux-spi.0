From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: fix spi-atmel.c printk format warnings
Date: Fri, 21 Mar 2014 17:45:37 +0000
Message-ID: <20140321174537.GC552@sirena.org.uk>
References: <532C6085.9070203@infradead.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lMM8JwqTlfDpEaS6"
Cc: LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Wenyou Yang <wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>,
	Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>,
	Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
To: Randy Dunlap <rdunlap-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <532C6085.9070203-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--lMM8JwqTlfDpEaS6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 21, 2014 at 08:53:41AM -0700, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
>=20
> Fix printk format warning by using %p extension 'ad' for dma_addr_t.

Applied, thanks.  Please try to use subject lines matching the style for
the subsystem.

--lMM8JwqTlfDpEaS6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTLHq9AAoJELSic+t+oim9b+8QAJMYskCpPnc47sJZOdUho0Kc
bJDlYHGghzz/1K+5GYxSvYB9fifnf1rVSxeHH3Rt0TovBtaelkeUaUJwk8S8vR4p
6VvP9bYDCT/CJWsulk7p8NYyqu94gi5CC0rDJUeJG82TkzmaercLFO5/mRuM8+H2
F/SpEdW51DgbKzEwg+GqcB7HimrXNqPKk4z2PPuz7N25amNO7nhdqK7U0Knzpwx3
Ygkrkt8MhtRLSg5CW5D85DKhek7hRClpm5MNDjuUoVSxcTpJJXbBQ/SYSCgNx+cG
Aehu+umXS+TGrIC5nrjL+WAYg2/Y04CnxLMPBvZGHXS+7uQiuDU0PW7U5LE7WfY0
KzH++EEX3CcQup0Z1t7PgtlMuPFsYV9AZC/hSlmNqLtnlTSUUOuQcCH7rE7yyI9Z
Ia6R/IDjwcASOk6syijDvtVdnR1jOTcz2XqSql6oVWcyB6Z2g9HFq8NitP66Ewos
5TxMiW6nJCG+9XDc7wHgmRGqHwUXxOJdt/SnPC7m4HJW1nrY4C5JXjyBEGC8ltFd
/Hft0gVl/OjjY463VG0P/1iP7TnmZEQC1hq29kgdpaP/P6eOhTg2kqiEDeFvqLni
urtSO+oKGLufy44yUKVjj7ijqpZs1xx1lr3sGi/KkoNl0HFG3UI7XlFSVERgPFmr
Qc69/U9h2rf81EUz+pdg
=VRFP
-----END PGP SIGNATURE-----

--lMM8JwqTlfDpEaS6--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
