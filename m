From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 1/4] spi: spi-fsl-dspi: Fix SPI transfer issue when
 using multiple SPI_IOC_MESSAGE
Date: Tue, 22 Nov 2016 16:22:51 +0000
Message-ID: <20161122162251.x7uheu47426g3mpg@sirena.org.uk>
References: <cover.1479706671.git.maitysanchayan@gmail.com>
 <bbdbc8df434dd2af74eb351b799a2812a1c1967e.1479706671.git.maitysanchayan@gmail.com>
 <20161121191847.vg32cwople4qmini@sirena.org.uk>
 <20161121191430.GA24521@Sanchayan-Arch.localdomain>
 <20161121191850.GB24521@Sanchayan-Arch.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nytvzblbt3cd3hzr"
Cc: stefan-XLVq0VzYD2Y@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
        linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: maitysanchayan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20161121191850.GB24521-2b/appYahYDPUjlVagVGR1Kr0EmMEXJSn9A1Ff6Mc9Q@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--nytvzblbt3cd3hzr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 22, 2016 at 12:48:50AM +0530, maitysanchayan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org wrote:
> On 16-11-22 00:44:30, maitysanchayan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org wrote:

> > This is not a resend of an applied patch. The whole series applies on
> > top of your topic/fsl-dspi branch and has fixes for the SPI DMA as
> > incremental changes

> Sorry. I take that back. I now see you applied the patch and I got the applied
> mail after I replied.

Ah, I did apply it on Friday but somehow it didn't get pushed until
yesterday.  Sorry for the confusion.

--nytvzblbt3cd3hzr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAABCAAGBQJYNHDbAAoJECTWi3JdVIfQrxgH/RLG+gnz7Slh0yiS7NdIQ4oS
o4LRHsk/jLv8MN0K8phvZxZV36N5JfainQOBGznf9O/Uw871ATDwiyDfF1ivRKC6
wipKzk6p1d3D4ef1CbrfdmQV+1C86tYQVXI3ZHXPgz6LadNXSxvfNNRNoFFtbZYV
zNMpePkfPtW68596MChQZxCZnnoLK6ZzZrelFS/bXUaQw/Z/6wEBOekrYHYaNkX1
mZCZ5FKmn4Vfoje33eDMVNiVmUl1oK60Ugg59PPQPrfuZdS2k84hwxqjixwz1FU7
QTepgqnppDR8L+S/WSrskIsOfMmU2eF/qa63IeLtAG2lDp/enY9F4QZENi8+Dj8=
=Pl+Z
-----END PGP SIGNATURE-----

--nytvzblbt3cd3hzr--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
