From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2] spi: orion.c: Add direct access mode
Date: Wed, 23 Mar 2016 11:33:16 +0000
Message-ID: <20160323113316.GH2566@sirena.org.uk>
References: <1458663893-13766-1-git-send-email-sr@denx.de>
 <20160322173546.40d24cc2@free-electrons.com>
 <56F17684.2010307@denx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="pjXrr8OcmD/XY8aP"
Cc: Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>,
	Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>,
	Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
To: Stefan Roese <sr-ynQEQJNshbs@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <56F17684.2010307-ynQEQJNshbs@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--pjXrr8OcmD/XY8aP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 22, 2016 at 05:44:52PM +0100, Stefan Roese wrote:
> On 22.03.2016 17:35, Thomas Petazzoni wrote:

> >Has there been any discussion on whether dynamically adding the MBus
> >window is a good idea, as opposed to statically defining it in the
> >board .dts ?

> Yes. My 1st patch version (still RFC) used fixed MBus windows instead:

> http://www.spinics.net/lists/linux-spi/msg06536.html

> Mark suggested to use dynamic windows, so that one area could be
> used for all SPI devices by switching (re-configuring) the MBus
> window:

> http://www.spinics.net/lists/linux-spi/msg06537.html

No, there's two separate things here.  The big problem with what you
originally sent was that you were defining a window per SPI device but
this is a part of the SPI controller so having to change windows per
device is just going to make the code more complex.  There's also the
separate issue of where any MBus windows we get come up with.

--pjXrr8OcmD/XY8aP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW8n77AAoJECTWi3JdVIfQ/ewH/33RyElpNNT2rwl9QmK771o+
KpMLePLKbvXsaAxYOAOGB0CG8cYMpHIGS7790H18oBrJKLtxX3AicYAVcQYpkOZ2
bFwyCiWaxJyQQxEXNFVNRhenK9DhoeM8/uwsPDYXoIklAEqfVQwvkTxsozCFv5cs
CJ1wAqjyPmFWm1vpsL8+OhmEJb0fPAo5J6RHU03OXiI8kDyiFnuB0tmmwCMeLEpP
34gvl7KJZfoi/ZJ7v2mjf6EjL7zC0xz/WYJQLdaIl5xDcS/RnLrFjfymeviDrln4
a9vTzaT1wtOXlbIx/fD99jiUC9ST37gxXYWrcmxqOQSlNGBpFQll09HEmekNZfc=
=eEHU
-----END PGP SIGNATURE-----

--pjXrr8OcmD/XY8aP--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
