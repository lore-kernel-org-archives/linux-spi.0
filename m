From: Esben Haabendal <esben.haabendal@gmail.com>
Subject: Re: [PATCH v2 3/4] spi: spi-fsl-dspi: Fix cmd_fifo is written before tx_fifo
Date: Sun, 30 Sep 2018 12:30:43 +0200
Message-ID: <87bm8f6zvw.fsf@gmail.com>
References: <20180930092535.24544-1-chuanhua.han@nxp.com>
        <20180930092535.24544-3-chuanhua.han@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: broonie@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, boris.brezillon@bootlin.com
To: Chuanhua Han <chuanhua.han@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180930092535.24544-3-chuanhua.han@nxp.com> (Chuanhua Han's
        message of "Sun, 30 Sep 2018 17:25:34 +0800")
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Chuanhua Han <chuanhua.han@nxp.com> writes:

> This patch fixes the problem of invalid data writing during the XSPI
> mode transfer of the dspi controller.
> In XSPI mode,When I executed TX FIFO first and then CMD FIFO for XSPI
> transmission, I found that SPIx_SR[TFIWF]=1(Invalid Data present in TX
> FIFO since CMD FIFO is empty).
> This is the time when no data can be read or written (all the data
> obtained is equal to 0).
>
> Signed-off-by: Chuanhua Han <chuanhua.han@nxp.com>
> ---
> Changes in v2:
>  -The original patch is divided into multiple patches(the original
> patch theme is "spi: spi-fsl-dspi: Fix support for XSPI transport
> mode"),one of which is segmented.
>
>  drivers/spi/spi-fsl-dspi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
> index 4dc1064bf408..96e790e90997 100644
> --- a/drivers/spi/spi-fsl-dspi.c
> +++ b/drivers/spi/spi-fsl-dspi.c
> @@ -590,6 +590,7 @@ static void dspi_tcfq_write(struct fsl_dspi *dspi)
>  		 */
>  		u32 data = dspi_pop_tx(dspi);
>  
> +		cmd_fifo_write(dspi);
>  		if (dspi->cur_chip->ctar_val & SPI_CTAR_LSBFE(1)) {
>  			/* LSB */
>  			tx_fifo_write(dspi, data & 0xFFFF);
> @@ -599,7 +600,6 @@ static void dspi_tcfq_write(struct fsl_dspi *dspi)
>  			tx_fifo_write(dspi, data >> 16);
>  			tx_fifo_write(dspi, data & 0xFFFF);
>  		}
> -		cmd_fifo_write(dspi);
>  	} else {
>  		/* Write one entry to both TX FIFO and CMD FIFO
>  		 * simultaneously.

I will try and find time to test this on our systems at work.

/Esben
