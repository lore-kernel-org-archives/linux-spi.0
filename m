Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B8D496D5A
	for <linux-spi@vger.kernel.org>; Fri,  2 Oct 2026 15:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790956179; cv=none; b=pZOFxxK3aQOoX5H1+dJbMX23UGL9sEWVfGraVR+fHK0snbp5RVB8PqXKsZDfSukuYHCG64FMZCxdxl7AOzLU7LlBf+vS+iOSqDaV1WwD3fi1XHH9vi/nARkUHs7FIfjuonSRu9Ja/X2eU+hKPowEEeDbZQDrqu7XJKlQdvC13Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790956179; c=relaxed/simple;
	bh=c3qAoLCDM/k5+TOJO+TjT2BWcWeWqZHWdxB3z2xzy4A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r3dyIIIZ/fYnTXRQ7XzIKyW6bFrPBysqdQ7SSumY26L4ltqbV3ssW0ydOtwu7Rr5U4OjIqyOyKyLEvIsIFqsX33BixZEo5+wtSoKgqcYqc5iI9KTqR80DLIoj3Qb71z5sT8vOFujFxEacg2k6IuOCz8K/ov+I4RmJCQl861nd4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CohWvxbb; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CohWvxbb"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e79a408deso200865e9.2
        for <linux-spi@vger.kernel.org>; Fri, 02 Oct 2026 08:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790956169; x=1791560969; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FYHcsVKthAuktHy8Ms39HRVTDQV0P7YdD/+UrF62aBY=;
        b=CohWvxbb3bTx2ybUQSULV5De8EZo+PapagOEhVKXc+4ntH/itLNv+n12bi3GpIqWf2
         +cm5iRchS7+e24gQmdZ/FaRerfmUWzAsccfD1wtLOImooVyschKKYnpa8ulVyi4GWoVe
         vI0Myo0e9UsALMWw1XiR66HkX9E6B/TwlfRrBqUTm2JX4JJ8a7qHWT2bRLhXRI45zlzP
         AdSGL8vTCGR4bA6V7ZjEdsAFY73acWeRmBsQhgxw8G1J2a4l4Y+r8roFUa7nrxelHUSG
         4zzfVuJXMRrK3mFKjwRqqerZUDAytmKZdsuFq3xVgtH9R1CQw9CJEw5oVShcDl38VUPE
         OKSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790956169; x=1791560969;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FYHcsVKthAuktHy8Ms39HRVTDQV0P7YdD/+UrF62aBY=;
        b=pnuw5WWBtGh252SFmPfWLEuNhciHmTa13toofgHH85Ocac0zL4NiX16wk/Up+SSNNA
         X9rAVRs5ruLni5wKtnkOFrrJ6lzAp3c26m3SBRYgvedxxmQzGtK4oAQlu6ji6gzAfyw5
         GojwM/+VAkevueCsgM6Wtr9sUtfTtbwn+7r01XpS31stMiR/SIPSXoejI8YZZhO6lJaZ
         yfSBoQEPuB7tuUCuLzCe7U5l1NL0XbMHiu3lXFHLg3hGYxYWuDjt1jvP6UfRn0/mvhbZ
         ey/sV6vTktxeIEEOTsNf5BR9TRStLwTpb7l5exswV69rW88frL4cSiP5vbM6rDLl/ve9
         XyLg==
X-Forwarded-Encrypted: i=1; AKwUvBw2/PGUAHlOhZYLfUQBXEwegz7ndnSfMzg1zzYyKK/Ka3m/wLWggCxuuIvuDou/aF9WnBNhdOYuq5A=@vger.kernel.org
X-Gm-Message-State: AFuF++k8d7IzNp4UeoZqZQDNThOufpQ+iCnwc3zZn2aO3I37PNgCOqo1
	0CB5ZiGpY/nJE/4g2B8qUCWlpPqeJfoTcabeLjVrvVMPzLN35UKbyxKc
X-Gm-Gg: AYBFou2jdqG6bljATBqh1cJ9Tr6vmiQQe+oCc8wScRgEW5DIM/ZS/DYCyGGhMiz3qZM
	79dM4rEiPck0AxW+xIJUthpMqU6pPa+075GaG6Cyee7TOGq75h/riJHfPi6R1+m/rZkIguFDdQq
	6Ff/CV0EZgf/c+cUUw9WmCTIEQM/5dY1A+yMZ8G+7U538ljeceSf+v6uP5KbPhrMCB+8grRfQ6b
	1plEcbI61QR4eLEGvs5IodrpNpqwy6p/xWQcbb2TiPoSyTSsonD0Tc9UOa0Adhkj2zDsop8Y9aN
	MslhgSWL+yzsYkiz25G7ZVqEhWGSFur4+etmGmGUPNgUbe8Ag60Pz24OMPyt+vGb35NIzYWt+OT
	oLkke15eRUzmXIZnexxUBBSfkJjMYRm9jQU8Z3StihhBKv0eCYnU1Ih8odHhMtyyK92SSgG9z7g
	FXno/6/ALV5Wsr8Rm+OK+qSUGdGatW3lPl2gLII9XhbZK51Bb+4GeDFYjmLcov8sMdMVThj4Fsb
	ZfGtKg3SELTQ8O4jmqtRVugL+4PNCilPoSoXzJIQN7C9HLYTQ==
X-Received: by 2002:a05:600c:6995:b0:4a0:159b:d283 with SMTP id 5b1f17b1804b1-4a0275857a7mr54816795e9.30.1790956168547;
        Fri, 02 Oct 2026 08:49:28 -0700 (PDT)
Received: from localhost.localdomain ([182.189.185.133])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a027740a2fsm108345025e9.13.2026.10.02.08.49.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 08:49:28 -0700 (PDT)
From: Saadanjum01 <saadanjum239@gmail.com>
X-Google-Original-From: Saadanjum01 <271059546@formanite.fccollege.edu.pk>
To: Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Saad Anjum <saadanjum239@gmail.com>,
	Saadanjum01 <271059546@formanite.fccollege.edu.pk>
Subject: [PATCH] spi: bitbang: Drop duplicated word in file header comment
Date: Fri,  2 Oct 2026 20:49:19 +0500
Message-ID: <20261002154919.13919-1-271059546@formanite.fccollege.edu.pk>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Saad Anjum <saadanjum239@gmail.com>

Commit 8ee46db14169 ("spi: bitbang: Add missing MODULE_DESCRIPTION()")
updated the terminology in the file header from "SPI master controller"
to "SPI host controller", but only the word "master" was replaced, so the
header now says "controller" twice in a row.

Drop the duplicated "controller" so that the comment matches the wording
used by the Kconfig entry and the MODULE_DESCRIPTION() string.

No functional change.

Signed-off-by: Saadanjum01 <271059546@formanite.fccollege.edu.pk>
---
 drivers/spi/spi-bitbang.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-bitbang.c b/drivers/spi/spi-bitbang.c
index fb288ed56..347265e80 100644
--- a/drivers/spi/spi-bitbang.c
+++ b/drivers/spi/spi-bitbang.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Polling/bitbanging SPI host controller controller driver utilities
+ * Polling/bitbanging SPI host controller driver utilities
  */
 
 #include <linux/spinlock.h>

base-commit: ce1e0223d8ad4211275c82a17ed6d43ab81e13d9
-- 
2.50.1 (Apple Git-155)

