From: Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 4/9] arm/pxa2xx: reorgazine SSP and SPI header files
Date: Wed, 24 Nov 2010 22:03:53 +0800
Message-ID: <AANLkTinBFQZkuH4haeQAZQv8p0WZN5uh4xJj53sjUGTt@mail.gmail.com>
References: <1290597207-29838-1-git-send-email-bigeasy@linutronix.de>
	<1290597207-29838-5-git-send-email-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
	linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, sodaville-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org,
	Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1290597207-29838-5-git-send-email-bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Wed, Nov 24, 2010 at 7:13 PM, Sebastian Andrzej Siewior
<bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org> wrote:
> The PXA-SPI driver relies on some files / defines which are arm specific
> and are within the ARM tree. The CE4100 SoC which is x86 has also the
> SPI core.
> This patch moves the ssp and spi files from arm/mach-pxa and plat-pxa to
> include/linux where the CE4100 can access them.
>
> This move got verified by building the following defconfigs:
> =A0 cm_x2xx_defconfig corgi_defconfig em_x270_defconfig ezx_defconfig
> =A0 imote2_defconfig pxa3xx_defconfig spitz_defconfig zeus_defconfig
> =A0 raumfeld_defconfig magician_defconfig
>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
> Signed-off-by: Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
> =A0Documentation/spi/pxa2xx =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 | =A0 =A04 ++--
> =A0arch/arm/mach-pxa/cm-x255.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0| =A0 =A02 +-
> =A0arch/arm/mach-pxa/cm-x270.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0| =A0 =A02 +-
> =A0arch/arm/mach-pxa/corgi.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0| =A0 =A02 +-
> =A0arch/arm/mach-pxa/devices.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0| =A0 =A02 +-
> =A0arch/arm/mach-pxa/em-x270.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0| =A0 =A02 +-
> =A0arch/arm/mach-pxa/hx4700.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 | =A0 =A02 +-
> =A0arch/arm/mach-pxa/icontrol.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 | =A0 =A02 +-
> =A0arch/arm/mach-pxa/littleton.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0| =A0 =A02 +-
> =A0arch/arm/mach-pxa/lubbock.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0| =A0 =A02 +-
> =A0arch/arm/mach-pxa/pcm027.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 | =A0 =A02 +-
> =A0arch/arm/mach-pxa/poodle.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 | =A0 =A02 +-
> =A0arch/arm/mach-pxa/spitz.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0| =A0 =A03 +--
> =A0arch/arm/mach-pxa/stargate2.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0| =A0 =A02 +-
> =A0arch/arm/mach-pxa/tosa.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 | =A0 =A02 +-
> =A0arch/arm/mach-pxa/trizeps4.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 | =A0 =A01 -
> =A0arch/arm/mach-pxa/z2.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 | =A0 =A02 +-
> =A0arch/arm/mach-pxa/zeus.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 | =A0 =A02 +-
> =A0arch/arm/plat-pxa/ssp.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0| =A0 =A02 +-
> =A0drivers/spi/pxa2xx_spi.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 | =A0 =A04 +---
> =A0.../plat/ssp.h =3D> include/linux/pxa2xx_ssp.h =A0 =A0 =A0 | =A0 =A08 =
++++----
> =A0.../mach =3D> include/linux/spi}/pxa2xx_spi.h =A0 =A0 =A0 =A0| =A0 =A0=
8 +++++---
> =A0sound/soc/pxa/pxa-ssp.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0| =A0 =A02 +-
> =A023 files changed, 30 insertions(+), 32 deletions(-)
> =A0rename arch/arm/plat-pxa/include/plat/ssp.h =3D> include/linux/pxa2xx_=
ssp.h (98%)
> =A0rename {arch/arm/mach-pxa/include/mach =3D> include/linux/spi}/pxa2xx_=
spi.h (92%)
>
> diff --git a/Documentation/spi/pxa2xx b/Documentation/spi/pxa2xx
> index 6bb916d..68a4fe3 100644
> --- a/Documentation/spi/pxa2xx
> +++ b/Documentation/spi/pxa2xx
> @@ -19,7 +19,7 @@ Declaring PXA2xx Master Controllers
> =A0-----------------------------------
> =A0Typically a SPI master is defined in the arch/.../mach-*/board-*.c as a
> =A0"platform device". =A0The master configuration is passed to the driver=
 via a table
