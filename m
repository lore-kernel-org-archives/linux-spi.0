From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: Remove warning in spi_split_transfers_maxsize()" to the
 spi tree
Date: Mon, 15 Apr 2019 09:53:33 +0100 (BST)
Message-ID: <20190415085333.3996811279E1@debutante.sirena.org.uk>
References: <20190413182415.38543-2-noralf@tronnes.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1331447000=="
Cc: stefan.wahren@i2se.com, dri-devel@lists.freedesktop.org,
 linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
 linux-rpi-kernel@lists.infradead.org, meghana.madhyastha@gmail.com,
 kernel@martin.sperl.org
To: =?UTF-8?Q?Noralf=20Tr=C3=83=C2=B8nnes=20=3Cnora?=
 =?UTF-8?Q?lf=40tronnes=2Eorg=3E?=
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20190413182415.38543-2-noralf@tronnes.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
List-Id: linux-spi.vger.kernel.org

--===============1331447000==
Content-Type: text/plain

The patch

   spi: Remove warning in spi_split_transfers_maxsize()

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

>From 179f7949c0663f1923564acf0e626d459ea80047 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>
Date: Sat, 13 Apr 2019 20:24:12 +0200
Subject: [PATCH] spi: Remove warning in spi_split_transfers_maxsize()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Don't warn about splitting transfers, the info is available in the
statistics if needed.

Signed-off-by: Noralf Trønnes <noralf@tronnes.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 86a31340ad03..3c6c6101b611 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2788,11 +2788,6 @@ static int __spi_split_transfer_maxsize(struct spi_controller *ctlr,
 	size_t offset;
 	size_t count, i;
 
-	/* warn once about this fact that we are splitting a transfer */
-	dev_warn_once(&msg->spi->dev,
-		      "spi_transfer of length %i exceed max length of %zu - needed to split transfers\n",
-		      xfer->len, maxsize);
-
 	/* calculate how many we have to replace */
 	count = DIV_ROUND_UP(xfer->len, maxsize);
 
-- 
2.20.1


--===============1331447000==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVs

--===============1331447000==--
