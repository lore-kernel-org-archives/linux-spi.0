From: Amelie Delaunay <amelie.delaunay@st.com>
Subject: [PATCHv2 4/9] spi: stm32: replace st, spi-midi with st,
 spi-midi-ns to fit bindings
Date: Tue, 27 Jun 2017 17:45:16 +0200
Message-ID: <1498578321-13980-5-git-send-email-amelie.delaunay@st.com>
References: <1498578321-13980-1-git-send-email-amelie.delaunay@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: devicetree@vger.kernel.org, Amelie Delaunay <amelie.delaunay@st.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-spi@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark
 Rutland <mark.rutland@arm.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@st.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1498578321-13980-1-git-send-email-amelie.delaunay@st.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

This patch fixes the optional dt property used to set master inter-data
idleness.

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 drivers/spi/spi-stm32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index ca38c24..0997d6d 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -582,7 +582,7 @@ static int stm32_spi_prepare_msg(struct spi_master *master,
 
 	/* SPI slave device may need time between data frames */
 	spi->cur_midi = 0;
-	if (np && !of_property_read_u32(np, "st,spi-midi", &spi->cur_midi))
+	if (np && !of_property_read_u32(np, "st,spi-midi-ns", &spi->cur_midi))
 		dev_dbg(spi->dev, "%dns inter-data idleness\n", spi->cur_midi);
 
 	if (spi_dev->mode & SPI_CPOL)
-- 
1.9.1
