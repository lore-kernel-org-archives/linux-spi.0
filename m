From: Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v1 1/1] spi: dw-mid: set DMA burst on memory side
Date: Tue, 12 Apr 2016 19:32:49 +0530
Message-ID: <20160412140249.GI2274@localhost>
References: <1460392212-101116-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <20160412003409.GN3351@sirena.org.uk>
 <1460462195.6620.100.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	dmaengine <dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1460462195.6620.100.camel-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Tue, Apr 12, 2016 at 02:56:35PM +0300, Andy Shevchenko wrote:
> On Tue, 2016-04-12 at 01:34 +0100, Mark Brown wrote:
> > On Mon, Apr 11, 2016 at 07:30:12PM +0300, Andy Shevchenko wrote:
> >=20
>=20
> +Vinod and dmaengine@
>=20
> > >=20
> > > To optimize amount of bus writes on memory side set burst to be t=
he
> > > same amount
> > > of data on both sides.
> > >=20
> > > +	txconf.src_maxburst =3D 4 * dws->dma_width;
> > > =A0	txconf.dst_maxburst =3D 16;
> > This doesn't seem to do what the subject says (at least not always,
> > it'll align for a dma_width of 4)?
>=20
> Thanks you didn't apply the patch.=A0
>=20
> I think the approach itself is wrong.
>=20
> The peripheral drivers usually have no idea and shouldn't know about =
DMA
> engine memory side characteristics (bus width, bursts, etc).

These are typically you system characterstics, like 32 bit or 64 bit bu=
s to
memory and rest (burst etc) should be maximum as the data will go from/=
to
dmaengine FIFO to/from memory, so you would want to push as fast as pos=
sible

Said that, maximun burst with 32bit wide should be saner value in moder=
n
systems.

>=20
> This should be fixed in certain DMA engine drivers.
>=20
> Also, as you may have noticed when we get maximum length of the segme=
nt
> we take into consideration what DMA device supports. Many of them rep=
ort
> something like 2^n - 1, which is apparently unaligned and thus in the
> poorly written DMA driver leads to performance degradation.

Which Intel controller supports 2^n - 1? AFAIK the dw and idma don't.

> Looks like all Intel related DMA drivers should be fixed (HSU, iDMA64=
,
> dw_dmac).
>=20
> Vinod, am I right?
>=20
> --=20
> Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> Intel Finland Oy
>=20

--=20
~Vinod
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
