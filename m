From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC] spi: dw: support setting tmode dynamically
Date: Wed, 23 Dec 2015 12:15:12 +0000
Message-ID: <20151223121512.GV16023@sirena.org.uk>
References: <20151223192338.128e95a4@xhacker>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="D2rVImvqWGvKULsk"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jisheng Zhang <jszhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20151223192338.128e95a4@xhacker>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--D2rVImvqWGvKULsk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 23, 2015 at 07:23:38PM +0800, Jisheng Zhang wrote:

> Currently the spi-dw tmode is fixed to SPI_TMOD_TR if cs_control is NULL, but we
> need to set it as SPI_TMOD_EPROMREAD to read nor flash, my solution is to add and
> export one functions to set the tmode, then the nor flash driver call it
> before reading and set back to SPI_TMOD_TR after done.

What does this mean - what is TMOD and why do we need to set it to read
NOR flash?  I've no information on this controller...

--D2rVImvqWGvKULsk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWepBPAAoJECTWi3JdVIfQThUH/3otzTUgOaWcwBNSNQqhjmg2
KckTgRYOg+JsTOIPMwpW23Oa3Hn+hyGurjL1QMuFTlkFJtoHPbXeab6KRIIiy5mT
ayrUXnAVlQX2duPYrIlslS7neFGtsawEhzZ3QiAIxAoBod7lMZzalOts+NHTb+5N
/JoRwgAa32Razt5QwaATLgGuN9APjs4Y4/yK14yLgryBS0SYsbuhVhOXMxOwWSFP
DqG7Jy1oneGqd3SspNzqBOq+c4AndeDiyZcQPO/eiX9IBzaXZS8/cNY0rhYCRNWH
E4P/ALdK5a9PDGkVe60yiq8vxaeHGI6asGG8AI4NTszGAICeYZEUM0hVvexY0S0=
=rECy
-----END PGP SIGNATURE-----

--D2rVImvqWGvKULsk--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
