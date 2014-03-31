From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: SPI chip select semantics (was: [PATCH RFT] spi: mpc512x-psc:
 Refactor to use core message parsing)
Date: Mon, 31 Mar 2014 16:48:14 +0100
Message-ID: <20140331154814.GT2269@sirena.org.uk>
References: <20140331073423.GD2775@book.gsilab.sittig.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CqxttG7JecUZZO5Y"
Cc: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>, Anatolij Gustschin <agust-ynQEQJNshbs@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Gerhard Sittig <gsi-ynQEQJNshbs@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140331073423.GD2775-kDjWylLy9wD0K7fsECOQyeGNnDKD8DIp@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--CqxttG7JecUZZO5Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 31, 2014 at 09:34:23AM +0200, Gerhard Sittig wrote:
> On Sun, 2014-03-30 at 00:30 +0000, Mark Brown wrote:
> > On Sat, Mar 29, 2014 at 04:09:10PM +0100, Gerhard Sittig wrote:

> > That's what it's intended to do, yes (and what a bunch of drivers were
> > doing).

> Turns out I was wrong.  CS gets deasserted if the caller
> requested it (did not request to keep it asserted) _or_ if
> transmission failed.  CS only remains asserted if the caller
> wanted it, _and_ transmission succeeded.

> This is what the implementation does, and what the documentation
> suggests.  So it's good.  I just wanted to correct my wrong
> interpretation of the code, should somebody look at archives.

Oh, sorry - I'd have said if I'd realised that was the bit you were
trying to clarify.

> > Well, the thing is that for hardware that can't control /CS from
> > software so anything using it between transfers can't rely on it
> > happening at all.  Within a transfer you can always paper this over
> > since there's full visibility of what's going to happen but that's
> > not possible over transfers.

> What I meant was that even those setups which do control CS from
> software might not be able to "late deassert" a previously kept
> CS signal upon new selection of another slave.  Think of an array
> of GPIO backed CS signals, asserting one of them won't change the
> others' current signal.

I don't understand why a GPIO based system would have trouble there?
That's the simplest case.

> The documentation might assume the specific behaviour of an
> individual controller or CS decoding approach that just does not
> apply in general.  It's not a problem in the implementation, but
> the documentation might need to get extended to become less
> permissive.  I prepared something along these lines (yet to get
> sent).

No, it's a problem in the implementation - the idea is that the
controller is meant to deassert /CS if it was left asserted and another
device needs to be selected.

> > It could be I guess, though to be honest I've never been convinced that
> > supporting set_cs on the final transfer is a sane idea in the first
> > place - my guess is that it's actually going to cost more on average to
> > implement it (what with remembering to deassert if another device is
> > selected and so on) than just unconditionally disabling /CS.

> The early decision of what CS should be after the transfer is not
> specific to the last transfer and to keeping CS asserted after
> the complete message.  It applies to any transfer within a
> message that might want to deassert CS.  So it applies to those
> intermediate transfers which want to pulse CS, as well as to the
> last transfer in the regular case of deasserting CS after the
> message.

My point is that hardware limitations may make it impossible to
implement the ability to leave /CS asserted outside of messages but
within messages we can always fiddle things.

> > Another thread would've been helpful - I was reading it thinking it was
> > going to explain the poor performance!

> In the MUA you will see that the performance and the CS semantics
> are two separate subthreads that both are spawned from the patch
> which switches MPC512x to the common message transmission
> routine.  I broke the thread for you, to not have the CS
> semantics discussion for the SPI core within the MPC512x patch
> feedback in trackers.  Hope it helps.

Right, but the reason it was confusing was that the topic had changed
without the thread changing.

--CqxttG7JecUZZO5Y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTOY46AAoJELSic+t+oim92q0P/2Ji0H9EbmtT+824ZMw3eu37
/Po9/e0vlH+72yr9cp8z03Oy+vHbI9PefSQVD2OGV4mRvpJ9ouqYKbsRrG+9IW7a
dLB+IF3AjSCvyIweT8IAihbi59q8GFVTyNhnyPT4fIW/rtm7bvqoqKRkYqRD/kgV
1j24EvqXgn8Gx5tPXqQVDTeQQ2H3OByHM5qw8knb5ppMJPpINkoah7UPXl9Oy3k+
6hiafaKPHwzqsSMzP+vj3p2ChDURh63Vh9y0CZhVt4qHkuYtD+NT+aXq+SrwTuUk
ep1rPxeyxcj+kescg5YkfRzfi97CrkgnhWDEupwIoAMISJ1XgD614RGKOZ22a83f
2eOVVXNx0Rf/EiIphF6TQYBNsf1q6hP5JOWTeFzhC+1vIFtR/RDi65O5s4a82zBF
oUhmGoZ74W7Voqu5fsbVenOKK7KYHsGfv0WIf/9QSx54/8gUHG/bC1+fcltIvoQ5
TBoEYZwqJzFxBm0zHb/YYXDsbGnu9gSQBg+/C6eauFxrgskKE9rY9yA5RA1WQviI
BQa2g6ucf3hvDzVUbGmO8XnEFWavj8ae9rScxWiO/JLCJ/7T3ixVPqGw5jJqNV7F
zeUtAtD5pE/SBGY/0qIUEZ1sGw/JZgxpGrWQofRbUTw9XFI/iktM6VDUO4adJ8pm
oTjZaYcaXITUV+0B1cC2
=lt5M
-----END PGP SIGNATURE-----

--CqxttG7JecUZZO5Y--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
