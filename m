From: Beniamino Galvani <b.galvani@gmail.com>
Subject: [PATCH v3 1/4] spi: core: Add spi_transfer_is_last() helper
Date: Sat, 22 Nov 2014 16:21:39 +0100
Message-ID: <1416669702-7841-2-git-send-email-b.galvani@gmail.com>
References: <1416669702-7841-1-git-send-email-b.galvani@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Russell King <linux@arm.linux.org.uk>, Victor Wan <victor.wan@amlogic.com>,
 Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>,
 linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
 Beniamino Galvani <b.galvani@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Kumar Gala <galak@codeaurora.org>, Carlo Caione <carlo@caione.org>,
 Jerry Cao <jerry.cao@amlogic.com>, linux-arm-kernel@lists.infradead.org
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1416669702-7841-1-git-send-email-b.galvani@gmail.com>
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

This adds the function spi_transfer_is_last() which can be used by
drivers to know whether a given transfer is the last one in the
current message.

Signed-off-by: Beniamino Galvani <b.galvani@gmail.com>
---
 include/linux/spi/spi.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 46d188a..a6ef2a8 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -1049,4 +1049,10 @@ spi_unregister_device(struct spi_device *spi)
 extern const struct spi_device_id *
 spi_get_device_id(const struct spi_device *sdev);
 
+static inline bool
+spi_transfer_is_last(struct spi_master *master, struct spi_transfer *xfer)
+{
+	return list_is_last(&xfer->transfer_list, &master->cur_msg->transfers);
+}
+
 #endif /* __LINUX_SPI_H */
-- 
1.9.1
