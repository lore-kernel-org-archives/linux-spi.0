From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH 3/6] SPI: S3C64XX: Debug status read
Date: Wed, 8 Sep 2010 22:56:49 -0600
Message-ID: <20100909045649.GE11833@angua.secretlab.ca>
References: <1OrKX4-0007cO-1K>
	<1283477806-31195-1-git-send-email-jassi.brar@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Jassi Brar <jassi.brar-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1283477806-31195-1-git-send-email-jassi.brar-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Fri, Sep 03, 2010 at 10:36:46AM +0900, Jassi Brar wrote:
> Instead of, wrongly, reusing the 'val' variable, use a dedicated
> one for reading the status register.
> 
> Signed-off-by: Jassi Brar <jassi.brar-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>

Applied to spi-merge, thanks.

g.

> ---
>  drivers/spi/spi_s3c64xx.c |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/spi/spi_s3c64xx.c b/drivers/spi/spi_s3c64xx.c
> index 12e7915..39816bb 100644
> --- a/drivers/spi/spi_s3c64xx.c
> +++ b/drivers/spi/spi_s3c64xx.c
> @@ -326,10 +326,11 @@ static int wait_for_xfer(struct s3c64xx_spi_driver_data *sdd,
>  		val = msecs_to_jiffies(ms) + 10;
>  		val = wait_for_completion_timeout(&sdd->xfer_completion, val);
>  	} else {
> +		u32 status;
>  		val = msecs_to_loops(ms);
>  		do {
> -			val = readl(regs + S3C64XX_SPI_STATUS);
> -		} while (RX_FIFO_LVL(val, sci) < xfer->len && --val);
> +			status = readl(regs + S3C64XX_SPI_STATUS);
> +		} while (RX_FIFO_LVL(status, sci) < xfer->len && --val);
>  	}
>  
>  	if (!val)
> -- 
> 1.6.2.5
> 

------------------------------------------------------------------------------
This SF.net Dev2Dev email is sponsored by:

Show off your parallel programming skills.
Enter the Intel(R) Threading Challenge 2010.
http://p.sf.net/sfu/intel-thread-sfd
