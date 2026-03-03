Received: from Atcsqr.andestech.com (unknown [60.248.187.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA6E33508E;
	Tue,  3 Mar 2026 02:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.248.187.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772506131; cv=none; b=ED/GEgNisQX+/dR9unVR2M96W0OgApMUay5GlVIWJWGmV9JeTIlTWhEimDxu8SsO0NQvh8q8eT1h6kVIGM/D533WHwkg5XiLhclCoYhZI53wh+SQtXewK43Y5lFLSIsuNEcTWnKRn9KMRLoQ5j62BGu0+EKSlxttYPaSz6kLf80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772506131; c=relaxed/simple;
	bh=jd2JgthORoVqck7uDhqdN/PDX86gkR+xKvsJD8blxNI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ckGgFa2YuK4QgTL57JrdMTCUvhdM3VunOR0E8KzWL+kVRHetyUtvhsSCbiMrkYEOV+8B6Dn626Pa4qMQzjJBmmKyxRT+KJCV5Txys/vwLd+eAfapuP1qoUfVmhkAMIeFcAgJNFO2xLcsp/kFE5IG2dYd1IQ/4xJyNnxCU7bJcr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=andestech.com; spf=pass smtp.mailfrom=andestech.com; arc=none smtp.client-ip=60.248.187.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=andestech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
	by Atcsqr.andestech.com with ESMTP id 6232lptB023764;
	Tue, 3 Mar 2026 10:47:51 +0800 (+08)
	(envelope-from cl634@andestech.com)
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS34.andestech.com
 (10.0.1.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 3 Mar
 2026 10:47:51 +0800
From: CL Wang <cl634@andestech.com>
To: <cl634@andestech.com>, <broonie@kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <xiaopeitux@foxmail.com>
CC: kernel test robot <lkp@intel.com>, Pei Xiao <xiaopei01@kylinos.cn>
Subject: [PATCH] spi: atcspi200: Handle invalid buswidth and fix compiler warning
Date: Tue, 3 Mar 2026 10:47:37 +0800
Message-ID: <20260303024737.1791196-1-cl634@andestech.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs34.andestech.com; dkim=none;
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:Atcsqr.andestech.com 6232lptB023764

The kernel test robot reported a compile-time error regarding the
FIELD_PREP() value being too large for the TRANS_DUAL_QUAD field:

  error: FIELD_PREP: value too large for the field
  note: in expansion of macro 'TRANS_DUAL_QUAD'
  tc |= TRANS_DUAL_QUAD(ffs(op->data.buswidth) - 1);

This occurs because TRANS_DUAL_QUAD is defined as a 2-bit field, and
GCC's static analysis cannot deduce that `ffs(op->data.buswidth) - 1`
will strictly fall within the 0~3 range. Although the SPI framework
guarantees that `op->data.buswidth` is valid at runtime (e.g., 1, 2,
4, 8), an explicit bounds check is necessary to satisfy the compiler.

To resolve the build warning, introduce a safe fallback mechanism.
If an unexpected buswidth is encountered, the driver will trigger
a WARN_ON_ONCE to leave a trace and fall back to width_code = 0
(standard 1-bit SPI mode). This approach guarantees predictable
hardware behavior.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202602140738.P7ZozxzI-lkp@intel.com/
Suggested-by: Pei Xiao <xiaopei01@kylinos.cn>
Signed-off-by: CL Wang <cl634@andestech.com>
---
 drivers/spi/spi-atcspi200.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-atcspi200.c b/drivers/spi/spi-atcspi200.c
index 2075058387f3..709d81475b68 100644
--- a/drivers/spi/spi-atcspi200.c
+++ b/drivers/spi/spi-atcspi200.c
@@ -195,7 +195,15 @@ static void atcspi_set_trans_ctl(struct atcspi_dev *spi,
 	if (op->addr.buswidth > 1)
 		tc |= TRANS_ADDR_FMT;
 	if (op->data.nbytes) {
-		tc |= TRANS_DUAL_QUAD(ffs(op->data.buswidth) - 1);
+		unsigned int width_code;
+
+		width_code = ffs(op->data.buswidth) - 1;
+		if (unlikely(width_code > 3)) {
+			WARN_ON_ONCE(1);
+			width_code = 0;
+		}
+		tc |= TRANS_DUAL_QUAD(width_code);
+
 		if (op->data.dir == SPI_MEM_DATA_IN) {
 			if (op->dummy.nbytes)
 				tc |= TRANS_MODE_DMY_READ |
-- 
2.34.1

