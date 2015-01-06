From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: sh-msiof: fix MDR1_FLD_MASK value
Date: Tue, 6 Jan 2015 11:08:31 +0000
Message-ID: <20150106110831.GV2634@sirena.org.uk>
References: <1420538486-1420-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <CAMuHMdUjor__TCQwDcHAR9-vH54=qB-_E5AM2a4hp2B+wE9c4Q@mail.gmail.com>
 <HKNPR06MB322387C2B14F90694CA90A8D8590@HKNPR06MB322.apcprd06.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IgDDV5QArAYIxtdK"
Cc: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: yoshihiro shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <HKNPR06MB322387C2B14F90694CA90A8D8590-xIjp3w5QIjwsJtb0Mgt7d79PrO6axcR4XA4E9RH9d+qIuWR1G4zioA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--IgDDV5QArAYIxtdK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 06, 2015 at 10:57:32AM +0000, yoshihiro shimoda wrote:

> > This patch doesn't apply, since Mark has applied your other patch
> > "spi: sh-msiof: Configure MSIOF sync signal timing in device tree".
> >=20
> > Please rebase on top of spi/for-next (or renesas-drivers-2015-01-06-v3.=
19-rc3).

> Oops. Thank you for the point.
> I used spi/for-linux branch. So, I will rebase on top of spi/for-next.

Actually since it's a fix I applied it on a fix branch anyway and
merged.

--IgDDV5QArAYIxtdK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUq8IuAAoJECTWi3JdVIfQQpUH/iS1WucBWhLHb5kwi3e4gOI5
YxU5nJ+wCDlELImiUpQ7IJvH25T5pFJSxHhL/ETBIstgXxu4FZkEpt932/KjL3FD
hxtXW3w/TX6T6fGgznZP7DUia4LoaEiBHpR4vHeU5WT1y51S7huFy06/AO9juJhP
d+KFPeQvAUElDvuxo0J2GIESv9aXAQiU5+1yUMK3Xi1j61jtaFbnmX6zsGYsMcXV
2+t75dopWs1BygwGJp9wPVt1lW4PQYYpziNpwUF7jgzB811nA6g6ynGzhIc92N8U
xdthXx6sx5Tv5xn9Ro7sk7FlILtid4p0/XANmMfi70CE9F7rtjg3TOf07SpH4BY=
=iZAU
-----END PGP SIGNATURE-----

--IgDDV5QArAYIxtdK--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
