From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: coldfire-qspi: Prevent NULL pointer dereference
Date: Mon, 10 Mar 2014 16:08:31 +0000
Message-ID: <20140310160831.GM28112@sirena.org.uk>
References: <1394345470.15686.1.camel@phoenix>
 <201403100904.05819.sfking@fdwdc.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1PVGkiWogmj8NWQ2"
Cc: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Steven King <sfking-xS0NTnu2YfYAvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <201403100904.05819.sfking-xS0NTnu2YfYAvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--1PVGkiWogmj8NWQ2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 10, 2014 at 09:04:05AM -0700, Steven King wrote:

> D'oh!  My bad.  Actually you're right there would be a NULL pointer=20
> dereference in cs_select and cs_deselect  (I was looking at the cs_setup =
and=20
> cs_teardown in the patch) and so cs_control must not be NULL.  Thats want=
 I=20
> get for replying before I've had my coffee and when I haven't looked at t=
he=20
> code in awhile.  So yeah, the patch is GTG.

Hrm, I managed to make the same mistake when I redid the verification
somehow.  Odd.  Anyway, reinstated the patch.

--1PVGkiWogmj8NWQ2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTHeN8AAoJELSic+t+oim97egP/0Ndqe4cY5B+KL/3jTPEfGbs
Dyn0T41zz++KEkI7IgKFonalUe7Ha/lxg3YGcIYK/Wp8BBcYE1j5HpNNp0Fr1qlQ
4y6RBVqjWuqc/c44xaxi2dgFDSWkc29mAD7N5GcFNulItYVLBBhm/buzr6mA2/il
ASa/sQJ0Ke/UBUEmynz8i+YyfySkQXuKsWR8br2ptH1dSbSHrQLKsSLejZLrKM3j
Rc/5MWkzP1qlrl1qnZPZcHq9b5ipv42MjSTZqAKSGgTC1lqbRimWuLiwSHKhh7fC
CrZYjLSttkctS2sayGqC+5TUefljnUFHzbOSeu4S9/KMETCH/aj4a+HgUZFqI4MS
Lhm0FP7ehId4L9A7oHycHkT1hUKBlimxt81LFay7C/Zji4F6Z13BhPEMeH0VwCDP
Y66IwcHQsp2wtfQW5wVSOOcKC0reOcI37BMhMYjTNw3AyE9rWEGmRwSfmGDaJm0O
INDAH+PVhA14GvePYu98s0RtgMwVPQ7vLSEGsdJuPAPTSCdkvC3PsPwZSy9s0uTD
GElwVyCPEPmpC7sILSC8DyKxfAwotIxlfx4SzRnleLT/IIC01SM6KcMjm3mXAo8f
9v/9PIOXFZ+8nn/ChLUBnChC06LdyglJuHbo3ll0mhp2ZcdNrp37wXjET9C/ZtIl
QUU/6zP/lbrYfy/i7l8G
=MLNl
-----END PGP SIGNATURE-----

--1PVGkiWogmj8NWQ2--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
