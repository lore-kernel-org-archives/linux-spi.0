From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH net-next 03/11] spi: Add a PTP system timestamp to
 the transfer structure
Date: Fri, 16 Aug 2019 13:58:20 +0100
Message-ID: <20190816125820.GF4039@sirena.co.uk>
References: <20190816004449.10100-1-olteanv@gmail.com>
 <20190816004449.10100-4-olteanv@gmail.com>
 <20190816121837.GD4039@sirena.co.uk>
 <CA+h21hqatTeS2shV9QSiPzkjSeNj2Z4SOTrycffDjRHj=9s=nQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="TU+u6i6jrDPzmlWF"
Cc: Hubert Feurstein <h.feurstein@gmail.com>, mlichvar@redhat.com,
        Richard Cochran <richardcochran@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-spi@vger.kernel.org, netdev <netdev@vger.kernel.org>
To: Vladimir Oltean <olteanv@gmail.com>
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CA+h21hqatTeS2shV9QSiPzkjSeNj2Z4SOTrycffDjRHj=9s=nQ@mail.gmail.com>
Sender: netdev-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--TU+u6i6jrDPzmlWF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 16, 2019 at 03:35:30PM +0300, Vladimir Oltean wrote:
> On Fri, 16 Aug 2019 at 15:18, Mark Brown <broonie@kernel.org> wrote:
> > On Fri, Aug 16, 2019 at 03:44:41AM +0300, Vladimir Oltean wrote:

> > > @@ -842,6 +843,9 @@ struct spi_transfer {
> > >
> > >       u32             effective_speed_hz;
> > >
> > > +     struct ptp_system_timestamp *ptp_sts;
> > > +     unsigned int    ptp_sts_word_offset;
> > > +

> > You've not documented these fields at all so it's not clear what the
> > intended usage is.

> Thanks for looking into this.
> Indeed I didn't document them as the patch is part of a RFC and I
> thought the purpose was more clear from the context (cover letter
> etc).
> If I do ever send a patchset for submission I will document the newly
> introduced fields properly.

The issue I'm having is that I have zero idea about the PTP API so I've
got nothing to go on when thinking about if this approach makes any
sense unless I go do some research.

> So let me clarify:
> The SPI slave device driver is populating these fields to indicate to
> the controller driver that it wants word number @ptp_sts_word_offset
> from the tx buffer snapshotted. The controller driver is supposed to
> put the snapshot into the @ptp_sts field, which is a pointer to a
> memory location under the control of the SPI slave device driver.

Snapshot here basically meaning recording a timestamp?  This interface
does seem like it basically precludes DMA based controllers from using
it unless someone happened to implement some very specific stuff in
hardware which seems implausible.  I'd be inclined to just require that
users can only snapshot the first (and possibly also the last, though
DMA completions make that fun) word of a transfer, we could then pull
this out into the core a bit by providing a wrapper function drivers
should call at the appropriate moment.

> It is ok if the ptp_sts pointer is NULL (no need to check), because
> the API for taking snapshots already checks for that.
> At the moment there is yet no proposed mechanism for the SPI slave
> driver to ensure that the controller will really act upon this
> request. That would be really nice to have, since some SPI slave
> devices are time-sensitive and warning early is a good way to prevent
> unnecessary troubleshooting.

Yes, that's one of the things I was thinking about looking at the series
- we should at least be able to warn if we can't timestamp so nobody
gets confused, possibly error out if the calling code particularly
depends on it.

--TU+u6i6jrDPzmlWF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1WqGsACgkQJNaLcl1U
h9CGoAf/UIB6zifv+qd++v5V+GB33nvGyd/uZvEunEr1laYQfXDcZwBlGWdiIYHU
NrjjdvRpmKjIkj0VcTnSnY2PQRRsWuiz4qnjRchLbe2cKJLQGNp+GNH3HvdhTyqv
mXNmKeO1LXOhxViuiSeqW5XxvKH2gT6dngXb5hKbCsTYwSWB73CTJ2GyrzXJBDPU
+rKLUlFhDb0lziPkKV584IuE2ArCyxVwGwwjE2bOKqprMOknLBDiLwr811/dYDg7
4InYjtkrDfccr58d+INSrQJTXpyVxuKtD9vkNiSzXeqS7msp1wiVafPwIf31WspT
x7pIGwR6FyKgrZCqPTC/lev3JawcPw==
=fXS5
-----END PGP SIGNATURE-----

--TU+u6i6jrDPzmlWF--
