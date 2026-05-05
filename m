Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D2935BDCA
	for <linux-spi@vger.kernel.org>; Tue,  5 May 2026 01:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777946045; cv=none; b=kPspVqtGMO1muKfK2ssFkKy+qJExN1nJvnAq9j9XTvrL+1Yz/EJoxfyxmD0bMncANxNOfhWzXufMWug5Suag/WLvPaBpWu7khGPhszD4srMoudHFoZSthJQGqBb5dwXT1mHnbWflLX2ViEZKz8SpNv1hJtBgJhqtV92ZMEBw1Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777946045; c=relaxed/simple;
	bh=bCXcH22VETc/1TUN/+hBoB9VD44HhAx4Bt4mZr0aROE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=RrN/QLJyoShI5Cz2GytPxMJWdRDNHIV+mOdfz+/6aqzFCBVQSPpcUOi8mg0Vd1JjSFfXXKe2V3vduDEuytmBpuzMYZEfG+Vo8D1B5oQFlxpfoUduBSz+Af+KVb7qo363QtDjRJvbnk5q4SoU7YwU9B45lO3DHzKC4qvndw7wa+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=kNnmpI0h; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="kNnmpI0h"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-835c98b659eso1129337b3a.0
        for <linux-spi@vger.kernel.org>; Mon, 04 May 2026 18:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1777946042; x=1778550842; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A4fW5IFCF+h7MNSs7mItaLMetGKpr2bIN5LAG6vg93E=;
        b=kNnmpI0h6rpwWjBKY25r1IVoarDSkqdUlE5K/MQXRhi2k2RYEhyVoz4xNt+XKpNi+F
         3DNuSXWQb9kothmMQgDebFa38WHz3iNkbk0QERRBzoRgqP4FbF4yL4v94+7nFkAvdxPr
         +r01UtV4AQZksKL71zfeU0Mb4BjosNRB53vmz0BhcC2jfWk3oOKC3bp63alhB9ZPv57o
         Erflo4To2NHaukhFBn9q9e5//hjtiXfn1h06tV5gyfYKw58PsbCVhKwxiROSCIMCEhJE
         RCSf10u89aGAX7OX0xYpyMNyn2NONNvLypNa8Sd6rF/M1jBw16mX1DcaA/ALlctNTYLA
         vtpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777946042; x=1778550842;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A4fW5IFCF+h7MNSs7mItaLMetGKpr2bIN5LAG6vg93E=;
        b=EpoN/yTD5MRu9FA8r4JvtOcx2J68XoQong6syqBtdHzAaugG706UyxOVOK2bq6NwSb
         zNeTnN5a/Kn6tHQpS1nzyQzyHCKs9r2kPPf0hv/MhYpuzdJmgg3/CXFYAwVXlgdYkmKi
         mxpT0j3oqCiitvZNHF2vkhH7FrmtpJkssEtQ4bF08kA1/n0FuSZeKXMkyWtAQVPtV7LF
         DnO/eplPl/rQU8VgE5lo4KfkiZIZ03KpfOdffCPfPckm0xH/JyZOn2Da+N4fUpYLgMmM
         qf/CqBEvmdD2P/rIntBg8MlmLgZImK8xv9DE5WujE+EGAtSFYdcwdHHcVmChnU/oDbSI
         Sf9A==
X-Gm-Message-State: AOJu0YwE5MTxvO56SRUbRZpARKTiGDxPL9GyKGZAhhUTSl7ztLOswxne
	numyJCgTudE0oX4dBX1jUbR4e8EAZbqtBM5hGlT9DgcSR53mYtQ3mysfOBvjckcUC6g=
X-Gm-Gg: AeBDietRI32tfYkENez+/3dgDtMKh4GlPSJaowHORpKJEUePPNTruxHMOT+0ay5xi0N
	C8/gm9nBJYfkq7sOpCZt1xjj8R87Ik/JoZBByVZTqv117Om9NiMCEcn3hX5YFJeKRTGgHsHIUzX
	feyE2edn0J4+BQNaRy/i5BJ7WW6oH4W0Oj4xePzaKGkqc3cJ7SE3M5DEmJZ+8ZMnhqTPhcz0uvC
	CJTrFBrx7udnZKgC+pI+91b/8slTD64PoFoF+R7gWl2Xxf13r/Kh+3+E/AkmZByhwnnx87qX3m4
	/93n+nOkcH9oJfktY2V6bUUi1JP/1mBlOdZZ9FRkZ2ZUqEKJswRGBVDLxXuyYsQ2fDa9R9wfyEP
	cADQzcxz8cSMV0xmnwtZ+bOuOzWNIqdJRXa4qGSYDRhOi5DwsOxeMpteSRV2mi63C/6lhzD285q
	oX8n+8ayyIoPWaJKwUImvqiBsN4N6WlZlDcTZ33wFl+23fE5mWBqDlrchWNAarj1P/
