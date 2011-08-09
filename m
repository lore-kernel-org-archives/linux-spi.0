From: Viresh Kumar <viresh.kumar-qxv4g6HH51o@public.gmane.org>
Subject: [PATCH 0/6] spi/spi-pl022 fixes
Date: Tue, 9 Aug 2011 16:35:17 +0530
Message-ID: <cover.1312887860.git.viresh.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: vipin.kumar-qxv4g6HH51o@public.gmane.org, viresh.kumar-qxv4g6HH51o@public.gmane.org, rajeev-dlh.kumar-qxv4g6HH51o@public.gmane.org,
	bhavna.yadav-qxv4g6HH51o@public.gmane.org, bhupesh.sharma-qxv4g6HH51o@public.gmane.org,
	pratyush.anand-qxv4g6HH51o@public.gmane.org, armando.visconti-qxv4g6HH51o@public.gmane.org,
	shiraz.hashim-qxv4g6HH51o@public.gmane.org, amit.virdi-qxv4g6HH51o@public.gmane.org, vipulkumar.samar-qxv4g6HH51o@public.gmane.org,
	deepak.sikri-qxv4g6HH51o@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
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

This patchset mainly covers following fixes:
- formatting related issues
- Passing GFP_NOWAIT for sg allocation from tasklet
- Fixing calculate_effective_freq() routine
- Allocate/free DMA channels as and when required.

I have rebased them on linux-next/master over following patch:

commit 9be355da3bae9feb09cdaf80c3ab560f1f0172cb
Author: Stephen Rothwell <sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org>
Date:   Tue Aug 9 13:30:19 2011 +1000

    Add linux-next specific files for 20110809
    
    Signed-off-by: Stephen Rothwell <sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org>

Looking forward to see your view on the patchset.

Viresh Kumar (6):
  spi/spi-pl022: Resolve formatting issues
  spi/spi-pl022: Use GFP_NOWAIT for allocation from tasklet
  spi/spi-pl022: Don't allocate more sg than required.
  spi/spi-pl022: calculate_effective_freq() must set rate <= requested
    rate
  spi/spi-pl022: Call pl022_dma_remove(pl022) only if enable_dma is
    true
  spi/spi-pl022: Request/free DMA channels as and when required.

 drivers/spi/spi-pl022.c |  265 ++++++++++++++++++++++++++---------------------
 1 files changed, 147 insertions(+), 118 deletions(-)

-- 
1.7.2.2


------------------------------------------------------------------------------
uberSVN's rich system and user administration capabilities and model 
configuration take the hassle out of deploying and managing Subversion and 
the tools developers use with it. Learn more about uberSVN and get a free 
download at:  http://p.sf.net/sfu/wandisco-dev2dev
