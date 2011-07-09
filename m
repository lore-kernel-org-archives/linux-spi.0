From: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH v2 0/7] Add device tree support for imx spi driver
Date: Sun, 10 Jul 2011 01:16:34 +0800
Message-ID: <1310231801-18761-1-git-send-email-shawn.guo@linaro.org>
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

Changes since v1:
 * Split the big patch into small ones per Sascha's comment
 * Drop the patch cleaning mxc/mach/gpio.h from the series.  Will
   post it separately later.
 * Drop dt helper patches, as they are on Grant's tree

Shawn Guo (7):
      spi/imx: do not make copy of spi_imx_devtype_data
      spi/imx: use mx21 to name SPI_IMX_VER_0_0 function and macro
      spi/imx: do not use spi_imx2_3 to name SPI_IMX_VER_2_3 function and macro
      spi/imx: merge type SPI_IMX_VER_0_7 into SPI_IMX_VER_0_4
      spi/imx: use soc name in spi device type naming scheme
      spi/imx: copy gpio number passed by platform data into driver private data
      spi/imx: add device tree probe support

 .../devicetree/bindings/spi/fsl-imx-cspi.txt       |   22 +
 arch/arm/mach-imx/clock-imx25.c                    |    7 +-
 arch/arm/mach-mx5/clock-mx51-mx53.c                |   11 +-
 arch/arm/plat-mxc/devices/platform-spi_imx.c       |   12 +-
 drivers/spi/Kconfig                                |   15 -
 drivers/spi/spi-imx.c                              |  468 ++++++++++----------
 6 files changed, 277 insertions(+), 258 deletions(-)
