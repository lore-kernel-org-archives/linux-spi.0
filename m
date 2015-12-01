From: Michal Suchanek <hramrach@gmail.com>
Subject: [PATCH v5 10/10] spi: m25p80: read in spi_max_transfer_size chunks
Date: 1 Dec 2015 16:51:06 -0000
Message-ID: <3b5bdc1fd88b1f18cddc926f85fb79c158e8f4eb.1448988089.git.hramrach@gmail.com>
References: <cover.1448988089.git.hramrach@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Heiner Kallweit <hkallweit1@gmail.com>,
  David Woodhouse <dwmw2@infradead.org>,
  Brian Norris <computersforpeace@gmail.com>, Han Xu <han.xu@freescale.com>,
  Mark Brown <broonie@kernel.org>, Michal Suchanek <hramrach@gmail.com>,
  Boris Brezillon <boris.brezillon@free-electrons.com>,
  Javier Martinez Canillas <javier@osg.samsung.com>,
  Stephen Warren <swarren@nvidia.com>, "Andrew F. Davis" <afd@ti.com>,
  Marek Vasut <marex@denx.de>, "Rafał Miłecki" <zajec5@gmail.com>,
  Mika Westerberg <mika.westerberg@linux.intel.com>,
  Gabor Juhos <juhosg@openwrt.org>,
  "Bean Huo 霍斌斌 " <beanhuo@micron.com>,
  Furquan Shaikh <furquan@google.com>, linux-mtd@lists.infradead.org,
  linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <cover.1448988089.git.hramrach@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

Take into account transfer size limitation of SPI master.

Signed-off-by: Michal Suchanek <hramrach@gmail.com>
---
 drivers/mtd/devices/m25p80.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
index 58ecfa4..4f21755 100644
--- a/drivers/mtd/devices/m25p80.c
+++ b/drivers/mtd/devices/m25p80.c
@@ -150,7 +150,10 @@ static ssize_t m25p80_read(struct spi_nor *nor, loff_t from, size_t len,
 
 	t[1].rx_buf = buf;
 	t[1].rx_nbits = m25p80_rx_nbits(nor);
-	t[1].len = len;
+	if (spi_max_transfer_size(spi))
+		t[1].len = min_t(size_t, len, spi_max_transfer_size(spi));
+	else
+		t[1].len = len;
 	spi_message_add_tail(&t[1], &m);
 
 	ret = spi_sync(spi, &m);
-- 
2.6.2


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
