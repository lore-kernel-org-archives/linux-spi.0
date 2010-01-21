From: George Shore <george-ofzTHo7+kyPpQY4QmZNtDQ@public.gmane.org>
Subject: [PATCH 3/5] spi/dw_spi: fixed a spelling typo
	in a warning message.
Date: Thu, 21 Jan 2010 11:40:50 +0000
Message-ID: <1264074052-2214-3-git-send-email-george@georgeshore.com>
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

Signed-off-by: George Shore <george-ofzTHo7+kyPpQY4QmZNtDQ@public.gmane.org>
---
 drivers/spi/dw_spi.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/spi/dw_spi.c b/drivers/spi/dw_spi.c
index 56d53a5..01292da 100644
--- a/drivers/spi/dw_spi.c
+++ b/drivers/spi/dw_spi.c
@@ -169,7 +169,7 @@ static void wait_till_not_busy(struct dw_spi *dws)
 			return;
 	}
 	dev_err(&dws->master->dev,
-		"DW SPI: Stutus keeps busy for 1000us after a read/write!\n");
+		"DW SPI: Status keeps busy for 1000us after a read/write!\n");
 }
 
 static void flush(struct dw_spi *dws)
-- 
1.6.6.264.gd0743


------------------------------------------------------------------------------
Throughout its 18-year history, RSA Conference consistently attracts the
world's best and brightest in the field, creating opportunities for Conference
attendees to learn about information security's most important issues through
interactions with peers, luminaries and emerging and established companies.
http://p.sf.net/sfu/rsaconf-dev2dev
