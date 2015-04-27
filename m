From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [linux-sunxi] [PATCH 2/3] spidev: Add DT binding example.
Date: Mon, 27 Apr 2015 11:16:01 +0100
Message-ID: <20150427101601.GN22845@sirena.org.uk>
References: <cover.1430034797.git.hramrach@gmail.com>
 <bb069283a5c2ccfbc05177f1ed41cabb1485796e.1430034797.git.hramrach@gmail.com>
 <20150426103257.GJ22845@sirena.org.uk>
 <CAOMqctR235uF+7kNGsLEGfrrAOQAYmw0pWgk6t8fZHNT7XsRuw@mail.gmail.com>
 <20150426110144.GK22845@sirena.org.uk>
 <553CCABA.3090504@redhat.com>
 <12F80B18-7418-430E-94F7-5A20C133BA9A@martin.sperl.org>
 <CAOMqctR8MZ_r6HHEBWhgxpUsTaV=M7DfmnJ_VxTqjWu4KMBSwA@mail.gmail.com>
 <20150426125113.GF5627@lukather>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rhiDJeLTeDyO3iY3"
Cc: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>,
	Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>,
	linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
	Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	linux-doc <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150426125113.GF5627@lukather>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--rhiDJeLTeDyO3iY3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Apr 26, 2015 at 02:51:13PM +0200, Maxime Ripard wrote:
> On Sun, Apr 26, 2015 at 02:38:18PM +0200, Michal Suchanek wrote:

> > >> I don't know if it's been suggested before, certainly nobody did the
> > >> work to make it happen.  I don't think I have a massive objection in
> > >> principal.

> Actually, I did it a year ago, and it looked at the time that it
> wasn't what should be done either.

> https://lkml.org/lkml/2014/4/28/612

lkml.org is being terrible as usual so I can't see half the thread (or
at least got fed up trying to get it to load) but I think the discussion
there petered out more than anything else.  Or was it the suggestion to
make this something that the driver core supported so that we didn't
have to open code it for every bus?

--rhiDJeLTeDyO3iY3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVPgxhAAoJECTWi3JdVIfQryUH/33lba8uUmpu4Dv00cmvNmAL
9vEjjHyu48ie8TOwEXreBMudsxWsD6o22bt5nU1TWNnr8ewB9MGgmz4HfVo3qgnR
0923degR5Ha2NhFIfJIl69e5QEIQoW3fq1CL20GOB0TiJsPSxTvLC2lNF/B/xJr2
CC0rcQADPgvgrpBMVGEIYnJ/NCzRT8XjNJS5p9vVXYPYdt0qMknAXyXKm4lNrcl9
TTMvEQ4/i542UQFZlDKLDwZ5lADVeyC7kkbptJSLe+V8Mb0fQSpAdjjwtvXZNWDO
7ekhVK0BaWi7OH96ZlaYzDH1q/WjKkgELyJFkrbYwsVVHxg1t9GkDMq5OyKq+Tc=
=gbKG
-----END PGP SIGNATURE-----

--rhiDJeLTeDyO3iY3--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
