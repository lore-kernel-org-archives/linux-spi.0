Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C20F313E34
	for <linux-spi@vger.kernel.org>; Sun, 12 Jul 2026 16:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783873514; cv=none; b=Xpdmphe9iJqEifvP/j40qocSXGUGbPDJ3xC0oVqfbdO8CSudwb7mJNwjLh3XE9Ugd6QwhZoZLhq1BuwX/bHHtPlDuXDbgm/wkFkZqvG/Xj+8cRcYOvFtlyBG32gCce6XDPgVpJxhUsufDeXvEyUEsgPobaA84HLdvHXrAEpIJdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783873514; c=relaxed/simple;
	bh=TizsjAo6H22VabPBe58L5vdTzzQI1Fe/SLJnZUEKHng=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=D3iufL0ztZEu6uJuRGLRvaxRV5vxeVJJRZCRRWKZUWzjrkMA8wu4JrTW7hq4CUY3Xv5z+IOpmAVbXW8Ra3YLRqxR21PCeKteNdqaL/fNUBI6/Y1f3oNaj5/Bl9RXQ7xP0pfAPzStnUFtf1nUCb4KPNKIVOuGF5ck2DgmyYx6JnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ceab75934dso10390905ad.2
        for <linux-spi@vger.kernel.org>; Sun, 12 Jul 2026 09:25:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783873513; x=1784478313;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mYwbmm2rFd+cIg+osK2dDYIzk9bxMwezMqTjeK3T5cs=;
        b=IyouT0Pcs+GrfQGrFLgQI7kAYnOZ7MmtJT0OeD2SNngmqAcMDPImAcRD+3FjQMIu7R
         U7zZuHmBNmY/CZkaBkbwWw60uKc/3kF7kCVRMeZY8bb76+ok7BxpCT6UBA2FMlWPSHig
         wDxJLPi1OZdfEJclr5Iu/BrKYPxW9AGi2tYSCjBiuLS99OxjsMKMUE501X8UyU4Ba4K0
         PNHl8tiZMldNJZT4EWCaeMhsj88lF3uoNsO6aUDzcizg8xlNEb1jU3BwLiBFFmu0TW9M
         n/f1RDdbRaq7E5tKmBFPPNXKEEQk79qRI9+uw17JmpIwN6Qr+8IJcFilHhqhxqHEZiDN
         CXSw==
X-Gm-Message-State: AOJu0YwPRkjCx4BvzoR5smdJIPPFYTmkrIKCSH16qMue0HolxupS0LR2
	l4/yzNp5uo6iwtL+GHbWDfqvPObEx5a2XnpOY7iQ/RPK6boPbdkajVA=
X-Gm-Gg: AfdE7cmkmDMczEl3OJOQic7TBHXYk6Xq5WXiCCB3vmFlxATj+NnnIURjbCK+hYtIpTw
	1m5sbgmZlUjFnl8hXY6RZzxskJFOH3HyL8rYh/0wbwgPfVz7sJT4r1s9Xw2sguIDVHXwmtHxAJo
	0sAw4ZRAujMX0VIYIHad8jsUxq1eRJqcFf5gMWWw+Jr/KCZi0r8Lt3VBsxdcc2kg/LpqTUGEZOP
	X3SzwmG8B/1fevHLMr1KWJFr1MT4g245O9HL2IzuAka3gVzEyFz3El1dBgAfXWHSYD0beL1nyZo
	C7KUhaKENmHVH6SrJ2s8Xpv3/Keen605aWnhrzvSBByaNHQnVsu+AJTkDbVtylSL0/AeDDaMtDX
	iRhfsYBsCipe/Jof5pT0MHhU07C+FulQwz3kMzc1tlqIkZ8KqiOPm7vJHjAoZVYwvlKm/WroMDv
	Xt1aRDFO3PROXVHAwXFHtOjLJ84MeVrLnX/9wXTkP5dO2xzLWElAh1PRenCEgCE9DmMWeEfuCT4
	0SqL+z6LQcaD6j+ia1ihMmYQKEv
X-Received: by 2002:a17:903:1af0:b0:2ca:e9dc:7357 with SMTP id d9443c01a7336-2ce9e9aaafdmr56220055ad.9.1783873512762;
        Sun, 12 Jul 2026 09:25:12 -0700 (PDT)
Received: from penguin.tail0a1999.ts.net (61-228-44-142.dynamic-ip.hinet.net. [61.228.44.142])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b93ae3b45sm12329887c88.15.2026.07.12.09.25.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 09:25:12 -0700 (PDT)
From: Shih-Yuan Lee <fourdollars@debian.org>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shih-Yuan Lee <fourdollars@debian.org>
Subject: [PATCH 0/2] spi: pxa2xx: MacBook8,1 quirk and LPSS S3 resume fixes
Date: Mon, 13 Jul 2026 00:24:18 +0800
Message-Id: <20260712162420.7453-1-fourdollars@debian.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes two bugs in the spi-pxa2xx driver found during work
to restore MacBook8,1 SPI keyboard/touchpad functionality across S3
suspend/resume cycles.

Patch 1 moves the force-PIO quirk for Apple MacBook8,1 from the client
driver (applespi) to the host controller driver (spi-pxa2xx-pci), where
LPSS setup properly belongs.  It also fixes a related runtime PM bug:
when DMA is disabled, pm_runtime_allow() must not be called, because
runtime autosuspend clock-gates the LPSS block between transfers and
causes PCIe Completion Timeouts when its MMIO registers are subsequently
accessed.

Patch 2 fixes S3 suspend/resume for all Intel LPSS SPI controllers.
The LPSS power domain is fully removed across S3, so all private
registers (BAR0 0x200-0x2ff) and IDMA registers (0x800-0x814) are lost.
Without explicitly de-asserting LPSS_PRIV_RESETS (0x204) on resume,
any MMIO access triggers a PCIe Completion Timeout and watchdog reset.
Additionally, the IDMA block (sharing the SPI interrupt line) must have
its registers restored to prevent spurious interrupts from masking real
SPI transfers.  The CS control register (0x224) is intentionally
re-initialised via lpss_ssp_setup() rather than restored from snapshot,
ensuring CS starts deasserted regardless of its state at suspend time.

These patches are independent of the companion applespi series also
submitted today.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=108331

Shih-Yuan Lee (2):
  spi: pxa2xx: disable DMA and fix runtime PM for Apple MacBook8,1
  spi: pxa2xx: restore LPSS private and IDMA registers on S3 resume

 drivers/spi/spi-pxa2xx-pci.c | 38 ++++++++++++++++++++++--
 drivers/spi/spi-pxa2xx.c     | 57 ++++++++++++++++++++++++++++++++++++
 drivers/spi/spi-pxa2xx.h     |  4 +++
 3 files changed, 96 insertions(+), 3 deletions(-)

-- 
2.39.5

