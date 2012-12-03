From: Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v1 0/1] spi: davinci: add OF support for the spi controller
Date: Mon, 3 Dec 2012 13:38:37 -0500
Message-ID: <1354559918-15105-1-git-send-email-m-karicheri2@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>
To: <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>,
	<devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	<davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>,
	<linux-keystone-uAqBSO/uNfhBDgjK7y7TUQ@public.gmane.org>
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

This adds OF support for DaVinci SPI driver. Following are changes from initial
version based on mostly review comments.
 - removed attribute for spi version. instead, compatibility string is
   modified to include version info.
 - pdata ptr in davinci_spi_platform_data is replaced with struct itself.
   spi_davinci_get_pdata() now populates the pdata in the above structure
   with parsed values from DT bindings.
 - rebased to v3.7 rc7 of linux-next
 - replaces clk_* APIs with their prepare/unprepare versions

Murali Karicheri (1):
  spi: davinci: add OF support for the spi controller

 .../devicetree/bindings/spi/spi-davinci.txt        |   51 ++++++++++
 drivers/spi/spi-davinci.c                          |  102 +++++++++++++++++---
 2 files changed, 139 insertions(+), 14 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-davinci.txt

-- 
1.7.9.5


------------------------------------------------------------------------------
Keep yourself connected to Go Parallel: 
BUILD Helping you discover the best ways to construct your parallel projects.
http://goparallel.sourceforge.net
