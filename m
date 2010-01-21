From: George Shore <george-ofzTHo7+kyPpQY4QmZNtDQ@public.gmane.org>
Subject: [PATCH 1/5] include/linux/spi/dw_spi.h: enable
	platform specific chipselect.
Date: Thu, 21 Jan 2010 11:40:48 +0000
Message-ID: <1264074052-2214-1-git-send-email-george@georgeshore.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: George Shore <george-ofzTHo7+kyPpQY4QmZNtDQ@public.gmane.org>
To: spi-devel-list <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
	David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

The driver core allows for a platform-specific chipselect assert/deassert
function, however the chipselect function in the core doesn't take advantage
of this fact.

This enables the use of a custom function, should it be defined.

Signed-off-by: George Shore <george-ofzTHo7+kyPpQY4QmZNtDQ@public.gmane.org>
---
 include/linux/spi/dw_spi.h |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/include/linux/spi/dw_spi.h b/include/linux/spi/dw_spi.h
index 1a127a3..cc813f9 100644
--- a/include/linux/spi/dw_spi.h
+++ b/include/linux/spi/dw_spi.h
@@ -172,6 +172,10 @@ static inline void spi_chip_sel(struct dw_spi *dws, u16 cs)
 {
 	if (cs > dws->num_cs)
 		return;
+
+	if (dws->cs_control)
+		dws->cs_control(1);
+
 	dw_writel(dws, ser, 1 << cs);
 }
 
-- 
1.6.6.264.gd0743


------------------------------------------------------------------------------
Throughout its 18-year history, RSA Conference consistently attracts the
world's best and brightest in the field, creating opportunities for Conference
attendees to learn about information security's most important issues through
interactions with peers, luminaries and emerging and established companies.
http://p.sf.net/sfu/rsaconf-dev2dev
