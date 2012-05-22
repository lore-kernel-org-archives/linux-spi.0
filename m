From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: of/spi: Supply proper "spi:" modalias prefixes.
Date: Tue, 22 May 2012 17:14:52 -0600
Message-ID: <20120522231452.4AB653E0793@localhost>
References: <1337726839-7710-1-git-send-email-ddaney.cavm@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, David Daney <david.daney-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
To: David Daney <ddaney.cavm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1337726839-7710-1-git-send-email-ddaney.cavm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Tue, 22 May 2012 15:47:19 -0700, David Daney <ddaney.cavm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> From: David Daney <david.daney-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
> 
> To get modprobe to automatically load the proper modules, we need to
> prefix things with "spi:".  Partially based on Grant Likely's suggestions.
> 
> Signed-off-by: David Daney <david.daney-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>

Applied, thanks.

g.

> ---
>  drivers/of/of_spi.c |    6 +++++-
>  drivers/spi/spi.c   |    2 +-
>  2 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/of/of_spi.c b/drivers/of/of_spi.c
> index 6dbc074..3486d2d 100644
> --- a/drivers/of/of_spi.c
> +++ b/drivers/of/of_spi.c
> @@ -25,6 +25,7 @@ void of_register_spi_devices(struct spi_master *master)
>  	struct spi_device *spi;
>  	struct device_node *nc;
>  	const __be32 *prop;
> +	char request_module_modalias[SPI_NAME_SIZE + 4];
>  	int rc;
>  	int len;
>  
> @@ -86,7 +87,10 @@ void of_register_spi_devices(struct spi_master *master)
>  		spi->dev.of_node = nc;
>  
>  		/* Register the new device */
> -		request_module(spi->modalias);
> +		snprintf(request_module_modalias,
> +			 sizeof(request_module_modalias),
> +			 "%s%s", SPI_MODULE_PREFIX, spi->modalias);
> +		request_module(request_module_modalias);
>  		rc = spi_add_device(spi);
>  		if (rc) {
>  			dev_err(&master->dev, "spi_device register error %s\n",
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index 3d8f662..da8aac7 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -51,7 +51,7 @@ modalias_show(struct device *dev, struct device_attribute *a, char *buf)
>  {
>  	const struct spi_device	*spi = to_spi_device(dev);
>  
> -	return sprintf(buf, "%s\n", spi->modalias);
> +	return sprintf(buf, "%s%s\n", SPI_MODULE_PREFIX, spi->modalias);
>  }
>  
>  static struct device_attribute spi_dev_attrs[] = {

-- 
Grant Likely, B.Sc, P.Eng.
Secret Lab Technologies, Ltd.

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
