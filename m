From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/3] spi: add initial set of spi_transfer transformation
 methods
Date: Thu, 3 Dec 2015 18:04:39 +0000
Message-ID: <20151203180439.GH5727@sirena.org.uk>
References: <1448888695-2260-1-git-send-email-kernel@martin.sperl.org>
 <1448888695-2260-3-git-send-email-kernel@martin.sperl.org>
 <20151201212929.GV1929@sirena.org.uk>
 <35C5C134-8291-4856-8916-7EDDFB07A0A9@martin.sperl.org>
 <20151203003618.GQ1929@sirena.org.uk>
 <91B0D66C-97E5-4683-8896-091C4BD7FCAF@martin.sperl.org>
 <20151203143417.GE5727@sirena.org.uk>
 <9DF774BE-EA2B-40E8-9CBF-E0A06AB5A751@martin.sperl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="it/zdz3K1bH9Y8/E"
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <9DF774BE-EA2B-40E8-9CBF-E0A06AB5A751-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--it/zdz3K1bH9Y8/E
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 03, 2015 at 04:33:52PM +0100, Martin Sperl wrote:
> > On 03.12.2015, at 15:34, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:

> > There are still a couple of users and someone needs to go through and
> > fix them.  I don't know which if any systems they run on, it's possible
> > that they manage to work as a result of the DMA mappings not getting in
> > the way the systems they're being used on (if they're being used at all)
> > or the controller drivers they're used with being equally aged.

> So if we make use of this =E2=80=9Coptimization=E2=80=9D globally we will=
 need to support it,
> otherwise we break it.

I'm relatively OK with breaking these users TBH, I'm not convinced any
of them are actually being run and it's probably easier to fix by fixing
the users when they're engaged.  Also if we do this in the message queue
thread then we're OK anyway since anything that uses these will old
enough to be using a custom message queue anyway so the risk is less
than it might appear.

> > Remember that we can't do any allocations in _verify() as it can run in
> > atomic context so while we want to check if we can take the message then
> > we are most likely going to be unable to implement transformations.

> I came to realize that in the meantime as well - it was just an idea
> how we could defer such things to a second CPU...

We could potentially try doing this in both call sites - we already have
special casing for spi_sync().  It's more fiddly but it could be done as
a future step.

--it/zdz3K1bH9Y8/E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWYIQ2AAoJECTWi3JdVIfQU+EH/2KX8TjIjByJf4cWmcRL4Stv
nkM8kPTX+yICuV75eGj1QsyGIDOQk9iq+0ndqOyv9kQhZ2Z9+rQfF7TC/BidUKo5
s6/KcBmBNo4h1XAh3qO8QerpqfaMqmuS5LTx6RPA5nRHLNgLbsJfEwcIVvo60acm
7/zBb49M1XSh2MTsThnBUC/ItXX5k1m2k4KMnES5b1AGtG8iZbZeAYMEJn6LhP8D
g4WjpO9HDkN8GwJ/Szq1tXSa3oG/HO2wzxhA8EfQDYsexL32dgUmRhU/N2pqvblg
j7Hz4MdAy6JTguEWxJTSuw8jmzXfD9/WxPrDm5eaBC3LNh2VU4ka5PkwcdH2s/o=
=EYwC
-----END PGP SIGNATURE-----

--it/zdz3K1bH9Y8/E--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
