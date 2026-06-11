Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24FE51D6DB5
	for <linux-spi@vger.kernel.org>; Thu, 11 Jun 2026 00:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781136910; cv=none; b=sV34ZyznkSJy/kpyvYp4flh8Gm5eVYyOZ6H/d5FLoyuKfWQ9jmmvs4/IeXSxqvxyimgt63syP4B4bhs8pqdqN1Rqk9P9H9wfG9i+Y58YCERtXUNc7lCqL6/J/dNRqphF9YyrpFyqk7YQDC3ScbgMo4NAbik/RZ5SlziegK6nPg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781136910; c=relaxed/simple;
	bh=+OlgXi9Skov+ThY6+3dH6KQ2ROhe9JPBW8e/CCW1r18=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Op6J1KCUXc1X18jOrfoEHfsEX2x4JhzRKf0mmfQWiycnyRt781DNUodVI5y7N9KTJM/7SLEY8UWVJMTn/33vI+u38kmiGcsO00n4VZEtqbz5g9jiz6ddhtBg4DEc3XjtHzYVdoZ6fyNutq7GvI+SaMRIE3H1G46J7MBqmzAZT+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WolDl2z7; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WolDl2z7"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-490b8ac62baso2683265e9.0
        for <linux-spi@vger.kernel.org>; Wed, 10 Jun 2026 17:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781136906; x=1781741706; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KTDFl51zdYZl6YO+uZhWWOZC/ibEg4/Hnu0SEvId+tM=;
        b=WolDl2z78C7dNPOOubPvHgNF9h1hWiAluoOOGwdirH0QcQpHs+Xg/DPm6gQz/ytmsI
         yHAR17n3SeOVPpvW7OIzZMs8UpBx4xYN8dGSYZUlY3eJt3sWrs29EdMtghNzGtUvRh6p
         KDrICGfFsNguy9Lj3K11WXe3qMVCdxw2Bf7giLd6Gu/zQmRJX/sLhvSjTywjYG2smYgI
         5n+1lcA7uWZ26ycbaw3PDTrAMF01WQuXMkcb8H0mlCyNIWX7CFoV6jr9ljUle5EUVqc6
         I7KTiwRubxRbcvQ5MlwGvFLoXc4F3xqHRK2+6LdbKeELGE81zQ14Wr1mRjJVI3kpUTma
         RufQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781136906; x=1781741706;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KTDFl51zdYZl6YO+uZhWWOZC/ibEg4/Hnu0SEvId+tM=;
        b=jIYXPP5jagZS3dAk1mp/b9b+p+B0C1yLQEEEleMfldpuFwG3kt0IR9Y4RfXE8EgqD3
         jV0iyo7inXvPAbV86JMWLpXakSp8bQnjb1DvceHIH+OGPV994pukXe6EU1N/7RieZjvj
         NQcCAp33HWRJOeSI2F3gNYQnJFAxYkfvDFo9SLSLh1VNZLGpEu49q1yTWYyZgDSRIX1A
         pSGO6S6yqE5yARTUldDA6jer4XZnl0S0XUKhn4pjtu2lJmRL31gKIqTW1VRG/SIVkY4o
         qOeAwx6vcmGWEV1brlnPBze9sYdtsAhUrLFc8WbhUKUGmQi3SjBjXqmlh8c/JVJMn+92
         beqg==
X-Forwarded-Encrypted: i=1; AFNElJ9Xwf3zxhTQnBgBGODwUla2vKBeaXNptl1fs1qwRZAAwkmPMNEi9EbjV08fFElePZdwSMGiN6C9BWA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwH3Ff3FjiLVgl/pnMXi3K0UhpImeXO7xdg/95ejslymKQai9ar
	4cPGMKitKSwvJyo5dycYTtPECeqmxfU0AIrymXQZf8Ryk47gEApndEcG
X-Gm-Gg: Acq92OFtqWlMcVjUAoUDXVWJBMeCG/BflQS4ZEeEd61CiRWsfAkHRE7mOKQI2fWCzsA
	cJkCvdNAM9AQE891W3aMjfb1l//nSTNTAGa7+aD06qrzbs1byyF1WOzI/GJSNPyXXfEdRu/ASxO
	bv8P5cbNDlE8ogm856wzcXgsHQNHtL2JLVc/Tuul8ax27NX2WB7axZ1cXBYKxY4t07PeQT71aD7
	SLP2vxqTahG5NvVdxV9igGV1pv+BCoVJpUAxRVDTCDKZ1pq00KRnnV+8fBrmlQQwpV8fdvWIoC5
	SBpv/kaOrwej4R5MnLHwaNZL2hP/8rRoQjHMcpdEeSnFN0RRrTakUG7fHx9qFF6ouZWVW1y1BER
	NIdcjjr66gIEGIH29svbIb4HYbK9meQfui9JjdNFq3FfTRqfM1XCWLPoxJpxcbYF1621DUJ65A8
	LEvRnKR3TQa4OCu7au4ShIl+KODnQYC9luMFXSKshDxDAN7j/FObJSElaPmUuLJR5h1bf0swFH2
	MfT37XnxLLzqjWa0eFUKVAN21LdDT9qWQ==
X-Received: by 2002:a05:600c:8b21:b0:489:32b:ac0b with SMTP id 5b1f17b1804b1-490e52d9966mr2024495e9.6.1781136906350;
        Wed, 10 Jun 2026 17:15:06 -0700 (PDT)
Received: from linux-kernel ([2a01:11:f30:3290:a00:27ff:fe92:9192])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490e2ca21f4sm20382865e9.7.2026.06.10.17.15.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 17:15:05 -0700 (PDT)
From: Diogo Pimenta <diogo2003pimenta@gmail.com>
X-Google-Original-From: Diogo Pimenta <diogo2003.pimenta@gmail.com>
To: broonie@kernel.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Diogo Pimenta <diogo2003.pimenta@gmail.com>
Subject: [PATCH] Documentation: spi: add SPDX license identifier
Date: Thu, 11 Jun 2026 00:15:02 +0000
Message-ID: <20260611001502.44480-1-diogo2003.pimenta@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add missing SPDX-License-Identifier tag to SPI documentation file.

This file is part of the kernel documentation and must include
an SPDX license identifier to comply with kernel documentation
licensing requirements and improve automated license scanning.

No functional changes are introduced.

Signed-off-by: Diogo Pimenta <diogo2003.pimenta@gmail.com>
---
 Documentation/spi/spi-summary.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/spi/spi-summary.rst b/Documentation/spi/spi-summary.rst
index 6e21e6f86912..23e07ba4f8cc 100644
--- a/Documentation/spi/spi-summary.rst
+++ b/Documentation/spi/spi-summary.rst
@@ -1,3 +1,4 @@
+.. SPDX-License-Identifier: GPL-2.0-only
 ====================================
 Overview of Linux kernel SPI support
 ====================================
-- 
2.53.0

