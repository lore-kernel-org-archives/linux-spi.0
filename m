From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3] spi: omap2-mcspi: Add support for GPIO chipselects
Date: Thu, 7 May 2015 20:27:58 +0100
Message-ID: <20150507192758.GR22845@sirena.org.uk>
References: <1430955472-11409-1-git-send-email-mwelling@ieee.org>
 <20150507185831.GQ22845@sirena.org.uk>
 <20150507192019.GA15112@deathray>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="OR4KrFHJQx98Cazv"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Welling <mwelling-EkmVulN54Sk@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150507192019.GA15112@deathray>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--OR4KrFHJQx98Cazv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 07, 2015 at 02:20:19PM -0500, Michael Welling wrote:
> On Thu, May 07, 2015 at 07:58:31PM +0100, Mark Brown wrote:

> > makes things easier to review and helps people trying to understand the

> Do you have any other suggestions or comments on the patch so that I
> can incorporate those changes as well in the patch series?

No, that's part of the "easier to review" bit.

> I noticed a few oddities in the code when converting.

> For instance:
> http://lxr.free-electrons.com/source/drivers/spi/spi-omap2-mcspi.c#L1225

> What is the point of trying to print tx or rx given the if statement
> insures that rx_buff and tx_buff are NULL?

I expect it's just a buggy test.

--OR4KrFHJQx98Cazv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVS7y9AAoJECTWi3JdVIfQpfoH/jBPpwSUVOQ6xxBEFMGGp50r
NTBilyLeDBRqJqChW7h0CfXsfHH+Rk5qrCWetTqW3jxXENjaaSX6ScCwrtAEDdz2
Ytz0ek+T4aG2NF8a1oyXd5Tz18bZfwSZrrjzpycFD5Dgyr/J76N2wQfm7+uKeG4b
sR56PF14I6nHu+93MuO/ZOBGmA2M1YSbJWIW52ayQOlMKHh2o0ToDfMsKtUr9wWR
QgTH98hR/UaoN9pX9zAwjYiro9tfvRj39bLvK3OmWVCbFiYO8pCAgw2tEOcTkd8A
5b5co6EycKO7XxSosu4CKWpGUwqjEBDHonZEfyrgiJYPEV8BfX9O3BSZEbab+zI=
=qHQh
-----END PGP SIGNATURE-----

--OR4KrFHJQx98Cazv--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
