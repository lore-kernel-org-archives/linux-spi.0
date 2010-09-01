From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH] spi/dw_spi: clean the cs_control code
Date: Wed, 1 Sep 2010 09:07:57 -0600
Message-ID: <20100901150757.GA13421@angua.secretlab.ca>
References: <1283319359-16297-1-git-send-email-feng.tang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	George Shore <george-ofzTHo7+kyPpQY4QmZNtDQ@public.gmane.org>,
	David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
To: Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1283319359-16297-1-git-send-email-feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi Feng,

On Wed, Sep 01, 2010 at 01:35:59PM +0800, Feng Tang wrote:
> commit 052dc7c45 introduced cs_control code,

Be friendly to mere-mortals.  You should quote the patch title "spi/dw_spi:
conditional transfer mode changes" in addition to the sha1 id.

> which has a bug in setting
> transfer mode,

It would be helpful if you explained what the bug is.

> also it forces devices who don't need cs_control to
> re-configured the control registers. This patch will fix them
> 
> Signed-off-by: Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Cc: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
> Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
> Cc: George Shore <george-ofzTHo7+kyPpQY4QmZNtDQ@public.gmane.org>
> ---
>  drivers/spi/dw_spi.c       |   17 +++++------------
>  include/linux/spi/dw_spi.h |    3 +++
>  2 files changed, 8 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/spi/dw_spi.c b/drivers/spi/dw_spi.c
> index d256cb0..4b75a81 100644
> --- a/drivers/spi/dw_spi.c
> +++ b/drivers/spi/dw_spi.c
> @@ -181,10 +181,6 @@ static void flush(struct dw_spi *dws)
>  	wait_till_not_busy(dws);
>  }
>  
> -static void null_cs_control(u32 command)
> -{
> -}
> -
>  static int null_writer(struct dw_spi *dws)
>  {
>  	u8 n_bytes = dws->n_bytes;
> @@ -322,7 +318,7 @@ static void giveback(struct dw_spi *dws)
>  					struct spi_transfer,
>  					transfer_list);
>  
> -	if (!last_transfer->cs_change)
> +	if (!last_transfer->cs_change && dws->cs_control)
>  		dws->cs_control(MRST_SPI_DEASSERT);
>  
>  	msg->state = NULL;
> @@ -544,13 +540,13 @@ static void pump_transfers(unsigned long data)
>  	 */
>  	if (dws->cs_control) {
>  		if (dws->rx && dws->tx)
> -			chip->tmode = 0x00;
> +			chip->tmode = SPI_TMOD_TR;
>  		else if (dws->rx)
> -			chip->tmode = 0x02;
> +			chip->tmode = SPI_TMOD_RO;
>  		else
> -			chip->tmode = 0x01;
> +			chip->tmode = SPI_TMOD_TO;
>  
> -		cr0 &= ~(0x3 << SPI_MODE_OFFSET);
> +		cr0 &= ~SPI_TMOD_MASK;
>  		cr0 |= (chip->tmode << SPI_TMOD_OFFSET);

Changing these values isn't mentioned in the patch description.  I assume this is not the bug fix because the #defines are the same values.

>  	}
>  
> @@ -699,9 +695,6 @@ static int dw_spi_setup(struct spi_device *spi)
>  		chip = kzalloc(sizeof(struct chip_data), GFP_KERNEL);
>  		if (!chip)
>  			return -ENOMEM;
> -
> -		chip->cs_control = null_cs_control;
> -		chip->enable_dma = 0;
>  	}
>  
>  	/*
> diff --git a/include/linux/spi/dw_spi.h b/include/linux/spi/dw_spi.h
> index cc813f9..cc9ded3 100644
> --- a/include/linux/spi/dw_spi.h
> +++ b/include/linux/spi/dw_spi.h
> @@ -12,9 +12,12 @@
>  #define SPI_FRF_RESV			0x3
>  
>  #define SPI_MODE_OFFSET			6
> +#define SPI_MODE_MASK			(0x3 << SPI_MODE_OFFSET)

SPI_MODE_MASK is unused.

>  #define SPI_SCPH_OFFSET			6
>  #define SPI_SCOL_OFFSET			7
> +
>  #define SPI_TMOD_OFFSET			8
> +#define SPI_TMOD_MASK			(0x3 << SPI_TMOD_OFFSET)
>  #define	SPI_TMOD_TR			0x0		/* xmit & recv */
>  #define SPI_TMOD_TO			0x1		/* xmit only */
>  #define SPI_TMOD_RO			0x2		/* recv only */
> -- 
> 1.7.0.4
> 

------------------------------------------------------------------------------
This SF.net Dev2Dev email is sponsored by:

Show off your parallel programming skills.
Enter the Intel(R) Threading Challenge 2010.
http://p.sf.net/sfu/intel-thread-sfd
