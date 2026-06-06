Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2D419E819;
	Sat,  6 Jun 2026 22:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780784773; cv=none; b=HSEcu3b8pVvZO12DHNYdIVgCE8w6PntCXt9yhlQTaGVyk0ZXn1quyTUriSBCD/cwPG9b/fhWdh95Jd9BGufHVcujESEkWmoSE8HfeaQt+WhFsl4rZTjWlBMVMK5YAqf4eTdtVbWzXg31bouHY7D0JB00ochHs6RnwQEbU8ykpsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780784773; c=relaxed/simple;
	bh=5wSrWN4gV49I5m0+JrbeMXcWq3VP0nPyx3T/hAdB0XA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=fS/V3tbuZz8AfNiwuAj2JeornNNPviryh+ThUXOI2XcgKS3+UEKVkv+KafyynIISYenfZN5XStgpFHwpdYMAGSailf5KD+Fj48IMK6i/s0in3l5XB4TRIHCPmO4K9MvqafyiFEYqpYLzo0RsXEuZmbGuDF+q80OEKZdfMOYMTK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jrx2kv28; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jrx2kv28"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B39A1F00893;
	Sat,  6 Jun 2026 22:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780784771;
	bh=TjVepQJ9m+BiQJN/HKXGmGrEuAQFwmWEnMg4yllArPg=;
	h=From:Date:Subject:To:Cc;
	b=jrx2kv28cWFJykHtDswQj1F95XY55kUa3ovTrUEaT4Go07wzaqar+MqBZQpa6lwFk
	 BVpS8Oyfps3NYJqwVTOK/M7JA/rbHsDYElmRp/TEiDl8ESwCYKkp4pxjkQ64ndJ/yt
	 AsYDO2GxOZFQuuByL8Nzw4jz7oMm2o1IbLNHQN1g8/gCUmLPdCUfWivvMGVmLdjUFQ
	 /JYhZ6FX8HDXxkpp6EACcWtaNAY8eP4SzZrF3euqKk8di6bX0KmRFvN10VAOp97zJp
	 VGVZxNi5EmO7mqbp9H5IyvGsqHlw8iIoIiI/dlCmqUQS2hAq/z34it7dsTCOlna6YN
	 Tp3fdeZzV9Pcw==
From: Nathan Chancellor <nathan@kernel.org>
Date: Sat, 06 Jun 2026 15:26:04 -0700
Subject: [PATCH] spi: cadence-xspi: Revert COMPILE_TEST support
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260606-spi-cadence-xspi-revert-compile-testing-v1-1-76219ea378bd@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXNzQrCMBAE4Fcpe3ahDf7VV5EeYjKpK5qGbJRC6
 bubKnP6DjOzkCILlC7NQhkfUZliRbdryN1tHMHiq8m05tjWsCZhZz2iA88bagu5sJteSZ7gAi0
 SRz71XW/Oe2/DIVBdSxlB5t/Tdfhb37cHXNnmaV2/H7obf4sAAAA=
X-Change-ID: 20260606-spi-cadence-xspi-revert-compile-testing-7919284daf5f
To: Mark Brown <broonie@kernel.org>
Cc: Rosen Penev <rosenp@gmail.com>, Jisheng Zhang <jszhang@kernel.org>, 
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2560; i=nathan@kernel.org;
 h=from:subject:message-id; bh=5wSrWN4gV49I5m0+JrbeMXcWq3VP0nPyx3T/hAdB0XA=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDFkq8xrXrHF3uro4W2Jy49Tj+8v/daTI3F75wcOPIdn7v
 1FButOnjlIWBjEuBlkxRZbqx6rHDQ3nnGW8cWoSzBxWJpAhDFycAjCR/wkM/4uk9pZa/X/a/ZrL
 5+OkwKV7pZLVmfTlPFuzA+4d//Yz6xYjQ8NB5TuG/69uy9wa/W7j1ilV4SkB1cvbKy8d15wt1q/
 ByQIA
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

Commit 0c5b5c40dc31 ("spi: cadence-xspi: Add COMPILE_TEST support")
allows this driver to be built for 32-bit platforms, which causes a
semantic conflict with commit 4954d4eca469 ("spi: cadence-xspi: Support
32bit and 64bit slave dma interface"), as readsq() and writesq() are
only available when targeting 64-bit platforms:

  drivers/spi/spi-cadence-xspi.c: In function 'cdns_xspi_sdma_read':
  drivers/spi/spi-cadence-xspi.c:601:25: error: implicit declaration of function 'readsq'; did you mean 'readsl'? [-Wimplicit-function-declaration]
    601 |                         readsq(src, buf, len >> 3);
        |                         ^~~~~~
        |                         readsl
  drivers/spi/spi-cadence-xspi.c: In function 'cdns_xspi_sdma_write':
  drivers/spi/spi-cadence-xspi.c:623:25: error: implicit declaration of function 'writesq'; did you mean 'writesl'? [-Wimplicit-function-declaration]
    623 |                         writesq(dst, buf, len >> 3);
        |                         ^~~~~~~
        |                         writesl

As there are no known 32-bit platforms that use this controller, revert
compile testing support to restrict the driver to 64-bit platforms to
avoid burdening the driver with workarounds.

Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 drivers/spi/Kconfig            | 3 +--
 drivers/spi/spi-cadence-xspi.c | 4 ----
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 957c3e065b83..8782514bb89b 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -321,8 +321,7 @@ config SPI_CADENCE_QUADSPI
 
 config SPI_CADENCE_XSPI
 	tristate "Cadence XSPI controller"
-	depends on HAS_IOMEM || COMPILE_TEST
-	depends on OF
+	depends on OF && HAS_IOMEM && 64BIT
 	depends on SPI_MEM
 	help
 	  Enable support for the Cadence XSPI Flash controller.
diff --git a/drivers/spi/spi-cadence-xspi.c b/drivers/spi/spi-cadence-xspi.c
index e2bfb0c78b82..e1b337789fce 100644
--- a/drivers/spi/spi-cadence-xspi.c
+++ b/drivers/spi/spi-cadence-xspi.c
@@ -22,10 +22,6 @@
 #include <linux/bitrev.h>
 #include <linux/util_macros.h>
 
-#ifndef CONFIG_64BIT
-#include <linux/io-64-nonatomic-lo-hi.h>
-#endif
-
 #define CDNS_XSPI_MAGIC_NUM_VALUE	0x6522
 #define CDNS_XSPI_MAX_BANKS		8
 #define CDNS_XSPI_NAME			"cadence-xspi"

---
base-commit: 4954d4eca469419339452cb5fea26dd0fc678c54
change-id: 20260606-spi-cadence-xspi-revert-compile-testing-7919284daf5f

Best regards,
--  
Cheers,
Nathan

