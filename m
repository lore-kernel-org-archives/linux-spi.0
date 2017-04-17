From: Martin Blumenstingl <martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Subject: Re: [PATCH 00/13] MIPS: lantiq: handle RCU register by separate drivers
Date: Mon, 17 Apr 2017 23:14:08 +0200
Message-ID: <CAFBinCCTmOh17bAc-4LbiZJrAy+mKjtC5giS3rB5asw-T8PR2g@mail.gmail.com>
References: <20170417192942.32219-1-hauke@hauke-m.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org,
        linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, john-Pj+rj9U5foFAfugRpC6u6w@public.gmane.org,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, hauke.mehrtens-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
To: Hauke Mehrtens <hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170417192942.32219-1-hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi Hauke,

On Mon, Apr 17, 2017 at 9:29 PM, Hauke Mehrtens <hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org> wrote:
> The RCU (Reset controller Unit) register block provides many different
> functionalities. Before they were handed by the code in arch/mips/lantiq
> /xway/reset.c, now there are separate drivers for the functionality.
> This block provides support for reset controller, GPHY firmware
> loading, USB PHY initialization and cross bar configuration.
>
> These changes are making the old device tree incompatible with the
> current kernel. The upstream Linux kernel supports loading the device
> tree blob from the boot loader since about one year, the latest
> released vendor kernel does not support loading the device tree from a
> bot loader.
great to see that you could use my work :-)

> I would prefer if this would go through the mips tree.
> There are more patches planed which would convert the Lantiq code
> to the common clock framework.
>
> Hauke Mehrtens (4):
>   mtd: lantiq-flash: drop check of boot select
>   mtd: spi-falcon: drop check of boot select
>   watchdog: lantiq: access boot cause register through regmap
>   MIPS: lantiq: remove old GPHY loader code
>
> Martin Blumenstingl (9):
>   MIPS: lantiq: Use of_platform_populate instead of __dt_register_buses
>   MIPS: lantiq: Enable MFD_SYSCON to be able to use it for the RCU MFD
>   MIPS: lantiq: Convert the xbar driver to a platform_driver
>   MIPS: lantiq: remove ltq_reset_cause() and ltq_boot_select()
>   reset: Add a reset controller driver for the Lantiq XWAY based SoCs
>   MIPS: lantiq: Add a GPHY driver which uses the RCU syscon-mfd
>   phy: Add an USB PHY driver for the Lantiq SoCs using the RCU module
>   Documentation: DT: MIPS: lantiq: Add docs for the RCU bindings
>   MIPS: lantiq: Remove the arch/mips/lantiq/xway/reset.c implementation
if anyone is wondering:
I started porting the lantiq target to the common clock framework
"some" time ago. unfortunately it turned out that some of the
"drivers" are tightly coupled and one cannot simply port the clock
handling to the common clock framework. so I started tackling more
drivers in arch/mips/lantiq/ until I had a huge pile of patches in my
tree but no time to improve them so they were ready to submit. so the
patches from Hauke are roughly based on the ideas of my patches (and
probably a few lines of code here and there).


>  .../devicetree/bindings/mips/lantiq/rcu-gphy.txt   |  54 +++
>  .../devicetree/bindings/mips/lantiq/rcu.txt        |  82 +++++
>  .../devicetree/bindings/mips/lantiq/xbar.txt       |  22 ++
>  .../bindings/phy/phy-lantiq-rcu-usb2.txt           |  59 ++++
>  .../devicetree/bindings/reset/lantiq,rcu-reset.txt |  43 +++
>  MAINTAINERS                                        |   1 +
>  arch/mips/include/asm/mach-lantiq/lantiq.h         |   4 -
>  arch/mips/lantiq/Kconfig                           |   2 +
>  arch/mips/lantiq/falcon/reset.c                    |  22 --
>  arch/mips/lantiq/prom.c                            |   3 +-
>  arch/mips/lantiq/xway/Makefile                     |   4 +-
>  arch/mips/lantiq/xway/reset.c                      | 387 ---------------------
>  arch/mips/lantiq/xway/sysctrl.c                    |  69 +---
>  arch/mips/lantiq/xway/xrx200_phy_fw.c              | 113 ------
>  drivers/mtd/maps/lantiq-flash.c                    |   6 -
>  drivers/phy/Kconfig                                |   8 +
>  drivers/phy/Makefile                               |   1 +
>  drivers/phy/phy-lantiq-rcu-usb2.c                  | 325 +++++++++++++++++
>  drivers/reset/Kconfig                              |   6 +
>  drivers/reset/Makefile                             |   1 +
>  drivers/reset/reset-lantiq-rcu.c                   | 231 ++++++++++++
>  drivers/soc/Makefile                               |   1 +
>  drivers/soc/lantiq/Makefile                        |   2 +
>  drivers/soc/lantiq/gphy.c                          | 242 +++++++++++++
>  drivers/soc/lantiq/xbar.c                          | 100 ++++++
>  drivers/spi/spi-falcon.c                           |   5 -
>  drivers/watchdog/lantiq_wdt.c                      |  47 ++-
>  include/dt-bindings/mips/lantiq_rcu_gphy.h         |  15 +
>  28 files changed, 1255 insertions(+), 600 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mips/lantiq/rcu-gphy.txt
>  create mode 100644 Documentation/devicetree/bindings/mips/lantiq/rcu.txt
>  create mode 100644 Documentation/devicetree/bindings/mips/lantiq/xbar.txt
>  create mode 100644 Documentation/devicetree/bindings/phy/phy-lantiq-rcu-usb2.txt
>  create mode 100644 Documentation/devicetree/bindings/reset/lantiq,rcu-reset.txt
>  delete mode 100644 arch/mips/lantiq/xway/reset.c
>  delete mode 100644 arch/mips/lantiq/xway/xrx200_phy_fw.c
>  create mode 100644 drivers/phy/phy-lantiq-rcu-usb2.c
>  create mode 100644 drivers/reset/reset-lantiq-rcu.c
>  create mode 100644 drivers/soc/lantiq/Makefile
>  create mode 100644 drivers/soc/lantiq/gphy.c
>  create mode 100644 drivers/soc/lantiq/xbar.c
>  create mode 100644 include/dt-bindings/mips/lantiq_rcu_gphy.h
>
> --
> 2.11.0
>
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
