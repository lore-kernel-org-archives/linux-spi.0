From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [linux-sunxi] [PATCH 2/3] spidev: Add DT binding example.
Date: Mon, 27 Apr 2015 19:07:28 +0100
Message-ID: <20150427180728.GW22845@sirena.org.uk>
References: <bb069283a5c2ccfbc05177f1ed41cabb1485796e.1430034797.git.hramrach@gmail.com>
 <20150426103257.GJ22845@sirena.org.uk>
 <CAOMqctR235uF+7kNGsLEGfrrAOQAYmw0pWgk6t8fZHNT7XsRuw@mail.gmail.com>
 <20150426110144.GK22845@sirena.org.uk>
 <553CCABA.3090504@redhat.com>
 <12F80B18-7418-430E-94F7-5A20C133BA9A@martin.sperl.org>
 <CAOMqctR8MZ_r6HHEBWhgxpUsTaV=M7DfmnJ_VxTqjWu4KMBSwA@mail.gmail.com>
 <20150426125113.GF5627@lukather>
 <20150427101601.GN22845@sirena.org.uk>
 <20150427173036.GA10950@lukather>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="edjURWvLLIq5zNyd"
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
In-Reply-To: <20150427173036.GA10950@lukather>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--edjURWvLLIq5zNyd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 27, 2015 at 07:30:36PM +0200, Maxime Ripard wrote:
> On Mon, Apr 27, 2015 at 11:16:01AM +0100, Mark Brown wrote:

> > lkml.org is being terrible as usual so I can't see half the thread (or
> > at least got fed up trying to get it to load)

> A part of it is also here:
> http://lkml.iu.edu/hypermail/linux/kernel/1405.0/00484.html

OK, thanks.

> > but I think the discussion there petered out more than anything
> > else.

> Maybe it did :)

I think so looking at the archives.

> > Or was it the suggestion to make this something that the driver core
> > supported so that we didn't have to open code it for every bus?

> Probably. That's something I really haven't took the time to look at,
> and don't really plan on doing so.

> I guess a good way forward would be to revive this patch, and wait for
> that generic way to happen.

> What do you think of this?

Probably best, the Pi bootloader does make it a bit more important.
Might also be worth speaking to Greg though.

--edjURWvLLIq5zNyd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVPnrfAAoJECTWi3JdVIfQbJIH/0fDIuE8W0pPOSg8xqnWPL/Y
cAQur3zcZrqUnxLCz8H8rLkbw/D0z1aAeXoPInBfSVQaYwt+a6CCg5GdPOoIdPub
uG6DcanqoicWmPuX63ep9URF3XFpAEWZc7F/LDERpILxkMA80bKiFUWg9GpU719g
O/3ptMRkikdGaj3SVIeHzFqOk9/WSEYONP/vLts3IqgEcxtnNanza6lVzHLEOEN9
b2KyVo/KNDppvPu/Amaja95ETxheNSNxRLOOzEYWuNZ+rmMfp+p6JbDGbiZ1/qY+
RkELFhW+AO48cEUv92gD23ROoxCIbX/qynRHAhaPy032jZRPlfPJQVqEONrbsmY=
=bDoQ
-----END PGP SIGNATURE-----

--edjURWvLLIq5zNyd--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
