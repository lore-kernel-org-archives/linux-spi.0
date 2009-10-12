From: "H Hartley Sweeten" <hartleys-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>
Subject: Re: [PATCH] drivers/misc: add driver for
	TexasInstruments DAC7512
Date: Mon, 12 Oct 2009 12:31:46 -0400
Message-ID: <BD79186B4FD85F4B8E60E381CAEE190901DB7EF3@mi8nycmail19.Mi8.com>
References: <1254945665-28053-1-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>,
	David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
To: "Daniel Mack" <daniel-rDUAYElUppE@public.gmane.org>,
	<linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
In-Reply-To: <1254945665-28053-1-git-send-email-daniel-rDUAYElUppE@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Wednesday, October 07, 2009 1:01 PM, Daniel Mack wrote:
> This is actually too trivial to publish, but to export the function of
> that chip to the userspace, a module like this is needed.
> 
> Signed-off-by: Daniel Mack <daniel-rDUAYElUppE@public.gmane.org>
> Cc: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
> Cc: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
> Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> ---

[snip]

> +static ssize_t dac7512_store_val(struct device *dev,
> +				 struct device_attribute *attr,
> +				 const char *buf, size_t count)
> +{
> +	struct spi_device *spi = to_spi_device(dev);
> +	unsigned char tmp[2];
> +	unsigned long val;
> +
> +	if (strict_strtoul(buf, 10, &val) < 0)
> +		return -EINVAL;
> +
> +	tmp[0] = val >> 8;
> +	tmp[1] = val & 0xff;
> +	spi_write(spi, tmp, sizeof(tmp));
> +	return count;
> +}
> +
> +static DEVICE_ATTR(value, S_IWUSR | S_IRUGO,
> +		   NULL, dac7512_store_val);

You have declared the "value" device attribute with mode S_IWUSR | S_IRUGO
but have not provided a show callback.

Regards,
Hartley

------------------------------------------------------------------------------
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
