From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 11/11] ARM: shmobile: koelsch: spidev for r2a11302
Date: Mon, 2 Dec 2013 13:24:26 +0000
Message-ID: <20131202132426.GF27568@sirena.org.uk>
References: <20131202031557.162e78d407d82effdee627ac@ops.dti.ne.jp>
 <1385921962-19843-1-git-send-email-takasi-y@ops.dti.ne.jp>
 <1385921962-19843-11-git-send-email-takasi-y@ops.dti.ne.jp>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EYAXRszTzQPG7bQS"
Cc: linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>,
	Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: takasi-y-nDL5PR/MsHhHfZP73Gtkiw@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1385921962-19843-11-git-send-email-takasi-y-nDL5PR/MsHhHfZP73Gtkiw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--EYAXRszTzQPG7bQS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 02, 2013 at 03:19:22AM +0900, takasi-y-nDL5PR/MsHhHfZP73Gtkiw@public.gmane.org wrote:
> From: Takashi Yoshii <takasi-y-nDL5PR/MsHhHfZP73Gtkiw@public.gmane.org>
>=20
> Add board info for r2a11302 on-board PMIC to access with spidev.

This doesn't sound clever - why is the PMIC being accessed with spidev
and not with an MFD integrated into the relevant kernel frameworks?
Apart from the issue of integrating in the normal way for Linus the PMIC
typically has the ability to cause lasting physical damage to the
system.

--EYAXRszTzQPG7bQS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSnIoHAAoJELSic+t+oim9Aq8P/jT/fAQIV1FyaLAvmriW+J+/
vHNfLp7v1QTjUcR/huauRBqgUatneNy4uZ5Lv/5LmTyUXG17lTSuQmO1XQgY7hON
lIhMnyZEO1kYbTFIEdHDYR1mC+VIlFDPWMAL3ekUKNJ+KE4teg6sfWQmE2kvtn9P
M3vzXQtIF2W6dCO9R6R5MnUtbCpIMS5VdjRYCTOYIJ5VG6C99SsdlnHl+Y9ej8Nc
j1X8r0MZXZBxIANHzUxBIWQ0UiZJ/fiJNQTxEH8/fA2MG43sK75o3Y2JAcx4/nK7
+DrMTjXnLEaG6i8WCefH3z6NqkVw/pJBvXr2QIYjUG+rPKn1pnmAnzJId79Dvx0X
ZlUE+YL330GZzkbSoClRPjnWvUMZZPC5FkLsgY2vhzf9tcsBUGv3uX6pO+ntis8L
PWlPzNscvcPf0+dUkwOyfa+2/vAlPEi0twKXGjoOo8cDAsTR6jRZuchVIrKAA9n/
/kNbeYSOu6fYzNH9ls/ole60wTycq/GGOMnT1wahtgUPRsXuTnIhQzfSNCcCNr0C
mlbQsyoNg9L308Y1FmHp25F7ReeVKUAmnXFz9eAYjXHDOxSWQFRxpk0FX/9VkhBZ
DUm0qRaJugdRs7VrwuUl66NbB7rZ3A7PVhokCmovWjbRtS6SA0jCa+cASzthEfgk
s0qPm5CJsA3rvOnThSUp
=bog+
-----END PGP SIGNATURE-----

--EYAXRszTzQPG7bQS--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
