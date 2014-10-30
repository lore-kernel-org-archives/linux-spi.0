From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v1 0/2] spi: dw-mid: fix simplex DMA transfers
Date: Thu, 30 Oct 2014 09:10:54 +0200
Message-ID: <1414653054.2396.66.camel@linux.intel.com>
References: <1414513502-595-1-git-send-email-andriy.shevchenko@linux.intel.com>
	 <20141028224156.GN18557@sirena.org.uk>
	 <1414579076.2396.62.camel@linux.intel.com>
	 <20141029111712.GE18557@sirena.org.uk>
	 <1414588848.2396.64.camel@linux.intel.com>
	 <20141029221530.GQ18557@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20141029221530.GQ18557-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Wed, 2014-10-29 at 22:15 +0000, Mark Brown wrote:
> On Wed, Oct 29, 2014 at 03:20:48PM +0200, Andy Shevchenko wrote:
> > On Wed, 2014-10-29 at 11:17 +0000, Mark Brown wrote:
>=20
> > >  - how exactly has this been tested? =20
>=20
> > I don't know how it was tested before, but, besides intel-mid-dma i=
s
> > somehow broken (I won't spend time to patch it), I'm using patch I
> > already published which converts driver to use dw_dmac driver. With=
 it I
> > run tests on a loop back.
>=20
> How exactly do you run those tests though, what is the client driver?

I have a hack patch to register the spidev and I run internal test suit=
e
written by Mika Westerberg. It uses a loop back mode to send and check
data.

>=20
> > > tx_dma and rx_dma
> > > *can* be provided by users but vanishingly few actually do so.  D=
rivers
> > > must not rely on the caller doing this, the feature will be going=
 away
> > > apart from anything else.  If the driver is relying on this it pr=
obably
> > > needs to have the DMA support that's there removed as a fix and s=
hould
> > > be converted to use the core DMA mapping functionality in -next.
>=20
> > So, regarding to above what would you like me to do as next step?
>=20
> Looking at map_dma_buffers() it's probably actually safe since it che=
cks
> that the message has is_dma_mapped set which virtually no clients wil=
l
> do.  However this means that we're not bothering to DMA almost all th=
e
> time which is silly - I'd like to see the driver converted to provide=
 a
> can_dma() operation and let the core worry about mapping, that will m=
ean
> a substantial performance win for most clients.

That is exactly my intention with the additional thing =E2=80=94 to use=
 dw_dmac
instead of intel-mid-dma.

--=20
Andy Shevchenko <andriy.shevchenko-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Intel Finland Oy

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
