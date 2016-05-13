From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] spi: spi-fsl-dspi: replace regmap R/W with internal
 implementation
Date: Fri, 13 May 2016 01:27:41 +0100
Message-ID: <20160513002741.GJ6261@sirena.org.uk>
References: <1461744756-31481-1-git-send-email-yao.yuan@freescale.com>
 <1461744756-31481-2-git-send-email-yao.yuan@freescale.com>
 <20160427152532.GX3217@sirena.org.uk>
 <AM2PR04MB072250B43DE37A38E374679989700@AM2PR04MB0722.eurprd04.prod.outlook.com>
 <20160509102840.GB6292@sirena.org.uk>
 <AM2PR04MB0722180ABF5DB9406F56162B89700@AM2PR04MB0722.eurprd04.prod.outlook.com>
 <20160512163131.GF6261@sirena.org.uk>
 <CADRPPNSA_2Wy+O1t0ggugp0eJL2q61s_m-rWzqNnLRB0fhF1Cw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="A1+ljxmNgwU2bK8G"
Cc: Yao Yuan <yao.yuan-3arQi8VN3Tc@public.gmane.org>, Yuan Yao <yao.yuan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	"robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	"pawel.moll-5wv7dgnIgG8@public.gmane.org" <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	"shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	"linux-devel-XDVM779Km55Y1YpKYGMr2+TW4wlIGRCZ@public.gmane.org" <linux-devel-XDVM779Km55Y1YpKYGMr2+TW4wlIGRCZ@public.gmane.org>,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Yang-Leo Li <leoyang.li-3arQi8VN3Tc@public.gmane.org>,
	Scott Wood <scott.wood-3arQi8VN3Tc@public.gmane.org>
To: Leo Li <pku.leo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CADRPPNSA_2Wy+O1t0ggugp0eJL2q61s_m-rWzqNnLRB0fhF1Cw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--A1+ljxmNgwU2bK8G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 12, 2016 at 06:55:38PM -0500, Leo Li wrote:
> On Thu, May 12, 2016 at 11:31 AM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> > On Mon, May 09, 2016 at 10:58:08AM +0000, Yao Yuan wrote:

> > That's not how regmap is intended to be used, the intention is that the
> > driver will interact with native endian values and regmap will hide the
> > endianness changes.  You could mask this with some cpu_to_be() and
> > be_to_cpu() usage but I'm not sure it's a great idea or what it's buying
> > you.

> So you do agree that the DSPI driver shouldn't use the regmap APIs?

No, of course not!  The driver's usage just appears to be very confused.

> It is still confusing to me on what is the intended behavior for the
> endianness property in device tree.  Previously for regmap binding the

What is confusing?  If the device is big endian the driver should
specify big endian.  If the device is little endian the driver should
specify little endian.  If the device is native endian the driver should
specify native endian.  Regardless of what the endianness of the device
is the driver should always use native endian when talking to the regmap
APIs.

> default endian is the native-endian if no endian property is not
> present.  But for bindings of many devices including the

No, the default is little endian (it always has been, though for a long
time only by accident and now the documentation matches that).  If this
was causing problems you should have reported it rather than trying to
hack around it.

--A1+ljxmNgwU2bK8G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXNR98AAoJECTWi3JdVIfQf0oH/1C9FFkt4xvDl+4yun2ma5pm
q7wedf9fpB0XI0Sk1PAFjTQhluxXN2AuPv7EU6K6aN/m8t/27ryxb20BCitUdlEy
vonPGFAmURJGIbGUHPUifNziXWV329Eov+jLsC3BlpTO8sGufzZ/w2rvKbktuCsq
Ga910hYkEp0ZljlUFYo75AnqP2bBjiKylAXS4//QFhX5Esq+6W+Duz/gZwaH1B63
9xVm266xl55endArPRHxbtMXn46OHAabVxG+grBllSk0mj/tCbF7D9hEwboYxLST
8m2NIWJOovh+xJTMGW3EREgf/1hJ6M8FWhdlryKBoG9hFJoEXbHXiElI01mpM+Y=
=gGS1
-----END PGP SIGNATURE-----

--A1+ljxmNgwU2bK8G--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
