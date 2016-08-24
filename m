From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: How to handle SPI components requiring heading/leading clock
 cycles with CS off
Date: Wed, 24 Aug 2016 12:27:02 +0100
Message-ID: <20160824112701.GE22076@sirena.org.uk>
References: <79679118-c092-1f9c-1972-0bb81bc59411@c-s.fr>
 <20160824094456.GB22076@sirena.org.uk>
 <8c6cbd99-7dd8-bbbf-89ee-a33752ab3063@c-s.fr>
 <20160824105640.GC22076@sirena.org.uk>
 <15444613-2f3d-9417-7d81-e545058afdf0@c-s.fr>
 <20160824111206.GD22076@sirena.org.uk>
 <9e854e9d-146c-61ea-da6e-a46b316b56c5@c-s.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kUmo4NyTJbuJZ752"
Cc: linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Christophe Leroy <christophe.leroy-GgN8y9CXRhA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <9e854e9d-146c-61ea-da6e-a46b316b56c5-GgN8y9CXRhA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--kUmo4NyTJbuJZ752
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 24, 2016 at 01:19:50PM +0200, Christophe Leroy wrote:

> No I can't see any special reason for this. But I can confirm that without
> the two additional clock cycles with CS\ high, the commands are not taken
> into account.

Right, I just looked at the datasheet and it says in the serial control
interface section that it needs a three clock cycle idle state.  Clearly
the designers weren't having a very good day when they did the digital
here but based on that you probably only need to send an extra byte with
chip select deasserted at the end of the transfer to satisfy it rather
than padding at both start and end.  Like I say it'll need a new core
feature though.

--kUmo4NyTJbuJZ752
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXvYSEAAoJECTWi3JdVIfQq1oH+wWjrLPyOoIX+6dPHcMtV9zT
p50kPHxBIR9XS6c5KVFZ/F/AZV4FVdjqLaSGAxLrAIwTO363DARpAwXW9XWlYGZB
Ne/Be6kMsoki4nR6S1ea8wVYb994/ZeVg8V+l5pgZVVMjOX7KbbadbHUoivzKouo
Wkfln9rDsai5xOvwP286w+ZzFFhqBRry7T30lGQoKq/MfarAKXtT5qXrJ8yYBZN0
esy7wcWi9EnAy5P+XS3hwwCdXYQ006TV9DzYjFdWkXZLavbqx/lwZbDtDOl7lguQ
TQLDmOCCkGBxp3g+UGBALwXfjXOdO6mhMP3FhkwYgVJt7LY85/BpmynjYeyfSCY=
=jIRs
-----END PGP SIGNATURE-----

--kUmo4NyTJbuJZ752--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
