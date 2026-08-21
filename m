Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5534546AF2D;
	Fri, 21 Aug 2026 10:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787309750; cv=none; b=g9qvwjMNw27T/Qm7ceNryUPwtDPcymZJc0TkjVzbJNPT2PRDZSmH7L69idHhzl9CeFd49XAtlVz9wtvZD43Qxb1C6uzA6asKscHl+pJ41pIAkQYpS08a22mc2aF/WtTTN7Zdq+RXIfRBskV25juDECbrEEZpcMhesoZWAYIiPpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787309750; c=relaxed/simple;
	bh=nbdqT+PW4muE2sijvGMotk8T6ks/rD5VfYHnB8+NFt8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UoHKIJWvhGl4EwN64Mktgh4g1+wRqlFI+k3kCVi9KvJyneHLk84SoUFrleYRSXSejUFzaEAfa9bcSgUi9cp86DfDeBnDPwBg83JJ982IhDArzSL5NxaQM7jBnsa6XsigN5JWpSrHV2707njFINb4owfJg8BsPb6rhJwuPY/ZN+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JhnI94vC; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JhnI94vC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787309750; x=1818845750;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=nbdqT+PW4muE2sijvGMotk8T6ks/rD5VfYHnB8+NFt8=;
  b=JhnI94vC+rwld06s2WEuhFAPd/+RBQH3gY+WflK3Tbl4S2u5gtg2Egvf
   Q7pYl336t0ukBdwjy4dLLK9GZ5sfLytzhgYnzk8COn2nGmUbwrPm0R2Qb
   4R99Hj9GLpjnlzl13j8Lo1HXlNC4CISaJ5oEaSabV4FUHnGzKYV5xkg3f
   ySjN8ORgZlgUv9f4FLysWerg6KVT3+iSdr+M7XIadBK7G4nmHuqrFVJMl
   6rJBRT6ppBS5hIGloWupge42V8e9V3f3fIIIBO2bxkiWaxmtZ2Of1OlbU
   dpmsZXY4Paf/Hx1B+hSv/qXvogtZbGKGeF64qaH5tkMqB4LLIKEA3lu42
   g==;
X-CSE-ConnectionGUID: Lh/u+c3TTm6ZOwDUnymuBA==
X-CSE-MsgGUID: eHt9gGN/QvKnxbKqcANHcA==
X-IronPort-AV: E=McAfee;i="6800,10657,11881"; a="88060547"
X-IronPort-AV: E=Sophos;i="6.25,235,1779174000"; 
   d="scan'208";a="88060547"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2026 03:55:47 -0700
X-CSE-ConnectionGUID: mgnF3q90SNiRD5g4GnNLoQ==
X-CSE-MsgGUID: vsDueNszRdan2uS9xG8M2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,235,1779174000"; 
   d="scan'208";a="289841515"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa002.fm.intel.com with ESMTP; 21 Aug 2026 03:55:45 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 168759B; Fri, 21 Aug 2026 12:55:44 +0200 (CEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/3] spi: Fix tab and space mixture in Kconfig
Date: Fri, 21 Aug 2026 12:54:52 +0200
Message-ID: <20260821105541.1432348-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260821105541.1432348-1-andriy.shevchenko@linux.intel.com>
References: <20260821105541.1432348-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are a couple of sections which indented using spaces and
not tabs. Fix them.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/Kconfig | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index a0f37e2df716..93c3d9e1416a 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -388,14 +388,14 @@ config SPI_DW_MMIO
 endif
 
 config SPI_DLN2
-       tristate "Diolan DLN-2 USB SPI adapter"
-       depends on MFD_DLN2
-       help
-	 If you say yes to this option, support will be included for Diolan
-	 DLN2, a USB to SPI interface.
+	tristate "Diolan DLN-2 USB SPI adapter"
+	depends on MFD_DLN2
+	help
+	  If you say yes to this option, support will be included for Diolan
+	  DLN2, a USB to SPI interface.
 
-	 This driver can also be built as a module.  If so, the module
-	 will be called spi-dln2.
+	  This driver can also be built as a module.  If so, the module
+	  will be called spi-dln2.
 
 config SPI_EP93XX
 	tristate "Cirrus Logic EP93xx SPI controller"
@@ -475,7 +475,7 @@ config SPI_NXP_FLEXSPI
 	  supports the high-level SPI memory interface.
 
 config SPI_NXP_XSPI
-        tristate "NXP xSPI controller"
+	tristate "NXP xSPI controller"
 	depends on ARCH_MXC || COMPILE_TEST
 	depends on HAS_IOMEM
 	help
-- 
2.50.1

