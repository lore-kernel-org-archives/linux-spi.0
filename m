From: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 0/6] Add device tree support for imx spi driver
Date: Fri,  8 Jul 2011 16:27:28 +0800
Message-ID: <1310113654-25887-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
List-Id: linux-spi.vger.kernel.org

The patch set makes some cleanups on imx spi driver to get it ready
for adding device tree probe and then add the support.

Those two dt helper function related patches are carried here to
resolve the dependency.  They should be on the way to sit on Grant's
devicetree/next branch.

Rob Herring (1):
      dt: add helper function to read u32 arrays

Shawn Guo (5):
      ARM: mxc: remove unnecessary header file inclusion from gpio.h
      spi/imx: use soc name in spi device type naming scheme
      spi/imx: copy gpio number passed by platform data into driver private data
      dt: add empty of_property_read_u32[_array] for non-dt
      spi/imx: add device tree probe support

 .../devicetree/bindings/spi/fsl-imx-cspi.txt       |   22 +
 arch/arm/mach-imx/clock-imx25.c                    |    7 +-
 arch/arm/mach-mx5/clock-mx51-mx53.c                |   11 +-
 arch/arm/plat-mxc/devices/platform-spi_imx.c       |   12 +-
 arch/arm/plat-mxc/include/mach/gpio.h              |    2 -
 drivers/of/base.c                                  |   19 +-
 drivers/spi/Kconfig                                |   15 -
 drivers/spi/spi-imx.c                              |  468 ++++++++++----------
 include/linux/of.h                                 |   29 ++-
 9 files changed, 317 insertions(+), 268 deletions(-)
