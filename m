From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: Depreciated spi_master.transfer and "prepared spi messages" for
 an optimized pipelined-SPI-DMA-driver
Date: Tue, 12 Nov 2013 01:19:54 +0000
Message-ID: <20131112011954.GH2674@sirena.org.uk>
References: <20131106232605.GC2674@sirena.org.uk>
 <72D635F5-4229-4D78-8AA3-1392D5D80127@sperl.org>
 <20131107203127.GB2493@sirena.org.uk>
 <86AE15B6-05AF-4EFF-8B8F-10806A7C148B@sperl.org>
 <20131108161957.GP2493@sirena.org.uk>
 <5F70E708-89B9-4DCF-A31A-E688BAA0E062@sperl.org>
 <20131108180934.GQ2493@sirena.org.uk>
 <C375DEE6-1AEC-4AFB-A9D6-583DCB4476A3@sperl.org>
 <20131109183056.GU2493@sirena.org.uk>
 <6C7903B3-8563-490E-AD7D-BA5D65FFB9BC@sperl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="X+8siUETKMkW99st"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Martin Sperl <martin-d5rIkyn9cnPYtjvyW6yDsg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <6C7903B3-8563-490E-AD7D-BA5D65FFB9BC-d5rIkyn9cnPYtjvyW6yDsg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--X+8siUETKMkW99st
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 10, 2013 at 11:54:16AM +0100, Martin Sperl wrote:
> On 09.11.2013, at 19:30, Mark Brown wrote:

> > What I'm missing with this example is the benefit of having an API for
> > pre-cooked messages, how it will deliver a performance improvement?
> > Flashing should be an infrequent operation and I'd expect it to involve
> > little reuse of messages which I'd expect to be the main thing that we
> > could gain from the API change.  I'd also not expect the controller
> > specific work to be especially expensive.

> It will deliver a performance improvement by not having to create identic=
al=20
> structures or running sanity thest every time you transmit the prepared m=
essage.

But is that a 0.01% improvement or a 50% improvement and is that because
we're pushing a silly implementation into a corner or because there's
actually substantial work that needs doing there?

If the error checking and so on is really that expensive this sounds
like we need to fix that anyway, even if it's just quick things like
making some of the validation debug only or pushing some of the work
out to the message update functions.

The messages and transfers ought to be totally reusable already, the
only bit that should need to be recreated is any data the driver creates
internally, most likely that's only going to be data for DMA.  We do
already have an interface for drivers to do the DMA mapping though it's
not very well loved at the minute...

> And for the DMA chains I have to create DMA chains that are of a length 1=
0-20=20
> - depending on the number of transfers.

What's the expense here - the mapping or something else?  This does also
seem like a lot of scatter/gather, why is the data so spread out and is
there room to do better in the client driver?

We ought to modernise this interface to be more in tune with what
dmaengine is doing anyway (probably taking scatterlists for example) -
you were also talking about DMA a lot in some of your earlier messages
and it is where I'd expect the cost to be so I'm wondering if this isn't
actually more to do with this interface being poor and if we don't need
dmaengine changes too to realise the benefits.

> I would say any little less CPU utilization helps if it is easy to implem=
ent.

I'm not clear on the easy to implement bit here (though obviously there
haven't been patches posted for review yet), especially the interaction
with DMA if that's a part of this, or what exactly you're expecting to
be allowed to happen to the message while it's been partially initalised
by the driver (I wouldn't use the term prepared for what you're
suggesting by the way, I'd expect preparation to be interacting with the
hardware) since that will affect how widely clients could take advantage
of this.

The other bit of easy to implement that concerns me is making sure that
it's easy to implement for the stack as a whole - one of the big
problems with the existing stack is that there is too little factoring
out of code into the core so we end up with individual drivers
implementing good ideas that are widely useful and most drivers being
basic so drivers are more complex to review and the benefits are not
widely distributed.  This makes me worry about an API that just
delegates everything to the driver and which requires both master and
client drivers to specifically support the feature.

> > You've been doing a bunch of other performance improvements as well,
> > it's not clear to me how much of this is coming from the API change and
> > how much of this is due to changes which can also be done by improving
> > the implementation and without requiring drivers to be specifically
> > updated to take advantage of it.=20

> I have told you, that I have created a module parameter which enables/dis=
ables=20
> the prepare code.

Right, and what I'm saying is that I'm not clear what's being done in
that code and hence why moving it makes a difference.

> >> Does this answer your question and convince you of this being realisti=
c?

> > It's still not clear to me exactly how this works and hence if the
> > benefit comes from the API change itself.

> There is no change in API - there is only an optional extension...

Adding new interfaces is a change too, on the driver side as well.

> Would these be good enough scenarios for you to finally convince you if t=
he
> numbers are favorable?

These seem rather artificial and I'm not sure they'd tell us much about
why the effects were being observed.  What would be more interesting
would be seeing where the time is being spent at the minute for real
loads (for example by using trace points like those that are currently
being added in mainline for examining the behaviour of the message pump)
- if we really are spending a noticeable proportion of the time in setup
then that's obviously a good case for optimising it but right now I
don't feel I understand which bits are slow enough to register in the
context of the overall transaction and hence if the suggested approach
is the best way to optimise them.

An implementation that avoided the need to have the master drivers
updated in order to get benefits would be a lot more interesting since
that would make this much more generally useful, and of course concrete
patches would be good too, but the main thing I'm missing is clarity on
how the gains are being made.

--X+8siUETKMkW99st
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSgYI3AAoJELSic+t+oim9vR8P/2quI0mL0aqwHC+wqra5mIM7
FNyenN7alI5/5XNYT27pYNMyz+MO9VfbinbADvdkKbj1gd8HBRsow+PqENhhPHr1
fil3MdIDCbrqIb4otTK6HWb+qo0e7RJfhjGtxoSmKitknLHciR7TAcuBkRNvIQQQ
Z5BdjTTJde+8gIWjpm11KK9/TPwWm2HpUGKFaZUahAjAM761E7nwoj5urFCC2FN2
1NVR7TwYIZHcTZo/qx4n5bqw/CDrm8OgXWS5j1GzUmbRSwGF79siZUy8fFVYLAjr
MAAiVTjI7osMt2UVEhlGOO6pY/In1RsvsuRuFbu/3kWMgy9ETNNQtq9+wQcJt8sd
LQWIZsh0rJOxF7dMB6/N/B0ZcS0vvkM+iHKsJv3PD94fNbb8wjN57wSRM1psFhtd
XTCw5ctf/1AJCm/NW5fWh0Y6eNSzPVL0JOs7aUWXPqaJTHAMEqK+5QM9fk0Zz0P0
czFc7pNKY41y2Fs1aMEqK0Mncm3uMJfow7uXnp/H9191kpeOO48QZNpmJt00iHvB
dbtHeiObfKPzo7OSsLhdj3R+lYuSrHiTW4A+feTlyhwGa0RLKTY/zDtgVcPZsKQ+
Lk7/UaCo9arERNGb1dqiZfXGof0t4Zanpc0APk8MCdSmOapdAb+SEw6SBautgPQT
RAd68KwZLyt22jfqAoJ+
=QazH
-----END PGP SIGNATURE-----

--X+8siUETKMkW99st--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
