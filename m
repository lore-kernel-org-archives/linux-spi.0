From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCHv2 0/3] Add spidev to the CFA-10049
Date: Wed, 31 Oct 2012 11:30:07 +0100
Message-ID: <1351679410-11026-1-git-send-email-maxime.ripard@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Brian Lilly <brian-ZKiFAVwZFM2FeswfMrDH8w@public.gmane.org>
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>,
	Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
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

Hi everyone,

This patchset probes spidev on the SSP3 bus where on the CFA-10049 there is
a Rohm DH2228FV DAC.

It first adds the dt bindings for the spidev driver, and the proper node in
the CFA-10049 device tree file.

Maxime

Changes from v1:
  - Removed the linux,spidev compatible string and use the compatible strings
    of the devices instead.

Maxime Ripard (3):
  spi: spidev: Add device tree bindings
  spi: spidev: Add Rohm DH2228FV DAC compatible string
  ARM: dts: cfa10049: Add the DH2228FV DAC to the DTS

 arch/arm/boot/dts/imx28-cfa10049.dts |    6 ++++++
 drivers/spi/spidev.c                 |   10 ++++++++++
 2 files changed, 16 insertions(+)

-- 
1.7.9.5


------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_sfd2d_oct
