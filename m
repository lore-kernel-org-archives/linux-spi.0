Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC3B28641E
	for <linux-spi@vger.kernel.org>; Tue, 19 May 2026 00:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779152196; cv=none; b=Dap3XotMi++2d7LhNlJVuOIQ1EzHorGIKcj5T7Ow3DzgMY1A7lMNayTxZSyIlk6E1ewY1+ddGJF72UHQrdaKjPHymnZjxLpN+/elWlNepKK4AEohqzz5TxSzH2QPXluFiplFstXDruhNAo16txII5XTITXI6+e57sRG1r2K0lD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779152196; c=relaxed/simple;
	bh=BTpfEAjwmZh4mPdi0IGtoS6z3WhGRpuvOrLDLsDtz3w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uG8FeAcr7iAJ5X5zjSIo4DGYfFCSfCjuizD9EAbdiwJYil9YdvCw+8zlXtAOB6JlIsEUnQ0ZukIyvNQFUQbqu4egXQSo0M8rTwNqrhTjPeeMpVKFbRGJSzbDV3InsxGXU/SikDMMbIBzmNmMDwDIVK0IpynWKEgiplSrnDrmhpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JypuPf14; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JypuPf14"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2ba0fc8b1f0so18464385ad.3
        for <linux-spi@vger.kernel.org>; Mon, 18 May 2026 17:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779152193; x=1779756993; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rNUfqjlkG3eaKiIRq2CYNoqUPH+rtaUsFg5I/QT17Qs=;
        b=JypuPf14Ovk2n/s0FaJi03/3yyAMdgC57Cmb18d1DB+KzS97K/IYpZt3Ny53hyXYvG
         ebD2vlUyYEotnkdQtTT/WhyCibCvw1qWVY3BKIwWQcofYKdP1DmyktA115wDGz84ZxSN
         WVxK3cR1c2I35OFujljcadREyZR1oPhc9YmHCMD/NaWuIPJ4Yzu7bWoZEe7ecth0NhNp
         FAAwF3w7PDKSXGgO3nyxNw4sP6FK3yfk1HiENbwt8EzVKTnhHpxpJasxWZZ3RufQUUbx
         5BESxVznwGzhD3CAlYV7KmjUxXJ3wxcssPhvkfhckQrZ+rNlgDE9supmiQiQOR145Fvs
         qVAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779152193; x=1779756993;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rNUfqjlkG3eaKiIRq2CYNoqUPH+rtaUsFg5I/QT17Qs=;
        b=S8SHI1S+Np45uivIFqJSjEr0RIAKsmsh2QIsJ29gW5923a9B/E+yXPIleoSEeGwEsX
         qX9/G81y5g5IOhHy/PxVdLsFaFXx1nBexenNV+yfnJJvpAX5wpo2SfPDllKX8S/Bgel4
         GHuKFZne000OGoyD+Z9uqSNmE+MGnzI7tRU5gRiYo+arUpFTpSR664CJSygf/GPD/A7C
         Fmc2+XKFs0OC32NysCs/SaRmuVXugTfly2jO+tA6csgoIxNmH/1rYy2jdmeEjeEf4SGf
         +xwPmparTJ297FSAe6gKJLDBnlvDMQquNRokqGQXIKXEfvjzr6MUYEKczqwWjXlX46m/
         DAbw==
X-Gm-Message-State: AOJu0YwBs6aFu4rzb7TqoDsqu+qHfIFvoFlWCwVttDps9gewZ/TU2idw
	spwZ2cPjGepuOA/VpCW6pL3JdjkvZmszWKwrkwSCKo39jC7OL5ombfaUP50xrGjY
X-Gm-Gg: Acq92OFgGh28WFMdDSAp7J2EWNgz36bwNMzp9iNmVYNOGw/ahJp8h5xR5+duM8EKVcy
	2T9+laQTlbhi+PaA9nKNoR4Jcscw68eyRPPY+uIRZWR/+UivvIbCWKuD1HPd+7g36AifKGw4zzb
	5hOhFxImycB4Ic+O0yO2DCFfMgcxsqeIbF/vU8K2QHkbN4bHLP3SDdtkZe1z98GnrVOiuYs1Z0e
	kq0FV1TmaIeAW1fYnkCHLMCEVfeCgsFX2V91hN7uMeV5khpAp5HqpnAEwSQhThTYRj18Chfyr9J
	5ZbEDwzmMRHhY7W7O4Oh7rapot8/yh8vcaG7Apd0rgieomLZxNnuofljLMAABiCpTSc/Q28kp0H
	1ZjiBjvVspc4xKQG3KP+2EhQzv7BZap8qby2t0JawSBAxYhwmifHiVA8EApgyp6XKAevjmODJk2
	2lvz79okaxCRbW+cyXxZ3n78mY8YGB4JnAivPP1xr4Y+y0x7orhcBDLqLkqVvKI/UmAHJLmhDin
	VIVjL6b+1Apd1svHdK/xac846onEmaGr8WungbJEg6oiw==
X-Received: by 2002:a17:903:3d47:b0:2b0:5795:9ead with SMTP id d9443c01a7336-2bd7e410cd1mr127913015ad.0.1779152192596;
        Mon, 18 May 2026 17:56:32 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5d11d6easm178330205ad.72.2026.05.18.17.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 17:56:31 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-spi@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] spi: cadence-xspi: Add COMPILE_TEST support
Date: Mon, 18 May 2026 17:56:14 -0700
Message-ID: <20260519005614.628437-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Cadence XSPI driver uses readq() and writeq(), which are not provided
directly by all 32-bit architectures. Include the generic non-atomic 64-bit
I/O accessor fallback for non-64-bit builds so the driver can build there.

Drop the 64BIT dependency at the same time. The driver only needs MMIO
and the SPI memory interface at build time, and the fallback accessors
cover the 32-bit compile-test case.

Assisted-by: Codex:GPT-5.5
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/spi/Kconfig            | 3 ++-
 drivers/spi/spi-cadence-xspi.c | 4 ++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 8782514bb89b..957c3e065b83 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -321,7 +321,8 @@ config SPI_CADENCE_QUADSPI
 
 config SPI_CADENCE_XSPI
 	tristate "Cadence XSPI controller"
-	depends on OF && HAS_IOMEM && 64BIT
+	depends on HAS_IOMEM || COMPILE_TEST
+	depends on OF
 	depends on SPI_MEM
 	help
 	  Enable support for the Cadence XSPI Flash controller.
diff --git a/drivers/spi/spi-cadence-xspi.c b/drivers/spi/spi-cadence-xspi.c
index 32fa19ebf7a9..c45b29c043bf 100644
--- a/drivers/spi/spi-cadence-xspi.c
+++ b/drivers/spi/spi-cadence-xspi.c
@@ -22,6 +22,10 @@
 #include <linux/bitrev.h>
 #include <linux/util_macros.h>
 
+#ifndef CONFIG_64BIT
+#include <linux/io-64-nonatomic-lo-hi.h>
+#endif
+
 #define CDNS_XSPI_MAGIC_NUM_VALUE	0x6522
 #define CDNS_XSPI_MAX_BANKS		8
 #define CDNS_XSPI_NAME			"cadence-xspi"
-- 
2.54.0

