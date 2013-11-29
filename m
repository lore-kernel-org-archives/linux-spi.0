From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] spi: tegra: avoid unsigned->signed->unsigned promotion
Date: Fri, 29 Nov 2013 22:43:15 +0100
Message-ID: <20131129214313.GA18036@mithrandir>
References: <1385745164-10534-1-git-send-email-mpn@google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RnlQjJ0d97Da+TV1"
Cc: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michal Nazarewicz <mpn-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1385745164-10534-1-git-send-email-mpn-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 29, 2013 at 06:12:44PM +0100, Michal Nazarewicz wrote:
> From: Michal Nazarewicz <mina86-deATy8a+UHjQT0dZR+AlfA@public.gmane.org>
>=20
> u8 type, which is unsigned, is promoted to int, which is singned, when
> doing a binary shift.  Then, on 64-bit machines, it is further promoted
> to unsigned long which may lead to more significant half of the value
> to be all ones.  To avoid this, explicitly promote to an unsigned type.

So this would only become an problem on 64-bit Tegra SoCs, right? I
suspect that there are quite a few places where something similar is
done and which suffer from the same issue.

But I don't think there's a real issue here. Even on 64-bit platforms,
writel() will only write 32-bit registers, and therefore discard the
upper 32 bits.

I think in general perhaps a more proper fix would be to use only u32
instead of unsigned long for these cases, since then the problem goes
away. u32 is also the type of the value used by writel() so it makes
perfect sense to use it.

Thierry

--RnlQjJ0d97Da+TV1
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSmQpxAAoJEN0jrNd/PrOhKX8QAJVak8r+fcCS6Wd160AiUjbS
2MVrJK5qDdzfTq6yMQ/x1yrLnJbM/deaY9+0wYiyjruM7yK7+P2e6b6nTa65r1HP
wbd3nwlZM/xCw4XZvhCMspY6EtHyKOO+Fb1nd+cUWeHYFnJCYDRhaPIX0YDar5a+
sp3PhgPnl4C77mTkbzlcJlR24thedBUjMe4sQnoBemhjTHWGCSxE5xjA0CjtJ5/V
Tm7mJBQXxgzQxKC5NH2CyA4rL1PX36eYXUXn8MxSOKTkj1wWjisj71f7r4OZTdrd
qNLy93qNFUWarsjDWoEpqjvsW4EHpZlQzUHMzEZtcS62X6lVyrHfI3q1htTRNUio
i8JlL8+OrzutmL/z2zID98dPBR/JGNXvSAEnB6wXeEsUU3d+3u96dkNnMWwLKwMO
ZwbE3mh1Y93FRJQEsNQ8U+QLiEd30uuuxrTsTn6kD097BhPMIHYbDkrvJpq1HG1L
AarGdHIYFZNUT9hdw7hGYjx3HoH+CIIMF2jDxrxu7TfDCgEvDQeU44yA6dReLso+
BzMncT9dIgvnnYpMO4T8//LvlSGfiyk4oPoyId28KhAAzqGVBryu+pqvZmP9QDR2
vz6BSpqFj6tQo16eY0S7C8kV3jaI62XVLb+6O4TkE6ho6gQ5doTga5vO905kl8vT
PT40bhsowybR8Lskazgg
=6AcE
-----END PGP SIGNATURE-----

--RnlQjJ0d97Da+TV1--
