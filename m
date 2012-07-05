From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [GIT PULL] PL022 patches for v3.6
Date: Thu, 5 Jul 2012 16:27:36 +0200
Message-ID: <CACRpkdYRjtdtswX+y1yOjEwN9cA9K7M0k_=u=LhU0_0yf4VyeA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi mailing list <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	Alexandre Pereira <aletes.xgr-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Virupax Sadashivpetimath <virupax.sadashivpetimath-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
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

Hi Wolfram,

since I guess you're gonna harvest SPI patches for the next merge window
could you please pull this set of PL022 patches?

The following changes since commit 6887a4131da3adaab011613776d865f4bcfb5678:

  Linux 3.5-rc5 (2012-06-30 16:08:57 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git
pl022

for you to fetch changes up to 5b063b87deba33ed1676db9d16c52ede662132d8:

  spi/pl022: cleanup pl022 header documentation (2012-07-02 13:55:36 +0200)

----------------------------------------------------------------
Alexandre Pereira da Silva (1):
      spi/pl022: cleanup pl022 header documentation

Linus Walleij (2):
      spi/pl022: delete DB5500 support
      spi/pl022: enable runtime PM

Virupax Sadashivpetimath (1):
      spi/pl022: disable port when unused

 drivers/spi/spi-pl022.c    |   23 +++++++++--------------
 include/linux/amba/pl022.h |    9 +--------
 2 files changed, 10 insertions(+), 22 deletions(-)

Thanks,
Linus Walleij

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
