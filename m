From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 0/2] spi: clps711x: SPI driver refactor
Date: Wed, 1 Jan 2014 13:24:43 +0000
Message-ID: <20140101132443.GQ31886@sirena.org.uk>
References: <1388556488-10887-1-git-send-email-shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="M+v2aDNX3KeyWL9I"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	arm-M9wQeQvtlogdnm+yROfE0A@public.gmane.org
To: Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1388556488-10887-1-git-send-email-shc_work-JGs/UdohzUI@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--M+v2aDNX3KeyWL9I
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 01, 2014 at 10:08:08AM +0400, Alexander Shiyan wrote:

> Since we do not have any platform users of this driver,
> non-DT support is removed. DT users will be introduced later
> once DT support for this platform will be completed.
> "ACK" from arm-soc maintainers will be useful here.

That's not likely to happen given that you didn't CC them, though it
shouldn't be need anyway - there's no reason for the arm-soc guys to
have to review driver changes.

--M+v2aDNX3KeyWL9I
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSxBcYAAoJELSic+t+oim9GYIP/1y7+M9aXGRoNLqikbdLWEpe
ensfXlfVrrpuspjsnoeHD6nvixAMtaijbA3hySdamiVpGgCtePhTEJmk7/r7mOwo
3oEeczhtqPR7u4uSC1qpR3Y2o91v8THD2ug413rmnqNOVvIpP2c3ymY60LXwCU3H
Cqz5ULm2fP4FUDi9P1MXqvHtzrJ6kTyXNHGcKOMI/wGNR9DW+Q1m5GZclmquTUuZ
J/z0KHr1mDT3bd6trRbeSA5Jjmn1UuRDQxjS1NRRVJqWB83OJNNQ5//lK25x9K2y
lGsBsqbhOndPycAhZvwLQGJiPMdvxSGHk28vIMDzayo1g7x2qvGFjr8SmUes1XKc
705rtm8dwswNpy9hcHsWDa9IvNDhi/70MYvZdllp9FA66yw2InbO8GWIHdo0anax
X6q/V4TssKmtXxqPTbh7seWLU3CBvz8+d2CiRcqc9e4VgEvJ0fON2rvuZqwhD2CA
f784gG/ISsRYHduXI/qbdQfG6LbneMWV14BRkUiU5mMXM5daklaWwUnK9iRsBabt
J7mri+ovjmm3282dysSa2Ef7mDIJhAMgi0gOiW8IS32b6MhijQLVxWge94efYycl
V//qEKcYLYXILXXPBMWqrRsSiLn2tbm3zjzcMjVoAGuEU0S5sdPGOHMBUyuSM0z2
f6cv4QobT9No1o2fcRVy
=UbY4
-----END PGP SIGNATURE-----

--M+v2aDNX3KeyWL9I--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
