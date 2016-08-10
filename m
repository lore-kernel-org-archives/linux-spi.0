From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH 3/3] lis3: SPI transport layer
Date: Wed, 10 Aug 2016 12:31:08 +0200
Message-ID: <CAMuHMdX-aX20QXMzKm5kxgCp+Bg+bYa-6+hNONy=rZ0MX4F2vA@mail.gmail.com>
References: <20090322234248.GG22927@buzzloop.caiaq.de> <1237765887-32672-1-git-send-email-daniel@caiaq.de>
 <1237765887-32672-2-git-send-email-daniel@caiaq.de> <1237765887-32672-3-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	=?UTF-8?Q?=C3=89ric_Piel?= <eric.piel-VkQ1JFuSMpfAbQlEx87xDw@public.gmane.org>,
	Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>,
	Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>,
	Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>,
	Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Daniel Mack <daniel-rDUAYElUppE@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1237765887-32672-3-git-send-email-daniel-rDUAYElUppE@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Daniel,

On Mon, Mar 23, 2009 at 12:51 AM, Daniel Mack <daniel-rDUAYElUppE@public.gmane.org> wrote:
> Make use of the new abstraction layer and add a new transport layer for
> spi. Works fine on a PXA based board.
>
> Signed-off-by: Daniel Mack <daniel-rDUAYElUppE@public.gmane.org>
> Acked-by: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
> Cc: Éric Piel <eric.piel-VkQ1JFuSMpfAbQlEx87xDw@public.gmane.org>
> Cc: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
> ---
>  drivers/hwmon/Kconfig         |   16 ++++++
>  drivers/hwmon/Makefile        |    1 +
>  drivers/hwmon/lis3lv02d_spi.c |  114 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 131 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/hwmon/lis3lv02d_spi.c
>
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index b84bf06..9d78ab4 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig

In the mean time, this has moved to drivers/misc/lis3lv02d/Kconfig

> @@ -895,6 +895,22 @@ config SENSORS_LIS3LV02D
>           Say Y here if you have an applicable laptop and want to experience
>           the awesome power of lis3lv02d.
>
> +config SENSORS_LIS3_SPI
> +       tristate "STMicroeletronics LIS3LV02Dx three-axis digital accelerometer (SPI)"
> +       depends on !ACPI && SPI_MASTER && INPUT

Is there any specific reason this option depends on !ACPI?
This hurts multi-platform kernels, supporting both OF and ACPI.

> +       default n
> +       help
> +         This driver provides support for the LIS3LV02Dx accelerometer connected
> +         via SPI. The accelerometer data is readable via
> +         /sys/devices/platform/lis3lv02d.
> +
> +         This driver also provides an absolute input class device, allowing
> +         the laptop to act as a pinball machine-esque joystick.
> +
> +         This driver can also be built as modules.  If so, the core module
> +         will be called lis3lv02d and a specific module for the SPI transport
> +         is called lis3lv02d_spi.
> +

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
