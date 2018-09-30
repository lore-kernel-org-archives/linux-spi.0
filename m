From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: Re: [PATCH v2 2/4] spi: spi-fsl-dspi: Fix delete the processing of
 undefined bitmask for rxdata
Date: Sun, 30 Sep 2018 12:06:59 +0200
Message-ID: <20180930120659.71b0e1e5@bbrezillon>
References: <20180930092535.24544-1-chuanhua.han@nxp.com>
        <20180930092535.24544-2-chuanhua.han@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: broonie@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, eha@deif.com
To: Chuanhua Han <chuanhua.han@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180930092535.24544-2-chuanhua.han@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Sun, 30 Sep 2018 17:25:33 +0800
Chuanhua Han <chuanhua.han@nxp.com> wrote:

> This patch fixes the problem of rxdata being equal to 0 during the XSPI
> mode transfer of the dspi controller.
> In XSPI mode, If it is not deleted, the value of rxdata will be equal
> to 0, and the data received will not be received correctly, causing the
> receiving transfer of the spi to fail.
> 
> Signed-off-by: Chuanhua Han <chuanhua.han@nxp.com>
> ---
> Changes in v2:
>  -The original patch is divided into multiple patches(the original
> patch theme is "spi: spi-fsl-dspi: Fix support for XSPI transport
> mode"),one of which is segmented.
> 
>  drivers/spi/spi-fsl-dspi.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
> index 3082e72e4f6c..4dc1064bf408 100644
> --- a/drivers/spi/spi-fsl-dspi.c
> +++ b/drivers/spi/spi-fsl-dspi.c
> @@ -243,9 +243,6 @@ static void dspi_push_rx(struct fsl_dspi *dspi, u32 rxdata)
>  	if (!dspi->rx)
>  		return;
>  
> -	/* Mask of undefined bits */
> -	rxdata &= (1 << dspi->bits_per_word) - 1;
> -

Why not

	if (dspi->bits_per_word)
		rxdata &= (1 << dspi->bits_per_word) - 1;

>  	if (dspi->bytes_per_word == 1)
>  		*(u8 *)dspi->rx = rxdata;
>  	else if (dspi->bytes_per_word == 2)
