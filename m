From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: [git pull] SPI bug fixes
Date: Fri, 3 May 2013 11:04:18 +0100
Message-ID: <CACxGe6sax5dPF3SB1oBRUpEnKde6QE9eXM+bR444Re=MLad6sw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
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

Hi Mark,

Here are some commits that I picked up a while ago but for some reason
never asked Linus to pull them. :( Can you pull this branch into your
tree for your next pull request to Linus?

Thanks,
g.


The following changes since commit fe6969094214350e586d56fbfa3ef97cdd74b270:

  Merge tag 'dm-3.9-fixes-2' of
git://git.kernel.org/pub/scm/linux/kernel/git/agk/linux-dm (2013-04-05
19:30:14 -0700)

are available in the git repository at:

  git://git.secretlab.ca/git/linux spi/merge

for you to fetch changes up to 0d2d0cc5216db678070efc911ef47f4cb53b4aad:

  spi/davinci: fix module build error (2013-04-07 10:12:21 +0100)

----------------------------------------------------------------
Andreas Larsson (2):
      spi: Initialize cs_gpio and cs_gpios with -ENOENT
      spi: Return error from of_spi_register_master on bad "cs-gpios" property

Joachim Eastwood (1):
      spi/atmel: fix speed_hz check in atmel_spi_transfer()

Manjunathappa, Prakash (1):
      spi/davinci: fix module build error

 drivers/spi/spi-atmel.c   | 4 ++--
 drivers/spi/spi-davinci.c | 2 +-
 drivers/spi/spi.c         | 9 ++++++---
 include/linux/spi/spi.h   | 4 ++--
 4 files changed, 11 insertions(+), 8 deletions(-)

--
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

------------------------------------------------------------------------------
Get 100% visibility into Java/.NET code with AppDynamics Lite
It's a free troubleshooting tool designed for production
Get down to code-level detail for bottlenecks, with <2% overhead.
Download for free and get started troubleshooting in minutes.
http://p.sf.net/sfu/appdyn_d2d_ap2
