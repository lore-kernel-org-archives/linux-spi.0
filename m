From: maitysanchayan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Subject: Re: [PATCH 3/4] spi: spi-fsl-dspi: Fix continuous selection format
Date: Fri, 18 Nov 2016 13:29:27 +0530
Message-ID: <20161118075927.GA1572@Sanchayan-Arch.localdomain>
References: <cover.1479384571.git.maitysanchayan@gmail.com>
 <c1e51fc92dbcc9c31dcdcdfab3eed40d7745308a.1479384571.git.maitysanchayan@gmail.com>
 <c1c4a3f3eac6d4e7378971431bd5f595@agner.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
        linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stefan Agner <stefan-XLVq0VzYD2Y@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <c1c4a3f3eac6d4e7378971431bd5f595-XLVq0VzYD2Y@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hello Stefan,

On 16-11-17 17:07:24, Stefan Agner wrote:
> On 2016-11-17 04:16, Sanchayan Maity wrote:
> > Current DMA implementation was not handling the continuous selection
> > format viz. SPI chip select would be deasserted even between sequential
> > serial transfers. Use the cs_change variable and correctly set or
> > reset the CONT bit accordingly for case where peripherals require
> > the chip select to be asserted between sequential transfers.
> > 
> > Signed-off-by: Sanchayan Maity <maitysanchayan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > ---
> >  drivers/spi/spi-fsl-dspi.c | 13 ++++++++++---
> >  1 file changed, 10 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
> > index aee8c88..164e2e1 100644
> > --- a/drivers/spi/spi-fsl-dspi.c
> > +++ b/drivers/spi/spi-fsl-dspi.c
> > @@ -258,9 +258,16 @@ static int dspi_next_xfer_dma_submit(struct fsl_dspi *dspi)
> >  	}
> >  
> >  	val = tx_word ? *(u16 *) dspi->tx : *(u8 *) dspi->tx;
> > -	dspi->dma->tx_dma_buf[i] = SPI_PUSHR_TXDATA(val) |
> > -					SPI_PUSHR_PCS(dspi->cs) |
> > -					SPI_PUSHR_CTAS(0);
> > +	if (dspi->cs_change) {
> > +		dspi->dma->tx_dma_buf[i] = SPI_PUSHR_TXDATA(val) |
> > +						SPI_PUSHR_PCS(dspi->cs) |
> > +						SPI_PUSHR_CTAS(0);
> > +	} else {
> > +		dspi->dma->tx_dma_buf[i] = SPI_PUSHR_TXDATA(val) |
> > +						SPI_PUSHR_PCS(dspi->cs) |
> > +						SPI_PUSHR_CTAS(0) |
> > +						SPI_PUSHR_CONT;
> > +	}
> 
> How about:
> 
> 
> 	dspi->dma->tx_dma_buf[i] = SPI_PUSHR_TXDATA(val) |
> 					SPI_PUSHR_PCS(dspi->cs) |
> 					SPI_PUSHR_CTAS(0);
> 
> +	if (dspi->cs_change)
> +		dspi->dma->tx_dma_buf[i] |= SPI_PUSHR_CONT;
> 
> 
> Avoids code duplication...

Agreed. It's much better. Should be !dspi->cs_change though.

Will include it in next iteration.

Thanks & Regards,
Sanchayan.

> 
> --
> Stefan
> 
> 
> 
> >  	dspi->tx += tx_word + 1;
> >  
> >  	dma->tx_desc = dmaengine_prep_slave_single(dma->chan_tx,
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
