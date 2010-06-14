From: Brian Niebuhr <BNiebuhr-JaPwekKOx1yaMJb+Lgu22Q@public.gmane.org>
Subject: RE: [PATCH 2/3] davinci: spi: add replacement SPI driver
Date: Mon, 14 Jun 2010 14:13:25 -0500
Message-ID: <BA34378D1528D04CB3C865B8BAB2472B024CC8@transmx01.transcrypt.local>
References: <1275923348-8533-1-git-send-email-bniebuhr@efjohnson.com>	<1275923348-8533-2-git-send-email-bniebuhr@efjohnson.com><1275923348-8533-3-git-send-email-bniebuhr@efjohnson.com>
	<004601cb0879$c25b75f0$471261d0$@raj@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: "Sudhakar Rajashekhara" <sudhakar.raj-l0cyMroinI0@public.gmane.org>,
        <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
Content-Class: urn:content-classes:message
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
List-Id: linux-spi.vger.kernel.org

> > diff --git a/arch/arm/mach-davinci/include/mach/spi.h 
> b/arch/arm/mach-davinci/include/mach/spi.h
> > index 910efbf..10c39d8 100644
> > --- a/arch/arm/mach-davinci/include/mach/spi.h
> > +++ b/arch/arm/mach-davinci/include/mach/spi.h
> > @@ -19,26 +19,39 @@
> >  #ifndef __ARCH_ARM_DAVINCI_SPI_H
> >  #define __ARCH_ARM_DAVINCI_SPI_H
> >  
> > +#define SPI_INTERN_CS	0xFF
> > +
> > +/* resource flags for IORESOURCE_DMA resources */
> > +#define IORESOURCE_DMA_RX_CHAN		0x01
> > +#define IORESOURCE_DMA_TX_CHAN		0x02
> > +#define IORESOURCE_DMA_EVENT_Q		0x04
> > +
> >  enum {
> > -	SPI_VERSION_1, /* For DM355/DM365/DM6467 */
> > +	SPI_VERSION_1, /* For DM355/DM365/DM6467*/
> 
> Above line in the patch is not required.

Right.
 
> > +
> > +	davinci_spi->version = pdata->version;
> > +
> > +	davinci_spi->bitbang.flags = SPI_NO_CS | SPI_LSB_FIRST 
> | SPI_LOOP;
> > +	if (davinci_spi->version == SPI_VERSION_2)
> > +		davinci_spi->bitbang.flags |= SPI_READY;
> > +
> > +	dma_rx_chan = davinci_spi_get_dma_by_flag(pdev, 
> IORESOURCE_DMA_RX_CHAN);
> > +	dma_tx_chan = davinci_spi_get_dma_by_flag(pdev, 
> IORESOURCE_DMA_TX_CHAN);
> > +	dma_eventq  = davinci_spi_get_dma_by_flag(pdev, 
> IORESOURCE_DMA_EVENT_Q);
> > +	davinci_spi->dma_channels.dma_rx_channel = -1;
> > +	davinci_spi->dma_channels.dma_rx_sync_dev = dma_rx_chan;
> > +	davinci_spi->dma_channels.dma_tx_channel = -1;
> > +	davinci_spi->dma_channels.dma_tx_sync_dev = dma_tx_chan;
> > +	davinci_spi->dma_channels.dummy_param_slot = -1;
> > +	davinci_spi->dma_channels.eventq = dma_eventq;
> 
> Can the above configurations be done only in case if DMA mode?

DMA mode is selected on a per-device basis.  This initialization is for
the controller, so it needs to be prepared to handle DMA if a device
uses it.  If DMA is not required, no DMA resource need be assigned to
the controller.

> Some way of informing the user about the mode in which the driver is
> working is desirable.

Yes, I'll try to come up with something.
