From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH 4/6] spi/spi_bfin_sport: drop bits_per_word from client
	data
Date: Fri, 27 Apr 2012 12:21:51 -0600
Message-ID: <20120427182151.34FE33E171B@localhost>
References: <1335219493-24184-1-git-send-email-scott.jiang.linux@gmail.com>
	<1335219493-24184-4-git-send-email-scott.jiang.linux@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Scott Jiang <scott.jiang.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
To: Scott Jiang <scott.jiang.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1335219493-24184-4-git-send-email-scott.jiang.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Mon, 23 Apr 2012 18:18:11 -0400, Scott Jiang <scott.jiang.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> Since the member was dropped from the common Blackfin header, we need
> to stop using it in the SPORT driver too.
> 
> Signed-off-by: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
> Signed-off-by: Scott Jiang <scott.jiang.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Applied, thanks

g.

> ---
>  drivers/spi/spi-bfin-sport.c |   14 ++++++++------
>  1 files changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/spi/spi-bfin-sport.c b/drivers/spi/spi-bfin-sport.c
> index bfd9047..1fe5119 100644
> --- a/drivers/spi/spi-bfin-sport.c
> +++ b/drivers/spi/spi-bfin-sport.c
> @@ -416,11 +416,12 @@ bfin_sport_spi_pump_transfers(unsigned long data)
>  	drv_data->cs_change = transfer->cs_change;
>  
>  	/* Bits per word setup */
> -	bits_per_word = transfer->bits_per_word ? : message->spi->bits_per_word;
> -	if (bits_per_word == 8)
> -		drv_data->ops = &bfin_sport_transfer_ops_u8;
> -	else
> +	bits_per_word = transfer->bits_per_word ? :
> +		message->spi->bits_per_word ? : 8;
> +	if (bits_per_word % 16 == 0)
>  		drv_data->ops = &bfin_sport_transfer_ops_u16;
> +	else
> +		drv_data->ops = &bfin_sport_transfer_ops_u8;
>  	bfin_write(&drv_data->regs->tcr2, bits_per_word - 1);
>  	bfin_write(&drv_data->regs->tfsdiv, bits_per_word - 1);
>  	bfin_write(&drv_data->regs->rcr2, bits_per_word - 1);
> @@ -597,11 +598,12 @@ bfin_sport_spi_setup(struct spi_device *spi)
>  			}
>  			chip->cs_chg_udelay = chip_info->cs_chg_udelay;
>  			chip->idle_tx_val = chip_info->idle_tx_val;
> -			spi->bits_per_word = chip_info->bits_per_word;
>  		}
>  	}
>  
> -	if (spi->bits_per_word != 8 && spi->bits_per_word != 16) {
> +	if (spi->bits_per_word % 8) {
> +		dev_err(&spi->dev, "%d bits_per_word is not supported\n",
> +				spi->bits_per_word);
>  		ret = -EINVAL;
>  		goto error;
>  	}
> -- 
> 1.7.0.4
> 
> 

-- 
Grant Likely, B.Sc, P.Eng.
Secret Lab Technologies, Ltd.

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
