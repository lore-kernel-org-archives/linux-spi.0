From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 08/10] spi: sh-msiof: Move clock management to
 (un)prepare_message()
Date: Mon, 24 Feb 2014 22:07:11 +0900
Message-ID: <20140224130711.GH25940@sirena.org.uk>
References: <1392907389-21798-1-git-send-email-geert@linux-m68k.org>
 <1392907389-21798-9-git-send-email-geert@linux-m68k.org>
 <20140222032700.GX25940@sirena.org.uk>
 <CAMuHMdWF5BnPPFoWPqASQjc+9GCYZQEVcWRZaLNFzdz0rAt0_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="w5TELPsKZB/ns6eJ"
Cc: Magnus Damm <magnus.damm@gmail.com>,
	Takashi Yoshii <takasi-y@ops.dti.ne.jp>,
	linux-spi <linux-spi@vger.kernel.org>,
	Linux-sh list <linux-sh@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Geert Uytterhoeven <geert+renesas@linux-m68k.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdWF5BnPPFoWPqASQjc+9GCYZQEVcWRZaLNFzdz0rAt0_A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--w5TELPsKZB/ns6eJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 24, 2014 at 10:48:26AM +0100, Geert Uytterhoeven wrote:

> Perhaps it's because the bitbang core may call the .chipselect() callback
> multiple times with is_on == BITBANG_CS_ACTIVE, and obviously the
> clock should be enabled/disabled only once?
> The current code doesn't seem to do that, but perhaps it was different when
> the sh-msiof driver was written?

Possibly, or perhaps someone was being overly cautious.

> As you mention yourself, all of this code existed before. It just got moved,
> to make the conversion to the SPI core message handling easier.
> If you don't mind, I'd like to defer these, and tackle runtime PM later.

Sure.

--w5TELPsKZB/ns6eJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTC0P8AAoJELSic+t+oim9aF4P/RNiBEhU0/pNGA0kaHy10avr
L4Bmsn4+975Tuwci+TWwfUq/9Aw9GGaQIBRT+bJDcrl3Kc5gPY6G8h498J9raSyq
RqPAh1M6/qhm/1bRNVKsTf7ldZuKzlsjeqLmDk8Nsl2eEs8g98LjTgzGE7upxyzG
KU80l7gmtoh/S1MQvEKePo3U0iuJ57Wb1V9vJ6dm8NZRedeSqCpA3VaBWhuVk+2B
oEkCdsXGEmhlUZ5fM2xpwGFymIVwgTaZAWghB0tyYRZ4TXk/Q6yuIF+EyR3pGUT9
W5ZCoaRTcG518R4cJncqlwsMB6Hw+j6Iv7/U1hutAnnVJfzqoOftNyrp/1iIfYTh
Cf5cvokH6pL8B2ITCUfjUQv5ewKYJ351CHil5QRweoGla0AkOSNZ4t5+bS4XZZ9e
UR+nQkfAURgbXa9hOfp7oWMO/445e2h31Datd2x4O3PKYvOezAov9SsOVJDTQ3Pj
zGy5cXGlFUgrXJfS2GLzi4AcgevQKBYZHvWBKuOX2ahubunwGF0uIvXnlrV4a7ei
dS/LdNeGWwmHh1JDPBYDtS0LSUhn9fhbQ5Sx4mM+eTQwoI4kP/U8SDQo7FUMfQZ0
PwaIgqGCDvqkdJqtKj4dlHCr6RPqvLNqIn0fkllgfRgQIhEFusugGzLCjFZRRHcZ
xt/A8bbiH/F8l36wu/2d
=m2RV
-----END PGP SIGNATURE-----

--w5TELPsKZB/ns6eJ--
