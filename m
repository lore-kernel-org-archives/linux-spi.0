From: Anatolij Gustschin <agust-ynQEQJNshbs@public.gmane.org>
Subject: [PATCH 0/2] Add SPI driver for MPC5121 PSC SPI
Date: Fri, 30 Apr 2010 15:21:25 +0200
Message-ID: <1272633687-6935-1-git-send-email-agust@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	Wolfgang Denk <wd-ynQEQJNshbs@public.gmane.org>, Detelv Zundel <dzu-ynQEQJNshbs@public.gmane.org>
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org
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

Anatolij Gustschin (2):
  powerpc/mpc5121: move PSC FIFO memory init to platform code
  spi: Add SPI master driver for MPC5121 PSC

 arch/powerpc/include/asm/mpc52xx_psc.h       |    1 +
 arch/powerpc/platforms/512x/mpc512x_shared.c |   78 ++++
 drivers/serial/mpc52xx_uart.c                |   69 ---
 drivers/spi/Kconfig                          |    7 +
 drivers/spi/Makefile                         |    1 +
 drivers/spi/mpc512x_psc_spi.c                |  576 ++++++++++++++++++++++++++
 6 files changed, 663 insertions(+), 69 deletions(-)
 create mode 100644 drivers/spi/mpc512x_psc_spi.c


------------------------------------------------------------------------------
