From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: AD ASoC: declare missing of table" to
	the spi tree
Date: Thu,  2 May 2019 03:19:00 +0100 (BST)
Message-ID: <20190502021900.5D8EE441D3D@finisterre.ee.mobilebroadband>
References: <1555960353-8836-1-git-send-email-dagmcr@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, tiwai@suse.com,
 lgirdwood@gmail.com, linux-spi@vger.kernel.org,
 Mark Brown <broonie@kernel.org>, dagmcr@gmail.com,
 Javier Martinez Canillas <javier@dowhile0.org>
To: Daniel Gomez <dagmcr@gmail.com>
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1555960353-8836-1-git-send-email-dagmcr@gmail.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
List-Id: linux-spi.vger.kernel.org

The patch

   spi: AD ASoC: declare missing of table

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.2

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 2a168e10d6db7b77190c55d994e42fc5a58fc8e5 Mon Sep 17 00:00:00 2001
From: Daniel Gomez <dagmcr@gmail.com>
Date: Mon, 22 Apr 2019 21:12:33 +0200
Subject: [PATCH] spi: AD ASoC: declare missing of table

Add missing <of_device_id> table for SPI driver relying on SPI
device match since compatible is in a DT binding or in a DTS.

Before this patch:
modinfo sound/soc/codecs/snd-soc-adau1977-spi.ko | grep alias
alias:          spi:adau1979
alias:          spi:adau1978
alias:          spi:adau1977

After this patch:
modinfo sound/soc/codecs/snd-soc-adau1977-spi.ko | grep alias
alias:          of:N*T*Cadi,adau1979C*
alias:          of:N*T*Cadi,adau1979
alias:          of:N*T*Cadi,adau1978C*
alias:          of:N*T*Cadi,adau1978
alias:          of:N*T*Cadi,adau1977C*
alias:          of:N*T*Cadi,adau1977
alias:          spi:adau1979
alias:          spi:adau1978
alias:          spi:adau1977

Reported-by: Javier Martinez Canillas <javier@dowhile0.org>
Signed-off-by: Daniel Gomez <dagmcr@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/adau1977-spi.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/sound/soc/codecs/adau1977-spi.c b/sound/soc/codecs/adau1977-spi.c
index 84ffbde9583f..2baf61567b59 100644
--- a/sound/soc/codecs/adau1977-spi.c
+++ b/sound/soc/codecs/adau1977-spi.c
@@ -10,6 +10,8 @@
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/regmap.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/spi/spi.h>
 #include <sound/soc.h>
 
@@ -54,9 +56,18 @@ static const struct spi_device_id adau1977_spi_ids[] = {
 };
 MODULE_DEVICE_TABLE(spi, adau1977_spi_ids);
 
+static const struct of_device_id adau1977_spi_of_match[] = {
+        { .compatible = "adi,adau1977" },
+        { .compatible = "adi,adau1978" },
+        { .compatible = "adi,adau1979" },
+        { },
+};
+MODULE_DEVICE_TABLE(of, adau1977_spi_of_match);
+
 static struct spi_driver adau1977_spi_driver = {
 	.driver = {
 		.name = "adau1977",
+		.of_match_table = of_match_ptr(adau1977_spi_of_match),
 	},
 	.probe = adau1977_spi_probe,
 	.id_table = adau1977_spi_ids,
-- 
2.20.1
