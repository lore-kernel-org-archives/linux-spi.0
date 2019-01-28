From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v7 4/5] spi: nxp-fspi: add octal mode flag bit for octal
 support
Date: Mon, 28 Jan 2019 12:30:50 +0000
Message-ID: <20190128123050.GE11699@sirena.org.uk>
References: <1547546584-5254-1-git-send-email-yogeshnarayan.gaur@nxp.com>
 <1547546584-5254-5-git-send-email-yogeshnarayan.gaur@nxp.com>
 <20190128122631.GD11699@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="r7U+bLA8boMOj+mD"
Cc: "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "tudor.ambarus@microchip.com" <tudor.ambarus@microchip.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "frieder.schrempf@exceet.de" <frieder.schrempf@exceet.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190128122631.GD11699@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--r7U+bLA8boMOj+mD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 28, 2019 at 12:26:31PM +0000, Mark Brown wrote:
> On Tue, Jan 15, 2019 at 10:05:29AM +0000, Yogesh Narayan Gaur wrote:

> > diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
> > index e23ad9ef028e..adc3c0e14f38 100644
> > --- a/drivers/spi/spi-nxp-fspi.c
> > +++ b/drivers/spi/spi-nxp-fspi.c
> > @@ -952,8 +952,8 @@ static int nxp_fspi_probe(struct platform_device *pdev)

> This does not apply against current code, the above file is not present
> upstream.  Please do not submit patches to out of tree code upstream.

So it turns out your other series was adding that driver.  Please if
you're doing this make sure you call out any interdependencies in either
the patch itself or the cover letter, if you're sending separate patch
serieses you should expect them to be handled separately.

--r7U+bLA8boMOj+mD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxO9fkACgkQJNaLcl1U
h9BsYQf6A45qVJRvph5tyVH50pk3XTa/3pcow8e2pPLdqTbQDypz5tpGQaDC4jqB
nsGIHXjKMru6xRvC49DPoKm4XGOpdHyW/qWGvaZmVnbGK2YX61L8BHQyfkN5LEGo
NsW89904eo5ycNYgapwwDwpUoUoE8Vj/9oYI/mDpW9Nr1QqyyIOHsh7yRXrZTdEV
S6pR/iU+KWgAFP3zrEXxkZqm8mdjwA5SEuAJ6oNl78Lz+Vtt3TleiLSnG2K+enTQ
WJYfS3mvVCjI6XQILWXracX0HmeC9T58GiyKyr8V4l8JEJS0YJI/zqb6b9ccSjgb
2YJA6Gp3Bh4MozVa3Dq+m2WFYN3giw==
=llBo
-----END PGP SIGNATURE-----

--r7U+bLA8boMOj+mD--
