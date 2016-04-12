From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v1 1/1] spi: dw-mid: set DMA burst on memory side
Date: Tue, 12 Apr 2016 14:56:35 +0300
Message-ID: <1460462195.6620.100.camel@linux.intel.com>
References: <1460392212-101116-1-git-send-email-andriy.shevchenko@linux.intel.com>
	 <20160412003409.GN3351@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Koul, Vinod" <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	dmaengine <dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160412003409.GN3351-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Tue, 2016-04-12 at 01:34 +0100, Mark Brown wrote:
> On Mon, Apr 11, 2016 at 07:30:12PM +0300, Andy Shevchenko wrote:
>=20

+Vinod and dmaengine@

> >=20
> > To optimize amount of bus writes on memory side set burst to be the
> > same amount
> > of data on both sides.
> >=20
> > +	txconf.src_maxburst =3D 4 * dws->dma_width;
> > =C2=A0	txconf.dst_maxburst =3D 16;
> This doesn't seem to do what the subject says (at least not always,
> it'll align for a dma_width of 4)?

Thanks you didn't apply the patch.=C2=A0

I think the approach itself is wrong.

The peripheral drivers usually have no idea and shouldn't know about DM=
A
engine memory side characteristics (bus width, bursts, etc).

This should be fixed in certain DMA engine drivers.

Also, as you may have noticed when we get maximum length of the segment
we take into consideration what DMA device supports. Many of them repor=
t
something like 2^n - 1, which is apparently unaligned and thus in the
poorly written DMA driver leads to performance degradation.

Looks like all Intel related DMA drivers should be fixed (HSU, iDMA64,
dw_dmac).

Vinod, am I right?

--=20
Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Intel Finland Oy

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
