From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH 2/2] spi/bfin_spi: return immediately after skipping to
	next transfer
Date: Tue, 15 Feb 2011 15:06:28 -0700
Message-ID: <20110215220628.GD28005@angua.secretlab.ca>
References: <1294762748-25122-1-git-send-email-vapier@gentoo.org>
	<1294762748-25122-2-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>,
	uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
To: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1294762748-25122-2-git-send-email-vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Tue, Jan 11, 2011 at 11:19:08AM -0500, Mike Frysinger wrote:
> From: Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
> 
> If there is an error with setting up a transfer, we need to return
> immediately rather than trying to continue to process things.  We
> already set up the error states for the caller at this point.
> 
> Signed-off-by: Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
> Signed-off-by: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>

Applied, thanks.

g.

> ---
>  drivers/spi/spi_bfin5xx.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/spi/spi_bfin5xx.c b/drivers/spi/spi_bfin5xx.c
> index e8d68b7..a284624 100644
> --- a/drivers/spi/spi_bfin5xx.c
> +++ b/drivers/spi/spi_bfin5xx.c
> @@ -653,6 +653,7 @@ static void bfin_spi_pump_transfers(unsigned long data)
>  		message->state = bfin_spi_next_transfer(drv_data);
>  		/* Schedule next transfer tasklet */
>  		tasklet_schedule(&drv_data->pump_transfers);
> +		return;
>  	}
>  
>  	if (transfer->tx_buf != NULL) {
> -- 
> 1.7.4.rc1
> 

------------------------------------------------------------------------------
The ultimate all-in-one performance toolkit: Intel(R) Parallel Studio XE:
Pinpoint memory and threading errors before they happen.
Find and fix more than 250 security defects in the development cycle.
Locate bottlenecks in serial and parallel code that limit performance.
http://p.sf.net/sfu/intel-dev2devfeb
