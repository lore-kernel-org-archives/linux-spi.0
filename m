From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: sh-msiof: Kill sh_msiof_spi_bits and
 sh_msiof_spi_hz functions
Date: Mon, 3 Mar 2014 10:47:09 +0900
Message-ID: <20140303014709.GM2411@sirena.org.uk>
References: <1393770632.4044.5.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JvUS8mwutKMHKosv"
Cc: Geert Uytterhoeven <geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>,
	Magnus Damm <damm-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1393770632.4044.5.camel@phoenix>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--JvUS8mwutKMHKosv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Mar 02, 2014 at 10:30:32PM +0800, Axel Lin wrote:
> In the implementation of __spi_validate(), spi core will set transfer
> bits_per_word and max speed as spi device default if it is not set for
> this transfer. So we can remove the same implementation in this driver.

Applied, thanks.

--JvUS8mwutKMHKosv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTE98aAAoJELSic+t+oim9x2gQAI+FUjnCrVbdw7rq1ygBcspp
2njCc/3GBXLMnitsNt+JBhLxBdJ2iwSIZe4bDMeZ2fi+pCyMjt+eK2MPkOHorc9M
rAnhX4PGcrDgP/IZpp5vg/00M0vHplXjTHWBYBxHP32SySXGfmGVOkA1X/tK08uB
acnXrJzesaSg/2uAcIpAowzzGvz0A6PDrod1RuQQTb3t5u6UeTUpDS580e0m/wtG
DUPvJjsdp4qB4nNgLEbbFQGXfk4QGTRFwUR3MpCGPeFyDK6BhiCRf9mqQPueupzC
74XsEWCeHjS+6EX0oprIfXuH+7jLnOEwwwYNale0eU6Y4gmAkIAAlOB0VHXOrDyo
XZCzZfMme1UCOZuuxuTs/7we6kgOH4ZoV3oRSBq9l9Brm296Ant2MRqpwe2wwvSX
SNm2XmB5kIAbCK8SqeljU/cEeM7ie7GGvD1GH/BKxtQ3xO1GG8HDuMX/yi7kSvAv
09LyKeqMpMujvujqjsMXBlbcH0jCb/Val4ViNhMAG1lzixxRc+mK9fRyLdKzIGGu
daR3DqWlAJnTPMQs/lcmip7xVtifpIdtU5avX8T7Em8/AYZ5vANmZfAyXhnfT8Aw
/E+pOJaFB2fzp6MSM1NScJejiLOyJGSADOQo/YEYbgpS4/1GiTb65ZEtDyK1GdZo
QHZ1180Cj2eA6U0mNqar
=BY6p
-----END PGP SIGNATURE-----

--JvUS8mwutKMHKosv--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
