From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v1 1/6] spi: dw: don't use mrst prefix anymore
Date: Sat, 13 Sep 2014 16:58:34 +0100
Message-ID: <20140913155834.GD7960@sirena.org.uk>
References: <1410523921-16732-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1410523921-16732-2-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="G/vVCphCGw+yuveY"
Cc: Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1410523921-16732-2-git-send-email-andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--G/vVCphCGw+yuveY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 12, 2014 at 03:11:56PM +0300, Andy Shevchenko wrote:
> Since driver is used on other platforms and debugfs stuff would be useful there
> as well let's substitute mrst_ by dw_ where it suits. Additionally let's use
> SPI master device name when print registers dump.

Could the driver use regmap and get the register dump functionality for
free?

--G/vVCphCGw+yuveY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUFGmpAAoJECTWi3JdVIfQ2SoH/3HrZZPKFlZ04LEFP+ZI8tAR
JiRntuTv876qyd3mdTjk8t5I9v93/thiAKG4ELV+GE/kyH4W0gcIzVBCE2/LMODv
JUM3wVORVh2zGTA+hUNxegxEYJe73x75w0nKk20TTTQNssa0LVdE+28Ox5EvpzDk
/5DeCA9wtzsLjzw4Ad89zltgF3Ru1Jz/sjXs+saVCGRRAQ5BSjEBVxXuPB3ZfVTn
SQTW4Aebc66IkdBZjGoDY7X9aft9bl59sz7eTyvGWPSv2OHUMc54QnWGZKfrdugX
hJIoj3EsrYS+I3/RhJ8rDF6knak0MdMC2gYuyvPtMWGR5Bf/CKMqesEKtvyT2G4=
=Xv5q
-----END PGP SIGNATURE-----

--G/vVCphCGw+yuveY--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
