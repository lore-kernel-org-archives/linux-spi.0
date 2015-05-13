From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH] spi: Force the registration of the spidev devices
Date: Wed, 13 May 2015 21:17:09 +0200
Message-ID: <20150513191709.GE4004@lukather>
References: <1431462804-30467-1-git-send-email-maxime.ripard@free-electrons.com>
 <20150513112604.GI3066@sirena.org.uk>
 <20150513153740.GC11677@kroah.com>
 <20150513171300.GD2761@sirena.org.uk>
 <20150513172028.GA18303@kroah.com>
 <20150513173922.GF2761@sirena.org.uk>
 <20150513181631.GB16811@kroah.com>
 <20150513183211.GK2761@sirena.org.uk>
 <20150513183653.GA879@kroah.com>
 <20150513185149.GL2761@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HeFlAV5LIbMFYYuh"
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>,
	Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150513185149.GL2761-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--HeFlAV5LIbMFYYuh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 13, 2015 at 07:51:49PM +0100, Mark Brown wrote:
> On Wed, May 13, 2015 at 11:36:53AM -0700, Greg Kroah-Hartman wrote:
> > On Wed, May 13, 2015 at 07:32:11PM +0100, Mark Brown wrote:
>=20
> > > Oh, right.  For this to be useful here we'd need to implement a new_id
> > > file, bind and unbind don't do anything helpful here.  I think I'd ha=
ve
> > > expected this to have a default implementation that non-enumerable bu=
ses
> > > could pick up.
>=20
> > No one has ever asked for that, so feel free to make a patch that adds
> > it :)
>=20
> Maxime?  :P

I can try to give it a shot.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--HeFlAV5LIbMFYYuh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVU6M1AAoJEBx+YmzsjxAgBVAP/jQyFByzpAUxLpHcByzLI8Yn
583rqh+1DoUkUxG5ltodhJ4SDMO8vDPienshgLEcaO62GoNRCWEM4iuTzg+HR9ng
mzs8fyp3dP7jWYU9I7Mq2E2i0f0qitGjdqHsjEYfRbeMvusGTPi6rVFGrhULkCjk
v97WOLhi6LPlodiUnYb3lHUo7JXBoovN3JrbbsDstTLEvEw0jE4zKS/DzRuag7SS
s5j6+RVW1rV6k9x2xnnIG3EOlgVbjq0qlZivklmEEI8rHPN2iuN9tZ5isT12lqj4
dSvgrFrSK7zb+2divzmhw8cTazmj/e0QYqRzxB/2MrYhTL0lJAkAuGVo8NT+DO8u
9oF+s0WkAl+uY30GSrYe9isnAg3KHK0jvH6Ha1WeBhKaHfzmPChb5/BdgkwcLZ6j
ZlWwpwOshCUBJMKk3fhYASK9xL6RRYRKBJAl5Vn/9duPUcEHyH1ObGhwxJF2rStz
dRHQK+z5gzQFujMnb7oLaqWxsl9nf+RtV7h95Xs6soERgLtVHudb1gtqq6KMasDC
CM6NxO6aXZd8UEl82cfB5RfSp6IbRTW5FZ9ZFAxXLfOwxFScblzx015IdXiHw5Dy
eY6dCMvViJITQoS9fuMQyeYCD2pAO2WXJAOo1lMoBPye59ggM2sLqkPHjpCkCGCq
E2osV7GgSN/5S0wceB+7
=4Ouv
-----END PGP SIGNATURE-----

--HeFlAV5LIbMFYYuh--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
