From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: bcm2835aux: Avoid 64-bit arithmetic in xfer len calc
Date: Wed, 14 Feb 2018 16:04:24 +0000
Message-ID: <20180214160424.GF12658@sirena.org.uk>
References: <1518463905.25398.281.camel@impinj.com>
 <20180212193814.17644-1-tpiepho@impinj.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="QXO0/MSS4VvK6f+D"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
        linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        "Gustavo A . R . Silva" <garsilva-L1vi/lXTdts+Va1GwOuvDg@public.gmane.org>,
        Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>,
        Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>,
        Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
To: Trent Piepho <tpiepho-cgc2CodaaHDQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20180212193814.17644-1-tpiepho-cgc2CodaaHDQT0dZR+AlfA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--QXO0/MSS4VvK6f+D
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2018 at 11:38:14AM -0800, Trent Piepho wrote:
> We want to check for xfers that are over 30 microseconds.  Rather than
> find how many =B5s a xfer will take, instead find how many bytes can be
> transferred in 30 =B5s.  The latter must be less than 32 bits (since our
> clock speed is limited to 32 bits), while the former involves 64 bit
> quantities and more arithmetic operations.

Please don't bury patches in the middle of existing threads, it makes it
much harder to find them.

--QXO0/MSS4VvK6f+D
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqEXgcACgkQJNaLcl1U
h9AOaAf+M3iRgU/R7ovC6LI/9ir/WLDZkKGuAvajlFBuGUihZ+ycSDmOA75Hg/EO
bV4LJvtMYwXU5Hrpx1p4ACm9LUDY1WmuL0ZKOZbkbBn5d2gvytdioQ3jUE2bAmmb
1/qh3WCqNl04rLMyO6ZPE+9EjqSzvNTYXPtc9Azxrl8WoZcLtf2A1v9GkG1rbgrW
UB0HakZw3cRTu7RfbEyPYTMb33PCLiGYRFHTpHjTejDeUe5LbBZpAc5dCLdL6gA0
/pm9JTtfpkZwIrzDdjktzk9MLnyXS79QwbY3IRPXA3vcqtRn9kX73Omx5QEJmqOk
jYOcUaId7GtwKPvTsHayOzuEPF8m9w==
=RJmP
-----END PGP SIGNATURE-----

--QXO0/MSS4VvK6f+D--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
