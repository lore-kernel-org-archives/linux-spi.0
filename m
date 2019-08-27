From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH spi for-5.4 2/5] spi: Add a PTP system timestamp to the
 transfer structure
Date: Tue, 27 Aug 2019 20:01:44 +0100
Message-ID: <20190827190144.GK23391@sirena.co.uk>
References: <20190818182600.3047-1-olteanv@gmail.com>
 <20190818182600.3047-3-olteanv@gmail.com>
 <20190822171137.GB23391@sirena.co.uk>
 <CA+h21hrwJi1ftJn56RrfobdkcCpsKZGy1VV1+ANWpxoKxwRmwA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="w3gPeeaTISh83WAP"
Cc: Hubert Feurstein <h.feurstein@gmail.com>,
        Miroslav Lichvar <mlichvar@redhat.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-spi@vger.kernel.org, netdev <netdev@vger.kernel.org>
To: Vladimir Oltean <olteanv@gmail.com>
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CA+h21hrwJi1ftJn56RrfobdkcCpsKZGy1VV1+ANWpxoKxwRmwA@mail.gmail.com>
Sender: netdev-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--w3gPeeaTISh83WAP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Aug 24, 2019 at 03:38:16PM +0300, Vladimir Oltean wrote:
> On Thu, 22 Aug 2019 at 21:19, Mark Brown <broonie@kernel.org> wrote:
> > On Sun, Aug 18, 2019 at 09:25:57PM +0300, Vladimir Oltean wrote:

> > > +     if (!ctlr->ptp_sts_supported) {
> > > +             list_for_each_entry(xfer, &mesg->transfers, transfer_list) {
> > > +                     xfer->ptp_sts_word_pre = 0;
> > > +                     ptp_read_system_prets(xfer->ptp_sts);
> > > +             }
> > > +     }

> > We can do better than this for controllers which use transfer_one().

> You mean I should guard this "if", and the one below, with "&&
> !ctlr->transfer_one"?

Yes, that'd make it a bit more obvious that the better handling
is there.

> > > + * @ptp_sts_supported: If the driver sets this to true, it must provide a
> > > + *   time snapshot in @spi_transfer->ptp_sts as close as possible to the
> > > + *   moment in time when @spi_transfer->ptp_sts_word_pre and
> > > + *   @spi_transfer->ptp_sts_word_post were transmitted.
> > > + *   If the driver does not set this, the SPI core takes the snapshot as
> > > + *   close to the driver hand-over as possible.

> > A couple of issues here.  The big one is that for PIO transfers
> > this is going to either complicate the code or introduce overhead
> > in individual drivers for an extremely niche use case.  I guess
> > most drivers won't implement it which makes this a bit moot but
> > then this is a concern that pushes back against the idea of
> > implementing the feature.

> The concern is the overhead in terms of code, or runtime performance?

Both, yes.

> Arguably the applications that require deterministic latency are
> actually going to push for overall less overhead at runtime, even if
> that comes at a cost in terms of code size. The spi-fsl-dspi driver
> does not perform worse by any metric after this rework.

Determinalistic and fast are often note the same thing here,
sometimes it's better not to optimize if the optimization only
works some of the time for example.

> > The other is that it's not 100% clear what you're looking to
> > timestamp here - is it when the data goes on the wire, is it when
> > the data goes on the FIFO (which could be relatively large)?  I'm
> > guessing you're looking for the physical transfer here, if that's
> > the case should there be some effort to compensate for the delays
> > in the controller?

> The goal is to timestamp the moment when the SPI slave sees word N of
> the data. Luckily the DSPI driver raises the TCF (Transfer Complete
> Flag) once that word has been transmitted, which I used to my
> advantage. The EOQ mode behaves similarly, but has a granularity of 4
> words. The controller delays are hence implicitly included in the
> software timestamp.

The documentation should be clear on that, it'd be very natural
for someone to timestamp on entry to the FIFO.

> But the question is valid and I expect that such compensation might be
> needed for some hardware, provided that it can be measured and
> guaranteed. In fact Hubert did add such logic to the v3 of his MDIO
> patch: https://lkml.org/lkml/2019/8/20/195 There were some objections
> mainly related to the certainty of those offset corrections. I don't
> want to "future-proof" the API now with features I have no use of, but
> such compensation logic might come in the future.

I think it's mainly important that people know what the
expectations are so different drivers are consistent in how they
work, as you say the API can always be extended later.

--w3gPeeaTISh83WAP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1lfhcACgkQJNaLcl1U
h9BfVgf/TBGpRMHiwIYmVpVCz4WXDNwCglzzVNRyywnwWSMWRSo73+uDZqnOdT+1
YkywbCcO2JWuHw+JuqIGa9jg/48x9/8HEoMPDe/RvhXqfE2IqCDOXIeiHf+wQstJ
P3a4/p13qbuzav3PTGYfoIxz8i6DtD/1m3dLvm8N/ONyIoqoJn8+K2XhMsb4lcbv
cHp9VOV3V2/8SDutfQcMHkGP5DnvyYTJNY7ld08/0txQf3WFSTfvUHGiXPf7wpEd
4GOp6mpHmD6aQ3kLw+scbrsmiNxZUucJr/LpD5gAeOfrd2aEqTnMfV3X2p8hRqWm
TLTHdyKhjai2va8NxzU4K1Dddg4T1Q==
=hvGY
-----END PGP SIGNATURE-----

--w3gPeeaTISh83WAP--
