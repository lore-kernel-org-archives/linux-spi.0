From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/8] spi: sirf: request and free cs gpio in setup and
 cleanup callbacks
Date: Thu, 30 Apr 2015 11:16:53 +0100
Message-ID: <20150430101653.GW22845@sirena.org.uk>
References: <20140906135735.GE2601@sirena.org.uk>
 <D031CA8D.21605%21cnbao@gmail.com>
 <CAGsJ_4yhSFnzyZV6B3j90LyJbstsyBJHCnk=LZqVDsL_u8foPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="oEZK72QTaj/2HSSF"
Cc: swingboard <swingboard-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Qipan Li <Qipan.Li-kQvG35nSl+M@public.gmane.org>,
	DL-SHA-WorkGroupLinux <workgroup.linux-kQvG35nSl+M@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Barry Song <Barry.Song-kQvG35nSl+M@public.gmane.org>,
	Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Barry Song <21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAGsJ_4yhSFnzyZV6B3j90LyJbstsyBJHCnk=LZqVDsL_u8foPQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--oEZK72QTaj/2HSSF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 28, 2015 at 11:36:51AM +0800, Barry Song wrote:

> Mark, i'd like to re-call this patch. "pulling the code earlier in
> probe" is impossible based on current SPI core codes. because before
> spi master is registerred,
> cs_gpios is NULL. but once it is registered, cs_gpios are assigned in
> spi_register_master:

I'm afraid I've forgotten what this patch is, sorry.  Can you resend
please?

--oEZK72QTaj/2HSSF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVQgEUAAoJECTWi3JdVIfQyZEH/3W8d4HYfq/ShuqnwcBtk/Q1
u+qZUWf8pfcZUNpat4Pz7L5wjgjKuOujzO7KGnj0tvglZIwTQLAvoeMc+B4mZTLf
uG2RcqSITV7mSE9aeIfYZKTpXZfxGDOe4w9uPgQHJV3rSCcWsWNBQLp9pE1J+QBo
b/QIxwbo8y/ojJMRKkWEckVtwCx7kVbAxLhvyBxQPMykY3N0ejDw94+rJqgZqcJr
aO9+NrWr8eL+/ec2Q9hbDNDsCzHuJ1/L+/U5hUZD5EeZW8tYZ2PYoAqgaAU1m5KU
PQIe8bZtO1Mks7/CDdjzf3Ufcw+Tx79/xU0yWndi6YSmUvTz6o01vVgBC8YPkkc=
=mhPI
-----END PGP SIGNATURE-----

--oEZK72QTaj/2HSSF--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
