From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 04/10] spi: dw-mid: follow new DMAengine workflow
Date: Wed, 24 Sep 2014 09:44:53 +0100
Message-ID: <20140924084453.GG4015@sirena.org.uk>
References: <1411060140-2801-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1411060140-2801-5-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="S0QU+l03nqHlODqK"
Cc: Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1411060140-2801-5-git-send-email-andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--S0QU+l03nqHlODqK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 18, 2014 at 08:08:54PM +0300, Andy Shevchenko wrote:
> Though intel-mid-dma does not follow a new DMA workflow let's prepare SPI DW
> driver for that.

I don't understand what this change is supposed to do - what is "a new
DMA workflow"?

--S0QU+l03nqHlODqK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUIoSEAAoJECTWi3JdVIfQWYgH/j5/m9/7jeNigUmsNImNHnUK
mvXg1h85N9WTZehGiD37rNlljH3zhZE/L8drVaesDqxuk1DN2Pbvnmm7mALNGcWV
4hFBczrXNwm81k7k245OYnDPsV2t2r2MCEoC9/aRqn4kDM8r9XN0gScK2yB3oi1Q
6xOaaN4CLjf8yx/vV669rHxrqwkY903YQ5gqg9tGkfC5TDbqsUezOajm7yCcR+SW
LS+9bhkCIFNKBKdx/p5YQTkpH3Xt6ezP9e54cFgExwmuu8Kh5psphVQI8lGAs6vr
9S2RzQF16gZ6tOTAQwuTnvrlGIElstXkegAWWgIhmFGw/fOX0ThxsUK/u3pkqSs=
=O/LL
-----END PGP SIGNATURE-----

--S0QU+l03nqHlODqK--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
