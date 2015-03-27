From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] spi/rockchip: Round up clock rate divisor to err on
 the safe side
Date: Thu, 26 Mar 2015 17:46:09 -0700
Message-ID: <20150327004609.GB3572@sirena.org.uk>
References: <1427412625-12377-1-git-send-email-jwerner@chromium.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="T0u6oYl84yPn00Od"
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>,
	addy ke <addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org>,
	Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Julius Werner <jwerner-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1427412625-12377-1-git-send-email-jwerner-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--T0u6oYl84yPn00Od
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 26, 2015 at 04:30:24PM -0700, Julius Werner wrote:
> The Rockchip SPI driver currently calculates its clock rate divisor by
> integer dividing the parent rate by the target rate, and then rounding
> the result up to the next even number (since the divisor must be
> even).

Applied both, thanks.

--T0u6oYl84yPn00Od
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVFKhQAAoJECTWi3JdVIfQwFkH/j+maez2s4cqChJbduOnwABh
9CEoPMZfuEUr2xoqwALE491xrlsAVhiv58LM0/3R6OXzh/RvTkisrVS2D9T/Pd0d
ADf9srakamClgrOTcEMeJDNB25pTXVVCkvek0SJWgrefPC2hxpl+caGv4fZmjEXU
RepzAZQGKtn/xAX6HMso9sWzTJBZAEPaY/dmutnjt0ywS184sk6+v0X426sfFyYl
09CkegF/ChBjkgWA7jJn+3l3O+cX8ekTMf2AdJeszUxka+9yhkUJDWbdT8YK0eiA
KVGK1dDTlDUAlfgm4pwEwkbi28Kp/kMyTTaPow2i1Z0SE2NRzOrYvOn4jYt5l84=
=DLmY
-----END PGP SIGNATURE-----

--T0u6oYl84yPn00Od--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
