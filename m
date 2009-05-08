From: Daniel Ribeiro <drwyrm@gmail.com>
Subject: pxa2xx_spi: prevent panic case setup() fails
Date: Fri, 08 May 2009 11:11:44 -0300
Message-ID: <1241791904.10342.44.camel@brutus>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: David Brownell <david-b@pacbell.net>, Ned Forrester <nforrester@whoi.edu>,
	openezx-devel <openezx-devel@lists.openezx.org>,
	linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>,
	spi-devel-general <spi-devel-general@lists.sourceforge.net>
To: Eric Miao <eric.y.miao@gmail.com>
Return-path: <openezx-devel-bounces@lists.openezx.org>
List-Unsubscribe: <https://lists.openezx.org/mailman/listinfo/openezx-devel>,
	<mailto:openezx-devel-request@lists.openezx.org?subject=unsubscribe>
List-Archive: <http://lists.openezx.org/pipermail/openezx-devel>
List-Post: <mailto:openezx-devel@lists.openezx.org>
List-Help: <mailto:openezx-devel-request@lists.openezx.org?subject=help>
List-Subscribe: <https://lists.openezx.org/mailman/listinfo/openezx-devel>,
	<mailto:openezx-devel-request@lists.openezx.org?subject=subscribe>
Sender: openezx-devel-bounces@lists.openezx.org
Errors-To: openezx-devel-bounces@lists.openezx.org
List-Id: linux-spi.vger.kernel.org

setup() may fail before ctldata is set, causing a kernel panic on
cleanup().

Signed-off-by: Daniel Ribeiro <drwyrm@gmail.com>

diff --git a/drivers/spi/pxa2xx_spi.c b/drivers/spi/pxa2xx_spi.c
index 885194a..2801307 100644
--- a/drivers/spi/pxa2xx_spi.c
+++ b/drivers/spi/pxa2xx_spi.c
@@ -1373,6 +1373,9 @@ static void cleanup(struct spi_device *spi)
 {
 	struct chip_data *chip = spi_get_ctldata(spi);
 
+	if (!chip)
+		return;
+
 	if (gpio_is_valid(chip->gpio_cs))
 		gpio_free(chip->gpio_cs);
 

-- 
Daniel Ribeiro
