From: Steffen Trumtrar <s.trumtrar-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH 0/6] of: add support for imx-wm8974
Date: Fri,  9 Nov 2012 15:00:19 +0100
Message-ID: <1352469625-32024-1-git-send-email-s.trumtrar@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org,
	Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>,
	Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org,
	Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Steffen Trumtrar <s.trumtrar-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
	Liam Girdwood <lrg-l0cyMroinI0@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
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

Hi!

This series adds devicetree support for the wm8974 connected via SPI/SSI to an
imx. The series was developed on an imx27 with a wm8974 connected via SPI.
That is why two patches for the SPI subsystem are also provided, which may be
also usefull without the wm8974 stuff. As they are needed, I included them in
this series and did not send them separately. If this is wrong, please let me
know.

The driver and bindings are based on the imx-sgtl5000 driver and are tested with
	* spi-imx
	* fsl_ssi
	* imx-audmux (v1)

Regards,
Steffen

Steffen Trumtrar (6):
  spi: imx: specify spi base for device tree probe
  spi/devicetree: find spi_device via device_node
  ASoC: wm8974: include MCLKDIV in pll_factors
  ASoC: wm8974: add SPI as a possible bus master
  ARM i.MX: rename ssi1 clock for imx27
  ASoC: fsl: add imx-wm8974 machine driver

 .../devicetree/bindings/sound/imx-audio-wm8974.txt |   48 ++++
 arch/arm/mach-imx/clk-imx27.c                      |    2 +-
 arch/arm/mach-imx/imx27-dt.c                       |    1 +
 drivers/spi/spi-imx.c                              |    2 +-
 drivers/spi/spi.c                                  |   20 ++
 include/linux/spi/spi.h                            |    3 +
 sound/soc/codecs/Kconfig                           |    2 +-
 sound/soc/codecs/wm8974.c                          |  101 ++++++++-
 sound/soc/fsl/Kconfig                              |   12 +
 sound/soc/fsl/Makefile                             |    2 +
 sound/soc/fsl/imx-wm8974.c                         |  233 ++++++++++++++++++++
 11 files changed, 419 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/imx-audio-wm8974.txt
 create mode 100644 sound/soc/fsl/imx-wm8974.c

-- 
1.7.10.4


------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_d2d_nov
