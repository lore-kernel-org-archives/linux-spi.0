From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/1] spi: fsl-dspi: Remove probe info message
Date: Thu, 25 Sep 2014 13:49:29 +0100
Message-ID: <20140925124929.GJ27755@sirena.org.uk>
References: <1411644744-29371-1-git-send-email-alexander.stein@systec-electronic.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HcccYpVZDxQ8hzPO"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexander Stein <alexander.stein-93q1YBGzJSMe9JSWTWOYM3xStJ4P+DSV@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1411644744-29371-1-git-send-email-alexander.stein-93q1YBGzJSMe9JSWTWOYM3xStJ4P+DSV@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--HcccYpVZDxQ8hzPO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 25, 2014 at 01:32:24PM +0200, Alexander Stein wrote:
> Remove the probe info message which also has wrong output. No need to add
> KERN_INFO to pr_info. Output was:
> 6Freescale DSPI master initialized

Applied, thanks.

--HcccYpVZDxQ8hzPO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUJA9YAAoJECTWi3JdVIfQ3aEH/1huoFLo9yVwq5hHPNwaJ8X6
1ekulrkdysbTmHTwt3pOfJwjDx/wNpT3k8nDmp7vOWV8eLXd8bckxxW+zJV4z4j5
b8Uo8HmylShW3PgASlmb3upRGKJpTk02XZSoRPkN0DrC27oPbLio/aa0ljW4L8eF
xSXE0ZRJ3PSztuqC9bub0Mmm2aSqzS/hQB5FYXdcDoB4t0VEjlMobUpmHdqAmbR4
Kwx8K71wKStOE0S46I1wVMBfWi7YfGmVUpe/aivpxZvtd8wDjQGD9B3dF5taFEZV
i/kNPljEYU3fx2clasLloHTd+lPcOwDdnCzPl+nPFhCRfgx3TRDCCVdO8aOGAyY=
=J9Br
-----END PGP SIGNATURE-----

--HcccYpVZDxQ8hzPO--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
