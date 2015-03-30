From: Stefan Agner <stefan-XLVq0VzYD2Y@public.gmane.org>
Subject: Re: [PATCH v2 2/2] spi: fsl-dspi: Add ~50ns delay between cs and sck
Date: Tue, 31 Mar 2015 00:13:04 +0200
Message-ID: <f3ccbe7241da59150674ec6e1488048e@agner.ch>
References: <1427737756-20487-1-git-send-email-aaron.brice@datasoft.com>
 <1427737756-20487-3-git-send-email-aaron.brice@datasoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Aaron Brice <aaron.brice-vSOi0k5x9wFWk0Htik3J/w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1427737756-20487-3-git-send-email-aaron.brice-vSOi0k5x9wFWk0Htik3J/w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Aaron,

Thanks for the fixes! Some comments below:

On 2015-03-30 19:49, Aaron Brice wrote:
> Add delay between chip select and clock signals, before clock starts and
> after clock stops.

This 50ns are specifc to the SPI slave at hand (SRAM) is this correct?
If yes, this would probably need new slave properties. I found a TI
controller which also supports such properties:
http://lists.infradead.org/pipermail/linux-arm-kernel/2014-September/285761.html

> 
> Signed-off-by: Aaron Brice <aaron.brice-vSOi0k5x9wFWk0Htik3J/w@public.gmane.org>
> ---
>  drivers/spi/spi-fsl-dspi.c | 53 ++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 51 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
> index 96cac87..41284cc 100644
> --- a/drivers/spi/spi-fsl-dspi.c
> +++ b/drivers/spi/spi-fsl-dspi.c
> @@ -20,6 +20,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
>  #include <linux/kernel.h>
> +#include <linux/math64.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
> @@ -51,7 +52,7 @@
>  #define SPI_CTAR_CPOL(x)	((x) << 26)
>  #define SPI_CTAR_CPHA(x)	((x) << 25)
>  #define SPI_CTAR_LSBFE(x)	((x) << 24)
> -#define SPI_CTAR_PCSSCR(x)	(((x) & 0x00000003) << 22)
> +#define SPI_CTAR_PCSSCK(x)	(((x) & 0x00000003) << 22)
>  #define SPI_CTAR_PASC(x)	(((x) & 0x00000003) << 20)
>  #define SPI_CTAR_PDT(x)	(((x) & 0x00000003) << 18)
>  #define SPI_CTAR_PBR(x)	(((x) & 0x00000003) << 16)
> @@ -59,6 +60,7 @@
>  #define SPI_CTAR_ASC(x)	(((x) & 0x0000000f) << 8)
>  #define SPI_CTAR_DT(x)		(((x) & 0x0000000f) << 4)
>  #define SPI_CTAR_BR(x)		((x) & 0x0000000f)
> +#define SPI_CTAR_SCALE_BITS	0xf
>  
>  #define SPI_CTAR0_SLAVE	0x0c
>  
> @@ -99,6 +101,8 @@
>  #define SPI_CS_ASSERT		0x02
>  #define SPI_CS_DROP		0x04
>  
> +#define NSEC_PER_SEC		1000000000L
> +

Avoid redefine this, should be available from headers (e.g. time.h)

>  struct chip_data {
>  	u32 mcr_val;
>  	u32 ctar_val;
> @@ -174,6 +178,40 @@ static void hz_to_spi_baud(char *pbr, char *br,
> int speed_hz,
>  	}
>  }
>  
> +static void ns_delay_scale(char *psc, char *sc, int delay_ns,
> +		unsigned long clkrate)
> +{
> +	int pscale_tbl[4] = {1, 3, 5, 7};
> +	int scale_needed, scale, minscale = INT_MAX;
> +	int i, j;
> +	u32 remainder;
> +
> +	scale_needed = div_u64_rem((u64)delay_ns * clkrate, NSEC_PER_SEC,
> +			&remainder);
> +	if (remainder)
> +		scale_needed++;
> +
> +	for (i = 0; i < ARRAY_SIZE(pscale_tbl); i++)
> +		for (j = 0; j <= SPI_CTAR_SCALE_BITS; j++) {
> +			scale = pscale_tbl[i] * (2 << j);
> +			if (scale >= scale_needed) {
> +				if (scale < minscale) {
> +					minscale = scale;
> +					*psc = i;
> +					*sc = j;
> +				}
> +				break;
> +			}
> +		}
> +
> +	if (minscale == INT_MAX) {
> +		pr_warn("Cannot find correct scale values for %dns delay at clkrate
> %ld, using max prescaler value",
> +			delay_ns, clkrate);
> +		*psc = ARRAY_SIZE(pscale_tbl) - 1;
> +		*sc = SPI_CTAR_SCALE_BITS;
> +	}
> +}
> +
>  static int dspi_transfer_write(struct fsl_dspi *dspi)
>  {
>  	int tx_count = 0;
> @@ -352,7 +390,8 @@ static int dspi_setup(struct spi_device *spi)
>  {
>  	struct chip_data *chip;
>  	struct fsl_dspi *dspi = spi_master_get_devdata(spi->master);
> -	unsigned char br = 0, pbr = 0, fmsz = 0;
> +	unsigned char br = 0, pbr = 0, pcssck = 0, cssck = 0;
> +	unsigned char pasc = 0, asc = 0, fmsz = 0;
>  
>  	if ((spi->bits_per_word >= 4) && (spi->bits_per_word <= 16)) {
>  		fmsz = spi->bits_per_word - 1;
> @@ -377,10 +416,20 @@ static int dspi_setup(struct spi_device *spi)
>  	hz_to_spi_baud(&pbr, &br,
>  			spi->max_speed_hz, clk_get_rate(dspi->clk));
>  
> +	/* Set PCS to SCK delay scale values for 50ns delay*/
> +	ns_delay_scale(&pcssck, &cssck, 50, clk_get_rate(dspi->clk));
> +
> +	/* Set After SCK delay scale values for 50ns delay*/
> +	ns_delay_scale(&pasc, &asc, 50, clk_get_rate(dspi->clk));
> +

This functions calls clk_get_rate three times, can you add a local
variable for it?

>  	chip->ctar_val =  SPI_CTAR_FMSZ(fmsz)
>  		| SPI_CTAR_CPOL(spi->mode & SPI_CPOL ? 1 : 0)
>  		| SPI_CTAR_CPHA(spi->mode & SPI_CPHA ? 1 : 0)
>  		| SPI_CTAR_LSBFE(spi->mode & SPI_LSB_FIRST ? 1 : 0)
> +		| SPI_CTAR_PCSSCK(pcssck)
> +		| SPI_CTAR_CSSCK(cssck)
> +		| SPI_CTAR_PASC(pasc)
> +		| SPI_CTAR_ASC(asc)
>  		| SPI_CTAR_PBR(pbr)
>  		| SPI_CTAR_BR(br);

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
