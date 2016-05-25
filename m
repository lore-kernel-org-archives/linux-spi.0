From: Rich Felker <dalias-8zAoT0mYgF4@public.gmane.org>
Subject: [PATCH v3 00/12] J-core J2 cpu and SoC peripherals support
Date: Wed, 25 May 2016 05:43:02 +0000
Message-ID: <cover.1464148904.git.dalias@libc.org>
Cc: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>,
	Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>,
	Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>,
	Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The following patchset adds support for the J-core J2, an open-source
VHDL reimplementation of the SH-2 ISA, and drivers for the associated
SoC devices (interrupt controller, clocksource, and SPI).

As arch/sh co-maintainer my intent is to include as much as possible
in my pull request for the linux-sh tree. If there are parts outside
of arch/sh that can be included in this, please let me know. I'm not
clear yet on what the right path to upstream is for the clocksource
and irq drivers that are currently only useful/interesting for one
arch, or for the DT binding patches. Even if some drivers are delayed
going upstream, I would really like to get DT bindings acked and
ideally merged, because we want to go ahead with moving the DTB into
J2 boot rom where it belongs, and that should only happen with stable
bindings.

Rich Felker (12):
  of: add vendor prefix for J-Core
  of: add J-Core cpu bindings
  of: add J-Core interrupt controller bindings
  of: add J-Core timer bindings
  of: add J-Core SPI master bindings
  sh: add support for J-Core J2 processor
  sh: add AT_HWCAP flag for J-Core cas.l instruction
  irqchip: add J-Core AIC driver
  clocksource: add J-Core timer/clocksource driver
  spi: add driver for J-Core SPI controller
  sh: add defconfig for J-Core J2
  sh: add device tree source for J2 FPGA on Mimas v2 board

 .../bindings/interrupt-controller/jcore,aic.txt    |  29 +++
 Documentation/devicetree/bindings/jcore/cpus.txt   |  92 +++++++
 .../devicetree/bindings/spi/jcore,spi.txt          |  23 ++
 .../devicetree/bindings/timer/jcore,pit.txt        |  28 ++
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 arch/sh/Kconfig                                    |   8 +
 arch/sh/Makefile                                   |   1 +
 arch/sh/boot/dts/j2_mimas_v2.dts                   |  87 +++++++
 arch/sh/configs/j2_defconfig                       |  38 +++
 arch/sh/include/asm/processor.h                    |   2 +-
 arch/sh/include/uapi/asm/cpu-features.h            |   1 +
 arch/sh/kernel/cpu/init.c                          |   2 +-
 arch/sh/kernel/cpu/proc.c                          |   1 +
 arch/sh/kernel/cpu/sh2/entry.S                     |   5 +
 arch/sh/kernel/cpu/sh2/probe.c                     |  36 ++-
 arch/sh/mm/Makefile                                |   3 +-
 arch/sh/mm/cache-j2.c                              |  58 +++++
 arch/sh/mm/cache.c                                 |   6 +-
 drivers/clocksource/Kconfig                        |   8 +
 drivers/clocksource/Makefile                       |   1 +
 drivers/clocksource/jcore-pit.c                    | 282 +++++++++++++++++++++
 drivers/irqchip/Kconfig                            |   6 +
 drivers/irqchip/Makefile                           |   1 +
 drivers/irqchip/irq-jcore-aic.c                    |  95 +++++++
 drivers/spi/Kconfig                                |   4 +
 drivers/spi/Makefile                               |   1 +
 drivers/spi/spi-jcore.c                            | 209 +++++++++++++++
 27 files changed, 1023 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/jcore,aic.txt
 create mode 100644 Documentation/devicetree/bindings/jcore/cpus.txt
 create mode 100644 Documentation/devicetree/bindings/spi/jcore,spi.txt
 create mode 100644 Documentation/devicetree/bindings/timer/jcore,pit.txt
 create mode 100755 arch/sh/boot/dts/j2_mimas_v2.dts
 create mode 100644 arch/sh/configs/j2_defconfig
 create mode 100644 arch/sh/mm/cache-j2.c
 create mode 100644 drivers/clocksource/jcore-pit.c
 create mode 100644 drivers/irqchip/irq-jcore-aic.c
 create mode 100644 drivers/spi/spi-jcore.c

-- 
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
