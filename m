From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [PATCH 3/4] spi: s3c64xx: add gpio quirk for controller
Date: Thu, 7 Feb 2013 11:55:47 +0000
Message-ID: <20130207115546.GA3801@sirena.org.uk>
References: <1360105784-12282-1-git-send-email-ks.giri@samsung.com>
	<1360105784-12282-4-git-send-email-ks.giri@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Girish K S <girishks2000-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1360105784-12282-4-git-send-email-ks.giri-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Tue, Feb 05, 2013 at 03:09:43PM -0800, Girish K S wrote:
> This patch adds support for spi controllers with
> dedicated clk/miso/mosi/cs pins. It skips the gpio
> parsing and initialization for controllers that
> have dedicated pins.

>  		if (sdd->tgl_spi != spi) { /* if last mssg on diff device */
>  			/* Deselect the last toggled device */
>  			cs = sdd->tgl_spi->controller_data;
> -			gpio_set_value(cs->line,
> -				spi->mode & SPI_CS_HIGH ? 0 : 1);
> +			if (!(sdd->port_conf->quirks & S3C64XX_SPI_QUIRK_GPIO))
> +				gpio_set_value(cs->line,
> +					spi->mode & SPI_CS_HIGH ? 0 : 1);
>  		}

This isn't going to work with system designs which ignore the /CS line
the controller has and just use a GPIO instead.  This is very common,
for example when connecting multiple devices to the same SPI bus.

It seems like there's really two changes here.  One change is making the
provision of pinmux information optional, the other is allowing the user
to use the controller /CS management rather than using GPIO.

------------------------------------------------------------------------------
Free Next-Gen Firewall Hardware Offer
Buy your Sophos next-gen firewall before the end March 2013 
and get the hardware for free! Learn more.
http://p.sf.net/sfu/sophos-d2d-feb
