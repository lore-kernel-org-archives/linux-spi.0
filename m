From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH/PROTO 0/9] R-Car H3 MSIOF Parent Clock Control Prototype
Date: Fri, 12 Aug 2016 18:38:36 +0200
Message-ID: <1471019925-29083-1-git-send-email-geert+renesas@glider.be>
Cc: linux-spi@vger.kernel.org, linux-clk@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
To: linux-renesas-soc@vger.kernel.org
Return-path: <linux-clk-owner@vger.kernel.org>
Sender: linux-clk-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

	Hi all,

On R-Car H3, the various MSIOF instances (used for SPI) have a common
parent clock. This mso clock is a programmable "DIV6" clock (divider
1 - 64). Its rate lies in the range 12.5 to 800 MHz, or 6.25 to 400 MHz
(depending on the main crystal).
After boot up, the default configuration is the lowest possible rate,
which leads to bad performance with devices desiring a higher transfer
rate.

MSIOF clock tree:

    pll1/4 (800 or 400 MHz)
      mso clock
	msiof0 clock (type MSTP = gate + status)
	  msiof0 internal divider (divider range 1 - 1024, with holes)
	msiof1 clock (type MSTP)
	  msiof1 internal divider
	msiof2 clock (type MSTP)
	  msiof2 internal divider
	msiof3 clock (type MSTP)
	  msiof3 internal divider

To optimize performance, we want to control the mso parent clock.

  - Higher parent clock means:
      + Better performance for devices wanting high target rates,
      + More accurate target rates in MSIOF driver,
      - More power consumption (doesn't matter that much with R-Car),
      - Cannot support devices needing real low target rates.
  - Lower parent clock means:
      + Less power consumption (doesn't matter that much with R-Car),
      + Can support all devices,
      - Worse performance for devices wanting high target rates,
      - Less accurate target rates, decreasing performance.

Configuring the mso parent clock rate can either be done statically, or
dynamically. In both cases, this must be based on individual device
requirements. Note that this is not specific to SPI.

SPI specific notes:
  - The SPI master knows about SPI slave device maximum frequencies only
    when spi_master.setup() is called,
  - SPI slave device maximum frequencies may change at runtime (through
    calling spi_setup(), esp. for spidev),
  - Currently the MSIOF driver does not set
    spi_master.{min,max}_speed_hz. However, setting it means the SPI
    core will never call spi_master.setup() with a rate outside this
    range, and thus we will never be informed of such rates.  Hence if
    we decide to set this, and we want dynamic configuration, we should
    fill in the real minimum and maximum supported by the hardware,
    regardless of the current parent clock rate.

In this prototype, I'm offering 3 solutions to control the mso parent
clock rate.

  - Option 1: Static configuration through the "assigned-clocks" and
    assigned-clock-rates DT properties.

  - Option 2: Dynamic configuration, by changing the mso clock through
    the msiofX module clocks from the MSIOF driver.

  - Option 2: Dynamic configuration, by changing a dummy clk-divider,
    which mimics the capabilities of the MSIOF internal divider.

More information can be found in the individual patches for the various
options.

For your convenience, these patches are also available in the following
branches of my renesas-drivers git repository at
https://git.kernel.org/cgit/linux/kernel/git/geert/renesas-drivers.git:
  - topic/r8a7795-msiof-parent-clock-prototype-core
  - topic/r8a7795-msiof-parent-clock-prototype-dt
  - topic/r8a7795-msiof-parent-clock-prototype-option-1
  - topic/r8a7795-msiof-parent-clock-prototype-option-2
  - topic/r8a7795-msiof-parent-clock-prototype-option-3

Warning:
  - None of these patches is intended to be applied as-is!
  - R-Car H3 ES1.0 has a hardware bug preventing MSIOF from being used
    with real SPI devices. However, this does not affect the generation
    of clock signals on the SPI bus.

Conclusion, based on the observations for the various options:
  The mso clock frequency cannot be changed while the mso clock is
  enabled. However, Runtime PM may not have disabled it yet due its
  asynchronous nature, leading to subtle failures. Add to this the added
  complexity for options 2 and 3, and their still needed improvements, I
  think static configuration in DT (option 1) is the best solution.

Thanks for your comments!

Geert Uytterhoeven (9):
  [common] spi: sh-msiof: Add support for R-Car H3
  [common] spi: sh-msiof: Print max and transfer frequency
  [common] arm64: dts: r8a7795: Add all MSIOF nodes
  [common] arm64: dts: salvator-x: Add dummy MSIOF SPI slave devices
  [option 1] arm64: dts: salvator-x: Configure MSIOF parent clock
  [option 2/3] spi: sh-msiof: Add clock notifier to enforce valid parent
    clock
  [option 2] spi: sh-msiof: Configure MSIOF parent clock
  [option 3] clk: divider: Add hack to support dummy clocks
  [option 3] spi: sh-msiof: Configure MSIOF parent clock

 Documentation/devicetree/bindings/spi/sh-msiof.txt |   1 +
 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts |  79 ++++
 arch/arm64/boot/dts/renesas/r8a7795.dtsi           |  52 +++
 drivers/clk/clk-divider.c                          |  33 ++-
 drivers/spi/spi-sh-msiof.c                         | 355 +++++++++++++++++++++
 include/linux/clk-provider.h                       |   1 +
 4 files changed, 508 insertions(+), 13 deletions(-)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
