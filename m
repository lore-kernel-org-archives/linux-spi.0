From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [GIT PULL] spi updates for Linux 3.2
Date: Fri,  9 Dec 2011 21:32:31 +0100
Message-ID: <1323462755-14369-1-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
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

Hi Linus,

please pull the following spi updates for 3.2 which I collected on Grant's
behalf while he is on his sabbatical. These updates include three build fixes
and one section mismatch removal. I don't know if you trust our git-server, so
I attach the patches as a series as well, trivial as they are.

Thanks,

   Wolfram

The following changes since commit 5611cc4572e889b62a7b4c72a413536bf6a9c416:

  Linux 3.2-rc4 (2011-12-01 14:56:01 -0800)

are available in the git repository at:
  git://git.pengutronix.de/git/wsa/linux-2.6.git spi/for-3.2

Axel Lin (1):
  spi/nuc900: Include linux/module.h

Gabor Juhos (1):
  spi/ath79: fix compile error due to missing include

Jiri Slaby (1):
  spi/fsl-espi: disable CONFIG_SPI_FSL_ESPI=m build

Manuel Lauss (1):
  spi/gpio: fix section mismatch warning

 drivers/spi/Kconfig      |    4 ++--
 drivers/spi/spi-ath79.c  |    1 +
 drivers/spi/spi-gpio.c   |    4 ++--
 drivers/spi/spi-nuc900.c |    1 +
 4 files changed, 6 insertions(+), 4 deletions(-)

-- 
1.7.2.5


------------------------------------------------------------------------------
Cloud Services Checklist: Pricing and Packaging Optimization
This white paper is intended to serve as a reference, checklist and point of 
discussion for anyone considering optimizing the pricing and packaging model 
of a cloud services business. Read Now!
http://www.accelacomm.com/jaw/sfnl/114/51491232/
