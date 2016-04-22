From: Purna Chandra Mandal <purna.mandal@microchip.com>
Subject: Re: [patch] spi: pic32-sqi: silence array overflow warning
Date: Fri, 22 Apr 2016 15:28:13 +0530
Message-ID: <5719F5B5.2030101@microchip.com>
References: <20160422095524.GB11398@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Cc: Mark Brown <broonie@kernel.org>, <linux-spi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
To: Dan Carpenter <dan.carpenter@oracle.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160422095524.GB11398@mwanda>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 04/22/2016 03:25 PM, Dan Carpenter wrote:

> We read one element beyond the end of the array when we access
> "rdesc[i + 1]" so it causes a static checker warning.  It's harmless
> because we write over it again on the next line.  But let's just silence
> the warning.
>
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>
> diff --git a/drivers/spi/spi-pic32-sqi.c b/drivers/spi/spi-pic32-sqi.c
> index b215347..74b9e68 100644
> --- a/drivers/spi/spi-pic32-sqi.c
> +++ b/drivers/spi/spi-pic32-sqi.c
> @@ -537,7 +537,7 @@ static int ring_desc_ring_alloc(struct pic32_sqi *sqi)
>  	}
>  
>  	/* Prepare BD: chain to next BD(s) */
> -	for (i = 0, rdesc = sqi->ring; i < PESQI_BD_COUNT; i++)
> +	for (i = 0, rdesc = sqi->ring; i < PESQI_BD_COUNT - 1; i++)
>  		bd[i].bd_nextp = rdesc[i + 1].bd_dma;
>  	bd[PESQI_BD_COUNT - 1].bd_nextp = 0;
>
Reviewed-by: Purna Chandra Mandal <purna.mandal@microchip.com>
