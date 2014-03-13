From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/3] spi: bitbang: add lsb first support
Date: Thu, 13 Mar 2014 18:41:09 +0000
Message-ID: <20140313184109.GE366@sirena.org.uk>
References: <20140313181107.GT3327@book.gsilab.sittig.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="f9lFb+Z4UT82L8vr"
Cc: Michael Grzeschik <m.grzeschik-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
To: Gerhard Sittig <gsi-ynQEQJNshbs@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140313181107.GT3327-kDjWylLy9wD0K7fsECOQyeGNnDKD8DIp@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--f9lFb+Z4UT82L8vr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 13, 2014 at 07:11:36PM +0100, Gerhard Sittig wrote:
> On Wed, Mar 12, 2014 at 21:35 +0000, Mark Brown wrote:

> > I was wondering myself, but on the other hand that's an extra operation
> > and this is about as CPU intensive as one can get.

> Actually I thought that bitbanging pins including the timing
> would be the most expensive part, and that swapping bits might
> not be negligable but could be acceptable in comparison.  But
> this was just a guess, no research was done.

I've not done any research here either really.  My thinking here is
based on the fact that everything other than the delays is essentially
overhead on those delays that stretches the time taken to perform the
overall operation.

> BTW are these bitbang routines referenced from several sites, not
> only spi-gpio.c.  They encode "be" in their name which might
> become misleading then they operate in LSB mode as well.

Indeed.

> And spidelay() appears to sometimes be a NOP -- could this be the
> reason for unreliable data transmission and bit errors in certain
> environments (optimized code, inlined GPIO access, fast CPU, slow
> SPI slave), instead of the suspected receiver's bit shifting?

That's a very interesting observation - I hadn't noticed that this was
the case.  That code is pretty old, modern processors are a lot faster
and it does seem entirely possible that we're able to bash data out
quickly enough to cause problems for some systems, especially if the
timing is uneven which I'd not be surprised by.

--f9lFb+Z4UT82L8vr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTIfvCAAoJELSic+t+oim9ifsP/3btzkLDkBdB9HAS/RRhnfyn
F0fZ9Xd4MrAyJq2DiEiJxd4dO6BdaWTWFeTbuYeJXjmf7nJKNcLkgI+W2PWafhOB
w0fG3ZGGKwPShxK6dqHFUrr9YDaoSouYqNbr6sqminbh5sl94Hr3Bfd2Ch1SeyWM
r0DbJBAw35GJRRoygSmOML+3b8kbzwRnUqyB47ypUApKWmovgt5W8dQxji/ZbtRA
ei9OJ4Y6fLJ/GllOrDM2zdY4WTNX+34qkvFL69/l4t7AY9Uzog31QUi+okyuy6Ta
4bbRWHZaCH5t1OcaHXgHotnOe0xAvPHGil7Fud/6EFqxXWDfyszKNXT9t/g1IvvB
GdjKzkwcalboAyM6SHQgXLXxbELUINahYEuURZCr2a6LJuy0t5F7rxsT5IawEFsY
veH7DclEFMXf052Ik/fRE93ZP9IKAh1OeG7hJdD2C6OWYyT4Tu3dMpy+jQ6pSuTn
g4rS4CbDni1PEZh2VIJ1ckwVjln3pi64D7+ElKUsqjmx6Dzr2k9dTYC5OFUZuYnl
Z0gnM3RVzBhtpa/eMsIpTJ3HI9VkB+3+WEhbjO69FbIHzVayWVOGfKMqvyvVuicv
Zvd1OJXsoPnlQgwJhUBI6+YDu+QaGUbSbmLVdJC37yOWHNpTQkpo4fZGy5y1UGMV
cs6r6RVTlvOADHeznCeg
=4VZX
-----END PGP SIGNATURE-----

--f9lFb+Z4UT82L8vr--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
