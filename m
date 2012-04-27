From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH 2/6] spi: spi-bfin-sport: move word length setup to
	transfer handler
Date: Fri, 27 Apr 2012 12:21:15 -0600
Message-ID: <20120427182115.54C223E171B@localhost>
References: <1335219493-24184-1-git-send-email-scott.jiang.linux@gmail.com>
	<1335219493-24184-2-git-send-email-scott.jiang.linux@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Scott Jiang <scott.jiang.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Scott Jiang <scott.jiang.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1335219493-24184-2-git-send-email-scott.jiang.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Mon, 23 Apr 2012 18:18:09 -0400, Scott Jiang <scott.jiang.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> Each transfer may have its own bits per word.
> 
> Signed-off-by: Scott Jiang <scott.jiang.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Applied, thanks.

g.

> ---
>  drivers/spi/spi-bfin-sport.c |    7 +++----
>  1 files changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/spi/spi-bfin-sport.c b/drivers/spi/spi-bfin-sport.c
> index 248a2cc..bfd9047 100644
> --- a/drivers/spi/spi-bfin-sport.c
> +++ b/drivers/spi/spi-bfin-sport.c
> @@ -252,19 +252,15 @@ static void
>  bfin_sport_spi_restore_state(struct bfin_sport_spi_master_data *drv_data)
>  {
>  	struct bfin_sport_spi_slave_data *chip = drv_data->cur_chip;
> -	unsigned int bits = (drv_data->ops == &bfin_sport_transfer_ops_u8 ? 7 : 15);
>  
>  	bfin_sport_spi_disable(drv_data);
>  	dev_dbg(drv_data->dev, "restoring spi ctl state\n");
>  
>  	bfin_write(&drv_data->regs->tcr1, chip->ctl_reg);
> -	bfin_write(&drv_data->regs->tcr2, bits);
>  	bfin_write(&drv_data->regs->tclkdiv, chip->baud);
> -	bfin_write(&drv_data->regs->tfsdiv, bits);
>  	SSYNC();
>  
>  	bfin_write(&drv_data->regs->rcr1, chip->ctl_reg & ~(ITCLK | ITFS));
> -	bfin_write(&drv_data->regs->rcr2, bits);
>  	SSYNC();
>  
>  	bfin_sport_spi_cs_active(chip);
> @@ -425,6 +421,9 @@ bfin_sport_spi_pump_transfers(unsigned long data)
>  		drv_data->ops = &bfin_sport_transfer_ops_u8;
>  	else
>  		drv_data->ops = &bfin_sport_transfer_ops_u16;
> +	bfin_write(&drv_data->regs->tcr2, bits_per_word - 1);
> +	bfin_write(&drv_data->regs->tfsdiv, bits_per_word - 1);
> +	bfin_write(&drv_data->regs->rcr2, bits_per_word - 1);
>  
>  	drv_data->state = RUNNING_STATE;
>  
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
