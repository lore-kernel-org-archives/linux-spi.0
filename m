From: Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: RE: [PATCH] spi/s3c64xx: Drop extra calls to spi_master_get in
	suspend/remove functions
Date: Thu, 23 Aug 2012 14:40:45 +0900
Message-ID: <1d0b01cd80f1$d77eaf90$867c0eb0$%kim@samsung.com>
References: <1345173265-1721-1-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	'Mark Brown' <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>,
	'Thomas Abraham' <thomas.abraham-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	'Ben Dooks' <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: 'Guenter Roeck' <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-reply-to: <1345173265-1721-1-git-send-email-linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Content-language: ko
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Guenter Roeck wrote:
> 
> Suspend and resume functions call spi_master_get() without matching
> spi_master_put(). The extra references are unnecessary and cause
> subsequent
> module unload attempts to fail. Drop the calls.
> 
> Signed-off-by: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>

Acked-by: Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>

(Cc'ed Mark Brown who is handling spi now)

Guenter, maybe you need to re-send this patch to Mark so that he can apply
;-)

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

> ---
>  drivers/spi/spi-s3c64xx.c |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
> index 646a765..d7a87df 100644
> --- a/drivers/spi/spi-s3c64xx.c
> +++ b/drivers/spi/spi-s3c64xx.c
> @@ -1409,7 +1409,7 @@ static int s3c64xx_spi_remove(struct platform_device
> *pdev)
>  #ifdef CONFIG_PM
>  static int s3c64xx_spi_suspend(struct device *dev)
>  {
> -	struct spi_master *master = spi_master_get(dev_get_drvdata(dev));
> +	struct spi_master *master = dev_get_drvdata(dev);
>  	struct s3c64xx_spi_driver_data *sdd =
> spi_master_get_devdata(master);
> 
>  	spi_master_suspend(master);
> @@ -1428,7 +1428,7 @@ static int s3c64xx_spi_suspend(struct device *dev)
> 
>  static int s3c64xx_spi_resume(struct device *dev)
>  {
> -	struct spi_master *master = spi_master_get(dev_get_drvdata(dev));
> +	struct spi_master *master = dev_get_drvdata(dev);
>  	struct s3c64xx_spi_driver_data *sdd =
> spi_master_get_devdata(master);
>  	struct s3c64xx_spi_info *sci = sdd->cntrlr_info;
> 
> @@ -1452,7 +1452,7 @@ static int s3c64xx_spi_resume(struct device *dev)
>  #ifdef CONFIG_PM_RUNTIME
>  static int s3c64xx_spi_runtime_suspend(struct device *dev)
>  {
> -	struct spi_master *master = spi_master_get(dev_get_drvdata(dev));
> +	struct spi_master *master = dev_get_drvdata(dev);
>  	struct s3c64xx_spi_driver_data *sdd =
> spi_master_get_devdata(master);
> 
>  	clk_disable(sdd->clk);
> @@ -1463,7 +1463,7 @@ static int s3c64xx_spi_runtime_suspend(struct device
> *dev)
> 
>  static int s3c64xx_spi_runtime_resume(struct device *dev)
>  {
> -	struct spi_master *master = spi_master_get(dev_get_drvdata(dev));
> +	struct spi_master *master = dev_get_drvdata(dev);
>  	struct s3c64xx_spi_driver_data *sdd =
> spi_master_get_devdata(master);
> 
>  	clk_enable(sdd->src_clk);
> --
> 1.7.9.7


------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
