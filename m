From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 4/4] spi: xtensa-xtfpga: remove unnecessary #ifdef
 CONFIG_OF
Date: Tue, 2 Sep 2014 11:50:34 +0100
Message-ID: <20140902105034.GS29327@sirena.org.uk>
References: <002a01cfc65d$2dc86640$895932c0$%han@samsung.com>
 <002d01cfc65d$9fa78d90$def6a8b0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="99FKeZQ5IARcBmLz"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Max Filippov' <jcmvbkbc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <002d01cfc65d$9fa78d90$def6a8b0$%han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--99FKeZQ5IARcBmLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 02, 2014 at 12:26:02PM +0900, Jingoo Han wrote:
> Remove unnecessary #ifdef CONFIG_OF, because this is already
> handled by the of_match_ptr macro.

Applied, thanks.

--99FKeZQ5IARcBmLz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUBaD3AAoJELSic+t+oim95IsP/itc9fjK3SjRdADIfoao2ht8
Ot8S9bS8hX4X685B8Z4dKIfP7YD5mrRZxc9yf3a4cmAR/QzWjkjYTW4tLqf//usG
Y0MTfohehoA5pUZdkTADqwZzvCLU2ATnhn1Qy9jIHEPwC9/NUniCkcma7siPpDEI
UeTt0/Rtt6NWjgaCBet9/xS0saJzzpwvZxNj4V412nrKdukGhRxgcPezMvmzFqN0
DG0f7RG1V5vYnRSwUw4Ofb3Ls5hYk9eMwFsdgOzGkzrd+4SbGmOYIOvys7mrQi6k
OfUiHCQfBdX7NCzFLkMGQuxjuO4IDxH4UuNRKOMFCKQsAZCDGX0KSqg5BpssbzOt
HwuA0c44qxM5G+8dFdLbFx9Rhb0lY3bgD3GXdFm18g8y4irBePZYDhiFfn8CUdis
nqzWGt8oEijVOD3VDya9uHAZIgqP1NNQfZ1n8cTnedABT4O3VvxakBkz7uwsioBh
xl1a4Xc0zfNchwZau7OYKXEiXqrstZLqjKVohJmqBpXdlBZiGE7JnAfurNpKxCsL
I3YcpDrKbT2gnFwtntkH/S015O1LKAUDXwUEZn66yWqBPI/kmdQeFrtWyBLGcJSw
dalI016c56YLkeP6Fi8BaeBTc9haG8ZLnqEerZhOHVXZnf2VucJJM1gw/BFvc19w
R/mhu+izQJhlu/Q/8tUX
=rduE
-----END PGP SIGNATURE-----

--99FKeZQ5IARcBmLz--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
