From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH 1/3] spi/bcm63xx: remove driver version
Date: Fri, 25 May 2012 16:59:52 -0600
Message-ID: <20120525225952.CFDCE3E0934@localhost>
References: <1337619960-9672-1-git-send-email-florian@openwrt.org>
	<1337619960-9672-2-git-send-email-florian@openwrt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Florian Fainelli <florian-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>, jonas.gorski-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
To: Florian Fainelli <florian-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1337619960-9672-2-git-send-email-florian-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Mon, 21 May 2012 19:05:58 +0200, Florian Fainelli <florian-p3rKhJxN3npAfugRpC6u6w@public.gmane.org> wrote:
> As Grant Likely reported, this does not make any sense in a mainline kernel
> remove that driver version string.
> 
> Reported-by: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
> Signed-off-by: Florian Fainelli <florian-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>

Applied, thanks.

g.

> ---
>  drivers/spi/spi-bcm63xx.c |    5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/spi/spi-bcm63xx.c b/drivers/spi/spi-bcm63xx.c
> index 7491971..478eddc 100644
> --- a/drivers/spi/spi-bcm63xx.c
> +++ b/drivers/spi/spi-bcm63xx.c
> @@ -36,7 +36,6 @@
>  #include <bcm63xx_dev_spi.h>
>  
>  #define PFX		KBUILD_MODNAME
> -#define DRV_VER		"0.1.2"
>  
>  struct bcm63xx_spi {
>  	struct completion	done;
> @@ -420,8 +419,8 @@ static int __devinit bcm63xx_spi_probe(struct platform_device *pdev)
>  		goto out_clk_disable;
>  	}
>  
> -	dev_info(dev, "at 0x%08x (irq %d, FIFOs size %d) v%s\n",
> -		 r->start, irq, bs->fifo_size, DRV_VER);
> +	dev_info(dev, "at 0x%08x (irq %d, FIFOs size %d)\n",
> +		 r->start, irq, bs->fifo_size);
>  
>  	return 0;
>  
> -- 
> 1.7.9.5
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
