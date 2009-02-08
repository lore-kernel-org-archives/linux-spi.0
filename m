From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH] spi: limit reaches -1, tested 0
Date: Sun, 8 Feb 2009 09:26:54 -0800
Message-ID: <200902080926.56810.david-b@pacbell.net>
References: <498EE9C0.3010601@gmail.com>
	<200902080828.49036.david-b@pacbell.net>
	<498F0D64.4040909@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>,
	lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Roel Kluin <roel.kluin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <498F0D64.4040909-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Sunday 08 February 2009, Roel Kluin wrote:
> >>> -			while ((read(drv_data) == 0) && limit--);
> >>> +			while ((read(drv_data) == 0) && --limit);
> > 
> > ... although I wouldn't have resisted the urge to make the
> > loop body be "cpu_relax();" instead of an empty statement.
> 
> Ok,
> ---------------------------->8-------------------8<-----------------------------
> With a postfix decrement limit will reach -1 rather than 0, so the warning will
> not be issued.
> 
> Signed-off-by: Roel Kluin <roel.kluin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Still:

Acked-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>


> ---
> diff --git a/drivers/spi/spi_imx.c b/drivers/spi/spi_imx.c
> index 269a55e..15abe61 100644
> --- a/drivers/spi/spi_imx.c
> +++ b/drivers/spi/spi_imx.c
> @@ -779,7 +779,8 @@ static irqreturn_t interrupt_transfer(struct driver_data *drv_data)
>  
>  			/* Read trailing bytes */
>  			limit = loops_per_jiffy << 1;
> -			while ((read(drv_data) == 0) && limit--);
> +			while ((read(drv_data) == 0) && limit--)
> +				cpu_relax();
>  
>  			if (limit == 0)
>  				dev_err(&drv_data->pdev->dev,
> 
> 



------------------------------------------------------------------------------
Create and Deploy Rich Internet Apps outside the browser with Adobe(R)AIR(TM)
software. With Adobe AIR, Ajax developers can use existing skills and code to
build responsive, highly engaging applications that combine the power of local
resources and data with the reach of the web. Download the Adobe AIR SDK and
Ajax docs to start building applications today-http://p.sf.net/sfu/adobe-com
