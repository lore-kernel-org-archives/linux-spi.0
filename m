From: Girish K S <girishks2000-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH V2 0/5]  Add polling support for 64xx spi controller
Date: Wed, 13 Feb 2013 12:03:43 -0800
Message-ID: <1360785828-32767-1-git-send-email-ks.giri@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
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

[PATCH 1/5]: fixes the error handling in the interrupt handler
[PATCH 2/5]: The existing driver support partial polling mode.
	     This patch modifies the current driver to support
	     only polling mode.
[PATCH 3/5]: provision to support SoC's with dedicated i/o pins
[PATCH 4/5]: provision to support dedicated cs pin
[PATCH 5/5]: support exynos5440 SoC in polling mode

Tested this patch on exynos5250 in dma mode, and exynos5440 in
polling mode.

Girish K S (5):
  spi: s3c64xx: modified error interrupt handling and init
  spi: s3c64xx: added support for polling mode
  spi: s3c64xx: Added provision for non-gpio i/o's
  spi: s3c64xx: Added provision for dedicated cs pin
  spi: s3c64xx: Added support for exynos5440 spi

 drivers/spi/spi-s3c64xx.c                 |  216 ++++++++++++++++++++---------
 include/linux/platform_data/spi-s3c64xx.h |    3 +
 2 files changed, 155 insertions(+), 64 deletions(-)

-- 
1.7.10.4


------------------------------------------------------------------------------
Free Next-Gen Firewall Hardware Offer
Buy your Sophos next-gen firewall before the end March 2013 
and get the hardware for free! Learn more.
http://p.sf.net/sfu/sophos-d2d-feb
