From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: Depreciated spi_master.transfer and "prepared spi messages" for
 an optimized pipelined-SPI-DMA-driver
Date: Wed, 13 Nov 2013 15:43:46 +0000
Message-ID: <20131113154346.GT878@sirena.org.uk>
References: <86AE15B6-05AF-4EFF-8B8F-10806A7C148B@sperl.org>
 <20131108161957.GP2493@sirena.org.uk>
 <5F70E708-89B9-4DCF-A31A-E688BAA0E062@sperl.org>
 <20131108180934.GQ2493@sirena.org.uk>
 <C375DEE6-1AEC-4AFB-A9D6-583DCB4476A3@sperl.org>
 <20131109183056.GU2493@sirena.org.uk>
 <6C7903B3-8563-490E-AD7D-BA5D65FFB9BC@sperl.org>
 <20131112011954.GH2674@sirena.org.uk>
 <52823E73.503@sperl.org>
 <2252E63E-176C-43F7-B259-D1C3A142DAFE@sperl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="h1wVxq8aeHrvhZJz"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Martin Sperl <martin-d5rIkyn9cnPYtjvyW6yDsg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <2252E63E-176C-43F7-B259-D1C3A142DAFE-d5rIkyn9cnPYtjvyW6yDsg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--h1wVxq8aeHrvhZJz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 12, 2013 at 06:59:02PM +0100, Martin Sperl wrote:

> First, sorry for the bad formatting in the last email - it looked ok when=
 typing=20
> it with Thunderbird... I even used the recommended plugin to make it wrap=
=20
> correctly (still format=3Dflowed).

Like I say still reading that, a couple of initial thoughts though...

> As for other interesting measurements a single example with 5 transfers:
> Interrupt to __spi_async:     19us
> __spi_async sanity start/end:  2us
> __SPI_ASYNC to DMA_PREPARE:   99us
> dma_prepare start/end:        40us
> dma_prepare_end to CS DOWN:    4us
> CS DOWN to CS UP:             16us (real transfer)

This is making me question the use of DMA at all here, this looks like
the situation of a lot of drivers where they switch to PIO mode for
small transfers since the cost of managing DMA is too great.  I'm also
curious which parts of the DMA preparation are expensive - is it the
building of the datastructure for DMA or is it dealing with the
coherency issues for the DMA controller?  The dmaengine API currently
needs transfers rebuilding each time I believe...

Also how does this scale for larger messages?

I appreciate that you want to push the entire queue down into hardware,
I'm partly thinking of the costs for drivers that don't go and do any of
the precooking here.

> This is actually one of the biggest "factors" to latency on its own.
> And that is the scheduling delay of the message-pump!

Right, which is why I'm much more interested in the refactoring of that
code to support kicking transfers without bouncing up there - the stuff
I was talking about which made you talk about checksumming and so on.

> So the "threaded" approach - even though nice on paper - is actually
> introducing long latencies. And that is why i would like to see how=20
> a fully DMA pipelined driver would fare - my guess is that the delays
> would be much smaller. It will not change the delays interrupt to
> running the handler, but the scheduling of the message pump would go
> away immediately.

Exactly, but this is largely orthogonal to having the client drivers
precook the messages.  You can't just discard the thread since some
things like clock reprogramming can be sleeping but we should be using
it less (and some of the use that is needed can be run in parallel with
the transfers of other messages if we build up a queue).

> So I hope that these are some hard enough facts for you to say, that=20
> "preparing" messages, that do not "change in structure" in a device
> driver _does_ bring an advantage.

The 40us is definitely somewhat interesting though I'd be interested to
know how that compares with PIO too.

--h1wVxq8aeHrvhZJz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSg54vAAoJELSic+t+oim9t34P/jrxhFz91VpWHIoQioXT4wPl
XY8R8I57AlxjXtPThk7oezDLxcxBng6285BMgDoL02ymC5vzEtVKFNXfEcxV40S/
NgeFDmP6oE29hiIAGmLc2qlHXnvP6so3C+ukwmua/zj+XxPb3NJa6szOOWyzjsUn
N2hYTMNSBQ2fTfqmR7vT66I38gZirI5FngIRqR9yZFXlcYChNazPqHgYN3ohtg97
fuoS2+1dkqsXB8c1f8ncd0rJEwUt/iO2DYo+NVXAMBt5DglB8HHicTB/iNWIHPlf
4891H8jRbPn9wmGTyhlAkDjpU90HAoC4jltqUHU4EfPy7/FXa8/PgWZYJUoLz5BJ
L+aJHR+OSQbp6L4LQN+F6EuQLlYjUcmutxgtp00b39kecbBqVHEL4CNAedvWjmFq
Xh7DKMLgb/X9SDnY1H1uoV4ifSzHY8dGia4Yj8F1T5xR8I890vD77m9A9u/hyH2K
7Z6Y5eNslaPHTn75wVHskZwg/li8F0cYNLgHIexRY0Ob3uEA9T5/1VF1PvLtb1Y1
zjiFWYvS/3R4+x2mnoSOVZNDS2/aLeUzr5Ob1xyKC0zGG7t4nvRvn5adAPJRJd7q
IX0widMcgjEFxXsj4jgUYOkd+oqux7PV5YR/df+UKRyvDHtRkMPfCYWz7/jgNIfM
+XOweV9XFnQ5La0keKuK
=Q7NA
-----END PGP SIGNATURE-----

--h1wVxq8aeHrvhZJz--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
