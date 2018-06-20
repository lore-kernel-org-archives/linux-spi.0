From: =?UTF-8?Q?Martin_Hundeb=c3=b8ll?= <martin@geanix.com>
Subject: Re: [PATCH 01/12] spi: spi-fsl-dspi: Drop unreachable else if
 statement
Date: Wed, 20 Jun 2018 10:40:54 +0200
Message-ID: <84f8dca3-d1af-5190-270b-5f5319ae4987@geanix.com>
References: <20180620073442.20913-1-esben.haabendal@gmail.com>
 <20180620073442.20913-2-esben.haabendal@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Cc: Kurt Kanzenbach <kurt@linutronix.de>,
        Angelo Dureghello <angelo@sysam.it>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Sanchayan Maity <maitysanchayan@gmail.com>,
        Yuan Yao <yao.yuan@nxp.com>, linux-kernel@vger.kernel.org,
        Esben Haabendal <eha@deif.com>
To: Esben Haabendal <esben.haabendal@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180620073442.20913-2-esben.haabendal@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org



On 2018-06-20 09:34, Esben Haabendal wrote:
> From: Esben Haabendal <eha@deif.com>
> 
> The if statement just above this if/else statement triggers on the same
> condition, and then invalidates it.
> 
> Signed-off-by: Esben Haabendal <eha@deif.com>
> Cc: Martin Hundebøll <martin@geanix.com>

For the entire series:
Acked-by: Martin Hundebøll <martin@geanix.com>

> ---
>   drivers/spi/spi-fsl-dspi.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
> index 0630962ce442..3ca9b9608801 100644
> --- a/drivers/spi/spi-fsl-dspi.c
> +++ b/drivers/spi/spi-fsl-dspi.c
> @@ -593,8 +593,7 @@ static int dspi_eoq_write(struct fsl_dspi *dspi)
>   			dspi_pushr |= SPI_PUSHR_EOQ;
>   			if ((dspi->cs_change) && (!dspi->len))
>   				dspi_pushr &= ~SPI_PUSHR_CONT;
> -		} else if (tx_word && (dspi->len == 1))
> -			dspi_pushr |= SPI_PUSHR_EOQ;
> +		}
>   
>   		regmap_write(dspi->regmap, SPI_PUSHR, dspi_pushr);
>   
> 

-- 
Kind regards,
Martin Hundebøll
Embedded Linux Consultant

+45 61 65 54 61
martin@geanix.com

Geanix IVS
DK39600706
