From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH] spi: tegra: fix error setting on timeout
Date: Wed, 13 Oct 2010 19:50:55 -0600
Message-ID: <20101014015055.GH15286@angua.secretlab.ca>
References: <1287018998-14931-1-git-send-email-konkers@android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Erik Gilling <konkers-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1287018998-14931-1-git-send-email-konkers-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Wed, Oct 13, 2010 at 06:16:38PM -0700, Erik Gilling wrote:
> avoids derefencing an uninitialized pointer
> 
> Change-Id: Icf528441ae481e9f6f5ddc0be32c7c217fa49701
> Signed-off-by: Erik Gilling <konkers-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>

Acked-by: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>

> ---
>  drivers/spi/spi_tegra.c |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/spi/spi_tegra.c b/drivers/spi/spi_tegra.c
> index 0385fde..bb7df02 100644
> --- a/drivers/spi/spi_tegra.c
> +++ b/drivers/spi/spi_tegra.c
> @@ -338,15 +338,15 @@ static void tegra_spi_rx_dma_complete(struct tegra_dma_req *req)
>  
>  	spin_lock_irqsave(&tspi->lock, flags);
>  
> -	if (timeout >= 1000)
> -		m->status = -EIO;
> -
>  	val = spi_tegra_readl(tspi, SLINK_STATUS);
>  	val |= SLINK_RDY;
>  	spi_tegra_writel(tspi, val, SLINK_STATUS);
>  
> -
>  	m = list_first_entry(&tspi->queue, struct spi_message, queue);
> +
> +	if (timeout >= 1000)
> +		m->status = -EIO;
> +
>  	spi = m->state;
>  
>  	tspi->cur_pos += spi_tegra_drain_rx_fifo(tspi, tspi->cur);
> -- 
> 1.7.3.1.1.g1cf9a4
> 
> 
> ------------------------------------------------------------------------------
> Beautiful is writing same markup. Internet Explorer 9 supports
> standards for HTML5, CSS3, SVG 1.1,  ECMAScript5, and DOM L2 & L3.
> Spend less time writing and  rewriting code and more time creating great
> experiences on the web. Be a part of the beta today.
> http://p.sf.net/sfu/beautyoftheweb
> _______________________________________________
> spi-devel-general mailing list
> spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/spi-devel-general

------------------------------------------------------------------------------
Beautiful is writing same markup. Internet Explorer 9 supports
standards for HTML5, CSS3, SVG 1.1,  ECMAScript5, and DOM L2 & L3.
Spend less time writing and  rewriting code and more time creating great
experiences on the web. Be a part of the beta today.
http://p.sf.net/sfu/beautyoftheweb
