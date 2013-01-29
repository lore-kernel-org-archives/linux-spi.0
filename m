From: Andreas Larsson <andreas-FkzTOoA/JUlBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH v2 0/6] of, of_gpio,
	of_spi: Bugfix and improve of_parse_phandle_with_args,
	of_gpio_named_count and of_spi_register_master
Date: Tue, 29 Jan 2013 15:53:37 +0100
Message-ID: <1359471223-4794-1-git-send-email-andreas@gaisler.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: software-FkzTOoA/JUlBDgjK7y7TUQ@public.gmane.org, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

This patch series fixes a bug where of_gpio_named count relied upon a return
value that was no longer returned from of_parse_phandle_with_args and adds the
possibility for of_gpio_named_count to return error values.

In addition, for of_spi_register_master it fixes a bug, adds documentation,
adds fetching of gpio flags and initializes gpio values to be consistent with
return values from of_parse_phandle_with_args.

Tested on sparc (excluding the changes to drivers gpio-fan, i2c-mux-gpio,
matrix_keypad, mdio-mux-gpio, spi-mpc52xx, spi-oc-tiny, spi-ppc4xx, selftest). 
Compile tested on x86, arm and ppc (all changed source files, when appropriate
for platform)

Changes since v1:
- PATCH 2/6: Handle error return values from calls to of_gpio_count

Andreas Larsson (6):
  of: Return -EEXIST from of_parse_phandle_with_args for holes in
    phandle list
  of: Return -ENXIO from of_parse_phandle_with_args for too large index
    and return errors from of_gpio_named_count
  of_spi: Initialize cs_gpios properly
  of_spi: Document cs_gpios and cs_gpio in kernel-doc
  of_spi: Add fetching of of_gpio flags to of_spi_register_master
  of_spi: Initialize cs_gpios and cs_gpio with -EEXIST

 Documentation/devicetree/bindings/spi/spi-bus.txt |    3 +-
 drivers/gpio/gpiolib-of.c                         |    8 +++--
 drivers/hwmon/gpio-fan.c                          |    6 ++--
 drivers/i2c/muxes/i2c-mux-gpio.c                  |    3 +-
 drivers/input/keyboard/matrix_keypad.c            |    2 +-
 drivers/net/phy/mdio-mux-gpio.c                   |    2 +-
 drivers/of/base.c                                 |    9 +++--
 drivers/of/selftest.c                             |    2 +-
 drivers/spi/spi-fsl-spi.c                         |    4 ++-
 drivers/spi/spi-mpc52xx.c                         |    5 +++
 drivers/spi/spi-oc-tiny.c                         |    4 ++-
 drivers/spi/spi-ppc4xx.c                          |    6 +++-
 drivers/spi/spi.c                                 |   40 ++++++++++++++++-----
 include/linux/spi/spi.h                           |   10 +++++
 14 files changed, 78 insertions(+), 26 deletions(-)


------------------------------------------------------------------------------
Master Visual Studio, SharePoint, SQL, ASP.NET, C# 2012, HTML5, CSS,
MVC, Windows 8 Apps, JavaScript and much more. Keep your skills current
with LearnDevNow - 3,200 step-by-step video tutorials by Microsoft
MVPs and experts. ON SALE this month only -- learn more at:
http://p.sf.net/sfu/learnnow-d2d
