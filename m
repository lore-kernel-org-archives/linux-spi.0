From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/1] generic spidev devices must be registered
Date: Fri, 5 Aug 2016 15:21:08 +0100
Message-ID: <20160805142108.GZ10383@sirena.org.uk>
References: <1470402714-10798-1-git-send-email-fabien.lahoudere@collabora.co.uk>
 <20160805134342.GD25152@leverpostej>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="sT0SRK93LqpGW452"
Cc: Fabien Lahoudere <fabien.lahoudere-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>,
	Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	"open list:SPI SUBSYSTEM" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
	<devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160805134342.GD25152@leverpostej>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--sT0SRK93LqpGW452
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 05, 2016 at 02:43:43PM +0100, Mark Rutland wrote:
> On Fri, Aug 05, 2016 at 03:11:53PM +0200, Fabien Lahoudere wrote:
> > Adding spidev in the compatible list, let configure spidev from device tree
> > instead of C source code.

> I'm not keen on this.

> It ties the hardware description to today's use-case, and leaves the DT
> without information regarding the particuarl device. The binding is also
> written in terms of the userspace interface, which is backwards.

> So NAK to this as-is.

Indeed.  Fabien, please see the *extensive* and repeated previous
discussions of this topic.  Device tree is there to describe the
hardware, not the software you currently happen to be using on your
system.  Please also see the comments in the driver which explain why we
require a compatible string which is descriptive of the hardware.

--sT0SRK93LqpGW452
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXpKDSAAoJECTWi3JdVIfQ6OIH/1/cbQhUpJBx5bGDOLQdoz2A
A7JufH4XkyGqDbicXlX8XE6aBiCGtZSmMX7jSz4UDG3Zk9SkRSzmxrhqGC4ec5HZ
tdyKwRpnZ+KunFf4m4V80ek26ZS11cYCTRpxZ1haQtpYiBJD2rT/9rn65N9cGA2m
i1yONN3m/1FP+RWvNheVJ3PTi070fQIMXDOJHusHXqAOqOyfGvllIvXId//c+Zoa
TcsI+M1KseybLzxU/UEiMQ95Fv6g/An2I0gJloBwr4+gm3XLhoiSaz14hUyUyV8v
PWEhc8PqXXe/BdS7ppdsq+Jhk42geN0GVdax8Zpsjh47KEeLrfRIjTFdPzl5Pos=
=Ep5f
-----END PGP SIGNATURE-----

--sT0SRK93LqpGW452--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
