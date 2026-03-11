Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E31E3DD51F
	for <linux-spi@vger.kernel.org>; Wed, 11 Mar 2026 12:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773232063; cv=none; b=JgDkyGYKZJ64vRIGWkaEnqdvRPuok7Uxkhj4yszwTIJDRPdsPREcuKK+oop+CoZ4mPmG0aNpfqPQ2DP9BoVGh/YyRqgC1VwOKWd4kHpaf7uhghWrib2MxImXwCYAO7T4GmJ8SGH11+GGF6+qPKvlCiNAa9dinrd2VIH0w7fJPgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773232063; c=relaxed/simple;
	bh=k91URhsfRskdTZme8uSkpuSCgqA6D++LrvkN7g0hseM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=IhMHKtIw0g6Dw27oavpV5b90peFaStqBjmlbZuAyqIaXlsi43bIJVfhoI20drDTAFismJ4FcpxnwFQhCUPp/SPCoyuKS9eOncp35EGfuR+YqUlS2mQzs3/nVu0D8BwoWYzWMVTyQHKdsR+EOUBmh7QcZsysdGQ5dkC2M7eDYHOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=ratatoskr.trumtrar.info)
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <s.trumtrar@pengutronix.de>)
	id 1w0Iez-0002PX-JW; Wed, 11 Mar 2026 13:27:33 +0100
From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Subject: [PATCH v2 0/2] LED: Add fault state handling to LP5860 LED
Date: Wed, 11 Mar 2026 13:27:00 +0100
Message-Id: <20260311-v6-19-topic-ti-lp5860-fault-v2-0-f9454910f009@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJRfsWkC/43PTW7DIBAF4KtYrDsVYIOxFVW9R5UFP0OCFBsXs
 JUqyt1L7V276fLN4r1vHiRjCpjJ2DxIwi3kEOca+EtD7FXPF4TgaiacckkZH2CTwAYocQkWSoD
 bIpSk4PV6K2CVccyLwdvWk9qwJPThvrd/nGu+hlxi+trHNvZz/V/vxoBBN1jFuLNUOv2+4HxZS
 4pzuL86JOfnsZbwc60vlGOSGJ0RbJymUMZGOuStV0wLpMqg8sYLVK7HwaOxPdfCCM/7HT5hznr
 /fWxOO7GlB7H7Q9z6ijMMnbRSd73FX7i3qnt+A8TfjgFoAQAA
X-Change-ID: 20260129-v6-19-topic-ti-lp5860-fault-c8bd1f59fc3f
To: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org, 
 Steffen Trumtrar <s.trumtrar@pengutronix.de>, 
 Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
X-Mailer: b4 0.14.3
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: s.trumtrar@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
Changes in v2:
- make some functions/defines clearer
- minor newline cleanups
- split sysfs patch into own patch
- fix scope of some variables
- Link to v1: https://lore.kernel.org/r/20260129-v6-19-topic-ti-lp5860-fault-v1-1-49c812dc06da@pengutronix.de

---
Steffen Trumtrar (2):
      led: lp5860: expose fault state via sysfs
      leds: lp5860: detect and report fault state

 Documentation/ABI/testing/sysfs-class-spi-lp5860 |  49 ++++++++
 drivers/leds/rgb/leds-lp5860-core.c              | 143 +++++++++++++++++++++++
 include/linux/platform_data/leds-lp5860.h        |  19 ++-
 3 files changed, 208 insertions(+), 3 deletions(-)
---
base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
change-id: 20260129-v6-19-topic-ti-lp5860-fault-c8bd1f59fc3f
prerequisite-message-id: <20260309-v6-14-topic-ti-lp5860-v7-1-b1ed6c6a47ce@pengutronix.de>
prerequisite-patch-id: 45e295aab0d3ea7d92bf71596f8b0e18e8621ac0

Best regards,
-- 
Steffen Trumtrar <s.trumtrar@pengutronix.de>

