From: Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 3/4] spi: Encode data width more efficiently
Date: Thu, 26 Sep 2013 11:44:22 +0530
Message-ID: <5243D0BE.4070800@ti.com>
References: <CA+7tXigzKW8sydfnktr4F5uY-SKk0JAMjaxFn74XLbw_NTYVXg@mail.gmail.com>
	<20130925235221.22061.64382.stgit@Graphine>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	yuhang wang <wangyuhang2014-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Trent Piepho <tpiepho-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20130925235221.22061.64382.stgit@Graphine>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Thursday 26 September 2013 05:22 AM, Trent Piepho wrote:
> The TX and RX data bus width fields, [tr]x_nbits, use 8 bits each in every
> SPI transfer.  Due to padding, this increases the size of a spi_transfer by
> 32 bits.  Really, only two bits are needed to encode the three possible
> values and there are seven bits of padding after cs_change.  By making
> [tr]x_nbits bitfields they can fit in this unused space and not increase
> the size of a spi_transfer at all.
>
> The standard width of one bit is currently indicated by two values, 0 or
> SPI_NBITS_SINGLE (1).  There is no need to have two different values for
> this.  By making SPI_NBITS_SINGLE have the value 0, the code in
> __spi_async() that transforms 0 into SPI_NBITS_SINGLE becomes unnecessary.
>
> Try to improve the grammar and clarity of the bit width documentation.  Try
> to be clear this refers to the bit width and not the bit length, which is a
> different property.
>
> Signed-off-by: Trent Piepho<tpiepho-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>   drivers/spi/spi.c       |    6 ------
>   include/linux/spi/spi.h |   27 ++++++++++++++-------------
>   2 files changed, 14 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index 8fcffe0..0e8e5e8 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -1445,8 +1445,6 @@ static int __spi_async(struct spi_device *spi, struct spi_message *message)
>   	/**
>   	 * Set transfer bits_per_word and max speed as spi device default if
>   	 * it is not set for this transfer.
> -	 * Set transfer tx_nbits and rx_nbits as single transfer default
> -	 * (SPI_NBITS_SINGLE) if it is not set for this transfer.
>   	 */
>   	list_for_each_entry(xfer,&message->transfers, transfer_list) {
>   		message->frame_length += xfer->len;
> @@ -1475,10 +1473,6 @@ static int __spi_async(struct spi_device *spi, struct spi_message *message)
>   		    xfer->speed_hz>  master->max_speed_hz)
>   			return -EINVAL;
>
> -		if (xfer->tx_buf&&  !xfer->tx_nbits)
> -			xfer->tx_nbits = SPI_NBITS_SINGLE;
> -		if (xfer->rx_buf&&  !xfer->rx_nbits)
> -			xfer->rx_nbits = SPI_NBITS_SINGLE;
>   		/* check transfer tx/rx_nbits:
>   		 * 1. keep the value is not out of single, dual and quad
>   		 * 2. keep tx/rx_nbits is contained by mode in spi_device
> diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
> index beaffe8..4dbf40e 100644
> --- a/include/linux/spi/spi.h
> +++ b/include/linux/spi/spi.h
> @@ -43,6 +43,9 @@ extern struct bus_type spi_bus_type;
>    *	The "active low" default for chipselect mode can be overridden
>    *	(by specifying SPI_CS_HIGH) as can the "MSB first" default for
>    *	each word in a transfer (by specifying SPI_LSB_FIRST).
> + *	The data width mode bits do not indicate the current mode, as the
> + *	other mode bits do, but rather the maximum supported width.  The
> + *	actual width used is specified for each spi_transfer.
>    * @bits_per_word: Data transfers involve one or more words; word sizes
>    *	like eight or 12 bits are common.  In-memory wordsizes are
>    *	powers of two bytes (e.g. 20 bit samples use 32 bits).
> @@ -463,10 +466,8 @@ extern struct spi_master *spi_busnum_to_master(u16 busnum);
>    * @rx_buf: data to be read (dma-safe memory), or NULL
>    * @tx_dma: DMA address of tx_buf, if @spi_message.is_dma_mapped
>    * @rx_dma: DMA address of rx_buf, if @spi_message.is_dma_mapped
> - * @tx_nbits: number of bits used for writting. If 0 the default
> - *      (SPI_NBITS_SINGLE) is used.
> - * @rx_nbits: number of bits used for reading. If 0 the default
> - *      (SPI_NBITS_SINGLE) is used.
> + * @tx_nbits: number of data lines used for transmit.
> + * @rx_nbits: number of data lines used for receive.
>    * @len: size of rx and tx buffers (in bytes)
>    * @speed_hz: Select a speed other than the device default for this
>    *      transfer. If 0 the default (from @spi_device) is used.
> @@ -521,10 +522,10 @@ extern struct spi_master *spi_busnum_to_master(u16 busnum);
>    * by the results of previous messages and where the whole transaction
>    * ends when the chipselect goes intactive.
>    *
> - * When SPI can transfer in 1x,2x or 4x. It can get this tranfer information
> - * from device through @tx_nbits and @rx_nbits. In Bi-direction, these
> - * two should both be set. User can set transfer mode with SPI_NBITS_SINGLE(1x)
> - * SPI_NBITS_DUAL(2x) and SPI_NBITS_QUAD(4x) to support these three transfer.
> + * When the SPI bus has more than one data line, the bit-width of the tranfer,
> + * i.e. SPI_NBITS_SINGLE (1x), SPI_NBITS_DUAL (2x), or SPI_NBITS_QUAD (4x)
> + * mode, is specified with @tx_nbits and @rx_nbits.  In bi-directional mode,
> + * both should be set.  Setting these fields to zero selects normal (1x) mode.
>    *
>    * The code that submits an spi_message (and its spi_transfers)
>    * to the lower layers is responsible for managing its memory.
> @@ -546,11 +547,11 @@ struct spi_transfer {
>   	dma_addr_t	rx_dma;
>
>   	unsigned	cs_change:1;
> -	u8		tx_nbits;
> -	u8		rx_nbits;
> -#define	SPI_NBITS_SINGLE	0x01 /* 1bit transfer */
> -#define	SPI_NBITS_DUAL		0x02 /* 2bits transfer */
> -#define	SPI_NBITS_QUAD		0x04 /* 4bits transfer */
> +	unsigned	tx_nbits:2;
> +	unsigned	rx_nbits:2;
> +#define	SPI_NBITS_SINGLE	0x00 /* 1x wide transfer */
> +#define	SPI_NBITS_DUAL		0x01 /* 2x wide transfer */
> +#define	SPI_NBITS_QUAD		0x02 /* 4x wide transfer */
>   	u8		bits_per_word;
>   	u16		delay_usecs;
>   	u32		speed_hz;
>
Reviewed-by: Sourav Poddar<sourav.poddar-l0cyMroinI0@public.gmane.org>
Tested-by: Sourav Poddar<sourav.poddar-l0cyMroinI0@public.gmane.org>

------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60133471&iu=/4140/ostg.clktrk
