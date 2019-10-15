From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: spidev: use new `word_delay` field for spi transfers" to the spi tree
Date: Tue, 15 Oct 2019 12:12:25 +0100 (BST)
Message-ID: <20191015111225.8434427419E4@ypsilon.sirena.org.uk>
References: <20190926105147.7839-7-alexandru.ardelean@analog.com>
Cc: baolin.wang@linaro.org, bcm-kernel-feedback-list@broadcom.com,
        broonie@kernel.org, f.fainelli@gmail.com, jic23@kernel.org,
        linus.walleij@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, orsonzhai@gmail.com,
        zhang.lyra@gmail.com
To: Alexandru Ardelean <alexandru.ardelean@analog.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190926105147.7839-7-alexandru.ardelean@analog.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: spidev: use new `word_delay` field for spi transfers

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.5

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

>From ec3fa72fa8404128771a095d5a56b738752ba9ff Mon Sep 17 00:00:00 2001
From: Alexandru Ardelean <alexandru.ardelean@analog.com>
Date: Thu, 26 Sep 2019 13:51:34 +0300
Subject: [PATCH] spi: spidev: use new `word_delay` field for spi transfers

The `word_delay` field had it's type changed to `struct spi_delay`.
This allows users to specify nano-second or clock-cycle delays (if needed).

Converting to use `word_delay` is straightforward: it's just assigning the
value to `word_delay.value` and hard-coding the `word_delay.unit` to
`SPI_DELAY_UNIT_USECS`

This keeps the uapi for spidev un-changed. Changing it can be part of
another changeset and discussion.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Link: https://lore.kernel.org/r/20190926105147.7839-7-alexandru.ardelean@analog.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spidev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index 3ea9d8a3e6e8..d63235dcb231 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -267,7 +267,8 @@ static int spidev_message(struct spidev_data *spidev,
 		k_tmp->bits_per_word = u_tmp->bits_per_word;
 		k_tmp->delay_usecs = u_tmp->delay_usecs;
 		k_tmp->speed_hz = u_tmp->speed_hz;
-		k_tmp->word_delay_usecs = u_tmp->word_delay_usecs;
+		k_tmp->word_delay.value = u_tmp->word_delay_usecs;
+		k_tmp->word_delay.unit = SPI_DELAY_UNIT_USECS;
 		if (!k_tmp->speed_hz)
 			k_tmp->speed_hz = spidev->speed_hz;
 #ifdef VERBOSE
-- 
2.20.1
