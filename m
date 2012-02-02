From: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Subject: [PATCH 0/3] spi: generalize message queueing
Date: Thu, 2 Feb 2012 13:59:21 +0100
Message-ID: <1328187561-12875-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Viresh Kumar <viresh.kumar-qxv4g6HH51o@public.gmane.org>,
	Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
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

From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

This is a patch series based on a suggestion from Mark Brown
to make the message queueing found in PL022 more general.

[1/3] is just the same minor update to the PL022 driver
 that was discussed before (I hope this can atleast go in).

[2/3] refactors the master registration a bit (could probably
  be nice no matter whether the next gets merged)

[3/3] is the bulf of the patch set moving the transfer queue
  out of the PL022 driver and rewriting it a bit, making it
  generic.

I have pretty good hopes for that this queueing code is solid,
my colleague Chris Blair has run very demanding megabit loads
using this queue, and I've left most of the logic in it intact.

So tell me if this is the right direction, else let's just do
[1/3] and maybe [2/3].

Linus Walleij


Chris Blair (1):
  spi/pl022: Add high priority message pump support

Linus Walleij (2):
  spi: split spi_register_master
  spi: create an optional message queueing infrastructure

 Documentation/spi/spi-summary |   56 +++++-
 drivers/spi/Kconfig           |    5 +
 drivers/spi/spi-pl022.c       |  288 ++++++---------------------
 drivers/spi/spi.c             |  444 ++++++++++++++++++++++++++++++++++++++---
 include/linux/amba/pl022.h    |    3 +
 include/linux/spi/spi.h       |   53 +++++
 6 files changed, 584 insertions(+), 265 deletions(-)

-- 
1.7.8


------------------------------------------------------------------------------
Keep Your Developer Skills Current with LearnDevNow!
The most comprehensive online learning library for Microsoft developers
is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
Metro Style Apps, more. Free future releases when you subscribe now!
http://p.sf.net/sfu/learndevnow-d2d
