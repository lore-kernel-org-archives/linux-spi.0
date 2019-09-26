From: Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v4 06/19] spi: spidev: use new `word_delay` field for spi transfers
Date: Thu, 26 Sep 2019 13:51:34 +0300
Message-ID: <20190926105147.7839-7-alexandru.ardelean@analog.com>
References: <20190926105147.7839-1-alexandru.ardelean@analog.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Cc: <jic23@kernel.org>, <broonie@kernel.org>, <f.fainelli@gmail.com>,
        <linus.walleij@linaro.org>, <orsonzhai@gmail.com>,
        <baolin.wang@linaro.org>, <zhang.lyra@gmail.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
To: <bcm-kernel-feedback-list@broadcom.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-tegra@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190926105147.7839-1-alexandru.ardelean@analog.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The `word_delay` field had it's type changed to `struct spi_delay`.
This allows users to specify nano-second or clock-cycle delays (if needed).

Converting to use `word_delay` is straightforward: it's just assigning the
value to `word_delay.value` and hard-coding the `word_delay.unit` to
`SPI_DELAY_UNIT_USECS`

This keeps the uapi for spidev un-changed. Changing it can be part of
another changeset and discussion.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/spi/spidev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index 255786f2e844..495319c2fa11 100644
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
