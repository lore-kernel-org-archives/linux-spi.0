From: "Gupta, Pekon" <pekon-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH] SPI: DUAL and QUAD support
Date: Wed, 7 Aug 2013 11:57:04 +0000
Message-ID: <20980858CB6D3A4BAE95CA194937D5E73E9F1993@DBDE04.ent.ti.com>
References: <20130729064234.GS9858@sirena.org.uk>
	<1375095194-7093-1-git-send-email-wangyuhang2014@gmail.com>
	<20980858CB6D3A4BAE95CA194937D5E73E9EE267@DBDE04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, "Poddar,
	Sourav" <sourav.poddar-l0cyMroinI0@public.gmane.org>, "tpiepho-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <tpiepho-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	"linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	"broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: wangyuhang <wangyuhang2014-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20980858CB6D3A4BAE95CA194937D5E73E9EE267-yXqyApvAXouIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

> 
> Hello,
> > diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
> > index 38c2b92..222e49e 100644
> > --- a/include/linux/spi/spi.h
> > +++ b/include/linux/spi/spi.h
> > @@ -437,6 +441,8 @@ extern struct spi_master
> > *spi_busnum_to_master(u16 busnum);
> >   * @rx_buf: data to be read (dma-safe memory), or NULL
> >   * @tx_dma: DMA address of tx_buf, if @spi_message.is_dma_mapped
> >   * @rx_dma: DMA address of rx_buf, if @spi_message.is_dma_mapped
> > + * @tx_nbits: number of bits used for writting
> > + * @rx_nbits: number of bits used for reading
> >   * @len: size of rx and tx buffers (in bytes)
> >   * @speed_hz: Select a speed other than the device default for this
> >   *      transfer. If 0 the default (from @spi_device) is used.
> > @@ -491,6 +497,11 @@ extern struct spi_master
> > *spi_busnum_to_master(u16 busnum);
> >   * by the results of previous messages and where the whole transaction
> >   * ends when the chipselect goes intactive.
> >   *
> > + * When SPI can transfer in 1x,2x or 4x. It can get this tranfer information
> > + * from device through @tx_nbits and @rx_nbits. In Bi-direction, these
> > + * two should both be set. User can set transfer mode with
> > SPI_NBITS_SINGLE(1x)
> > + * SPI_NBITS_DUAL(2x) and SPI_NBITS_QUAD(4x) to support these three
> > transfer.
> > + *
> >   * The code that submits an spi_message (and its spi_transfers)
> >   * to the lower layers is responsible for managing its memory.
> >   * Zero-initialize every field you don't set up explicitly, to
> > @@ -511,6 +522,11 @@ struct spi_transfer {
> >  	dma_addr_t	rx_dma;
> >
> >  	unsigned	cs_change:1;
> > +	u8		tx_nbits;
> > +	u8		rx_nbits;
> > +#define	SPI_NBITS_SINGLE	0x0; /* 1bit transfer */
> > +#define	SPI_NBITS_DUAL		0x01; /* 2bits transfer */
> > +#define	SPI_NBITS_QUAD		0x02; /* 4bits transfer */
> 
> [Pekon]: I don't think it's a good place for #defines.  Plz keep it out of struct
> body.
One more feedback, Its better you define SPI_NBITS_xx matching
the actual number of wires used. This would leave places for some
micro-wire and 3-wire SPI, and would be more readable.
+#define	SPI_NBITS_SINGLE_HALF_DUPLEX	0x0; /* 1bit transfer  microwire*/
+#define	SPI_NBITS_SINGLE_FULL_DUPLEX	0x01; /* 1bit transfer  normal SPI*/
+#define	SPI_NBITS_DUAL	2; /* 2bits transfer */
+#define	SPI_NBITS_QUAD	4; /* 4bits transfer */

with regards, pekon

------------------------------------------------------------------------------
Get 100% visibility into Java/.NET code with AppDynamics Lite!
It's a free troubleshooting tool designed for production.
Get down to code-level detail for bottlenecks, with <2% overhead. 
Download for free and get started troubleshooting in minutes. 
http://pubads.g.doubleclick.net/gampad/clk?id=48897031&iu=/4140/ostg.clktrk
