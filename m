From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 1/4] hwmon: (lm70) Simplify show_name function
Date: Sun, 16 Sep 2012 15:09:01 +0200
Message-ID: <20120916150901.6df27a85@endymion.delvare>
References: <1347396773-32108-1-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	lm-sensors <lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
To: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1347396773-32108-1-git-send-email-linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi Guenter,

On Tue, 11 Sep 2012 13:52:50 -0700, Guenter Roeck wrote:
> Instead of using a switch statement to determine the device name, use
> to_spi_device(dev)->modalias to simplify the code and reduce module size.
> 
> Signed-off-by: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
> ---
>  drivers/hwmon/lm70.c |   21 +--------------------
>  1 file changed, 1 insertion(+), 20 deletions(-)
> 
> diff --git a/drivers/hwmon/lm70.c b/drivers/hwmon/lm70.c
> index 789753d..2d1777a 100644
> --- a/drivers/hwmon/lm70.c
> +++ b/drivers/hwmon/lm70.c
> @@ -124,26 +124,7 @@ static DEVICE_ATTR(temp1_input, S_IRUGO, lm70_sense_temp, NULL);
>  static ssize_t lm70_show_name(struct device *dev, struct device_attribute
>  			      *devattr, char *buf)
>  {
> -	struct lm70 *p_lm70 = dev_get_drvdata(dev);
> -	int ret;
> -
> -	switch (p_lm70->chip) {
> -	case LM70_CHIP_LM70:
> -		ret = sprintf(buf, "lm70\n");
> -		break;
> -	case LM70_CHIP_TMP121:
> -		ret = sprintf(buf, "tmp121\n");
> -		break;
> -	case LM70_CHIP_LM71:
> -		ret = sprintf(buf, "lm71\n");
> -		break;
> -	case LM70_CHIP_LM74:
> -		ret = sprintf(buf, "lm74\n");
> -		break;
> -	default:
> -		ret = -EINVAL;
> -	}
> -	return ret;
> +	return sprintf(buf, "%s\n", to_spi_device(dev)->modalias);
>  }

That's a very nice cleanup, but it makes me wonder...

Wouldn't it make sense to create the "name" attribute of spi devices at
the spi core level, as we do for i2c devices? All spi-based hwmon
drivers create the hwmon attributes as the spi device level, as is done
for i2c devices, so that would make no difference from a user-space
perspective. And this would avoid code redundancy.

If we don't want to do that, then let's offer drivers a nicer function
to retrieve the spi device name, e.g. spi_dev_name(). That way, the
internal implementation can change in the future without having to
update all drivers.

Grant, what do you think?

-- 
Jean Delvare

------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://ad.doubleclick.net/clk;258768047;13503038;j?
http://info.appdynamics.com/FreeJavaPerformanceDownload.html
