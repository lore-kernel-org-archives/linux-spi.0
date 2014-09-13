From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: davinci: request cs_gpio's from probe
Date: Sat, 13 Sep 2014 09:28:58 -0700
Message-ID: <20140913162858.GG7960@sirena.org.uk>
References: <1410533640-21469-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="x9NlMAausKqHAFUv"
Cc: santosh.shilimkar-l0cyMroinI0@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	m-karicheri2-l0cyMroinI0@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1410533640-21469-1-git-send-email-grygorii.strashko-l0cyMroinI0@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--x9NlMAausKqHAFUv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 12, 2014 at 05:54:00PM +0300, Grygorii Strashko wrote:

>  static void davinci_spi_cleanup(struct spi_device *spi)
>  {
> -	if (spi->cs_gpio >= 0)
> -		gpio_free(spi->cs_gpio);
>  }

This function is now empty so should be removed.  I've applied for now
but please send a followup fixing this.

--x9NlMAausKqHAFUv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUFHDKAAoJECTWi3JdVIfQBD4H+wdGDwo/FXZl1wonQJibciUy
iRzykddOp0JPTuuwhsLfCIE84vJHODdqyfZnMgz5cQ1GuKBA0UHzEWde4Nn+6YJJ
BZ0BiCGjfivS/WXx1mWvSpwPnJ11PKO0tIqkWPadT9OXBPakZZzLMH2rst+kshsd
LtD7k32P2edLwumMuv+Jui5C2TWQ4oqYnikDIUV2ccBW1Jjz6cJEkR8XDVNkth5R
ZxWZCaTbfrVjFF13cFH6IgEXEj+9ErEqufgNtRA28xYrigto3HfwnLBmiDfq+aCS
UjQDJGtYeKifAsQBd8NFZlP4Vlr409b8fjK/GHUnthFlE6Lw8toZg87wRn1bbzs=
=DTnG
-----END PGP SIGNATURE-----

--x9NlMAausKqHAFUv--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
