From: Boris Brezillon <boris.brezillon-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Subject: Re: [PATCH v2 02/11] spi: set mode bits for "spi-rx-dtr" and
 "spi-tx-dtr"
Date: Mon, 2 Mar 2020 11:20:02 +0100
Message-ID: <20200302112002.4e3aaffd@collabora.com>
References: <20200226093703.19765-1-p.yadav@ti.com>
        <20200226093703.19765-3-p.yadav@ti.com>
        <20200227172247.0e8ec459@collabora.com>
        <20200302094829.opazalwldrdn4s7y@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Tudor Ambarus <tudor.ambarus-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>,
        Miquel Raynal <miquel.raynal-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>,
        Richard Weinberger <richard-/L3Ra7n9ekc@public.gmane.org>,
        Vignesh Raghavendra <vigneshr-l0cyMroinI0@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
        <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>,
        <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Pratyush Yadav <p.yadav-l0cyMroinI0@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200302094829.opazalwldrdn4s7y-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Mon, 2 Mar 2020 15:18:31 +0530
Pratyush Yadav <p.yadav-l0cyMroinI0@public.gmane.org> wrote:

> > > diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> > > index 38b4c78df506..25c8ed9343f9 100644
> > > --- a/drivers/spi/spi.c
> > > +++ b/drivers/spi/spi.c
> > > @@ -1927,6 +1927,13 @@ static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
> > >  		}
> > >  	}
> > >  
> > > +	/* Device DTR mode. */
> > > +	if (of_property_read_bool(nc, "spi-tx-dtr"))
> > > +		spi->mode |= SPI_TX_DTR;
> > > +
> > > +	if (of_property_read_bool(nc, "spi-rx-dtr"))
> > > +		spi->mode |= SPI_RX_DTR;
> > > +  
> > 
> > If this DTR mode is only used in spi-mem, maybe we shouldn't add those
> > flags. SPI mem devices are usually smart enough to advertise what they
> > support, and the subsystem in charge of those devices (in this specific
> > case, spi-nor) will check what the controller supports
> > using spi_mem_supports_op(). The only case we might have to deal with
> > at some point is board level limitations (disabling DTR because the
> > routing prevents using this mode).  
>  
> Yes, being able to handle board-level limitations is the main reason 
> behind this change. There should be a way to over-ride the use of DTR 
> for a given board. And IIUC, SPI allows doing the same for Rx and Tx 
> buswidth. So I don't see why we should deviate from that model.

My point is, maybe it should be expressed as a limitation, rather than
made mandatory for the non-limited case (default to supported, unless
stated otherwise). I think we already had this discussion with Rob and
Mark regarding the QUAD/DUAL flags, which made conversion from spi-nor
to spi-mem non-backward compatible for some controllers (some spi-nor
controller drivers were considering the absence of spi-{tx,rx}-width as
'use the max supported by the controller if the device supports it'
while the spi subsystem goes for the more conservative 'use single SPI
if spi-{tx,rx}-width is missing'). If we introduce a new property, maybe
it'd be a good thing to think twice before taking this decision. FWIW,
I'd vote for a 'spi-no-dtr' property to express board-level
limitations.

Orthogonal to this is the question of where we should put those flags,
and I'm still not convinced we need that at the spi level (at least not
yet).
