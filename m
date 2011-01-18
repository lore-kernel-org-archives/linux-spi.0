From: Cyril Chemparathy <cyril-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v8 00/11]  tnetv107x ssp drivers
Date: Tue, 18 Jan 2011 14:21:34 -0500
Message-ID: <1295378505-15221-1-git-send-email-cyril@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org,
        spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org,
        rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org, dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
List-Id: linux-spi.vger.kernel.org

TI's sequencer serial port (TI-SSP) is a jack-of-all-trades type of serial port
device.  It has a built-in programmable execution engine that can be programmed
to operate as almost any serial bus (I2C, SPI, EasyScale, and others).

This patch series implements a driver stack that looks like the following:

                             +--------+
                             | eeprom | . . .
                             +--------+
   +-----------+             +--------------+ +---------+
   | regulator | . . .       |   i2c-gpio   | | 1-wire  | . . .
   +-----------+             +--------------+ +---------+
   +----------------------+  +--------------------------------+
   |       ssp-spi        |  |           ssp-gpio             |
   +----------------------+  +--------------------------------+
   +----------------------------------------------------------+
   |                            ssp                           |
   +----------------------------------------------------------+

Changes between v8 and v7 of this series:
  - Reorder commits, removed regulator driver patch (already upstreamed)
  - Renamed static function definitions to keep namespace clean (mfd, gpio)
  - Removed instance pdata in mfd driver

Changes between v7 and v6 of this series:
  - Workaround for iosel2 register not reading back set bits.
  - Update backlight status once probe succeeds.

Changes between v6 and v5 of this series:
  - Changed initcalls to module_init() across all drivers.  This series now
    uses a late_initcall() in the board to delay initialization of gpio and
    regulator dependent devices.

Changes between v5 and v4 of this series:
  - Moved drivers from misc/gpio/spi to mfd
  - Removed implicit init-time iosel setup
  - Minor cleanups in backlight driver

Changes between v3 and v4 of this series:
  - Replaced polled wait for sequence termination with interrupt
  - Improved locking within SSP driver
  - Other minor cleanups

Changes between v2 and v3 of this series:
  - Minor cleanups in Kconfig and Makefile ordering

Changes between v1 and v2 of this series:
  - Replaced open()/close() semantics with dynamic platform_device
    registration on SSP probe.
  - Removed user-land interface to regulator registers
  - More sensible regulator constraints
  - Other minor cleanups


Cyril Chemparathy (11):
  mfd: add driver for sequencer serial port
  spi: add ti-ssp spi master driver
  gpio: add ti-ssp gpio driver
  backlight: add support for tps6116x controller
  davinci: add tnetv107x ssp platform device
  davinci: add ssp config for tnetv107x evm board
  davinci: add spi devices on tnetv107x evm
  davinci: add tnetv107x evm regulators
  davinci: add tnetv107x evm ti-ssp gpio device
  davinci: add tnetv107x evm backlight device
  davinci: add tnetv107x evm i2c eeprom device

 arch/arm/mach-davinci/board-tnetv107x-evm.c    |  197 ++++++++++
 arch/arm/mach-davinci/devices-tnetv107x.c      |   25 ++
 arch/arm/mach-davinci/include/mach/tnetv107x.h |    2 +
 arch/arm/mach-davinci/tnetv107x.c              |    2 +-
 drivers/gpio/Kconfig                           |   10 +
 drivers/gpio/Makefile                          |    1 +
 drivers/gpio/ti-ssp-gpio.c                     |  207 ++++++++++
 drivers/mfd/Kconfig                            |   11 +
 drivers/mfd/Makefile                           |    1 +
 drivers/mfd/ti-ssp.c                           |  476 ++++++++++++++++++++++++
 drivers/spi/Kconfig                            |   10 +
 drivers/spi/Makefile                           |    1 +
 drivers/spi/ti-ssp-spi.c                       |  402 ++++++++++++++++++++
 drivers/video/backlight/Kconfig                |    7 +
 drivers/video/backlight/Makefile               |    2 +-
 drivers/video/backlight/tps6116x.c             |  299 +++++++++++++++
 include/linux/mfd/ti_ssp.h                     |   97 +++++
 17 files changed, 1748 insertions(+), 2 deletions(-)
 create mode 100644 drivers/gpio/ti-ssp-gpio.c
 create mode 100644 drivers/mfd/ti-ssp.c
 create mode 100644 drivers/spi/ti-ssp-spi.c
 create mode 100644 drivers/video/backlight/tps6116x.c
 create mode 100644 include/linux/mfd/ti_ssp.h
