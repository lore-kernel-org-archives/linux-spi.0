From: George Shore <george-ofzTHo7+kyPpQY4QmZNtDQ@public.gmane.org>
Subject: [PATCH 2/5] spi/dw_spi: add return value to
	empty mrst_spi_debugfs_init()
Date: Thu, 21 Jan 2010 11:40:49 +0000
Message-ID: <1264074052-2214-2-git-send-email-george@georgeshore.com>
References: <1264074052-2214-1-git-send-email-george@georgeshore.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: George Shore <george-ofzTHo7+kyPpQY4QmZNtDQ@public.gmane.org>
To: spi-devel-list <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
	David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1264074052-2214-1-git-send-email-george-ofzTHo7+kyPpQY4QmZNtDQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

As per the function signature.

Signed-off-by: George Shore <george-ofzTHo7+kyPpQY4QmZNtDQ@public.gmane.org>
---
 drivers/spi/dw_spi.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/spi/dw_spi.c b/drivers/spi/dw_spi.c
index f713af8..56d53a5 100644
--- a/drivers/spi/dw_spi.c
+++ b/drivers/spi/dw_spi.c
@@ -152,6 +152,7 @@ static void mrst_spi_debugfs_remove(struct dw_spi *dws)
 #else
 static inline int mrst_spi_debugfs_init(struct dw_spi *dws)
 {
+	return 0;
 }
 
 static inline void mrst_spi_debugfs_remove(struct dw_spi *dws)
-- 
1.6.6.264.gd0743


------------------------------------------------------------------------------
Throughout its 18-year history, RSA Conference consistently attracts the
world's best and brightest in the field, creating opportunities for Conference
attendees to learn about information security's most important issues through
interactions with peers, luminaries and emerging and established companies.
http://p.sf.net/sfu/rsaconf-dev2dev
