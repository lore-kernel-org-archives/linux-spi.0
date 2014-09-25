From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/1] spi: fsl-dspi: Fix probe info message
Date: Thu, 25 Sep 2014 12:11:42 +0100
Message-ID: <20140925111142.GN16977@sirena.org.uk>
References: <1411635212-20908-1-git-send-email-alexander.stein@systec-electronic.com>
 <20140925101430.GM16977@sirena.org.uk>
 <74325058.MxaXLQJlSp@ws-stein>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6yHiY5vv/BiPjcMt"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexander Stein <alexander.stein-93q1YBGzJSMe9JSWTWOYM3xStJ4P+DSV@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <74325058.MxaXLQJlSp@ws-stein>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--6yHiY5vv/BiPjcMt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 25, 2014 at 12:30:58PM +0200, Alexander Stein wrote:
> On Thursday 25 September 2014 11:14:30, Mark Brown wrote:
> > On Thu, Sep 25, 2014 at 10:53:32AM +0200, Alexander Stein wrote:

> > > -	pr_info(KERN_INFO "Freescale DSPI master initialized\n");
> > > +	dev_info(&pdev->dev, "master initialized\n");

> > This message has no content, it should just be removed entirely.

Fix your mailer to word wrap within paragraphs please.

> Well, you know that the device has been probed successfully, which IMO is a message the user should be able to see in dmesg.

The same thing applies to absolutely every driver in the system; if this
is a useful thing to do we should just make the driver core do it,
though there are then problems with noise during boot and an impact on
boot time when using a serial console.

--6yHiY5vv/BiPjcMt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUI/htAAoJECTWi3JdVIfQm1oH/19bAdnJfM3nywoENz6/ljpM
y0sVV3PnXM8clkIJ4TE0ikhp6MRt6v5wX3ElVyLWwxnBleIoQopIlKn5D9bNShlZ
wOijoxNEWH7GX4u1BsmaeiAboo5qdYw1iT+OFbfyew3pU/VKFObDxPk909/yz/m/
A+L7KungCA/nzXTb0QwJEG9yE8kMVkTOuafhlVe5lbaUIYk3Unv/hPrgoi3v78WH
8YKGf9L7RHqQlwRYDv7x1kh4/BQOIlGAKFCnjjMhpseLIOaecLMn+xjof/dqVbfO
veqxUxjq6A0EXSDiOWYJxAcZd0u4weBA4UYDO1iDh5S4a0+ShsRZXPXpgFzQ3+Q=
=qztn
-----END PGP SIGNATURE-----

--6yHiY5vv/BiPjcMt--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
