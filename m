From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 3/6] spi: bcm2835: fill FIFO before enabling interrupts to
Date: Tue, 31 Mar 2015 06:25:19 +0100
Message-ID: <20150331052519.GZ2869@sirena.org.uk>
References: <3628E5E2-7EA9-488F-AF5F-A2E43D2D1E3E@martin.sperl.org>
 <551A1185.6060502@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="s89yJNDe6fM6BJKb"
Cc: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>, lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-rpi-kernel <linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <551A1185.6060502-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--s89yJNDe6fM6BJKb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 30, 2015 at 09:16:21PM -0600, Stephen Warren wrote:
> On 03/29/2015 08:03 AM, Martin Sperl wrote:

> > There have been rare cases where short (<200ns) chip-select switches with
> > native CS have been observed during such operation, this is why this
> > optimization is only enabled for GPIO-CS.

> > +	/* fill in fifo if we have gpio-cs
> > +	 * note that there have been rare events where the native-CS
> > +	 * flapped for <1us which may change the behaviour
> > +	 * with gpio-cs this does not happen, so it is implemented
> > +	 * only for this case
> > +	 */

> However, I'm not sure why this is in any way related to whether the
> chip-select GPIO is valid. Surely we always want to do this? How does
> the mechanism used to control chip selects influence whether we want to
> pre-fill the FIFO?

I think both the comment and the commit message answer that question -
something triggers spurious chip select changes?

--s89yJNDe6fM6BJKb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEbBAEBCAAGBQJVGi++AAoJECTWi3JdVIfQnUMH+LjYycqADHb5ORgg4jeOYWLo
tqkTzCr4GT3gopg1AOpNHTe0gTTWWvo6T9PKuEIzfp9wQEfmpStPAKCT27CJt63Z
m7dDhAHEzbaWW/CZJKHmh3t6PleVMFUh5Q38sxtG8qB66r4piCvkaFYrvy0DfMPl
44Yy1fNNFepl1lk5ySNw2mpz2CQr8wy/RsujOMIYsL8AbCOsfiCY0zpmH42JkIWI
2W2ywL84lXSuGO47COr8rGaThDR0sSK8yqNrM42PSdBWGlKhqD+Da0hIn4ALBFyM
4rb/BS64OPEibpkHAA2q167MeW0woygGDCF/lZJkCXeaOfoudawd2OIeGEvvWQ==
=UZFm
-----END PGP SIGNATURE-----

--s89yJNDe6fM6BJKb--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
