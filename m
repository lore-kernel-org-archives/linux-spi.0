From: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
Subject: Re: [PATCHv2 0/3] I2C and SPI dev_name change for ACPI enumerated slaves
Date: Fri, 01 Nov 2013 14:18:06 +0100
Message-ID: <1601125.4tFOPicoTX@vostro.rjw.lan>
References: <1382703540-3769-1-git-send-email-jarkko.nikula@linux.intel.com> <1383309356-25430-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1383309356-25430-1-git-send-email-jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Friday, November 01, 2013 02:35:53 PM Jarkko Nikula wrote:
> Hi
> 
> Second version of the set that changes I2C and SPI slave device names
> to be generated from stable ACPI device names on ACPI 5 based systems
> instead of using bus numbers which could change.
> 
> Slave device name change goes as
> 
> 	"x-00yz" -> "i2c-INTABCD:ij"
> 	"spix.y" -> "spi-INTABCD:ij"
> 
> This version adds patch to include/acpi/acpi_bus.h that allow us to
> remove #if IS_ENABLED(CONFIG_ACPI) checks that were added in the
> first version.
> 
> Set goes on top linux-pm/linux-next commit e56b4d2.
> 
> First version here:
> http://mailman.alsa-project.org/pipermail/alsa-devel/2013-October/067737.html
> 
> Jarkko Nikula (3):
>   ACPI: Expose struct acpi_device and acpi_bus_get_device() to non-ACPI
>     builds
>   i2c: Use stable dev_name for ACPI enumerated I2C slaves
>   spi: Use stable dev_name for ACPI enumerated SPI slaves
> 
>  drivers/i2c/i2c-core.c  | 24 ++++++++++++++++++++----
>  drivers/spi/spi.c       | 20 +++++++++++++++++---
>  include/acpi/acpi_bus.h |  9 +++++++--
>  3 files changed, 44 insertions(+), 9 deletions(-)

Looks good to me.  If there are no objections, I can merge these through my tree.

Thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
