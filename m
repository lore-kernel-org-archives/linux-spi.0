From: Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/3] davinci: spi: move event_q parameter to platform data
Date: Fri, 04 Feb 2011 15:03:43 +0300
Message-ID: <4D4BEB1F.6060200@mvista.com>
References: <1296779690-9723-1-git-send-email-michael.williamson@criticallink.com>
	<1296779690-9723-2-git-send-email-michael.williamson@criticallink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Cc: khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
        davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org,
        grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Michael Williamson <michael.williamson-wZX4cNJlHJ2sVWG7oymsAA@public.gmane.org>
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <1296779690-9723-2-git-send-email-michael.williamson-wZX4cNJlHJ2sVWG7oymsAA@public.gmane.org>
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

Hello.

On 04-02-2011 3:34, Michael Williamson wrote:

> For DMA operation, the davinci spi driver needs an eventq number.
> Currently, this number is passed as a IORESOURCE_DMA.  This is not
> correct, as the eventq is not a DMA channel.  Pass the eventq
> via the platform data structure instead.

> Signed-off-by: Michael Williamson<michael.williamson-wZX4cNJlHJ2sVWG7oymsAA@public.gmane.org>
[...]

> diff --git a/arch/arm/mach-davinci/include/mach/spi.h b/arch/arm/mach-davinci/include/mach/spi.h
> index 38f4da5..0853a5f 100644
> --- a/arch/arm/mach-davinci/include/mach/spi.h
> +++ b/arch/arm/mach-davinci/include/mach/spi.h
[...]
> @@ -39,13 +41,16 @@ enum {
>    *		to populate if all chip-selects are internal.
>    * @cshold_bug:	set this to true if the SPI controller on your chip requires
>    *		a write to CSHOLD bit in between transfers (like in DM355).
> + * @dma_event_q: DMA event_q to use if SPI_IO_TYPE_DMA is used for any device

    s/event_q/event queue/?

> + *		on the bus.
>    */
>   struct davinci_spi_platform_data {
> -	u8	version;
> -	u8	num_chipselect;
> -	u8	intr_line;
> -	u8	*chip_sel;
> -	bool	cshold_bug;
> +	u8			version;
> +	u8			num_chipselect;
> +	u8			intr_line;
> +	u8			*chip_sel;
> +	bool			cshold_bug;
> +	enum dma_event_q	dma_event_q;
>   };
>
>   /**
> diff --git a/drivers/spi/davinci_spi.c b/drivers/spi/davinci_spi.c
> index 6beab99..166a879 100644
> --- a/drivers/spi/davinci_spi.c
> +++ b/drivers/spi/davinci_spi.c
[...]
> @@ -878,17 +877,13 @@ static int davinci_spi_probe(struct platform_device *pdev)
>   	r = platform_get_resource(pdev, IORESOURCE_DMA, 1);
>   	if (r)
>   		dma_tx_chan = r->start;
> -	r = platform_get_resource(pdev, IORESOURCE_DMA, 2);
> -	if (r)
> -		dma_eventq = r->start;
>
>   	dspi->bitbang.txrx_bufs = davinci_spi_bufs;
>   	if (dma_rx_chan != SPI_NO_RESOURCE&&
> -	    dma_tx_chan != SPI_NO_RESOURCE&&
> -	    dma_eventq != SPI_NO_RESOURCE) {
> +	    dma_tx_chan != SPI_NO_RESOURCE) {
>   		dspi->dma.rx_channel = dma_rx_chan;
>   		dspi->dma.tx_channel = dma_tx_chan;
> -		dspi->dma.eventq = dma_eventq;
> +		dspi->dma.eventq = pdata->dma_event_q;

    It makes sense to merge this patch with the patches 2 and 3 as otherwise 
the bisectability is prevented for DM3[56]5 -- their 'dma_event_q' field will 
be anonymously initialized to 0 after this patch but should be 1 and 3 instead 
correspondingly. Although, this doesn't seem to be a fatal defect, so the 
patches can be kept separate... Don't know what's better.

WBR, Sergei
