From: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 20/49] spi: davinci: check for NULL buffer pointer before
	using it
Date: Wed, 17 Nov 2010 16:13:52 +0530
Message-ID: <1289990661-30126-21-git-send-email-nsekhar@ti.com>
References: <1289990661-30126-1-git-send-email-nsekhar@ti.com>
	<1289990661-30126-2-git-send-email-nsekhar@ti.com>
	<1289990661-30126-3-git-send-email-nsekhar@ti.com>
	<1289990661-30126-4-git-send-email-nsekhar@ti.com>
	<1289990661-30126-5-git-send-email-nsekhar@ti.com>
	<1289990661-30126-6-git-send-email-nsekhar@ti.com>
	<1289990661-30126-7-git-send-email-nsekhar@ti.com>
	<1289990661-30126-8-git-send-email-nsekhar@ti.com>
	<1289990661-30126-9-git-send-email-nsekhar@ti.com>
	<1289990661-30126-10-git-send-email-nsekhar@ti.com>
	<1289990661-30126-11-git-send-email-nsekhar@ti.com>
	<1289990661-30126-12-git-send-email-nsekhar@ti.com>
	<1289990661-30126-13-git-send-email-nsekhar@ti.com>
	<1289990661-30126-14-git-send-email-nsekhar@ti.com>
	<1289990661-30126-15-git-send-email-nsekhar@ti.com>
	<1289990661-30126-16-git-send-email-nsekhar@ti.com>
	<1289990661-30126-17-git-send-email-nsekhar@ti.com>
	<1289990661-30126-18-git-send-email-nsekhar@ti.com>
	<1289990661-30126-19-git-send-email-nsekhar@ti.com>
	<1289990661-30126-20-git-send-email-nsekhar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
        davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org,
        David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <1289990661-30126-20-git-send-email-nsekhar-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
List-Id: linux-spi.vger.kernel.org

From: Brian Niebuhr <bniebuhr-JaPwekKOx1yaMJb+Lgu22Q@public.gmane.org>

In the davinci_spi_{tx|rx}_u{8|16}() functions, check for
buffer pointer being valid before using it. While providing
for better error checking, this change will help simplify
code in the caller.

Signed-off-by: Brian Niebuhr <bniebuhr-JaPwekKOx1yaMJb+Lgu22Q@public.gmane.org>
Tested-By: Michael Williamson <michael.williamson-wZX4cNJlHJ2sVWG7oymsAA@public.gmane.org>
Signed-off-by: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
---
 drivers/spi/davinci_spi.c |   40 ++++++++++++++++++++++------------------
 1 files changed, 22 insertions(+), 18 deletions(-)

diff --git a/drivers/spi/davinci_spi.c b/drivers/spi/davinci_spi.c
index b0b338f..10b0a08 100644
--- a/drivers/spi/davinci_spi.c
+++ b/drivers/spi/davinci_spi.c
@@ -158,37 +158,41 @@ static unsigned use_dma;
 
 static void davinci_spi_rx_buf_u8(u32 data, struct davinci_spi *davinci_spi)
 {
-	u8 *rx = davinci_spi->rx;
-
-	*rx++ = (u8)data;
-	davinci_spi->rx = rx;
+	if (davinci_spi->rx) {
+		u8 *rx = davinci_spi->rx;
+		*rx++ = (u8)data;
+		davinci_spi->rx = rx;
+	}
 }
 
 static void davinci_spi_rx_buf_u16(u32 data, struct davinci_spi *davinci_spi)
 {
-	u16 *rx = davinci_spi->rx;
-
-	*rx++ = (u16)data;
-	davinci_spi->rx = rx;
+	if (davinci_spi->rx) {
+		u16 *rx = davinci_spi->rx;
+		*rx++ = (u16)data;
+		davinci_spi->rx = rx;
+	}
 }
 
 static u32 davinci_spi_tx_buf_u8(struct davinci_spi *davinci_spi)
 {
-	u32 data;
-	const u8 *tx = davinci_spi->tx;
-
-	data = *tx++;
-	davinci_spi->tx = tx;
+	u32 data = 0;
+	if (davinci_spi->tx) {
+		const u8 *tx = davinci_spi->tx;
+		data = *tx++;
+		davinci_spi->tx = tx;
+	}
 	return data;
 }
 
 static u32 davinci_spi_tx_buf_u16(struct davinci_spi *davinci_spi)
 {
-	u32 data;
-	const u16 *tx = davinci_spi->tx;
-
-	data = *tx++;
-	davinci_spi->tx = tx;
+	u32 data = 0;
+	if (davinci_spi->tx) {
+		const u16 *tx = davinci_spi->tx;
+		data = *tx++;
+		davinci_spi->tx = tx;
+	}
 	return data;
 }
 
-- 
1.7.3.2
