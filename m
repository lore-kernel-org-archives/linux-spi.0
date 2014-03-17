From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/2] spi/fsl-lib: Get the SPI controller bus number from
 DTS
Date: Mon, 17 Mar 2014 13:01:09 +0000
Message-ID: <20140317130109.GE11706@sirena.org.uk>
References: <1394789757-40732-1-git-send-email-B48286@freescale.com>
 <1394789757-40732-2-git-send-email-B48286@freescale.com>
 <20140314191922.GA366@sirena.org.uk>
 <c4b28b01b2f544ca9d264eaee2542257@DM2PR03MB301.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kA1LkgxZ0NN7Mz3A"
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org" <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>,
	"pawel.moll-5wv7dgnIgG8@public.gmane.org" <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	"mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	"ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org" <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	"galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org" <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	"grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org" <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
	Scott Wood <scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	"Mingkai.Hu-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <Mingkai.Hu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
To: "B48286-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <B48286-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <c4b28b01b2f544ca9d264eaee2542257-ufbTtyGzTTTk7ZsBhlipOOO6mTEJWrR4XA4E9RH9d+qIuWR1G4zioA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--kA1LkgxZ0NN7Mz3A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 17, 2014 at 05:11:11AM +0000, B48286-KZfg59tc24xl57MIdRCFDg@public.gmane.org wrote:
> > On Fri, Mar 14, 2014 at 05:35:57PM +0800, Hou Zhiqiang wrote:
> > > Get the spi_master's bus_num from DTS to make the spi_master's name
> > > static. So "mtdparts=3Dspi.bus_num.chip_select:..." in cmdline can be
> > > used to asign mtd partions of spi flash.

> > If we are going to do this it shouldn't be device specific (it should be
> > done in the framework since nothing is specific to the controller there)
> > but I'm not convinced that we should be doing it - this is all very Lin=
ux
> > specific.

> This patch just assign a bus number to the controller. It is driver's=20
> responsibility to distribute a bus number to spi_master and the definition
> of bus_num is used to distinguish controllers. So, it is specific for the
> controller and doesn't affect the framework.=20

You are adding a property to specify a bus number.  There is no reason
why such a property should be specific to a single controller, every
controller in every system has a bus number assigned to it so if we have
a way to specify one controller via the device tree we should have a way
to specify it for all.

> > The DT already has support for specifying flash layouts, can't those be
> > used (for example via chosen if they're not fixed for the board)?  Or if
> > it's just picking the correct filesystem then UUIDs and labels are the
> > standard way to do things.

> The DT specifying flash layouts is ok. There is another way to make the
> flash layouts using command line, but it is not safe because of the dynam=
ic
> bus_num. It is not the reason that the way of DT is supported flash layou=
ts,
> to live the other way unsafe, right?

This sounds to me like we need a better way of talking about flash
device names on the Linux command line rather than a way to fix the bus
number - for example, being able to refer to them using a fixed property
like the physical address.  Being able to refer to devices via an alias
assigned in the DT would also be useful (and more readable), I think
there may already be a mechanism for doing that which would need to be
plumbed in but I'm not 100% sure.

--kA1LkgxZ0NN7Mz3A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTJvIRAAoJELSic+t+oim9QpkQAIkRSGJNK6SxGWOCkdPIThke
EGrtLdsUkJ20IPZ1vP73uk1WlmtIk4D800pmqjltcSQr89RD+ohzQX4iOVoBQcuQ
xt0JuS/lnrzkT7q4vuDurva/9mNEj+LiCzwpn9yTqYGmgG8Jmc+7pgMByLGZt6bi
iLVg0E+/011lAP1phfRXzFa8eJEIO6mVRRR7ZBQONy9nB5BLxFrtwf1kUZgH1V2c
QF0yIb29bZLBau0gY7ohEQhkrGq90myMCDvao0uiwlkYNeDxUqqnAYPQnH3DKegc
lZLJrR22shrWJaOZWZtfTZrmt27MbQjChSqsMaSHdTctnB0+/pHhUSMf3z0kn6vV
4iCSF7RJXFLOUEjTHDVSRyvWCITn+OigWoP0oUwRi3Lfmzxq9FDH8Gm1y82+nO2C
rigmz7FrwRSTOoN4I+d5a/1UY1LtNSJAHti8oL1EmzUFPkUWDR/5EC3VNCfaihfB
blN5aYKIi3xrR+MYRQFLM6xmnPH0FhlcrlKLdCMMfPqz9IGGdUeDD0ON3KmDxIcK
y+Yi6KdGiTd4UH3WemN/qbVMD8VK6+DgrwI37beVD+kq4hDUi58mCgPuBHIKdjXK
gSCyktwk8UDjT+o0aXaPWsfTZDbvBjpD15JETjBFQOKIMgkBEwKPhfgv2NfzScDt
dwUowp8RGevH3fy2MbMy
=E8xC
-----END PGP SIGNATURE-----

--kA1LkgxZ0NN7Mz3A--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
