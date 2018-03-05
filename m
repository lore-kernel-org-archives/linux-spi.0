From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] spi: tegra20-slink: use true and false for boolean values
Date: Mon, 5 Mar 2018 17:53:39 -0600
Message-ID: <20180305235339.GA646@embeddedgus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>
To: Laxman Dewangan <ldewangan@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Assign true or false to boolean variables instead of an integer value.

This issue was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/spi/spi-tegra20-slink.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-tegra20-slink.c b/drivers/spi/spi-tegra20-slink.c
index 3e12d5f..6f7b946b 100644
--- a/drivers/spi/spi-tegra20-slink.c
+++ b/drivers/spi/spi-tegra20-slink.c
@@ -276,10 +276,10 @@ static unsigned tegra_slink_calculate_curr_xfer_param(
 	tspi->bytes_per_word = DIV_ROUND_UP(bits_per_word, 8);
 
 	if (bits_per_word == 8 || bits_per_word == 16) {
-		tspi->is_packed = 1;
+		tspi->is_packed = true;
 		tspi->words_per_32bit = 32/bits_per_word;
 	} else {
-		tspi->is_packed = 0;
+		tspi->is_packed = false;
 		tspi->words_per_32bit = 1;
 	}
 	tspi->packed_size = tegra_slink_get_packed_size(tspi, t);
-- 
2.7.4
