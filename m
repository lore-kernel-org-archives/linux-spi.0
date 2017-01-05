From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: Applied "spi: dw: Make debugfs name unique between instances" to
 the spi tree
Date: Thu, 5 Jan 2017 09:52:43 +0000
Message-ID: <20170105095243.etgkecu3mnmhz2r6@sirena.org.uk>
References: <1482398292-46946-1-git-send-email-preid@electromag.com.au>
 <E1cOqRP-00026r-Q6@debutante>
 <CAHp75VccfSoo1yq60G9X=_WxKKR3pwiQvBkqA6vyFthDrKxPDA@mail.gmail.com>
 <20170105010146.iyo5mvfjzd555egm@sirena.org.uk>
 <af8816db-331d-d9cc-0178-c99fb612f555@electromag.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pvqfvhu4gpwmavqo"
Cc: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, kernel-NoMTM8u0nx3R7s880joybQ@public.gmane.org,
        Jisheng Zhang <jszhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Phil Reid <preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <af8816db-331d-d9cc-0178-c99fb612f555-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--pvqfvhu4gpwmavqo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 05, 2017 at 10:29:02AM +0800, Phil Reid wrote:
> On 5/01/2017 09:01, Mark Brown wrote:

> > I applied this before you started discussing the approach...

> There was a v2 of the patch sent Tue 12:54 +0800
> Which uses the bus number.
> There's also a problem with the name registering the name of the irq.

This was also after I applied the patch.

> Please let me know how to proceed.
> Should I apply new patches against v1 of this patch now?

Yes, please.

--pvqfvhu4gpwmavqo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlhuF2sACgkQJNaLcl1U
h9AdPQf+MG5wG559F5GeDoiHeQN5+ymeRDKC3gilxkOUWyiDs1L57/bCuCWaTGIA
hgrvtA4GsKOBvNuN6991LM5zkx61RjS0DugXF/W6bqPWiSnv+9aWBOtXp84QBFRa
A/y1qEooDLB1svjtj2VUizFAyGqrbixdJuYdm4sRoB0RQJPif2AODWIO4PcZ48t5
If8oXHA5l6Kr+zcvhxcNOWKmFjybOh9mXGaOaWh84hTDZ2saZybRjasDQlPh0tQp
RJRRhbCaUnsANoplHJcnIAnCWdiRrZYeEL00ZhPhFmPSdEcfcC2b6sQ3opNbV5gJ
IjYObs8fth9Eh+0SQP+BZcOO3oSXbA==
=9ldB
-----END PGP SIGNATURE-----

--pvqfvhu4gpwmavqo--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
