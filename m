From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: sh-sci: Prevent NULL pointer dereference
Date: Thu, 13 Mar 2014 13:40:21 +0000
Message-ID: <20140313134021.GS366@sirena.org.uk>
References: <1394677957.15733.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jo46wx5DSA4a/gWG"
Cc: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1394677957.15733.1.camel@phoenix>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--jo46wx5DSA4a/gWG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 13, 2014 at 10:32:37AM +0800, Axel Lin wrote:
> If sp->info is NULL, we will hit NULL pointer dereference in probe() while
> setting bus_num and num_chipselect for master:
>=20
>         sp->bitbang.master->bus_num =3D sp->info->bus_num;
>         sp->bitbang.master->num_chipselect =3D sp->info->num_chipselect;

Applied, thanks.

--jo46wx5DSA4a/gWG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTIbVCAAoJELSic+t+oim9MS8P/2wZM2wvmuaXjmMs1KXIm9/w
JNz1+y3lE5lWFSivD0mJKMLKWOKW2x87FAgdnsCucrgMQsSd2O0Z56z4uANLdufy
771c/7bb+QmIPilb3x1qfLRCE/D7U6NFEJrNsFE/4vmhRODI+NF5REMQJl21VHov
YUrnxiYw1kx9sY5Vu8NjyuPC0pEUzsokfbtxx4dFUeDAV7qC1UOmGNT0MF7iKhwm
Bt+0HTZHCoOEft5CbUsUnTzlRVS2bd1nrp/Q8/p8R4Hjr20C8o3l55ZiuZCJQwnA
vn05tWpBVpT85iSgA7lnlW5N3dCXAfONC9HdRM9zbkMsg1TKSL9Q0ae+209RotcO
XjafYr0DlKDJy/5rJe9wcrW3R0egyElvuAfr0D1UqwpNygCO+NPrl9GOhDUwRyri
ZcSA9FjRxIlZJQEoGavsgVd64bkhI6cWTBqfSlDgL3nG5DY0lIuzLfp/1Lm+3UTy
GzmOyA+t5O9VcAWt5vgDH1djHJi4KB3z/hRxCSb5uJ6sGbsohqRJ9Wdmo7/IhuN8
4qtM43JBJRdKa6d1xW+w8bruy0La2bTPzZ1X21go+DhICtbLhVzbNJQqk0izaMH8
0Vf5Y3dAEoO8F+6NMnNUmn2qhTCs3FJW63pQwz/EMIY+ch+ekBD5b3EwbyFq6+bz
FS+ozqiDb2k6PDAB4D4w
=zELT
-----END PGP SIGNATURE-----

--jo46wx5DSA4a/gWG--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
