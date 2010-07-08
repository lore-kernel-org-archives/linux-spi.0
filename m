From: Brian Niebuhr <bniebuhr3-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v4 0/1] davinci: spi: replace existing
	driver
Date: Thu,  8 Jul 2010 17:39:04 -0500
Message-ID: <1278628745-18502-1-git-send-email-bniebuhr@efjohnson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
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

Fixed in this version:

-Fixed whitespace mangling


** NOTE **

This patch requires the EDMA patch at:

http://linux.davincidsp.com/pipermail/davinci-linux-open-source/2010-March/018022.html

which is queued waiting on another driver fix, for DMA mode to work correctly.


Brian Niebuhr (1):
  davinci: spi: replace existing driver

 arch/arm/mach-davinci/board-dm355-evm.c     |   10 +
 arch/arm/mach-davinci/board-dm355-leopard.c |   10 +
 arch/arm/mach-davinci/board-dm365-evm.c     |   10 +
 arch/arm/mach-davinci/dm355.c               |    8 +-
 arch/arm/mach-davinci/dm365.c               |    6 -
 arch/arm/mach-davinci/include/mach/spi.h    |   35 +-
 drivers/spi/davinci_spi.c                   | 1112 ++++++++++++---------------
 7 files changed, 528 insertions(+), 663 deletions(-)


------------------------------------------------------------------------------
This SF.net email is sponsored by Sprint
What will you do first with EVO, the first 4G phone?
Visit sprint.com/first -- http://p.sf.net/sfu/sprint-com-first
