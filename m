From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: omap2-mcspi: fix blatant abuse of the resource
 subsystem
Date: Fri, 18 Jul 2014 18:10:35 +0100
Message-ID: <20140718171035.GQ17528@sirena.org.uk>
References: <1405683053-14104-1-git-send-email-LW@KARO-electronics.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ensexbfp9Ul6anXl"
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>,
	Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>,
	Charulatha V <charu-l0cyMroinI0@public.gmane.org>
To: Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW-bxm8fMRDkQLDiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1405683053-14104-1-git-send-email-LW-bxm8fMRDkQLDiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--ensexbfp9Ul6anXl
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 18, 2014 at 01:30:53PM +0200, Lothar Wa=DFmann wrote:
> Aua. This really hurts. I wonder how this could ever be admitted to
> the Linux kernel...
> Further comments suppressed because the would most likely violate the
> CDA.
>=20
> If someone should not grasp what this patch does, they should consider
> what happens upon unloading/reloading the kernel module.
>=20
> Signed-off-by: Lothar Wa=DFmann <LW-bxm8fMRDkQLDiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org>

I'm not going to apply this with a commit message such as the above.
Quite aside from the tone the fact that it doesn't describe the issue
is not helpful for review, one of the things done in review is to try to
check that the change has the intended effect.

--ensexbfp9Ul6anXl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTyVUIAAoJELSic+t+oim9fmUP/1SyGlhn0Me9y8BBLgnUTImu
kWdKdLhh91px+7Zwz/P64DrnyEMj5Nqnay63LCjBRHK+pI3aBUu3ZMMzsiO8A77j
lmi04xEGdUIrfG/3qQ2wyacnBvlChDjplhTwRx2OBy37gF+4sD3fCa3BgUHpCejM
Vgyb+OGhtbhx2uwn5DOM3CDRd47WCOZ6kXD1qVhvVuoqVvo2EfdXDMqh/r8bG7gZ
p7Z7yjI7POEzi7Zb/OE1MiKQTWarwnpG9DcdKW3qmjAotaNjqdqur2oQIuaWCPkw
psaQqvRMZj3JjeuHYxCZ7a8maWLIv6H2Tl+PFB2BwdkF2F9xRXOYS/50ST6kyUHP
Nm2LuHp1atAUfAHRW8OZUYIpGQW7q+K2F+ZZ+021hfUa3IbzOC7n4ugCVlFmvWCx
LeiuXo70cjxnujvOwM9KO8x9D3TmVNg3mj9J9uZ68jYHBLmAtvgUJG07EGdA/nLL
chyS7b6CfeIKRgGSFMMfYx2EEIqso6kZG9U1sBnjgg9RxeaQ7ictGDwV/kIlkJ2n
0e8o8WTM+2EmNUnBiHv4Lt+10UNGxLaqP0mxsYMNk4+04pShln8U3t/IwmRlPSdw
TsFOxXzs2Vn3tb/+IO6PtN9s9D1BNDsiJ8G26kInutVx6mQmjPR240AVUd2dle3g
ArbUgKXm+rkHnN4UGSKZ
=fSdJ
-----END PGP SIGNATURE-----

--ensexbfp9Ul6anXl--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
