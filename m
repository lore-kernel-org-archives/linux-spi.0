From: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/2] atmel/spi: fix missing probe
Date: Thu, 03 Nov 2011 18:50:31 +0100
Message-ID: <4EB2D467.7050901@gmail.com>
References: <1320342082-18573-1-git-send-email-plagnioj@jcrosoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Greg Kroah-Hartman <gregkh-l3A5Bk7waGM@public.gmane.org>,
	Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Jean-Christophe PLAGNIOL-VILLARD <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1320342082-18573-1-git-send-email-plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On 11/03/2011 06:41 PM, Jean-Christophe PLAGNIOL-VILLARD wrote:
> Commit 940ab889 "drivercore: Add helper macro for platform_driver boilerplate"
> converted this driver to use module_platform_driver, but due to the use
> of platform_driver_probe(), this resulted in the call to atmel_spi_probe being
> lost. Place the call to this function into the driver structure.
>
> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD<plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>
> Cc: Greg Kroah-Hartman<gregkh-l3A5Bk7waGM@public.gmane.org>
> Cc: Grant Likely<grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
> Cc: Russell King - ARM Linux<linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
> ---
> v3:
>
> 	update commit message
>   drivers/spi/spi-atmel.c |    1 +
>   1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
> index 79665e2..3cd4f49 100644
> --- a/drivers/spi/spi-atmel.c
> +++ b/drivers/spi/spi-atmel.c
> @@ -1072,6 +1072,7 @@ static struct platform_driver atmel_spi_driver = {
>   	},
>   	.suspend	= atmel_spi_suspend,
>   	.resume		= atmel_spi_resume,
> +	.prove		= atmel_spi_probe,
          ^^^^^

This is certainly a typo. Didn't you even compile-test this?



Daniel

------------------------------------------------------------------------------
RSA(R) Conference 2012
Save $700 by Nov 18
Register now
http://p.sf.net/sfu/rsa-sfdev2dev1
