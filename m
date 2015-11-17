From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/8] Documentation/spi/spidev_test.c: use one rx buffer
Date: Tue, 17 Nov 2015 17:41:56 +0000
Message-ID: <20151117174156.GX31303@sirena.org.uk>
References: <cover.1447773299.git.stillcompiling@gmail.com>
 <2f17ae29e75967b4522b080c275b907622e1d353.1447773299.git.stillcompiling@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="OtXN0xDA1zr/oUEL"
Cc: Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>,
	Adrian Remonda <adrianremonda-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Joshua Clayton <stillcompiling-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <2f17ae29e75967b4522b080c275b907622e1d353.1447773299.git.stillcompiling-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--OtXN0xDA1zr/oUEL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 17, 2015 at 07:24:21AM -0800, Joshua Clayton wrote:

> default_rx and rx are needlessly different.
> Use one buffer, local to transmit()

Why?  This isn't what I'd expect from black boxing the API, from a
userspace point of view the transfer is atomic and in an ideal world
we'd be able to do direct to/from memory transfers rather than memcpy()
into kernel space which means that userspace should assume the transfers
are going on simultaneously even if they don't currently.

--OtXN0xDA1zr/oUEL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWS2bjAAoJECTWi3JdVIfQJXcH/1xtb1soGkkp/U0p9wpfckQZ
Y91S4gmigfDDDjtlQqI+IXXYGVL6AAj43qR3lHUBhFerq7VMrcY1+FmI4Zwew+BS
u34ToY0epv3IqChDS/BYryuRPIEHeTkeAMDCqyIpA+zuqOnfLnyu2QdlnBXdSrmZ
rrmvadVZnsdxYlH3/toN01op/rzvv3y0A9YlvnHQ3mGsOvbUbqt38r77ECatFJn1
Zz85/38rGJVeyNf9OmXB6GkIg+zbC/qs+TFcTgKX12mH9NYYDeq+F3cW5si9i1KG
srkH9UM1+FezOwucaobEaZpX0x38taOWPkR9CL4s/8pYG2HPo0ocI3ta2zxyMsA=
=WUfe
-----END PGP SIGNATURE-----

--OtXN0xDA1zr/oUEL--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