X-Received: by 2002:a05:6a00:1250:b0:837:a211:4edd with SMTP id d2e1a72fcca58-837a21153a9mr6252120b3a.3.1777946042159;
        Mon, 04 May 2026 18:54:02 -0700 (PDT)
Received: from [127.0.1.1] ([2a12:a305:4::3016])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-839682a4bffsm211375b3a.56.2026.05.04.18.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 18:54:01 -0700 (PDT)
From: Guodong Xu <guodong@riscstar.com>
Date: Tue, 05 May 2026 09:53:34 -0400
Subject: [PATCH] spi: spacemit: add u64 cast to NSEC_PER_SEC to avoid
 32-bit overflow
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260505-spi-spacemit-k1-fix-overflow-v1-1-77564c2e4e86@riscstar.com>
X-B4-Tracking: v=1; b=H4sIAF32+WkC/yXMywqDMBCF4VeRWXcgBqymr1K6iHHUsa2RjDcQ3
 73TdnEWHwf+A4QSk8AtOyDRysJxVOSXDELvx46QGzVYY6+mMAXKxDof6M0zPnNsece4UmpfccO
 qdK6pg/XkStDElEj/X/7++FuWeqAwf5twnh9PJHf6gAAAAA==
X-Change-ID: 20260505-spi-spacemit-k1-fix-overflow-8799dbc2ae97
To: Mark Brown <broonie@kernel.org>, Yixun Lan <dlan@kernel.org>, 
 Alex Elder <elder@riscstar.com>
Cc: linux-spi@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org, 
 kernel test robot <lkp@intel.com>, Guodong Xu <guodong@riscstar.com>
X-Mailer: b4 0.15.1

NSEC_PER_SEC expands to the long constant 1000000000L, so NSEC_PER_SEC *
BITS_PER_BYTE (8 * 10^9) overflows on 32-bit-long architectures
before the result reaches the u64 nsec_per_word.

Promote the multiplication to u64 by casting the first operand, which is
NSEC_PER_SEC.

Fixes: efcd8b9d1111 ("spi: spacemit: introduce SpacemiT K1 SPI controller driver")
Suggested-by: Alex Elder <elder@riscstar.com>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202605050437.RS6mmV2b-lkp@intel.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202605050317.Tf9j487w-lkp@intel.com/
Signed-off-by: Guodong Xu <guodong@riscstar.com>
---
Hi, Mark

This is an incremental fix on top of your for-7.2, addressing the
overflow warning.

Verified on BPI-F3 with a GD25Q64E SPI NOR, read/write/erase still work.

Thank you.
Guodong
---
 drivers/spi/spi-spacemit-k1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-spacemit-k1.c b/drivers/spi/spi-spacemit-k1.c
index 99db429db0b26..215fe66d27b4d 100644
--- a/drivers/spi/spi-spacemit-k1.c
+++ b/drivers/spi/spi-spacemit-k1.c
@@ -390,7 +390,7 @@ static int k1_spi_set_speed(struct k1_spi_driver_data *drv_data,
 	 *   ticks_per_word = BITS_PER_BYTE * drv_data->bytes;
 	 * We do the divide last for better accuracy.
 	 */
-	nsec_per_word = NSEC_PER_SEC * BITS_PER_BYTE * drv_data->bytes;
+	nsec_per_word = (u64)NSEC_PER_SEC * BITS_PER_BYTE * drv_data->bytes;
 	nsec_per_word = DIV_ROUND_UP_ULL(nsec_per_word, drv_data->rate);
 
 	/*

---
base-commit: efcd8b9d111177d48c841d09beca43b15d5b9e5f
change-id: 20260505-spi-spacemit-k1-fix-overflow-8799dbc2ae97

Best regards,
--  
Guodong Xu <guodong@riscstar.com>

