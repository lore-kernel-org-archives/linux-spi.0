From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: Depreciated spi_master.transfer and "prepared spi messages" for
 an optimized pipelined-SPI-DMA-driver
Date: Sat, 16 Nov 2013 14:23:56 +0000
Message-ID: <20131116142356.GY15393@sirena.org.uk>
References: <5F70E708-89B9-4DCF-A31A-E688BAA0E062@sperl.org>
 <20131108180934.GQ2493@sirena.org.uk>
 <C375DEE6-1AEC-4AFB-A9D6-583DCB4476A3@sperl.org>
 <20131109183056.GU2493@sirena.org.uk>
 <6C7903B3-8563-490E-AD7D-BA5D65FFB9BC@sperl.org>
 <20131112011954.GH2674@sirena.org.uk>
 <52823E73.503@sperl.org>
 <20131114015009.GB26614@sirena.org.uk>
 <9640F4C7-7F82-453E-9D83-5875A1559A20@sperl.org>
 <5286026B.2090903@sperl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="niUlcCfh/sMBwTxc"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Martin Sperl <martin-d5rIkyn9cnPYtjvyW6yDsg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5286026B.2090903-d5rIkyn9cnPYtjvyW6yDsg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--niUlcCfh/sMBwTxc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 15, 2013 at 12:15:55PM +0100, Martin Sperl wrote:

> You essentially gave me the idea that we could reduce restrictions
> on the proposed spi_prepare_message by adding some flags of in what way
> the structure may change. So if you got a "fully" fixed structure,
> then we could add "flags" here to indicate if the structure also is
> fixed with regards to:

Adding flags seems like a good idea, probably easiest to start with
everything is fixed and then add the ability to relax things later.

> This comes with a potential "trap": We would need to define if a
> "reorder" of SPI messages between two different SPI Bus devices with
> different CS is a valid operation or not.
> (the question is mostly: would this "queuing" happen on a per bus-driver
> basis or on a per CS basis)

I'd expect us to continue to do things per bus, at least for the time
being.  This is definitely a stage two consideration though, getting
something working=20

> But the first question is: are there any drivers currently that require
> multiple CS to do its work?

No.

> All of these ideas will also help us in the future and may then may get
> used for other bus-drivers as well - we then could even start using a
> "DMA-sequencing" engine inside the framework to reduce the code on the
> driver (how to define those would be tricky though - we would need to
> see how "flexible" other devices are compared to bcm2835).

The only thing that you're talking about that sounds unusual is the
ability to add timed delays in the hardware, otherwise this all sounds
very standard assuming DMA controllers will play nice with mixing in
writes to registers (which I expect to be common).

> We could make this a flag in the spi_message structure or use different
> functions: spi_async_threaded and spi_async_interrupt while having the
> spi_async map to spi_async_interrupt for compatibility reasons with
> older drivers.

Separate functions would be a bit more idiomatic.

> why not call the new interface:
> int spi_(pre)build_message(struct spi_device*,struct spi_message,
> 	unsigned long flags);
> int spi_unbuild_message(struct spi_device*,struct spi_message);

Seems fine.  Or init/done.

--niUlcCfh/sMBwTxc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSh3/zAAoJELSic+t+oim9zjAQAJc3L22dlm53vSgo6eOqFZ6F
XxDNIJgSQkANMIWsIemS/l14zWYXU5Dp7a79+4oVooRQkWU/5fyNNdIEBnsLoXGu
L3BYxk4v8/Ffl1cHu6hCPEPxl/lG0GSwZmF1QiO5mPzVFy1dyEpOOOSXyn+ezdQ0
lFKuZU7w6J75JxLZZIT608LdEtlrwF6/EZiKGJo0H7THIwZqsYd4WQNjH119Pi91
Z2O/KpxXdqArZps+8m62Dowwvwzp9tRk5B5RhphJ1etFkzaIuAmzpmd/XP5oM0oC
aJfHvb9TD5jsuptd7WjmHD9tVu9vqklDvmR7w+KYBozL2o+FY+jyCcLO3meYCWKn
eW8Uyw7ZxuTE++Qpp75esOelCRxMJgD4OvYmgNuAT7+39xU6bT/LgnXeKEPyHRwC
KzmiA+H9lp5r1tA9yrqboaS0cj2Rz2Jp+2eHOkWVHqLijQ2PRgTQGJptUetCup0W
4e62E1+V5dW51gb/ulb0o4fo+WAyVqO7/fO4ncO00G9s6Sdle+1stI8lqlD8P/LY
wULO+fcqSl3+gseGz+IaNNemKDNVQ/4nF6+Z0JkpJE3atsKkbB/PtoHJY1EJhTOJ
yMYVUMR27qCyGo8AJ5aw6RRhAtrelzyITxL4c2N0ozEXxw3x8cVxRWn7W0pq3pq9
5FA+RpENdMaG6iHcHp1B
=RWF8
-----END PGP SIGNATURE-----

--niUlcCfh/sMBwTxc--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
