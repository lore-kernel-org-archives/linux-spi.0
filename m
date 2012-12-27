From: Gabor Juhos <juhosg-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
Subject: [PATCH 0/6] spi/ath79: various fixes
Date: Thu, 27 Dec 2012 10:42:23 +0100
Message-ID: <1356601349-23617-1-git-send-email-juhosg@openwrt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Gabor Juhos <juhosg-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
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

This patch set contain various fixes for the spi-ath79 driver.

Gabor Juhos (6):
  spi/ath79: add delay between SCK changes
  spi/ath79: add missing HIGH->LOW SCK transition
  spi/ath79: remove superfluous chip select code
  spi/ath79: use gpio_request_one
  spi/ath79: avoid multiple initialization of the SPI controller
  spi/ath79: add shutdown handler

 drivers/spi/spi-ath79.c |  121 ++++++++++++++++++++++++++++++++++-------------
 1 file changed, 88 insertions(+), 33 deletions(-)

-- 
1.7.10


------------------------------------------------------------------------------
Master Visual Studio, SharePoint, SQL, ASP.NET, C# 2012, HTML5, CSS,
MVC, Windows 8 Apps, JavaScript and much more. Keep your skills current
with LearnDevNow - 3,200 step-by-step video tutorials by Microsoft
MVPs and experts. ON SALE this month only -- learn more at:
http://p.sf.net/sfu/learnmore_122712
