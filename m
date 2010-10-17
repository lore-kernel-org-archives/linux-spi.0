From: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 14/28] Blackfin: SPI: expand SPI
	bitmasks
Date: Sun, 17 Oct 2010 18:59:27 -0400
Message-ID: <1287356381-31495-15-git-send-email-vapier@gentoo.org>
References: <1287356381-31495-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
        David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
        Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
In-Reply-To: <1287356381-31495-1-git-send-email-vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://blackfin.uclinux.org/mailman/options/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=unsubscribe>
List-Archive: <http://blackfin.uclinux.org/pipermail/uclinux-dist-devel>
List-Post: <mailto:uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
List-Help: <mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=help>
List-Subscribe: <https://blackfin.uclinux.org/mailman/listinfo/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=subscribe>
Sender: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
Errors-To: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Expand the BIT_CTL defines to use the naming convention of the hardware,
and expand the masks to cover all documented bits.

Signed-off-by: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
---
 arch/blackfin/include/asm/bfin5xx_spi.h |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/blackfin/include/asm/bfin5xx_spi.h b/arch/blackfin/include/asm/bfin5xx_spi.h
index ee3ecb9..126d25e 100644
--- a/arch/blackfin/include/asm/bfin5xx_spi.h
+++ b/arch/blackfin/include/asm/bfin5xx_spi.h
@@ -26,11 +26,14 @@
 #define BIT_CTL_ENABLE      0x4000
 #define BIT_CTL_OPENDRAIN   0x2000
 #define BIT_CTL_MASTER      0x1000
-#define BIT_CTL_POLAR       0x0800
-#define BIT_CTL_PHASE       0x0400
-#define BIT_CTL_BITORDER    0x0200
+#define BIT_CTL_CPOL        0x0800
+#define BIT_CTL_CPHA        0x0400
+#define BIT_CTL_LSBF        0x0200
 #define BIT_CTL_WORDSIZE    0x0100
-#define BIT_CTL_MISOENABLE  0x0020
+#define BIT_CTL_EMISO       0x0020
+#define BIT_CTL_PSSE        0x0010
+#define BIT_CTL_GM          0x0008
+#define BIT_CTL_SZ          0x0004
 #define BIT_CTL_RXMOD       0x0000
 #define BIT_CTL_TXMOD       0x0001
 #define BIT_CTL_TIMOD_DMA_TX 0x0003
-- 
1.7.3.1
