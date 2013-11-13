From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: Depreciated spi_master.transfer and "prepared spi messages" for
 an optimized pipelined-SPI-DMA-driver
Date: Wed, 13 Nov 2013 19:33:20 +0000
Message-ID: <20131113193320.GE878@sirena.org.uk>
References: <5F70E708-89B9-4DCF-A31A-E688BAA0E062@sperl.org>
 <20131108180934.GQ2493@sirena.org.uk>
 <C375DEE6-1AEC-4AFB-A9D6-583DCB4476A3@sperl.org>
 <20131109183056.GU2493@sirena.org.uk>
 <6C7903B3-8563-490E-AD7D-BA5D65FFB9BC@sperl.org>
 <20131112011954.GH2674@sirena.org.uk>
 <52823E73.503@sperl.org>
 <2252E63E-176C-43F7-B259-D1C3A142DAFE@sperl.org>
 <20131113154346.GT878@sirena.org.uk>
 <ED58E869-A9F6-4BB2-8EC6-D71F946509DC@sperl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lLbDBsvWahy0xqFJ"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Martin Sperl <martin-d5rIkyn9cnPYtjvyW6yDsg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <ED58E869-A9F6-4BB2-8EC6-D71F946509DC-d5rIkyn9cnPYtjvyW6yDsg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--lLbDBsvWahy0xqFJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2013 at 07:35:27PM +0100, Martin Sperl wrote:

> You also see that this driver is already trying to keep the latencies as
> short as possible by using the chaining instead of issuing each of those
> CS-enable sequence separately.

It's going to be more sensible to work to eliminate the extra overhead
for doing multiple messages than to faff around in individual client
drivers, solve the problem at the right level - this will play more
nicely when two devices are hitting the same bus as well.

> So you think this is really cheaper from the CPU perspective to take the
> Interrupt-driven approach?

Well, if we ignore the scheduling (which we ought to be able to get rid
of anyway) then the DMA is starting to look like overhead for what
appears to be a small transfer.

> > Exactly, but this is largely orthogonal to having the client drivers
> > precook the messages.  You can't just discard the thread since some
> > things like clock reprogramming can be sleeping but we should be using
> > it less (and some of the use that is needed can be run in parallel with
> > the transfers of other messages if we build up a queue).

> Ok - the clock setting is possibly valid for some SPI devices, but not for
> all. And we all know that a "one-size fits all" does not scale in=20
> performance.

> Also it may be a possibility that different devices have different=20
> feature-sets, where in part we need to drop back to something else (threa=
d).

Of course, we will need to allow the driver to control when it punts
back to the thread.  What we don't want to have to do is reimplement the
mechanics of all this in every single driver since that's the situation
we have now for everything that isn't bitbanging.  Broadly speaking most
of the hardware we have now falls into a few classes and most of it
isn't being driven anywhere near as effectively as it could be.

> You see where PIPO looses its time?

Not really, I mean the data transfers wind up being slower because
they're bigger than they looked from the timings (you haven't mentioned
how big they are...) but I don't really see why PIO (assuming that's
what you mean by "PIPO" which is an acronym I don't recall hearing
before) impacts the time taken to raise /CS.

--lLbDBsvWahy0xqFJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSg9P8AAoJELSic+t+oim97WgP/iQ7dPO51FVN7aLe50Zb95aK
jXS4dT/fF+f1ukXqnZ/wdGUVmIZwaLjGADKBsdj7xh4Yo/QWtkfJB7DHPLS9tVFr
3eDv+yL0gT2aPWn6956VS8NXCpp4NAdad4/tmaVx8Q5KaETyOWOegjCJdV2NZa4i
3uk5ObtO1dFra/YI7xdTj8sPf8FvDUNjNdpr42gBUXAExTStwSb/bKdSSFkWKYLy
ir6kwBEhAEeyoOUik4dRWKafi2VbdKQNqNS0alGksxjEBdO/Ik+mzLXQt0ENrFXv
kvdCFbVSLVv7VEJw3660696saRYyyRI9+8psMl+usoFJ4IegzAJEC/3c3ojBY2Of
Aa30OqkYk2YmvSMhUOkiVp3321b+t4Q2g+WObrlcbNxygdYslhNsAQtFbD+t+Afg
nz143/+XdjKRqm1oCBysu7BAsSP4bbDAyu4I3pplCBINDqBzrOKXXeoWQuLMu2rH
1wxK2qjfelQxM3JfMCzOoj3x7NSpebAMdYAq4shk1ibD/gHSTArM12pdJwUafB/S
4qE0/+wJ3Iat+ufK9qDwCNaEpHOW1H5fWMLt/UFbYMlapB1UktrrEipwH2GeKDw/
esuIHKfe9Ui7CJwtibLDiIuH8/g2gFKTDgM1vMx7TFWFnd1dRRQec2LAhUtwb/7a
qVKLYxZIOV6UELe3RavJ
=jxBe
-----END PGP SIGNATURE-----

--lLbDBsvWahy0xqFJ--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
