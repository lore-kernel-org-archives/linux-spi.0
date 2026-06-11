Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EACEC368D79
	for <linux-spi@vger.kernel.org>; Thu, 11 Jun 2026 11:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781175971; cv=none; b=rFXXqTkaotGvSsfNDCuohSpBdqxSMm6YTf4nOXRH7tk5NT13/bOrMe26QqBECfNJz8UDT9BygVBPm9Y7bFHLMBZUuFXjKpoxEgISVDcRYibYA24y8yIsBprB4yDfP7fDilT/f8b+7vcc1SahDlQAjUFBkgEdvKvI+Q2xyNAz+2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781175971; c=relaxed/simple;
	bh=//6zCP+8PiYss4+CbcuOVeL3bsOkfJT1WzeWTbr71fo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rx/r1FKdQHaynb9+cIQERempA+A1NlsPofWDNExQX4uzr5ZkkMUe7DJYiEZazx7jozrcCGRA1Nv1TW1YnESvjECZQbn1XZvCoH4VG7JIJZd5AxcT/i57q0zXeglMwyy68B4qb/v16Kn32WjS+nVrxaO0zicR7ug2S5KHYQuruBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=keK0XW2t; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="keK0XW2t"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-46066e640easo405937f8f.1
        for <linux-spi@vger.kernel.org>; Thu, 11 Jun 2026 04:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781175968; x=1781780768; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ufXYSrZtvQlRFd8i2CT02XRwqa4toSjllvW/ZRboweg=;
        b=keK0XW2tTuc/qlVkopfRVJAT0GQu4X0GYS+xWeDlfCojMXLw3tQ2NcEoyKUaguRaw3
         bY7xQGLlwiQAqD5srxtHnOKthAu+vL8sJ16vcTNVlyuikY2KpxgsZL2YWBPvRFZV6o+c
         x1GyVvwmA/EPsaVfiY+0C4kOscGJRy3qLMSTIEIAtEsNmlfmBULF+87NKG7OW0oYGG9b
         n/PKz7UA7iH13jKl0B0avGkEK1qyPkgOqs3WsGGn21weKubG3gZUV0SJlitArpeshKaS
         pJboV8Y9pgi/w0NlY9evdaULaPeUZeWqr2eEhq7HvhZfb1GgxUZqjtVnRFRrxnF8rMZY
         gIQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781175968; x=1781780768;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ufXYSrZtvQlRFd8i2CT02XRwqa4toSjllvW/ZRboweg=;
        b=qylRCS6wD92MSBJ4LKWAu2Pgmu54OPq6nZHUVbYsnfELzPh26IWSf8jHe6wy9uJdqW
         K9Hnp2pseAtw8TBCLhKzf5NJfjZ4jY4byZ0ltMZGYRlI5cDAyr32/iqzdYWYdEI06fUk
         f7yFPiTItlRjSe2ycn+HvlA8xTOW8drN5dNvnICFp//LvFaHe8HZWfjgI4Ltq4fLN45Z
         uhpgw4Tgu/Fpx3zIz8sxSyO527VkAOrufzp/ATAuU/UviZWRMNig12+w0RQYnCBRclal
         qPE+BKxf1MVPQj583h8rLLtbXG2VNWqpLJmQiIBc4DsizowLLm632oQHhSSLwYOQjeJd
         AVZg==
X-Gm-Message-State: AOJu0Yy3BKIo3SPtKxgzXqJtrBfSIiaWG75+Rm4+AUV3xGDtGW2Tbmus
	Y427OMvlCGQ1eyS02OqWArxrqXfslG9k3YnlTdeTik7avWPfBwAqAxnw
X-Gm-Gg: Acq92OFJCYCU8vw+hApDdsTM9+fLnXS8vvDZLQwcJdfhNpUY24eyXDqA47SwY5P13mt
	QUmlOkPWIIbLFJz2EnzbvVAHhYCHMTBZHZ8Iq7hLDONK6JrWSmTS17X7gnmcHqZTRDvnIpFFWu+
	UOdO2yF8C4EVdbH29lqVbfR3I3f7a5IHtWako45ic4feL7oDaHO4pzD2u0ZHAqZXuzkkbEtXrHq
	fySZLklQlclgfxnIAmEFais4TpFhQNa0rGGGFWC7xAxCeJxMjnQwOTkX3c6y8ABA1H7Eb0ZZa6D
	ZGtxLfYSdywqsPNMVhAaqQAjp67fS9mDXOm0sTT9xcPQfYKKiKVoM5wabq+jy3YJ+6ManGYLeEG
	JimTmFWD5aI6IWk223pFjPZaqUyBFjAjtZjhHbtPNPcOV0/bYrNj3/8wJKUdnt4KR0DHrYNr9MI
	9sUDadpr9Wt5l+RTZhZbu22zqxaly+miHEON0iVyBFkNdOIBab/iO4SMHuAwKkXBUsWBQ9nDjl2
	+o3jZNXAHeTPSYCOgoFo/qWTVWI1zDtQQ==
X-Received: by 2002:a5d:6f1e:0:b0:460:3234:4474 with SMTP id ffacd0b85a97d-460677ee84fmr3470976f8f.42.1781175967981;
        Thu, 11 Jun 2026 04:06:07 -0700 (PDT)
Received: from linux-kernel ([2a01:11:f30:3290:a00:27ff:fe92:9192])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2dcae2sm85935203f8f.6.2026.06.11.04.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 04:06:07 -0700 (PDT)
From: Diogo Pimenta <diogo2003pimenta@gmail.com>
X-Google-Original-From: Diogo Pimenta <diogo2003.pimenta@gmail.com>
To: broonie@kernel.org
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Diogo Pimenta <diogo2003.pimenta@gmail.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] Documentation: spi: fix SPDX directive formatting
Date: Thu, 11 Jun 2026 11:06:03 +0000
Message-ID: <20260611110603.2768-1-diogo2003.pimenta@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a blank line after the SPDX directive to satisfy
reStructuredText parsing requirements and avoid
documentation build warnings reported by the kernel
test robot.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202606111027.TFnhhj2n-lkp@intel.com/

Signed-off-by: Diogo Pimenta <diogo2003.pimenta@gmail.com>
---
 Documentation/spi/spi-summary.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/spi/spi-summary.rst b/Documentation/spi/spi-summary.rst
index 23e07ba4f8cc..c6bbbd9bce9f 100644
--- a/Documentation/spi/spi-summary.rst
+++ b/Documentation/spi/spi-summary.rst
@@ -1,4 +1,5 @@
 .. SPDX-License-Identifier: GPL-2.0-only
+
 ====================================
 Overview of Linux kernel SPI support
 ====================================
-- 
2.53.0

