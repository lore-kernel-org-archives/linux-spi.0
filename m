From: Michael Walle <michael-QKn5cuLxLXY@public.gmane.org>
Subject: Re: [PATCH 2/6] spi: spi-fsl-dspi: Fix little endian access to PUSHR
 CMD and TXDATA
Date: Mon, 09 Mar 2020 18:59:04 +0100
Message-ID: <d8e39e402328b962cdbc25316a27eac8@walle.cc>
References: <20200309145624.10026-1-olteanv@gmail.com>
 <20200309145624.10026-3-olteanv@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
        robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org,
        devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, eha-/iRVSOupHO4@public.gmane.org, angelo-BIYBQhTR83Y@public.gmane.org,
        andrew.smirnov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, gustavo-L1vi/lXTdts+Va1GwOuvDg@public.gmane.org, weic-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org,
        mhosny-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, peng.ma-3arQi8VN3Tc@public.gmane.org
To: Vladimir Oltean <olteanv-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200309145624.10026-3-olteanv-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Am 2020-03-09 15:56, schrieb Vladimir Oltean:
> From: Vladimir Oltean <vladimir.oltean-3arQi8VN3Tc@public.gmane.org>
> 
> In XSPI mode, the 32-bit PUSHR register can be written to separately:
> the higher 16 bits are for commands and the lower 16 bits are for data.
> 
> This has nicely been hacked around, by defining a second regmap with a
> width of 16 bits, and effectively splitting a 32-bit register into 2
> 16-bit ones, from the perspective of this regmap_pushr.
> 
> The problem is the assumption about the controller's endianness. If the
> controller is little endian (such as anything post-LS1046A), then the
> first 2 bytes, in the order imposed by memory layout, will actually 
> hold
> the TXDATA, and the last 2 bytes will hold the CMD.
> 
> So take the controller's endianness into account when performing split
> writes to PUSHR. The obvious and simple solution would have been to 
> call
> regmap_get_val_endian(), but that is an internal regmap function and we
> don't want to change regmap just for this. Therefore, we define the
> offsets per-instantiation, in the devtype_data structure. This means
> that we have to know from the driver which controllers are big- and
> which are little-endian (which is fine, we do, but it makes the device
> tree binding itself a little redundant except for regmap_config).
> 
> This patch does not apply cleanly to stable trees, and a punctual fix 
> to
> the commit cannot be provided given this constraint of lack of access 
> to
> regmap_get_val_endian(). The per-SoC devtype_data structures (and
> therefore the premises to fix this bug) have been introduced only a few
> commits ago, in commit d35054010b57 ("spi: spi-fsl-dspi: Use specific
> compatible strings for all SoC instantiations")
> 
> Fixes: 58ba07ec79e6 ("spi: spi-fsl-dspi: Add support for XSPI mode 
> registers")
> Signed-off-by: Vladimir Oltean <vladimir.oltean-3arQi8VN3Tc@public.gmane.org>
> ---
>  drivers/spi/spi-fsl-dspi.c | 28 ++++++++++++++++++++++------
>  1 file changed, 22 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
> index 0ce26c1cbf62..a8e56abe20ac 100644
> --- a/drivers/spi/spi-fsl-dspi.c
> +++ b/drivers/spi/spi-fsl-dspi.c
> @@ -103,10 +103,6 @@
>  #define SPI_FRAME_BITS(bits)		SPI_CTAR_FMSZ((bits) - 1)
>  #define SPI_FRAME_EBITS(bits)		SPI_CTARE_FMSZE(((bits) - 1) >> 4)
> 
> -/* Register offsets for regmap_pushr */
> -#define PUSHR_CMD			0x0
> -#define PUSHR_TX			0x2
> -
>  #define DMA_COMPLETION_TIMEOUT		msecs_to_jiffies(3000)
> 
>  struct chip_data {
> @@ -124,6 +120,12 @@ struct fsl_dspi_devtype_data {
>  	u8			max_clock_factor;
>  	int			fifo_size;
>  	int			dma_bufsize;
> +	/*
> +	 * Offsets for CMD and TXDATA within SPI_PUSHR when accessed
> +	 * individually (in XSPI mode)
> +	 */
> +	int			pushr_cmd;
> +	int			pushr_tx;
>  };

Shouldn't this just read the "little-endian" property of the
device tree node? Like it worked before with regmap, which takes
the little-endian/big-endian property into account.

If I understand this correctly, this solution would mix the methods
how the IP endianess is determined. Eg. regmap_xx uses the
little-endian property and this driver then also uses the compatible
string to also distinguish between the endianess.

-michael

>  enum {
> @@ -150,42 +152,56 @@ static const struct fsl_dspi_devtype_data
> devtype_data[] = {
>  		.trans_mode		= DSPI_XSPI_MODE,
>  		.max_clock_factor	= 8,
>  		.fifo_size		= 4,
> +		.pushr_cmd		= 0,
> +		.pushr_tx		= 2,
>  	},
>  	[LS1012A] = {
>  		/* Has A-011218 DMA erratum */
>  		.trans_mode		= DSPI_XSPI_MODE,
>  		.max_clock_factor	= 8,
>  		.fifo_size		= 16,
> +		.pushr_cmd		= 0,
> +		.pushr_tx		= 2,
>  	},
>  	[LS1043A] = {
>  		/* Has A-011218 DMA erratum */
>  		.trans_mode		= DSPI_XSPI_MODE,
>  		.max_clock_factor	= 8,
>  		.fifo_size		= 16,
> +		.pushr_cmd		= 0,
> +		.pushr_tx		= 2,
>  	},
>  	[LS1046A] = {
>  		/* Has A-011218 DMA erratum */
>  		.trans_mode		= DSPI_XSPI_MODE,
>  		.max_clock_factor	= 8,
>  		.fifo_size		= 16,
> +		.pushr_cmd		= 0,
> +		.pushr_tx		= 2,
>  	},
>  	[LS2080A] = {
>  		.trans_mode		= DSPI_DMA_MODE,
>  		.dma_bufsize		= 8,
>  		.max_clock_factor	= 8,
>  		.fifo_size		= 4,
> +		.pushr_cmd		= 2,
> +		.pushr_tx		= 0,
>  	},
>  	[LS2085A] = {
>  		.trans_mode		= DSPI_DMA_MODE,
>  		.dma_bufsize		= 8,
>  		.max_clock_factor	= 8,
>  		.fifo_size		= 4,
> +		.pushr_cmd		= 2,
> +		.pushr_tx		= 0,
>  	},
>  	[LX2160A] = {
>  		.trans_mode		= DSPI_DMA_MODE,
>  		.dma_bufsize		= 8,
>  		.max_clock_factor	= 8,
>  		.fifo_size		= 4,
> +		.pushr_cmd		= 2,
> +		.pushr_tx		= 0,
>  	},
>  	[MCF5441X] = {
>  		.trans_mode		= DSPI_EOQ_MODE,
> @@ -670,12 +686,12 @@ static void dspi_pushr_cmd_write(struct fsl_dspi
> *dspi, u16 cmd)
>  	 */
>  	if (dspi->len > dspi->oper_word_size)
>  		cmd |= SPI_PUSHR_CMD_CONT;
> -	regmap_write(dspi->regmap_pushr, PUSHR_CMD, cmd);
> +	regmap_write(dspi->regmap_pushr, dspi->devtype_data->pushr_cmd, cmd);
>  }
> 
>  static void dspi_pushr_txdata_write(struct fsl_dspi *dspi, u16 txdata)
>  {
> -	regmap_write(dspi->regmap_pushr, PUSHR_TX, txdata);
> +	regmap_write(dspi->regmap_pushr, dspi->devtype_data->pushr_tx, 
> txdata);
>  }
> 
>  static void dspi_xspi_write(struct fsl_dspi *dspi, int cnt, bool eoq)
