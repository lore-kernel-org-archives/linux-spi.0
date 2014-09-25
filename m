From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/1] spi: fsl-dspi: Fix probe info message
Date: Thu, 25 Sep 2014 11:14:30 +0100
Message-ID: <20140925101430.GM16977@sirena.org.uk>
References: <1411635212-20908-1-git-send-email-alexander.stein@systec-electronic.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="C01fF7hLGvN0zd9s"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexander Stein <alexander.stein-93q1YBGzJSMe9JSWTWOYM3xStJ4P+DSV@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1411635212-20908-1-git-send-email-alexander.stein-93q1YBGzJSMe9JSWTWOYM3xStJ4P+DSV@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--C01fF7hLGvN0zd9s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 25, 2014 at 10:53:32AM +0200, Alexander Stein wrote:

> -	pr_info(KERN_INFO "Freescale DSPI master initialized\n");
> +	dev_info(&pdev->dev, "master initialized\n");

This message has no content, it should just be removed entirely.

--C01fF7hLGvN0zd9s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUI+sFAAoJECTWi3JdVIfQRRgH/iUJjUnzkz6S/YhydKOgiMqq
8O1Pb8sDhtFinquGy43/ga/AdDybKrmpDPSmxUCBXf6Z82yzYI2t3jX+q0my/olf
qPsM1ROk1SxdK7DjDmLPmVRrXdffQkbuc2dD7n69KbETYKyxGVftYYFlmOEC2niU
+Bmhtzz7Vp3ycZC/GKOzWletESTvLviRo0rEJBiH0DPmXU7Iqx5o9wvGxepLHq/F
lk0WtgzIGlC2iCzYBxK4wWDsCGwHf9clf6syd3mjsdnJch6UoZ5tG19duDr5eTRu
EwnTArLnA7b15N+tfnBqz3YHNN/QhUex7qGdh1qycOzP2EG/hgwz+pmKhSAO0IY=
=/+mZ
-----END PGP SIGNATURE-----

--C01fF7hLGvN0zd9s--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
