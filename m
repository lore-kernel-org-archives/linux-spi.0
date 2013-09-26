From: Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 2/4] spi: Order fields in spi_device for better packing
Date: Thu, 26 Sep 2013 11:44:01 +0530
Message-ID: <5243D0A9.7070701@ti.com>
References: <CA+7tXigzKW8sydfnktr4F5uY-SKk0JAMjaxFn74XLbw_NTYVXg@mail.gmail.com>
	<20130925235214.22061.8047.stgit@Graphine>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	yuhang wang <wangyuhang2014-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Trent Piepho <tpiepho-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20130925235214.22061.8047.stgit@Graphine>
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
> Now that spi_device->mode is a u16, the chip_select, bits_per_mode,
> and mode fields pack poorly, taking 8 bytes:  four data and four
> padding.  By moving (u8)bits_per_word up one position, to after
> (u8)chip_select, they pack better and only use 4 bytes.
>
> Signed-off-by: Trent Piepho<tpiepho-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>   include/linux/spi/spi.h |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
> index 887116d..beaffe8 100644
> --- a/include/linux/spi/spi.h
> +++ b/include/linux/spi/spi.h
> @@ -74,6 +74,7 @@ struct spi_device {
>   	struct spi_master	*master;
>   	u32			max_speed_hz;
>   	u8			chip_select;
> +	u8			bits_per_word;
>   	u16			mode;
>   #define	SPI_CPHA	0x01			/* clock phase */
>   #define	SPI_CPOL	0x02			/* clock polarity */
> @@ -91,7 +92,6 @@ struct spi_device {
>   #define	SPI_TX_QUAD	0x200			/* transmit with 4 wires */
>   #define	SPI_RX_DUAL	0x400			/* receive with 2 wires */
>   #define	SPI_RX_QUAD	0x800			/* receive with 4 wires */
> -	u8			bits_per_word;
>   	int			irq;
>   	void			*controller_state;
>   	void			*controller_data;
>
Reviewed-by: Sourav Poddar<sourav.poddar-l0cyMroinI0@public.gmane.org>
Tested-by: Sourav Poddar<sourav.poddar-l0cyMroinI0@public.gmane.org>

------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60133471&iu=/4140/ostg.clktrk
