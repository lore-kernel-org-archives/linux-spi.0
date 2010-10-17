From: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 27/28] Blackfin SPI: check per-transfer bits_per_word
Date: Sun, 17 Oct 2010 18:59:40 -0400
Message-ID: <1287356381-31495-28-git-send-email-vapier@gentoo.org>
References: <1287356381-31495-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org, Bob Liu <lliubbo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1287356381-31495-1-git-send-email-vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

From: Bob Liu <lliubbo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Currently, if the bits_per_word when doing a transfer is not 8bits, we
always treat it as 16bits when we should actually be returning an error.

Signed-off-by: Bob Liu <lliubbo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi_bfin5xx.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/drivers/spi/spi_bfin5xx.c b/drivers/spi/spi_bfin5xx.c
index 21de860..bd18214 100644
--- a/drivers/spi/spi_bfin5xx.c
+++ b/drivers/spi/spi_bfin5xx.c
@@ -644,11 +644,16 @@ static void bfin_spi_pump_transfers(unsigned long data)
 		drv_data->len = transfer->len;
 		cr_width = 0;
 		drv_data->ops = &bfin_transfer_ops_u8;
-	} else {
+	} else if (bits_per_word == 16) {
 		drv_data->n_bytes = 2;
 		drv_data->len = (transfer->len) >> 1;
 		cr_width = BIT_CTL_WORDSIZE;
 		drv_data->ops = &bfin_transfer_ops_u16;
+	} else {
+		dev_err(&drv_data->pdev->dev, "transfer: unsupported bits_per_word\n");
+		message->status = -EINVAL;
+		bfin_spi_giveback(drv_data);
+		return;
 	}
 	cr = read_CTRL(drv_data) & ~(BIT_CTL_TIMOD | BIT_CTL_WORDSIZE);
 	cr |= cr_width;
-- 
1.7.3.1


------------------------------------------------------------------------------
Download new Adobe(R) Flash(R) Builder(TM) 4
The new Adobe(R) Flex(R) 4 and Flash(R) Builder(TM) 4 (formerly 
Flex(R) Builder(TM)) enable the development of rich applications that run
across multiple browsers and platforms. Download your free trials today!
http://p.sf.net/sfu/adobe-dev2dev
