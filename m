From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/5] spi: sirf: set SPI controller in RISC IO chipselect
 mode
Date: Mon, 14 Apr 2014 21:03:06 +0100
Message-ID: <20140414200306.GU25182@sirena.org.uk>
References: <1397457001-5266-1-git-send-email-21cnbao@gmail.com>
 <1397457001-5266-3-git-send-email-21cnbao@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/Rh48Y0bnrojh5Wm"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	workgroup.linux-kQvG35nSl+M@public.gmane.org, Qipan Li <Qipan.Li-kQvG35nSl+M@public.gmane.org>,
	Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>
To: Barry Song <21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1397457001-5266-3-git-send-email-21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--/Rh48Y0bnrojh5Wm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 14, 2014 at 02:29:58PM +0800, Barry Song wrote:
> From: Qipan Li <Qipan.Li-kQvG35nSl+M@public.gmane.org>
>=20
> SPI bitbang supply "chipselect" interface for change chip-select line
> , in the SiRFSoC SPI controller, we need to enable "SPI_CS_IO_MODE",

Applied, thanks.

--/Rh48Y0bnrojh5Wm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTTD73AAoJELSic+t+oim9AsoP+wYuADpAw2AENIDFePA7HyZ5
y91kYNMWOgtl910qjFTs0p45+RQF2Rr+taE5qiEwZ3SzXuWZTF4SbJ6AZaSYBj3a
RHP551C61nkD/7BzN4IlV1hIEXCCzhhtzMtk6ORCnixfqteUcxlK/1boIjvzzurI
e0DgCWc7Ms3h6iSLmfdmqswvnHdK1kpHwxL5SplbY7irGTXTWQBk5A77wGcOLsOG
2ebGXpdJsaZKuwvl2CoyFiJxmRrl8BV2EOjDCpQM8jA4N03m6Pyp2oyOiublcx4Q
zMZP5boG3WX7rC06Vc3VaAHY439ybUpdnMBNKpzxxWyn7dpvAySXGkehusrjQWiY
XHZChnedtNTx8kx+K4fhoz+BfeQk8FNTOsoVjClqjU/+ErVtsxWFVP2+Zwf9YDYM
mS8dUJLXX3/IXfWRvy0RbS3dIdv/fhVcf+XLD1Zu4v0snfRaLD5YKtPD+wJsFmeq
Mm8INcQKVioGBZuxlx00H0tXnX4MZiGLv08SlCmCzFP8JETD0zWPNkZkxllaCYAN
hoT5bs9ykoEVtWckVEfpyHlWPRaC6lGw2sMAnC2zRuidZVVYqopPrvDfKw1D38l9
rUYoaomUj7ez723lWXrdvcxMx2aVAwbrZK+28gh58a+H8d+y/EhXCcZk8oJBnYyL
gWHIHHvHBwz8h6cubTVc
=5tKZ
-----END PGP SIGNATURE-----

--/Rh48Y0bnrojh5Wm--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
