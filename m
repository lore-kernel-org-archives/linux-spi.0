From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/3] spi: mediatek: Add spi bus for Mediatek MT8173
Date: Wed, 17 Jun 2015 17:35:31 +0100
Message-ID: <20150617163531.GU14071@sirena.org.uk>
References: <1431675522.2128.13.camel@mhfsdcap03>
 <20150515092543.GY2761@sirena.org.uk>
 <1433758546.19786.16.camel@mtksdaap41>
 <20150608175927.GO14071@sirena.org.uk>
 <1433844321.16178.6.camel@mtksdaap41>
 <20150609103951.GA14071@sirena.org.uk>
 <1433923569.22080.1.camel@mtksdaap41>
 <1434532083.19346.27.camel@mtksdaap41>
 <20150617124758.GE3214@sirena.org.uk>
 <1434550251.23617.38.camel@mtksdaap41>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="TMj/TYF/hpk1GcbO"
Cc: Leilk Liu =?utf-8?B?KOWImOejiik=?= <Leilk.Liu@mediatek.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	HongZhou Yang <hongzhou.yang@mediatek.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>,
	srv_heupstream <srv_heupstream@mediatek.com>
To: Eddie Huang <eddie.huang@mediatek.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1434550251.23617.38.camel@mtksdaap41>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--TMj/TYF/hpk1GcbO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 17, 2015 at 10:10:51PM +0800, Eddie Huang wrote:

> Our hardware limitation is: we don't have separate dma tx, rx channel
> with transfer finish interrupt, only have spi trigger operation.So the
> mediatek SPI dma full duplex operation steps are:
> 1. Set TX DMA address.
> 2. Set RX DMA address.
> 3. Set length (this step assume TX, RX are the same size).
> 4. Set TX DMA enable, RX DMA enable bit in spi config register. (not
> trigger DMA, just told spi use dma)
> 5. Trigger spi operations.
> 6. Wait spi operations finish interrupt.

Sure, that's what I understood.

> If tx scatterlist per list data size are 128, 4096, 256. rx scatterlist
> per list data size are 128, 4096, 256. So we need to go through above
> steps three times. If tx scatterlists per list data size are 128, 4096,
> 256. rx scatterlists per list data size are 256, 4096, 128. If we start
> sending first entry, tx size is 128, rx size is 256, this will cause
> hardware malfunction because tx, rx data length are not the same.

> The solution I think is copy scatterlist data into one single buffer in
> mediatek spi transfer function, but I think this is odd because
> __spi_map_msg() map single buffer into scatterlist, then our driver map
> scatterlist into single buffer again. I hope this explaination is more
> clear than before.

To repeat what I said in my last mail: there's no need to use the
scatterlists as-is, your driver can do whatever set of DMA transfers it
likes to keep the lengths of each transfer the same.  Attempting to
linearise the transfers in memory isn't going to work unless you
allocate physically contiguous memory (which could get painful) and will
add substantial overhead.

For example with your above example you could split the transfers up to
be 128, 128, 3968, 128, 128.

--TMj/TYF/hpk1GcbO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVgaHQAAoJECTWi3JdVIfQAksH/jIeZwEfqVtwT6EEhUEl2nAf
2mB4U8etaTNL8MrkztPeU3zQFQKlCJkoF+YGK4IypF1kToaUgLkDDpFf04aEEAdK
E+jMMLgkCY2Ba1DJtxZ4FCnnSqLIcFIHmcnLPjtd2sU3UjAnPnFDctuzjCtlJy4V
Oovc3xO9fEPznpo28DR2UFf/SZMjQntjS9Rj4aOn8EpPvA/A92r6TKiTY14JE0bn
3RHpsQ17x9LReKEuv/rcnVZsB6ONqolEPMTmOxtRTEAJQvEQsj2F6+11d80kdj9g
6icITaTDIF6yBwyzDQ5xiY6F23RW4w/aLBSFyslLZK3rQnYyJcyA0ecJbh3/C28=
=vCVN
-----END PGP SIGNATURE-----

--TMj/TYF/hpk1GcbO--
