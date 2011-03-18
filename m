From: Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 0/4] patch serie for dw_spi driver
Date: Fri, 18 Mar 2011 15:50:52 +0800
Message-ID: <1300434656-16870-1-git-send-email-feng.tang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org,
	dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
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

Hi all,

Alek Du made some optimization for the dw_spi driver, the original driver
will wait for non-busy state after every work of read/write. With these
patches, driver will read/write as much as possible data from/to the HW
FIFO. The DMA mode transfer is not affected at all. There is also some
minor code cleanup.

The patch serie is generated against 2.6.38 kernel.

Pls help to review, thanks!

- Feng

-----------------
Feng Tang (4):
  spi/dw_spi: unify the low level read/write routines
  spi/dw_spi: remove the un-necessary flush()
  spi/dw_spi: change poll mode transfer from byte ops to batch ops
  spi/dw_spi: improve the interrupt mode with the batch ops

 drivers/spi/dw_spi.c       |  202 ++++++++++++++-----------------------------
 include/linux/spi/dw_spi.h |    2 -
 2 files changed, 66 insertions(+), 138 deletions(-)


------------------------------------------------------------------------------
Colocation vs. Managed Hosting
A question and answer guide to determining the best fit
for your organization - today and in the future.
http://p.sf.net/sfu/internap-sfd2d
