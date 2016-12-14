From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: fsl-lpspi: Pre-initialize ret in fsl_lpspi_transfer_one_msg()" to the spi tree
Date: Wed, 14 Dec 2016 18:03:58 +0000
Message-ID: <E1cHDuI-0007Gv-Vy@debutante>
References: <1481714455-14224-1-git-send-email-geert@linux-m68k.org>
Cc: Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        Gao Pan <pandy.gao@nxp.com>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1481714455-14224-1-git-send-email-geert@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: fsl-lpspi: Pre-initialize ret in fsl_lpspi_transfer_one_msg()

has been applied to the spi tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

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

>From cc4a7ffe02c95f537541c91e9842e3710decae6e Mon Sep 17 00:00:00 2001
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 14 Dec 2016 12:20:55 +0100
Subject: [PATCH] spi: fsl-lpspi: Pre-initialize ret in
 fsl_lpspi_transfer_one_msg()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

With gcc 4.1.2:

    drivers/spi/spi-fsl-lpspi.c: In function ‘fsl_lpspi_transfer_one_msg’:
    drivers/spi/spi-fsl-lpspi.c:369: warning: ‘ret’ may be used uninitialized in this function

If the message contains no transfers, the function will set the
message's status to an uninitialized value, and will return that
uninitialized value.

While __spi_validate() should have been called in all paths leading to
this, and thus have rejected such messages, we better pre-initialize ret
to be safe for future modifications (spi_transfer_one_message() also
does this).

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-fsl-lpspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index 52551f6d0c7d..2b93bc605b91 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -366,7 +366,7 @@ static int fsl_lpspi_transfer_one_msg(struct spi_master *master,
 	struct spi_transfer *xfer;
 	bool is_first_xfer = true;
 	u32 temp;
-	int ret;
+	int ret = 0;
 
 	msg->status = 0;
 	msg->actual_length = 0;
-- 
2.11.0
