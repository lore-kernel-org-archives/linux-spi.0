From: Sowjanya Komatineni <skomatineni@nvidia.com>
Subject: [PATCH V1 05/26] spi: tegra114: use unpacked mode for below 4 byte transfers
Date: Tue, 26 Mar 2019 22:56:26 -0700
Message-ID: <1553666207-11414-5-git-send-email-skomatineni@nvidia.com>
References: <1553666207-11414-1-git-send-email-skomatineni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <ldewangan@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>
To: <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <talho@nvidia.com>, <skomatineni@nvidia.com>, <broonie@kernel.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <kyarlagadda@nvidia.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1553666207-11414-1-git-send-email-skomatineni@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Fixes: use unpacked mode when transfer length is less than 4 bytes.

Packed mode expects minimum transfer length of 4 bytes.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/spi/spi-tegra114.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index dc63536dbda4..716587b663a3 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -259,7 +259,8 @@ static unsigned tegra_spi_calculate_curr_xfer_param(
 
 	tspi->bytes_per_word = DIV_ROUND_UP(bits_per_word, 8);
 
-	if (bits_per_word == 8 || bits_per_word == 16 || bits_per_word == 32) {
+	if ((bits_per_word == 8 || bits_per_word == 16 ||
+	     bits_per_word == 32) && t->len > 3) {
 		tspi->is_packed = 1;
 		tspi->words_per_32bit = 32/bits_per_word;
 	} else {
-- 
2.7.4
