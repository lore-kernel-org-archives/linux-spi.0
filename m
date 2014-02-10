From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH RFT] spi: txx9: Convert to let spi core handle checking
 transfer speed
Date: Mon, 10 Feb 2014 14:15:23 +0000
Message-ID: <20140210141523.GK1757@sirena.org.uk>
References: <1391919307.26425.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="g5OIygP5QP1fC/+Y"
Cc: Atsushi Nemoto <anemo-7JcRY8pycbNHfZP73Gtkiw@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1391919307.26425.2.camel@phoenix>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--g5OIygP5QP1fC/+Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Feb 09, 2014 at 12:15:07PM +0800, Axel Lin wrote:
> By setting master->max_speed_hz and master->min_speed_hz, spi core will handle
> checking transfer speed. Then we can remove the same checking in this driver.

Applied, thanks.

--g5OIygP5QP1fC/+Y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS+N74AAoJELSic+t+oim9r6wP/0YEStEQjw19jSpnT4/Isq4E
MQTE2RUX+QozHDBx2praoil3hHneoAW8X7JPaKcllOl7rBLz90Z+sXXs33heuVVr
P5taCC387pO8J164J/iFOWYUQ/25HTiC/508Yl50TDn1qf/X6aoS0sLqtVxQJZLe
rqWMbDhO6zsx+i+D5PpZBeqWf3qbsmm6lGx83T87WTI3T7cEYloXY9X6j9dQO4sQ
ZodYxq2WXbOMZaiVp6QnJHFnfYgDJ0sdd6c1uWUHBRWIkP0Ul/GRshWuKLrAIhxy
V52DJO6Lmy8+R1W8+om+BepF04Hf3q6gLQuqiXwbmiWughuqdr7H8wdHC488asnL
lLxdPTDtanHnOKvWkPCBFWb3frPFhGL8WPcj6qmH4oPFkzDA2pak6HDvO/ThTZlg
BIta3gCeEBApUEkUgWffnGnbbGsgQLNgSwMNa1kHxNQVwZYAxmBODpd2yHqvNtzu
8ztjhT28xN6xk6mFhGg46L4aknVZbWkPe1GQ1GQ5jDnIKSzTm3Kueb/ClwdxSrz8
8lcYOLJycOdtoBt/gQafapzNUAUIE15cMkv8nhUFIuJ/qSWuZJ3AODwQhH0AyB/3
RnASjsv4doN6H6wnM9yN4Are1M4a9wASfoVzQcG7GdqiClKo7yIEDuAf5GZignii
ffptntpmlLyM7ee2CEk0
=dl5r
-----END PGP SIGNATURE-----

--g5OIygP5QP1fC/+Y--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
