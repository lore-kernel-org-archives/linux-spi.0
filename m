From: Mika Westerberg <mika.westerberg-X3B1VOXEql0@public.gmane.org>
Subject: Re: [PATCH] spi/ep93xx: clean probe/remove routines
Date: Thu, 19 Apr 2012 09:16:09 +0300
Message-ID: <20120419061609.GC18520@mwesterb-mobl.lan>
References: <1334752571-24627-1-git-send-email-hannuxx@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hannu Heikkinen <hannuxx-X3B1VOXEql0@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1334752571-24627-1-git-send-email-hannuxx-X3B1VOXEql0@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Wed, Apr 18, 2012 at 03:36:11PM +0300, Hannu Heikkinen wrote:
> Use devm_* functions for managing devres resources.
> 
> Also use local espi_irq and remove irq variable from
> struct ep93xx_spi.
> 
> Cc: mika.westerberg-X3B1VOXEql0@public.gmane.org
> Cc: grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org
> Signed-off-by: Hannu Heikkinen <hannuxx-X3B1VOXEql0@public.gmane.org>
> ---
>  drivers/spi/spi-ep93xx.c |   36 ++++++++++--------------------------
>  1 file changed, 10 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/spi/spi-ep93xx.c b/drivers/spi/spi-ep93xx.c
> index 6db2887..2c5fb81 100644
> --- a/drivers/spi/spi-ep93xx.c
> +++ b/drivers/spi/spi-ep93xx.c
> @@ -114,7 +114,6 @@ struct ep93xx_spi {
>  	struct clk			*clk;
>  	void __iomem			*regs_base;
>  	unsigned long			sspdr_phys;
> -	int				irq;
>  	unsigned long			min_rate;
>  	unsigned long			max_rate;
>  	bool				running;
> @@ -1035,6 +1034,7 @@ static int __devinit ep93xx_spi_probe(struct platform_device *pdev)
>  	struct ep93xx_spi_info *info;
>  	struct ep93xx_spi *espi;
>  	struct resource *res;
> +	int espi_irq;

Since you are going to make a new version of the patch anyway, can you rename
'espi_irq' to just plain 'irq'?

After that you can add my

Acked-by: Mika Westerberg <mika.westerberg-X3B1VOXEql0@public.gmane.org>

------------------------------------------------------------------------------
For Developers, A Lot Can Happen In A Second.
Boundary is the first to Know...and Tell You.
Monitor Your Applications in Ultra-Fine Resolution. Try it FREE!
http://p.sf.net/sfu/Boundary-d2dvs2
