From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3] spi: omap2-mcspi: Add support for GPIO chipselects
Date: Thu, 7 May 2015 20:56:58 +0100
Message-ID: <20150507195658.GT22845@sirena.org.uk>
References: <1430955472-11409-1-git-send-email-mwelling@ieee.org>
 <20150507185831.GQ22845@sirena.org.uk>
 <20150507192019.GA15112@deathray>
 <20150507192758.GR22845@sirena.org.uk>
 <20150507193851.GA15313@deathray>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="JFRr7CqTUjWuHVlW"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Welling <mwelling-EkmVulN54Sk@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150507193851.GA15313@deathray>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--JFRr7CqTUjWuHVlW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 07, 2015 at 02:38:52PM -0500, Michael Welling wrote:
> On Thu, May 07, 2015 at 08:27:58PM +0100, Mark Brown wrote:
> > On Thu, May 07, 2015 at 02:20:19PM -0500, Michael Welling wrote:
> > > On Thu, May 07, 2015 at 07:58:31PM +0100, Mark Brown wrote:

> > > I noticed a few oddities in the code when converting.

> > > For instance:
> > > http://lxr.free-electrons.com/source/drivers/spi/spi-omap2-mcspi.c#L1225

> > > What is the point of trying to print tx or rx given the if statement
> > > insures that rx_buff and tx_buff are NULL?

> > I expect it's just a buggy test.

> Not sure I understand what you mean.

I expect that the code is just being silly.

--JFRr7CqTUjWuHVlW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVS8OJAAoJECTWi3JdVIfQAP0H/3fXtU43XN38UR7ytSfDpfHn
BrLW/HE4coyeP+4UnH1VExcMn6OBobzsMbgQIDch+TCYzEk5IqX6Z1k1kq2Svi+I
NSqDw5BGCEOzaH8meKfBDmALigEL2DqlTUBQ4+fxZmEGUn4DZ3LXyTosRLqz8R2J
pm2Px7g45jKN8CwARhAX0ho4o+KTsbArAYBGPZnFL6jT188t4443QoydA1WyTXF0
0o0VXZrllwW/0ALeJH1WQDD4fggxoV9k0N6dhErtGBWDyHEif/Ky2UeqqdCMz9Cf
nwMcPWbrYk4MvQ2duaRUXNO+S4pJuCmDY7cF85neEvkGa5WgpRrY4k6oBir3l3Q=
=rWEs
-----END PGP SIGNATURE-----

--JFRr7CqTUjWuHVlW--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
