From: Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 0/4] patch serie for dw_spi driver
Date: Wed, 30 Mar 2011 23:09:51 +0800
Message-ID: <1301497795-6924-1-git-send-email-feng.tang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: alek.du-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
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

Pls help to review, thanks!

v2 change:
	* fix a typo about bits_per_word checking 
	* re-generate the patches against v2.6.39-rc1

Thanks,
Feng
-------------------------

Alek Du (3):
  spi/dw_spi: remove the un-necessary flush()
  spi/dw_spi: change poll mode transfer from byte ops to batch ops
  spi/dw_spi: improve the interrupt mode with the batch ops

Feng Tang (1):
  spi/dw_spi: unify the low level read/write routines

 drivers/spi/dw_spi.c |  202 ++++++++++++++++---------------------------------
 drivers/spi/dw_spi.h |    2 -
 2 files changed, 66 insertions(+), 138 deletions(-)


------------------------------------------------------------------------------
Create and publish websites with WebMatrix
Use the most popular FREE web apps or write code yourself; 
WebMatrix provides all the features you need to develop and 
publish your website. http://p.sf.net/sfu/ms-webmatrix-sf
