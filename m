From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: omap2-mcspi: Add calls for pinctrl state select
Date: Wed, 13 May 2015 19:15:36 +0100
Message-ID: <20150513181536.GI2761@sirena.org.uk>
References: <1431519316-30989-1-git-send-email-pascal.huerst@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+dJ5Ea9E9bxtHwvD"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: pascal.huerst-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1431519316-30989-1-git-send-email-pascal.huerst-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--+dJ5Ea9E9bxtHwvD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 13, 2015 at 02:15:16PM +0200, pascal.huerst-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org wrote:

> This adds calls to pinctrl subsystem in order to switch pin states
> on suspend/resume if you provide a "sleep" state in DT.

> If no "sleep" state is provided in DT, these calls turn
> to NOPs, so we don't need error checking here.

We should still be checking if we succesfully changed the state when
there is a state provided shouldn't we?

--+dJ5Ea9E9bxtHwvD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVU5THAAoJECTWi3JdVIfQVAUH/iLOBXeEYMGC4Q0q903KJfOt
aJFtbpkHFRQuvSi3mkSrNuD2fwMQDc2AET3/96jXT3VTq2T47Ut4mB8cKvxeiR+E
HLe5oOrHl5cmwVLUGzC+bJcm354pCe2fv4Z9Ay63tTUdP5qcOx7GiJZj51TY0i8g
Z/DKO871F50terPwYlH/EWXG89ErWl3YVuBcs0sHPqcgEdU4odHiVzskQCx8Mt3X
dDNexMq4wyiPfZGZsbjvxdURXbAzmGp6jm5+9sdGYJXgt/hdyAN4WBgRjwcYHb3n
m4YfDH/Fg73UZIKY6oMSp70wCcmEhDBQyJh79VTgPYIr89RpPWAjezhr1sxTtc4=
=D9ug
-----END PGP SIGNATURE-----

--+dJ5Ea9E9bxtHwvD--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
