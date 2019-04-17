From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: Add spi_is_bpw_supported()" to the spi tree
Date: Wed, 17 Apr 2019 17:42:16 +0100 (BST)
Message-ID: <20190417164216.D754B1128FC8@debutante.sirena.org.uk>
References: <20190412094131.25616-1-noralf@tronnes.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1537170066=="
Cc: Mark Brown <broonie@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-spi@vger.kernel.org
To: =?UTF-8?Q?Noralf=20Tr=C3=83=C2=B8nnes=20=3Cnora?=
 =?UTF-8?Q?lf=40tronnes=2Eorg=3E?=
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20190412094131.25616-1-noralf@tronnes.org>
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

--===============1537170066==
Content-Type: text/plain

The patch

   spi: Add spi_is_bpw_supported()

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

>From e6f3f7e4dc76eb8d8a546dc66621a02c5c84f4ac Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>
Date: Fri, 12 Apr 2019 11:41:30 +0200
Subject: [PATCH] spi: Add spi_is_bpw_supported()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This let SPI clients check if the controller supports a particular word
width. drivers/gpu/drm/tinydrm/mipi-dbi.c will use this to determine if
the controller supports 16-bit for RGB565 pixels. If it doesn't it will
swap the bytes before transfer on little endian machines.

Signed-off-by: Noralf Trønnes <noralf@tronnes.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/linux/spi/spi.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 662b336aa2e4..b30e3d13a5ac 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -983,6 +983,26 @@ spi_max_transfer_size(struct spi_device *spi)
 	return min(tr_max, msg_max);
 }
 
+/**
+ * spi_is_bpw_supported - Check if bits per word is supported
+ * @spi: SPI device
+ * @bpw: Bits per word
+ *
+ * This function checks to see if the SPI controller supports @bpw.
+ *
+ * Returns:
+ * True if @bpw is supported, false otherwise.
+ */
+static inline bool spi_is_bpw_supported(struct spi_device *spi, u32 bpw)
+{
+	u32 bpw_mask = spi->master->bits_per_word_mask;
+
+	if (bpw == 8 || (bpw <= 32 && bpw_mask & SPI_BPW_MASK(bpw)))
+		return true;
+
+	return false;
+}
+
 /*---------------------------------------------------------------------------*/
 
 /* SPI transfer replacement methods which make use of spi_res */
-- 
2.20.1


--===============1537170066==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVs

--===============1537170066==--
