From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: Add a timeout when waiting for transfers
Date: Fri, 31 Jan 2014 12:26:17 +0000
Message-ID: <20140131122617.GC22609@sirena.org.uk>
References: <1391121536-10937-1-git-send-email-broonie@kernel.org>
 <CAMuHMdUVmL5Zq8AYPVmUyWEBTzokSMV-Xg4uFzpxr7c2uSmU7g@mail.gmail.com>
 <20140131114935.GA22609@sirena.org.uk>
 <CAMuHMdXLe+Ot5ntOtUC2Qynid4mv1h+UoitJuDW=Z-iyRKXCdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fwblGvOBo7NCOYks"
Cc: linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdXLe+Ot5ntOtUC2Qynid4mv1h+UoitJuDW=Z-iyRKXCdg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--fwblGvOBo7NCOYks
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 31, 2014 at 01:00:31PM +0100, Geert Uytterhoeven wrote:

> One other thing: I haven't tried your patch yet, but I'm afraid the 10 ms
> may be too small.

> E.g. with PIO-based RSPI I don't get more than 2 Mbps, even though
> spi-max-frequency = <30000000>, due to the PIO and interrupt overhead.
> Hence a 1 MiB read would take ca. 4s, while your timeout would be 300 ms.

Hrm, I wouldn't have expected something doing PIO in more than one burst
to be letting the transfer run in the background.  Though I suppose that
might make sense in some situations...

I was wondering if that was cutting it a bit fine but more for scheduler
reasons, it's what the s3c64xx driver has been using for a while without
complaints but may not translate so well with greater exposure.

--fwblGvOBo7NCOYks
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS65ZlAAoJELSic+t+oim9opAP/32ABGnJRpGL+sI/pz0VbM6D
S+QV/+0bBEtvkyFCaqXvDwFad956t6IABM35BvdnSmbs8qhRXcSB6o0zbmUoT3c8
DLOAfPPz4PQgf/XscZO7A42KlWC4nAAdBc5qFp4xkkb6npXt0IEnZ61RLr4Btjtu
2AfFC571pkHBYImpCpg2Hpw7QHFAA31ZnXtr0MeYn+znscBNf12FOe0yGyQhib+P
qlIp8yEcVJmVebtN0o89fW3xufeoO1XQoPf2ovOahrmLKP1D8kQgIFDGoHb87avb
C7fcq8zQ6t/HIPcuOfsKM1MsLuaY6dRgB7QSwqT1ya2ZIF9G0JPT31zbacx8fZhA
oaacQ9n0kbIpUca+p30x1c4YGNxvF3uMH0M/pUe1+jw/qNBMO01UDS/DXH7DNcJ8
zPsd9eDw7KEy3OWkQNvwDr8veTpi4ey4DfCJZ7pe+zFNR7v2XeA9r/pTACJRMXRK
mmUIc23+5zRlROiT471hKMkcMhiCbeqz7vlZ8j3BRlpcRNEcjLyVv6s3WzyTpauQ
Eo+3bfZ33zcdJZ0Ro+tfCTAj/VxmnbBGA0rEQTWDSjBK0g1t0IR52q3OrpgTZOB3
efYiNZhJZWqyrL2dfMbGITT6QPpH9Z7EyTqvMOZtHQF0gTxhiWpY+paNhPZqlrC5
Q6y8TbVWMxKQKTgGrhfx
=Bi8t
-----END PGP SIGNATURE-----

--fwblGvOBo7NCOYks--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
