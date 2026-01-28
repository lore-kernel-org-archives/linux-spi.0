Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8EE434D4E6;
	Wed, 28 Jan 2026 09:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769594273; cv=none; b=tB0vYxlNn9vlj0axGHucuTvUwLxY4j1fX0Tk23oVojuUQFq6d9GupPy58g0EBjPoZ70h/nYE7IgXH2rErC63ojqQ5+SNkTfQVnVs4vGNvYDBKVhDIL1cVLDuODZZIgMRQxHCpq9wW6l0DNsr1TdnA6cs9y0Oiy0trRU+u/hSiNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769594273; c=relaxed/simple;
	bh=qyw3b6JJnTL8+L8CKPjC7znOFllMYl7N/wbaqY/lU5k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E97vTm4nbXP5W+Cjek6gk0eTSKzB8reMZE3I8o4g3VB4FEMDcOxIwM3r/EJtrtux/ZtfnxO5lIwMY5diWqZsA2mO93VUuqV666ACl6qut2yF8PNqeHb31M1l643ZGI+MVjzNhdsb4EE6Kczzr7DGDetNL8z+flytquwd/9Vu9Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jDYB9jgs; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jDYB9jgs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769594271; x=1801130271;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qyw3b6JJnTL8+L8CKPjC7znOFllMYl7N/wbaqY/lU5k=;
  b=jDYB9jgsz1ccREvGpmzGblFHKDCnQyfcSpgO8HJU0j/nBg2MXkQQtIxo
   lG+GW5skoPyoPvRAcPBnuezNVvNvVRwmxj50QEkpAdbpoyEZPOKuk96Pc
   hQtPOWvapsd0ubIL05MS+xriPgDBHFnLIyhD0xz6uDc7PAJqR34bTL7F6
   E+O/tPKLJvPZ7jf8iHCjS+BXtpHBgvDj3w86PuEA5dJBiqf/PgNa9sXPD
   QYrxsJM9yL/RcNSuHK+EhaNGKnUwDLfFm9wMwBYJFvkzJNwm4yQji7ljx
   tbKO02q4PHiE29f1l/DN5Wqrc/NHEcoJeXuHsctED6zxO4HeID6MuS0tq
   g==;
X-CSE-ConnectionGUID: y3XYKBbAQVq18UsQmh2OpQ==
X-CSE-MsgGUID: gik6KCcST3yjzjVfyNGlWg==
X-IronPort-AV: E=McAfee;i="6800,10657,11684"; a="74429068"
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="74429068"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 01:57:51 -0800
X-CSE-ConnectionGUID: befGTVPGTf+grWq/K+A7Xg==
X-CSE-MsgGUID: 4kCV9Ck7SnGrvwZ5yOxoYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="212704254"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa005.fm.intel.com with ESMTP; 28 Jan 2026 01:57:50 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 0D68B95; Wed, 28 Jan 2026 10:57:49 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>,
	=?UTF-8?q?Beno=C3=AEt=20Monin?= <benoit.monin@bootlin.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] spi: dw: Remove duplicate error message
Date: Wed, 28 Jan 2026 10:57:48 +0100
Message-ID: <20260128095748.4156926-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

devm_platform_ioremap_resource() prints an error message depending on
the actual error. The caller doesn't need to repeat that.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-dw-mmio.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
index 33239b4778cb..1332fdbf9a21 100644
--- a/drivers/spi/spi-dw-mmio.c
+++ b/drivers/spi/spi-dw-mmio.c
@@ -104,10 +104,8 @@ static int dw_spi_mscc_init(struct platform_device *pdev,
 		return -ENOMEM;
 
 	dwsmscc->spi_mst = devm_platform_ioremap_resource(pdev, 1);
-	if (IS_ERR(dwsmscc->spi_mst)) {
-		dev_err(&pdev->dev, "SPI_MST region map failed\n");
+	if (IS_ERR(dwsmscc->spi_mst))
 		return PTR_ERR(dwsmscc->spi_mst);
-	}
 
 	dwsmscc->syscon = syscon_regmap_lookup_by_compatible(cpu_syscon);
 	if (IS_ERR(dwsmscc->syscon))
-- 
2.50.1

