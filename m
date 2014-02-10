From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: core: Set max_speed_hz of spi_device default to
 max_speed_hz of controller
Date: Mon, 10 Feb 2014 12:52:07 +0000
Message-ID: <20140210125207.GA1757@sirena.org.uk>
References: <1391962085.10294.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fU5tsrXreH0/dVH0"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1391962085.10294.1.camel@phoenix>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--fU5tsrXreH0/dVH0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 10, 2014 at 12:08:05AM +0800, Axel Lin wrote:
> In __spi_validate(), xfer->speed_hz is set to be spi->max_speed_hz if it is not
> set for this transfer. However, if spi->max_speed_hz is also not set,
> xfer->speed_hz is 0. Some drivers (e.g. au1550, tegra114, tegra20-sflash,
> tegra20-slink, etc.) then use below code to avoid setting xfer->speed_hz to 0.

Applied, thanks.

--fU5tsrXreH0/dVH0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS+MtzAAoJELSic+t+oim9vFcP/ioPnAFyE/8frI8zaWl5DK/d
HMTuQtXFkcVhyo1LZ045pS7hKmBorFqEUtzM9vpXBeG6EaRYR3bgW8pqwtTUgzEI
dLeEnijZ64xTvS5qX/jVubwtAnYp3LYO4P5f+yPcLi9IH6jHVogJ/Q49qjTUwhOd
a3kXdXa15i3+U9cZ2fpqDvPdrEC1XjmDWQCNByhZMgjjWvHBqbHBPoKk7xt3Qaa3
HWS/61aZn8hTblYcLYAJXLUAGuxcPeoceKO6IjkJDBHeU65LTAYzZLobOgEozyvz
WJvy6MK05hkubBXSvFTBlJvE2Ze0EtAQp4nIzXBbfJYQW0ZWMqpSV5BG2nMFoecO
f0b+kEBu7X9cL78BkchwRmg8pJPMg3gNpBHz5IpoeX5f8OmVk+DjCM1me9K64gax
SrkAzQxUNmLUqKQKpb18Tv7w4w0eKaeRWnotMiiT/ca6VznULGnwBZZXISvUUZMo
ZiE/GOg92zbGKXy1jxF6scaw/1c7BOnyfkM+CSSIZriP2xvgW4VTMgJcwuD+0HaF
P7DDKJmjCL5zlIcqb1cszvrMDFJ9htXkmbWalA+nsILwG1Gi8a5Nqy3TUNPQIz6C
zSJwlV8D0c40FQyw3ie+D2SinMnjwdsv3R0c1aqYqfV8fOTovpa+0CRbSCTlv+Z7
EXu/+HYRgkV88xLxEvbV
=4N2N
-----END PGP SIGNATURE-----

--fU5tsrXreH0/dVH0--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
