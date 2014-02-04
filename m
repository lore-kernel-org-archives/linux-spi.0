From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: spi-fsl-spi.c: Fix problem with multi message
 transfers
Date: Tue, 4 Feb 2014 11:33:50 +0000
Message-ID: <20140204113350.GV22609@sirena.org.uk>
References: <1391172299-30640-1-git-send-email-sr@denx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gst1TLx4aVAjus+f"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Holger Brunck <holger.brunck-SkAbAL50j+5BDgjK7y7TUQ@public.gmane.org>
To: Stefan Roese <sr-ynQEQJNshbs@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1391172299-30640-1-git-send-email-sr-ynQEQJNshbs@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--gst1TLx4aVAjus+f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 31, 2014 at 01:44:59PM +0100, Stefan Roese wrote:
> When used via spidev with more than one messages to tranfer via
> SPI_IOC_MESSAGE the current implementation would return with
> -EINVAL, since bits_per_word and speed_hz are set in all
> transfer structs. And in the 2nd loop status will stay at
> -EINVAL as its not overwritten again via fsl_spi_setup_transfer().

Applied, but the driver really ought to be updated to support
configuration changes here.  This also isn't anything to do with spidev,
any client can do this.

--gst1TLx4aVAjus+f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS8NAbAAoJELSic+t+oim9DccP/jxXxNTY1op6yAj2ZjZP/g3q
4/I5MWACxHNVL1f4utZRLp7x4ENDuKkD08dvdDoalu4auafLXppl+vnM4B/tb54Z
Xm9nEowhu7iuJZ1+yUfaWvgSbqd/FEDFU10S3bCevAhIqtzzPVutINhk/qtOirGQ
cXVwoMuOYzbWw5OfFku32Z2G3ohelqe/Ah39xbG1tCpJKJjEwXBA8sKYF1k+N5F0
0BlKOoqGeSOjiry0Nob+RMDXUPrsh0tE9aXX2hT47mfLEeTObWF9beybeDLAVZfQ
c0Ipzr+Y5ySRZTACLNdQjezm3i6yXzz4WI3ZFE1R0cTejhjvWXqnnpu6npnx56vi
0Hu0clzU59SnGU7qVIqVUq+wIXWMRrFKrsCMi8JH1h1wXIiinOWqvEhji9bm8PbV
7lHFkjCXfRNcJ5yVH+gtpG+hZaCeK98wHLs5a6SnnTpgRq3eHxHOik5HJkO3fA67
B0D0vO+PD1lzLABTmXWGUgjI9AViMaq71t674K+0v5Bo733GoZrBmr3uRJz61NST
i7/7Z/4wx6orJrBpR/envbV1V3b2/+K33gahIXRkIzKTpw++0gfKCv5uHyrVxRTN
mD9ZooSuW8rUfEsZUsR3m856JE8ltNxwmYYOoyQKUMq92c35rT7C7A6BmmeGdinb
AcNWlNrMjzrul9UZREZ4
=z+lS
-----END PGP SIGNATURE-----

--gst1TLx4aVAjus+f--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
