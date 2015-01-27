From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 00/18] spi/xilinx: Speed-up
Date: Tue, 27 Jan 2015 00:14:19 +0000
Message-ID: <20150127001419.GO21293@sirena.org.uk>
References: <1422029330-10971-1-git-send-email-ricardo.ribalda@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="T3X/gqwmxfK0WLE8"
Cc: Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	=?iso-8859-1?Q?S=F6ren?= Brinkmann <soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ricardo Ribalda Delgado <ricardo.ribalda-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1422029330-10971-1-git-send-email-ricardo.ribalda-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--T3X/gqwmxfK0WLE8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 23, 2015 at 05:08:32PM +0100, Ricardo Ribalda Delgado wrote:
> This set of patches has been developed after using the core to access a s=
pi
> nor flash. The initial performance was not as desired. The following chan=
ges
> have been done.

In general the best way to present a series is to start off with any bug
fixes (so they can be sent to Linus and stable if needed), then move on
to mechanical and stylistic cleanups (since they tend to be easy to
review and apply) and finally move on to new functionality (since that
is most likely to run into review problems and the cleanups should help
review). =20

>   spi/xilinx: Support for spi mode LOOP
>   spi/xilinx: Simplify data read from the Rx FIFO
>   spi-xilinx: Simplify spi_fill_tx_fifo

spi-xilinx?

--T3X/gqwmxfK0WLE8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJUxthaAAoJECTWi3JdVIfQvM0H/RUTIKxyqWSI0rmnTeamiy5U
LE1NUOz6tDgWDbc7vJjj13MsK1RACWRirfZDvD5GDHZXKJW8buIMSBF2jkFOSaLd
Ngn3+L7RK+dsS0Hv0wOj6Gdodrz9SGdTOCKQ56Z9yDHC7HWRZSKKVlOfTW0tShRw
RvbbEPP2dpTBe/7BUq7MQbmW+niNED00HtTKRj+ZGDMCFKrcpOsWFziW6/vsIfGH
2hFh2La3VRTa38p4q3y8YSODLV66H9f+9LJfHZO7xG38C79EdVVl1ISccPxvh21l
UOigq5GdvV2Xwm5D2B1rwsw+dzOcBwg9J9U9HJ4UrEk8tLWd0DgwlRqufYcphIs=
=+k5F
-----END PGP SIGNATURE-----

--T3X/gqwmxfK0WLE8--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
