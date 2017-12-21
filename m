From: Randy Dunlap <rdunlap-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Subject: Re: [PATCH] spi: Add a sysfs interface to instantiate devices
Date: Thu, 21 Dec 2017 12:11:23 -0800
Message-ID: <881b7381-0bba-70af-b4fe-24f0d388109e@infradead.org>
References: <20171221200309.17967-1-kyle.roeschley@ni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
To: Kyle Roeschley <kyle.roeschley-acOepvfBmUk@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171221200309.17967-1-kyle.roeschley-acOepvfBmUk@public.gmane.org>
Content-Language: en-US
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 12/21/2017 12:03 PM, Kyle Roeschley wrote:
> Add a sysfs interface to instantiate and delete SPI devices using the
> spidev driver. This can be used when developing a driver on a
> self-soldered board which doesn't yet have proper SPI device declaration
> at the platform level, and presumably for various debugging situations.
> 
> Inspired by 99cd8e25875a ("i2c: Add a sysfs interface to instantiate
> devices").
> 
> Signed-off-by: Kyle Roeschley <kyle.roeschley-acOepvfBmUk@public.gmane.org>
> ---
>  Documentation/spi/spi-summary | 14 ++++++++
>  drivers/spi/spi.c             | 78 +++++++++++++++++++++++++++++++++++++++++++
>  include/linux/spi/spi.h       |  3 ++
>  3 files changed, 95 insertions(+)
> 
> diff --git a/Documentation/spi/spi-summary b/Documentation/spi/spi-summary
> index 1721c1b570c3..51d9747c4426 100644
> --- a/Documentation/spi/spi-summary
> +++ b/Documentation/spi/spi-summary
> @@ -339,6 +339,20 @@ up the spi bus master, and will likely need spi_new_device() to provide the
>  board info based on the board that was hotplugged.  Of course, you'd later
>  call at least spi_unregister_device() when that board is removed.
>  
> +Alternatively, a sysfs interface was added to let the user create devices which

                                                                             when

> +using the spidev driver. This interface is made of 2 attribute files which are
> +created in every SPI master directory: new_device and delete_device. Both files
> +are write only and you must write the decimal SPI chip select number to them in

       write-only

> +order to properly instantiate or delete a SPI device. As no two devices can be
> +attached to the same master with the same chip select line, the chip select
> +number is sufficient to uniquely identify the device to be deleted.
> +
> +Example:
> +# echo 1 > /sys/class/spi_master/spi0/new_device
> +
> +In general, this interface should only be used when in-kernel device
> +declaration can't be done.
> +
>  When Linux includes support for MMC/SD/SDIO/DataFlash cards through SPI, those
>  configurations will also be dynamic.  Fortunately, such devices all support
>  basic device identification probes, so they should hotplug normally.

thanks.
-- 
~Randy
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
