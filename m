From: Viresh Kumar <viresh.kumar-qxv4g6HH51o@public.gmane.org>
Subject: [PATCH V2 0/6] spi/spi-pl022 fixes
Date: Wed, 10 Aug 2011 14:20:53 +0530
Message-ID: <cover.1312965741.git.viresh.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: pratyush.anand-qxv4g6HH51o@public.gmane.org, viresh.kumar-qxv4g6HH51o@public.gmane.org, rajeev-dlh.kumar-qxv4g6HH51o@public.gmane.org,
	bhavna.yadav-qxv4g6HH51o@public.gmane.org, bhupesh.sharma-qxv4g6HH51o@public.gmane.org,
	armando.visconti-qxv4g6HH51o@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org,
	vipin.kumar-qxv4g6HH51o@public.gmane.org, shiraz.hashim-qxv4g6HH51o@public.gmane.org, amit.virdi-qxv4g6HH51o@public.gmane.org,
	vipulkumar.samar-qxv4g6HH51o@public.gmane.org, deepak.sikri-qxv4g6HH51o@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
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

Hi Grant,

I have added Tested-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> on all patches.

This patchset mainly covers following fixes:
- formatting related issues
- Passing GFP_ATOMIC for sg allocation from tasklet
- Fixing calculate_effective_freq() routine
- Allocate/free DMA channels as and when required.

Changes since V1:
- Replace GFP_NOWAIT with GFP_ATOMIC
- Wrote inline routine spi_rate instead of macro

Viresh Kumar (6):
  spi/spi-pl022: Resolve formatting issues
  spi/spi-pl022: Use GFP_ATOMIC for allocation from tasklet
  spi/spi-pl022: Don't allocate more sg than required.
  spi/spi-pl022: calculate_effective_freq() must set rate <= requested
    rate
  spi/spi-pl022: Call pl022_dma_remove(pl022) only if enable_dma is
    true
  spi/spi-pl022: Request/free DMA channels as and when required.

 drivers/spi/spi-pl022.c |  269 ++++++++++++++++++++++++++---------------------
 1 files changed, 151 insertions(+), 118 deletions(-)

-- 
1.7.2.2


------------------------------------------------------------------------------
uberSVN's rich system and user administration capabilities and model 
configuration take the hassle out of deploying and managing Subversion and 
the tools developers use with it. Learn more about uberSVN and get a free 
download at:  http://p.sf.net/sfu/wandisco-dev2dev
