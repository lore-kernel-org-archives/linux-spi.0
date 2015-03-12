From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] spi: sh-msiof: Fix limit maximum word transfer size of
 FIFO size
Date: Thu, 12 Mar 2015 16:00:47 +0000
Message-ID: <20150312160047.GQ28806@sirena.org.uk>
References: <1426127476-18456-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
 <CAMuHMdXmr7QH8jSkyH2q6xCise7ew5YzyAFc6Zb0psHZt3mGrg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9BaxaTZrvsRxcpDQ"
Cc: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>,
	Linux-sh list <linux-sh@vger.kernel.org>,
	linux-spi <linux-spi@vger.kernel.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdXmr7QH8jSkyH2q6xCise7ew5YzyAFc6Zb0psHZt3mGrg@mail.gmail.com>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--9BaxaTZrvsRxcpDQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 12, 2015 at 01:35:10PM +0100, Geert Uytterhoeven wrote:
> On Thu, Mar 12, 2015 at 3:31 AM, Nobuhiro Iwamatsu

> > This driver is the case of tx_buf was set or SPI_MASTER_MUST_TX is set to
> > master_flags, will be transmit mode. However, the current code, when
> > transmit mode and buffer is NULL, will be set to value of receive mode
> > size.

> If SPI_MASTER_MUST_TX is set, tx_buf will never be NULL.
> If an SPI slave driver submits a receive-only request, the SPI core will
> provide a dummy buffer (spi_master.dummy_tx).

Right, my reading of the changelog was that this was a red herring.

> > +       int rx_words = min_t(int, words, p->rx_fifo_size);
> > +       int tx_words = min_t(int, words, p->tx_fifo_size);

> Sorry, I fail to see what exactly this is fixing.

> If SPI_MASTER_MUST_TX is set, all hardware SPI transfers are either
>   a) transmit-only.
>   b) bidirectional (transmit buffer may be a dummy, provided by the SPI core).

> For case a, only the TX FIFO size matters.
>   - The original code ignored the RX FIFO size (rx_buf == NULL),
>   - After your change, it always uses the minimum of the TX and RX FIFO sizes
>     (granted, the RX FIFO size is larger, so this doesn't make a difference on
>     current hardware).

...

> What am I missing?
> Are you using a backport with broken SPI_MASTER_MUST_TX handling in the SPI
> core?

My understanding was that it was just about making sure that the driver
picked the minimum of the two FIFO sizes.

--9BaxaTZrvsRxcpDQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVAbguAAoJECTWi3JdVIfQ9dwH/3FQtIEPeg0iKwW6m73LTnwb
aP9JKAIwO2Xhh1VAuDdgvceFMkZVTzGpRPggt++Yt0kYR2fr4cKaUjH9nRBaCkYK
OahANCvKD/SgrOSkbT2YRyfDsgiYyXfQFbWrQ5f5Hfm57JCaBG/MFZnkQIs3MhsG
nqxbMxX2WoSqNhKZQa3hmQ0KFPyKjzhzJNAgx5ykPoQ2vkwl0zhytxhlHOViW3OB
0CobXAM9ICuzzCDvbOBpeW+2cR9PMhUBjnAW4mPlcKVR5qfZVxo+2LoLRORNDfur
tmN6hXV1hswcXjkcGPHwqrA3jd1LCdiI8ltkp/dC0hjdyTWNb71yqve015JYCNU=
=ncb+
-----END PGP SIGNATURE-----

--9BaxaTZrvsRxcpDQ--
