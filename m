From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: Additional SPI-master parameters per SPI-Device in device-tree
Date: Tue, 4 Aug 2015 12:15:28 +0100
Message-ID: <20150804111528.GL20873@sirena.org.uk>
References: <55C05E18.600@martin.sperl.org>
 <20150804095443.GH20873@sirena.org.uk>
 <55C08F70.5070303@martin.sperl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5mN69Y7OHXGepfYh"
Cc: linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <55C08F70.5070303-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--5mN69Y7OHXGepfYh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 04, 2015 at 12:09:52PM +0200, Martin Sperl wrote:
> On 04.08.2015 11:54, Mark Brown wrote:

> >Why would these things be configured in the device tree in the first
> >place?  They don't look like things that should be device tree
> >properties, they look like something the kernel should figure out at
> >runtime - the system tuning may change as the kernel evolves or
> >depending on userspace needs.

> Sometimes it may be necessary to define different values than the
> "kernel" thinks may be necessary (hardcoded).

So improve the kernel or (if you're really desparate) provide runtime
configuration - if you're just randomly bashing on things you can
rebuild the kernel just as well as the DT.  We don't want random magic
number performance tuning becoming an ABI, that way if the kernel
changes we're stuck with trying to work with the old magic numbers even
if they no longer work or perform well.

> We just had one issue with fbtft devices where it would have been
> nice to change those values on a per device basis (even if it was
> just for some testing to see why it was behaving badly
> - see the still un-merged patch:
> "spi: bcm2835: set up spi-mode before asserting cs-gpio").

I'm not finding that patch particularly enlightening here, sorry...  can
you be more explicit please?

> So I was wondering what was feasible/acceptable.

There are properties that might make sense on a per device basis like
descriptions of which chip select to use in the hardware, it's just that
these don't seem like such properties.

--5mN69Y7OHXGepfYh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVwJ7PAAoJECTWi3JdVIfQdwkH/1aW/FbehmLbrYwW5lGZcsie
VZfkSWdkqU938w+vfNOIrnXQzrExLurYWDtFlYv/EuduLsP42WG00ARAZ1sUwTkn
+TwwpKOdZpJWz8lhUPwgS5eogIBXldKjpUJi/By8tn7OoouImK9aGaDJSYQdc93P
0R+zTYV7oaJexHfu643rhUyKr3qNFTcjQcR6krbocej7hiOArqo6fCduapUaUDjc
/GkjbbckjIyozD4q7HMVXRg1kGsXYavq+EG1ZnEtI2N5W71zSeiS3q4erz0X7yMH
m76TzTY0Y9D3QMfv7TZM7JApcvwVJJGu2d6eqFrpTZQMbI70P9v9KDoZRqWqPPE=
=5vdQ
-----END PGP SIGNATURE-----

--5mN69Y7OHXGepfYh--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
