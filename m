From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: RfC: Handle SPI controller limitations like maximum message
 length
Date: Fri, 20 Nov 2015 12:35:40 +0000
Message-ID: <20151120123540.GC1929@sirena.org.uk>
References: <564CEB61.2000601@gmail.com>
 <20151120000226.GP64635@google.com>
 <564EC4E0.90602@gmail.com>
 <CAFSsGVsJBi6yPin7X9MCS8LD6nygjynfgDgFicjojkm0rOJSJw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="GZVR6ND4mMseVXL/"
Cc: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, martin-d5rIkyn9cnPYtjvyW6yDsg@public.gmane.org
To: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAFSsGVsJBi6yPin7X9MCS8LD6nygjynfgDgFicjojkm0rOJSJw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--GZVR6ND4mMseVXL/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 20, 2015 at 11:06:47AM +0100, Heiner Kallweit wrote:
> On Fri, Nov 20, 2015 at 7:59 AM, Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> > It would be sufficient if it's a valid case that spi_master returns 0
> > and an actual_length < requested_length as this is some kind of error
> > situation.

> I had one more look at the SPI core and e.g. spi_write_then_read
> calls spi_sync w/o checking actual_length afterwards.
> This can mean the discussed case is not valid, however it also could be
> simply a bug.

We can't assume that users of spi_write_then_read() will cope with a
restarted transfer - the usual use case is things like register I/O
where restarting a partial transfer wouldn't produce the desired result
so it's just a plain error for users of that interface.  Anything that
is able to cope needs to be using the core API directly.

> If the discussed case is valid a clear hint to all users of spi_sync and
> friends should be added that the caller can not rely on status code 0
> only but must check actual_length to verify that the complete message
> was transferred.

You'll get an error on truncation.  It may be possible to recover.

--GZVR6ND4mMseVXL/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWTxObAAoJECTWi3JdVIfQ52kIAIPHA+/Gb7/HKArUY3G+u/If
OasT/W2ANTvqFeM3FU+JNsDyFhqKqj/Q1qbEhb2+Ubr0E5OzXZEGM2baA7ibXDkh
bkZ9kmMhYnvXhUG5paIfigbVOROoVO+7k7UDYG1nVf6Is3zN7PMcUryX3Dx4QM+k
+YjHTSnftTV3nvuf2jBfaZGKqFFF7vTUtAAvic2ZoEPx7V+vw9m1/sM1w6/V3FF6
cWWeUUGrlKzUwCtOknmgdgDQ9dRwiuadsrlVmcMzFDOxHPyL6Iy3N8Qw/IP1SQop
v6HjX05QzjuB8cSd6zxiXEcPiIR62msg+2J1NNgfGXnUczr6h6WT/hmFC+EjEfA=
=a7DU
-----END PGP SIGNATURE-----

--GZVR6ND4mMseVXL/--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