> -found in arch/arm/mach-pxa/include/mach/pxa2xx_spi.h:
> +found in include/linux/spi/pxa2xx_spi.h:
>
> =A0struct pxa2xx_spi_master {
> =A0 =A0 =A0 =A0enum pxa_ssp_type ssp_type;
> @@ -94,7 +94,7 @@ using the "spi_board_info" structure found in "linux/sp=
i/spi.h". See
>
> =A0Each slave device attached to the PXA must provide slave specific conf=
iguration
> =A0information via the structure "pxa2xx_spi_chip" found in
> -"arch/arm/mach-pxa/include/mach/pxa2xx_spi.h". =A0The pxa2xx_spi master =
controller driver
> +"include/linux/spi/pxa2xx_spi.h". =A0The pxa2xx_spi master controller dr=
iver
> =A0will uses the configuration whenever the driver communicates with the =
slave
> =A0device. All fields are optional.
>
> diff --git a/arch/arm/mach-pxa/cm-x255.c b/arch/arm/mach-pxa/cm-x255.c
> index f1a7703..93f59f8 100644
> --- a/arch/arm/mach-pxa/cm-x255.c
> +++ b/arch/arm/mach-pxa/cm-x255.c
> @@ -17,13 +17,13 @@
> =A0#include <linux/mtd/nand-gpio.h>
>
> =A0#include <linux/spi/spi.h>
> +#include <linux/spi/pxa2xx_spi.h>
>
> =A0#include <asm/mach/arch.h>
> =A0#include <asm/mach-types.h>
> =A0#include <asm/mach/map.h>
>
> =A0#include <mach/pxa25x.h>
> -#include <mach/pxa2xx_spi.h>
>
> =A0#include "generic.h"
>
> diff --git a/arch/arm/mach-pxa/cm-x270.c b/arch/arm/mach-pxa/cm-x270.c
> index a9926bb..b88d601 100644
> --- a/arch/arm/mach-pxa/cm-x270.c
> +++ b/arch/arm/mach-pxa/cm-x270.c
> @@ -19,12 +19,12 @@
> =A0#include <video/mbxfb.h>
>
> =A0#include <linux/spi/spi.h>
> +#include <linux/spi/pxa2xx_spi.h>
> =A0#include <linux/spi/libertas_spi.h>
>
> =A0#include <mach/pxa27x.h>
> =A0#include <mach/ohci.h>
> =A0#include <mach/mmc.h>
> -#include <mach/pxa2xx_spi.h>
>
> =A0#include "generic.h"
>
> diff --git a/arch/arm/mach-pxa/corgi.c b/arch/arm/mach-pxa/corgi.c
> index 821229a..3b8dcac 100644
> --- a/arch/arm/mach-pxa/corgi.c
> +++ b/arch/arm/mach-pxa/corgi.c
> @@ -28,6 +28,7 @@
> =A0#include <linux/spi/spi.h>
> =A0#include <linux/spi/ads7846.h>
> =A0#include <linux/spi/corgi_lcd.h>
> +#include <linux/spi/pxa2xx_spi.h>
> =A0#include <linux/mtd/sharpsl.h>
> =A0#include <linux/input/matrix_keypad.h>
> =A0#include <video/w100fb.h>
> @@ -48,7 +49,6 @@
> =A0#include <mach/irda.h>
> =A0#include <mach/mmc.h>
> =A0#include <mach/udc.h>
> -#include <mach/pxa2xx_spi.h>
> =A0#include <mach/corgi.h>
> =A0#include <mach/sharpsl_pm.h>
>
> diff --git a/arch/arm/mach-pxa/devices.c b/arch/arm/mach-pxa/devices.c
> index aaa1166..c4f9c71 100644
> --- a/arch/arm/mach-pxa/devices.c
> +++ b/arch/arm/mach-pxa/devices.c
> @@ -3,6 +3,7 @@
> =A0#include <linux/init.h>
> =A0#include <linux/platform_device.h>
> =A0#include <linux/dma-mapping.h>
> +#include <linux/spi/pxa2xx_spi.h>
>
> =A0#include <asm/pmu.h>
> =A0#include <mach/udc.h>
> @@ -12,7 +13,6 @@
> =A0#include <mach/irda.h>
> =A0#include <mach/ohci.h>
> =A0#include <plat/pxa27x_keypad.h>
> -#include <mach/pxa2xx_spi.h>
> =A0#include <mach/camera.h>
> =A0#include <mach/audio.h>
> =A0#include <mach/hardware.h>
> diff --git a/arch/arm/mach-pxa/em-x270.c b/arch/arm/mach-pxa/em-x270.c
> index ed0dbfdb..b20b944 100644
> --- a/arch/arm/mach-pxa/em-x270.c
> +++ b/arch/arm/mach-pxa/em-x270.c
> @@ -26,6 +26,7 @@
> =A0#include <linux/spi/spi.h>
> =A0#include <linux/spi/tdo24m.h>
> =A0#include <linux/spi/libertas_spi.h>
> +#include <linux/spi/pxa2xx_spi.h>
> =A0#include <linux/power_supply.h>
> =A0#include <linux/apm-emulation.h>
> =A0#include <linux/i2c.h>
> @@ -46,7 +47,6 @@
> =A0#include <plat/pxa27x_keypad.h>
> =A0#include <plat/i2c.h>
> =A0#include <mach/camera.h>
> -#include <mach/pxa2xx_spi.h>
>
> =A0#include "generic.h"
> =A0#include "devices.h"
> diff --git a/arch/arm/mach-pxa/hx4700.c b/arch/arm/mach-pxa/hx4700.c
> index 76d93a2..f09526f 100644
> --- a/arch/arm/mach-pxa/hx4700.c
> +++ b/arch/arm/mach-pxa/hx4700.c
> @@ -33,6 +33,7 @@
> =A0#include <linux/regulator/max1586.h>
> =A0#include <linux/spi/ads7846.h>
> =A0#include <linux/spi/spi.h>
> +#include <linux/spi/pxa2xx_spi.h>
> =A0#include <linux/usb/gpio_vbus.h>
>
> =A0#include <mach/hardware.h>
> @@ -43,7 +44,6 @@
> =A0#include <mach/hx4700.h>
> =A0#include <plat/i2c.h>
> =A0#include <mach/irda.h>
> -#include <mach/pxa2xx_spi.h>
>
> =A0#include <video/platform_lcd.h>
> =A0#include <video/w100fb.h>
> diff --git a/arch/arm/mach-pxa/icontrol.c b/arch/arm/mach-pxa/icontrol.c
> index d51ee3d..3ab6fd3 100644
> --- a/arch/arm/mach-pxa/icontrol.c
> +++ b/arch/arm/mach-pxa/icontrol.c
> @@ -24,7 +24,7 @@
> =A0#include <mach/mxm8x10.h>
>
> =A0#include <linux/spi/spi.h>
> -#include <mach/pxa2xx_spi.h>
> +#include <linux/spi/pxa2xx_spi.h>
> =A0#include <linux/can/platform/mcp251x.h>
>
> =A0#include "generic.h"
> diff --git a/arch/arm/mach-pxa/littleton.c b/arch/arm/mach-pxa/littleton.c
> index 41aa89e..8051925 100644
> --- a/arch/arm/mach-pxa/littleton.c
> +++ b/arch/arm/mach-pxa/littleton.c
> @@ -22,6 +22,7 @@
> =A0#include <linux/clk.h>
> =A0#include <linux/gpio.h>
> =A0#include <linux/spi/spi.h>
> +#include <linux/spi/pxa2xx_spi.h>
> =A0#include <linux/smc91x.h>
> =A0#include <linux/i2c.h>
> =A0#include <linux/leds.h>
> @@ -42,7 +43,6 @@
> =A0#include <mach/pxa300.h>
> =A0#include <mach/pxafb.h>
> =A0#include <mach/mmc.h>
> -#include <mach/pxa2xx_spi.h>
> =A0#include <plat/pxa27x_keypad.h>
> =A0#include <mach/littleton.h>
> =A0#include <plat/i2c.h>
> diff --git a/arch/arm/mach-pxa/lubbock.c b/arch/arm/mach-pxa/lubbock.c
> index 1499493..4a3fe45 100644
> --- a/arch/arm/mach-pxa/lubbock.c
> +++ b/arch/arm/mach-pxa/lubbock.c
> @@ -25,7 +25,7 @@
>
> =A0#include <linux/spi/spi.h>
> =A0#include <linux/spi/ads7846.h>
> -#include <mach/pxa2xx_spi.h>
> +#include <linux/spi/pxa2xx_spi.h>
>
> =A0#include <asm/setup.h>
> =A0#include <asm/memory.h>
> diff --git a/arch/arm/mach-pxa/pcm027.c b/arch/arm/mach-pxa/pcm027.c
> index c77e8f3..a5596f9 100644
> --- a/arch/arm/mach-pxa/pcm027.c
> +++ b/arch/arm/mach-pxa/pcm027.c
> @@ -25,12 +25,12 @@
> =A0#include <linux/mtd/physmap.h>
> =A0#include <linux/spi/spi.h>
> =A0#include <linux/spi/max7301.h>
> +#include <linux/spi/pxa2xx_spi.h>
> =A0#include <linux/leds.h>
>
> =A0#include <asm/mach-types.h>
> =A0#include <asm/mach/arch.h>
> =A0#include <mach/pxa27x.h>
> -#include <mach/pxa2xx_spi.h>
> =A0#include <mach/pcm027.h>
> =A0#include "generic.h"
>
> diff --git a/arch/arm/mach-pxa/poodle.c b/arch/arm/mach-pxa/poodle.c
> index 93a191c..c05eee3 100644
> --- a/arch/arm/mach-pxa/poodle.c
> +++ b/arch/arm/mach-pxa/poodle.c
> @@ -25,6 +25,7 @@
> =A0#include <linux/i2c.h>
> =A0#include <linux/spi/spi.h>
> =A0#include <linux/spi/ads7846.h>
> +#include <linux/spi/pxa2xx_spi.h>
> =A0#include <linux/mtd/sharpsl.h>
>
> =A0#include <mach/hardware.h>
> @@ -43,7 +44,6 @@
> =A0#include <mach/irda.h>
> =A0#include <mach/poodle.h>
> =A0#include <mach/pxafb.h>
> -#include <mach/pxa2xx_spi.h>
> =A0#include <plat/i2c.h>
>
> =A0#include <asm/hardware/scoop.h>
> diff --git a/arch/arm/mach-pxa/spitz.c b/arch/arm/mach-pxa/spitz.c
> index f736119..4fd5572 100644
> --- a/arch/arm/mach-pxa/spitz.c
> +++ b/arch/arm/mach-pxa/spitz.c
> @@ -23,7 +23,7 @@
> =A0#include <linux/spi/spi.h>
> =A0#include <linux/spi/ads7846.h>
> =A0#include <linux/spi/corgi_lcd.h>
> -#include <linux/mtd/physmap.h>
> +#include <linux/spi/pxa2xx_spi.h>
> =A0#include <linux/mtd/sharpsl.h>
> =A0#include <linux/input/matrix_keypad.h>
> =A0#include <linux/regulator/machine.h>
> @@ -41,7 +41,6 @@
> =A0#include <mach/mmc.h>
> =A0#include <mach/ohci.h>
> =A0#include <mach/pxafb.h>
> -#include <mach/pxa2xx_spi.h>
> =A0#include <mach/spitz.h>
> =A0#include <mach/sharpsl_pm.h>
>
> diff --git a/arch/arm/mach-pxa/stargate2.c b/arch/arm/mach-pxa/stargate2.c
> index 738adc1..325f6ac 100644
> --- a/arch/arm/mach-pxa/stargate2.c
> +++ b/arch/arm/mach-pxa/stargate2.c
> @@ -46,10 +46,10 @@
> =A0#include <plat/i2c.h>
> =A0#include <mach/mmc.h>
> =A0#include <mach/udc.h>
> -#include <mach/pxa2xx_spi.h>
> =A0#include <mach/pxa27x-udc.h>
>
> =A0#include <linux/spi/spi.h>
> +#include <linux/spi/pxa2xx_spi.h>
> =A0#include <linux/mfd/da903x.h>
> =A0#include <linux/sht15.h>
>
> diff --git a/arch/arm/mach-pxa/tosa.c b/arch/arm/mach-pxa/tosa.c
> index 0ee1df4..7b5765d 100644
> --- a/arch/arm/mach-pxa/tosa.c
> +++ b/arch/arm/mach-pxa/tosa.c
> @@ -32,6 +32,7 @@
> =A0#include <linux/gpio.h>
> =A0#include <linux/pda_power.h>
> =A0#include <linux/spi/spi.h>
> +#include <linux/spi/pxa2xx_spi.h>
> =A0#include <linux/input/matrix_keypad.h>
>
> =A0#include <asm/setup.h>
> @@ -44,7 +45,6 @@
> =A0#include <mach/mmc.h>
> =A0#include <mach/udc.h>
> =A0#include <mach/tosa_bt.h>
> -#include <mach/pxa2xx_spi.h>
> =A0#include <mach/audio.h>
>
> =A0#include <asm/mach/arch.h>
> diff --git a/arch/arm/mach-pxa/trizeps4.c b/arch/arm/mach-pxa/trizeps4.c
> index 565d062..bdb02a0 100644
> --- a/arch/arm/mach-pxa/trizeps4.c
> +++ b/arch/arm/mach-pxa/trizeps4.c
> @@ -40,7 +40,6 @@
> =A0#include <asm/mach/flash.h>
>
> =A0#include <mach/pxa27x.h>
> -#include <mach/pxa2xx_spi.h>
> =A0#include <mach/trizeps4.h>
> =A0#include <mach/audio.h>
> =A0#include <mach/pxafb.h>
> diff --git a/arch/arm/mach-pxa/z2.c b/arch/arm/mach-pxa/z2.c
> index fefde98..1b8b71b 100644
> --- a/arch/arm/mach-pxa/z2.c
> +++ b/arch/arm/mach-pxa/z2.c
> @@ -20,6 +20,7 @@
> =A0#include <linux/z2_battery.h>
> =A0#include <linux/dma-mapping.h>
> =A0#include <linux/spi/spi.h>
> +#include <linux/spi/pxa2xx_spi.h>
> =A0#include <linux/spi/libertas_spi.h>
> =A0#include <linux/spi/lms283gf05.h>
> =A0#include <linux/power_supply.h>
> @@ -38,7 +39,6 @@
> =A0#include <mach/pxafb.h>
> =A0#include <mach/mmc.h>
> =A0#include <plat/pxa27x_keypad.h>
> -#include <mach/pxa2xx_spi.h>
>
> =A0#include <plat/i2c.h>
>
> diff --git a/arch/arm/mach-pxa/zeus.c b/arch/arm/mach-pxa/zeus.c
> index dea46a2..f5c9f30 100644
> --- a/arch/arm/mach-pxa/zeus.c
> +++ b/arch/arm/mach-pxa/zeus.c
> @@ -20,6 +20,7 @@
> =A0#include <linux/dm9000.h>
> =A0#include <linux/mmc/host.h>
> =A0#include <linux/spi/spi.h>
> +#include <linux/spi/pxa2xx_spi.h>
> =A0#include <linux/mtd/mtd.h>
> =A0#include <linux/mtd/partitions.h>
> =A0#include <linux/mtd/physmap.h>
> @@ -41,7 +42,6 @@
> =A0#include <mach/pxa27x-udc.h>
> =A0#include <mach/udc.h>
> =A0#include <mach/pxafb.h>
> -#include <mach/pxa2xx_spi.h>
> =A0#include <mach/mfp-pxa27x.h>
> =A0#include <mach/pm.h>
> =A0#include <mach/audio.h>
> diff --git a/arch/arm/plat-pxa/ssp.c b/arch/arm/plat-pxa/ssp.c
> index c6357e5..58b7980 100644
> --- a/arch/arm/plat-pxa/ssp.c
> +++ b/arch/arm/plat-pxa/ssp.c
> @@ -28,11 +28,11 @@
> =A0#include <linux/clk.h>
> =A0#include <linux/err.h>
> =A0#include <linux/platform_device.h>
> +#include <linux/spi/pxa2xx_spi.h>
> =A0#include <linux/io.h>
>
> =A0#include <asm/irq.h>
> =A0#include <mach/hardware.h>
> -#include <plat/ssp.h>
>
> =A0static DEFINE_MUTEX(ssp_lock);
> =A0static LIST_HEAD(ssp_list);
> diff --git a/drivers/spi/pxa2xx_spi.c b/drivers/spi/pxa2xx_spi.c
> index a4c795c..3802ba6 100644
> --- a/drivers/spi/pxa2xx_spi.c
> +++ b/drivers/spi/pxa2xx_spi.c
> @@ -23,6 +23,7 @@
> =A0#include <linux/errno.h>
> =A0#include <linux/interrupt.h>
> =A0#include <linux/platform_device.h>
> +#include <linux/spi/pxa2xx_spi.h>
> =A0#include <linux/dma-mapping.h>
> =A0#include <linux/spi/spi.h>
> =A0#include <linux/workqueue.h>
> @@ -35,9 +36,6 @@
> =A0#include <asm/irq.h>
> =A0#include <asm/delay.h>
>
> -#include <mach/dma.h>
> -#include <plat/ssp.h>
> -#include <mach/pxa2xx_spi.h>
>
> =A0MODULE_AUTHOR("Stephen Street");
> =A0MODULE_DESCRIPTION("PXA2xx SSP SPI Controller");
> diff --git a/arch/arm/plat-pxa/include/plat/ssp.h b/include/linux/pxa2xx_=
ssp.h
> similarity index 98%
> rename from arch/arm/plat-pxa/include/plat/ssp.h
> rename to include/linux/pxa2xx_ssp.h
> index 21c12ca..84465d4 100644
> --- a/arch/arm/plat-pxa/include/plat/ssp.h
> +++ b/include/linux/pxa2xx_ssp.h
Is there any reason to rename ssp.h?

> @@ -1,5 +1,5 @@
> =A0/*
> - * =A0ssp.h
> + * =A0pxa2xx_ssp.h
> =A0*
> =A0* =A0Copyright (C) 2003 Russell King, All Rights Reserved.
> =A0*
> @@ -16,8 +16,8 @@
> =A0* =A0 =A0 =A0 PXA3xx =A0 =A0 SSP1, SSP2, SSP3, SSP4
> =A0*/
>
> -#ifndef __ASM_ARCH_SSP_H
> -#define __ASM_ARCH_SSP_H
> +#ifndef __LINUX_SSP_H
> +#define __LINUX_SSP_H
>
> =A0#include <linux/list.h>
> =A0#include <linux/io.h>
> @@ -184,4 +184,4 @@ static inline u32 pxa_ssp_read_reg(struct ssp_device =
*dev, u32 reg)
>
> =A0struct ssp_device *pxa_ssp_request(int port, const char *label);
> =A0void pxa_ssp_free(struct ssp_device *);
> -#endif /* __ASM_ARCH_SSP_H */
> +#endif
> diff --git a/arch/arm/mach-pxa/include/mach/pxa2xx_spi.h b/include/linux/=
spi/pxa2xx_spi.h
> similarity index 92%
> rename from arch/arm/mach-pxa/include/mach/pxa2xx_spi.h
> rename to include/linux/spi/pxa2xx_spi.h
> index b87cecd..471ed68 100644
> --- a/arch/arm/mach-pxa/include/mach/pxa2xx_spi.h
> +++ b/include/linux/spi/pxa2xx_spi.h
> @@ -15,9 +15,11 @@
> =A0* along with this program; if not, write to the Free Software
> =A0* Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
> =A0*/
> +#ifndef __linux_pxa2xx_spi_h
> +#define __linux_pxa2xx_spi_h
>
> -#ifndef PXA2XX_SPI_H_
> -#define PXA2XX_SPI_H_
> +#include <linux/pxa2xx_ssp.h>
> +#include <mach/dma.h>
>
> =A0#define PXA2XX_CS_ASSERT (0x01)
> =A0#define PXA2XX_CS_DEASSERT (0x02)
> @@ -44,4 +46,4 @@ struct pxa2xx_spi_chip {
>
> =A0extern void pxa2xx_set_spi_info(unsigned id, struct pxa2xx_spi_master =
*info);
>
> -#endif /*PXA2XX_SPI_H_*/
> +#endif
> diff --git a/sound/soc/pxa/pxa-ssp.c b/sound/soc/pxa/pxa-ssp.c
> index b439eee..8ad93ee 100644
> --- a/sound/soc/pxa/pxa-ssp.c
> +++ b/sound/soc/pxa/pxa-ssp.c
> @@ -20,6 +20,7 @@
> =A0#include <linux/platform_device.h>
> =A0#include <linux/clk.h>
> =A0#include <linux/io.h>
> +#include <linux/pxa2xx_ssp.h>
>
> =A0#include <asm/irq.h>
>
> @@ -33,7 +34,6 @@
> =A0#include <mach/hardware.h>
> =A0#include <mach/dma.h>
> =A0#include <mach/audio.h>
> -#include <plat/ssp.h>
>
> =A0#include "../../arm/pxa2xx-pcm.h"
> =A0#include "pxa-ssp.h"
> --
> 1.7.3.2
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>

---------------------------------------------------------------------------=
---
Increase Visibility of Your 3D Game App & Earn a Chance To Win $500!
Tap into the largest installed PC base & get more eyes on your game by
optimizing for Intel(R) Graphics Technology. Get started today with the
Intel(R) Software Partner Program. Five $500 cash prizes are up for grabs.
http://p.sf.net/sfu/intelisp-dev2dev
