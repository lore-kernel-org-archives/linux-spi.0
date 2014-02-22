From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 08/10] spi: sh-msiof: Move clock management to
 (un)prepare_message()
Date: Sat, 22 Feb 2014 12:27:00 +0900
Message-ID: <20140222032700.GX25940@sirena.org.uk>
References: <1392907389-21798-1-git-send-email-geert@linux-m68k.org>
 <1392907389-21798-9-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AAkN98o3X3ouhQaz"
Cc: Takashi Yoshii <takasi-y@ops.dti.ne.jp>,
	Magnus Damm <magnus.damm@gmail.com>, linux-spi@vger.kernel.org,
	linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@linux-m68k.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1392907389-21798-9-git-send-email-geert@linux-m68k.org>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--AAkN98o3X3ouhQaz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 20, 2014 at 03:43:07PM +0100, Geert Uytterhoeven wrote:

> +	if (!test_and_set_bit(0, &p->flags)) {
> +		pm_runtime_get_sync(&p->pdev->dev);
> +		clk_enable(p->clk);
> +	}

That test_and_set_bit() is a bit odd - what's going on there, perhaps a
comment is in order?  I'd also like to see return value checks, though
the original didn't have them so it's not a blocker, and ideally that
should be clk_prepare_enable().  I guess the clock stuff could even be
moved inside the runtime PM callbacks?  Again not a blocker if the
existing code doesn't have things but it'd be nice to do.

There's also auto_runtime_pm in the SPI core which will do the runtime
PM for you if you can do it unconditionally.

--AAkN98o3X3ouhQaz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTCBkBAAoJELSic+t+oim9OacP/RvGDmota4Vu+MzGTGBuFGch
eR/aEYNJwXXQNCCDsKAwKXlWG7BdWv3esfDot+l3SlSH43AL+VLyRFxPHLVonCWk
G4IUjn3YO80A9hbcobkGVDnhKaFrLRaVuK5HmsT2LeexznfWnb0LfBjro/5FmTP2
54Rv6ZQjUKfkTEqyVZN4Hswx31TVFyo631hmNvurKEVdfi6BXcI/MfCrXf+2IXF9
+Qyb9EF2wkV2V4vhwd+lQf6x/RoA3QhosVZ+xtohQwDIPzO/IvBJfZy5SIDRJvsw
yP2OCS+6RF0dAaus1Xxk1z5i0eHdZDM49ecbjK1yzWXkh6TWFngY+yn/EJwWdCM5
oQK103KLtLLwsZ/C1zgOSW9uzJ5Ql40dK6SvTiF4d635T+peLPrKxj6PGbrjL+cf
Q4V/+vXRv/ld5csTkfBxD6dGDFO36LgUSCT6vxvoDWNgpF5YEfrTn8aSTV1lxR6w
gWSLXZVfZiJCDF78EtbB7EhYfIreVXLGCCo6BRsxJba6g47kf5PlQfQKrwycRImY
3cdSqJm6uyKgoi5U6ZgwozgIkl49DD3NUXiYE2Vo5qEy813FL3UKpnkNi8g2OS7A
eSPLIzkElxpf2g1ogGG1uOxB0PQmCBQIT1YN7Zvoa8prcILgpEXsR/8jDXS4kDAN
hx8MvHS1w4lku1Op4IUP
=Gdac
-----END PGP SIGNATURE-----

--AAkN98o3X3ouhQaz--
