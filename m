From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 4/5] spi: img-spfi: Setup TRANSACTION register before
 CONTROL register
Date: Wed, 8 Apr 2015 11:36:38 +0100
Message-ID: <20150408103638.GU6023@sirena.org.uk>
References: <1428355747-16822-1-git-send-email-abrestic@chromium.org>
 <1428355747-16822-4-git-send-email-abrestic@chromium.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="SbCGc7/cX5mN2zxo"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Sifan Naeem <sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
To: Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1428355747-16822-4-git-send-email-abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--SbCGc7/cX5mN2zxo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 06, 2015 at 02:29:06PM -0700, Andrew Bresticker wrote:
> From: Sifan Naeem <sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
>=20
> Setting the transfer length in the TRANSACTION register after the
> CONTROL register is programmed causes intermittent timeout issues in
> SPFI transfers when using the SPI framework to control the CS GPIO
> lines.  To avoid this issue, set transfer length before programming
> the CONTROL register.

Applied, thanks.

--SbCGc7/cX5mN2zxo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVJQS1AAoJECTWi3JdVIfQc/8H/231IPPWR1su/YILOrKOcjtJ
nUKqy6uTxzRWIW5gHoZayO33gUi7oLLFFBpVmrYCjbbRlCiYBHyR2PI+F4m5T3eh
ekNypmj1zLCagjvH1UGqhK9MNZgkvjdPowOZGrkA3yn9/ZUUToXE+1+rCCZB36RU
wAyflVb+Ocq/XBMJXIuBZj+RdimcXNv1Y/3C1uOxXb1kbARyYbxSN/BpY7DRJnXc
4Lox4vBWQpwbrE+fk6Q7q/VbxKbd+AvX4hIu0GsjlDyzRY4QBUwMlj8YQ1pZpKX2
dw+b6iJYwxYBn9ttsMgaxSpw1O3z1985V2tOzIeVux09hoHCfsulu0jsBIuZUDw=
=XhFU
-----END PGP SIGNATURE-----

--SbCGc7/cX5mN2zxo--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
