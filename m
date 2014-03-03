From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: spi-ath79: fix initial GPIO CS line setup
Date: Mon, 3 Mar 2014 12:39:44 +0800
Message-ID: <20140303043944.GK2411@sirena.org.uk>
References: <1393790082-23964-1-git-send-email-juhosg@openwrt.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4xmAKYnxoHNXa3WQ"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Gabor Juhos <juhosg-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1393790082-23964-1-git-send-email-juhosg-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--4xmAKYnxoHNXa3WQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Mar 02, 2014 at 08:54:42PM +0100, Gabor Juhos wrote:
> The 'ath79_spi_setup_cs' function initializes the chip
> select line of a given SPI device in order to make sure
> that the device is inactive.

Applied, thanks.

--4xmAKYnxoHNXa3WQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTFAeNAAoJELSic+t+oim9WtEP/RRtix2OuS8R6KmeWZlBAfnf
IYQ+rLHuc9H48Ph+RhH4JVtwce8dVQJiCmT8Gq5WQvFbRk9dZUmhmjBgnLHJvLcu
vL5earNKScZTV1+xd0BCAKFIv98ZugW92tY9ee2osnJ0G/4swGQhBXvTJCgQZxh1
bkIRuZe5OCPSoGrpebjrc+SYeBPjVXiuNEWQ/31J8gxkq055J9o7izkQV++zNzLD
VHBM6I23cqVL1IgVxEWhWbtfB2aoTk6bPAp4WKFbBF0esG1KF4WZPeaVUKc90oCp
bUXLP5Xw9cxaND1EzDbGHMQdAVVWOcSPJhex3Gq2ceZNvmLZVlcv0lbroBPCeYj1
FOrAhmF3uk5yhvW26pYCtNVPAD/NDz3exPBO2YUG9u6YToEODgZzmLXM1G9tDdsm
pLMK0ZLt4gn50yzk5yUrxNq5wNCy/aw2x1Us7A9qessuVpH+VHCB916YMDF+CUSR
XXTvDjq5mA7qnR2Zh07hSkFxqNPsUVaTqD4+jjkMp+4Pp+07L0xQABuFBYyAa/XS
MFknwTJ8ojPfIQ6Y0QPtNDXSjsuxt/M2a+5P/frYG8dQ5GP/XDRj7hVQQNi8yGP3
EMfW5c4bKsV30In/iQ0r/q0baHJXwDB52hGyIJHX6LzdFqAuE6GrkAt3UW+f0hFZ
JwtMRuGAmIwyy+NhKbNj
=TF1b
-----END PGP SIGNATURE-----

--4xmAKYnxoHNXa3WQ--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
