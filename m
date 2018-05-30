From: Frieder Schrempf <frieder.schrempf@exceet.de>
Subject: [PATCH 02/11] mtd: m25p80: Call spi_mem_get_name() to let controller
 set a custom name
Date: Wed, 30 May 2018 15:14:31 +0200
Message-ID: <1527686082-15142-3-git-send-email-frieder.schrempf@exceet.de>
References: <1527686082-15142-1-git-send-email-frieder.schrempf@exceet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: yogeshnarayan.gaur@nxp.com, Philipp Puschmann <pp@emlix.com>,
 richard@nod.at, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 prabhakar.kushwaha@nxp.com, Frieder Schrempf <frieder.schrempf@exceet.de>,
 Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>, marek.vasut@gmail.com,
 han.xu@nxp.com, broonie@kernel.org, miquel.raynal@bootlin.com,
 fabio.estevam@nxp.com, david.wolfe@nxp.com, computersforpeace@gmail.com,
 dwmw2@infradead.org, linux-kernel@vger.kernel.org
To: linux-mtd@lists.infradead.org, boris.brezillon@bootlin.com,
 linux-spi@vger.kernel.org
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <1527686082-15142-1-git-send-email-frieder.schrempf@exceet.de>
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

By calling spi_mem_get_name(), the driver of the (Q)SPI controller can
set a custom name for the memory device if necessary.
This is useful to keep mtdparts compatible when controller drivers are
ported from the MTD to the SPI layer.

Signed-off-by: Frieder Schrempf <frieder.schrempf@exceet.de>
---
 drivers/mtd/devices/m25p80.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
index 3dc022d..e1ee3b9 100644
--- a/drivers/mtd/devices/m25p80.c
+++ b/drivers/mtd/devices/m25p80.c
@@ -199,8 +199,7 @@ static int m25p_probe(struct spi_mem *spimem)
 			hwcaps.mask |= SNOR_HWCAPS_READ_1_2_2;
 	}
 
-	if (data && data->name)
-		nor->mtd.name = data->name;
+	nor->mtd.name = spi_mem_get_name(spimem);
 
 	/* For some (historical?) reason many platforms provide two different
 	 * names in flash_platform_data: "name" and "type". Quite often name is
-- 
2.7.4


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
