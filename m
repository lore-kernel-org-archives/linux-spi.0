Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=114.242.206.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793689692;
	b=PVM6r5ezg8pM4yEq3qeaBqJKLGG9v+T09etxem1JWpGXFZtYrxXunhNxoitJl7j1mIuX
	 RIjypRdZykOwwik5Kkw3Qa/Wa0+LNDToCuO8xkCNmsfFUBY+I+1k/XHR9RqiH1/8ydrrd
	 MmMmB0LOin66Nz0H48gY8eAQcPocv+qyIcJk3NHRkHEyX/aFZZvVT4bBw4lqQgTmRHDrc
	 kOuxiWJShAS/HCNi+j1ojRj59A/k80LZ5BvYY8yEfagI0kRCN5CtaRnX56q8Y6fFejxtI
	 lVMkPPtI2f671XFJ0b5Um5aRgVkc83H0ov0R6SLsh9UX1VuYlsJb1tNnaru6qMxi3UQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793689692;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-CM-SenderInfo:X-Coremail-Antispam;
	bh=dFj0a/EKFZ24fIVp+xOvR4+qo4gXBCRZ4uJatICBRCw=;
	b=NDlaKfESrNhW5U1fRIg/BNWYbu3nfUG7HNGmfB3eXcSMe7UBc7m6pi7xEwXrMoB38Qz4
	 XZObLYCW3QJhAVT8egOMouqOV2nUxwVKIYxuWvka/fTNFWOzCKDyrGeukl/O6PxL2NNvy
	 aArsIP9bx6tVI9lxCBcefOU41F+S4TwwwnMt/4uUiEj4h9UOWMsxOvVPXChMvFW+Nf6hL
	 sa+NbWAKpXcU6kWkwBr9nZATN0tHsS/r0lBARlFJVVqw8MqvlSwM7Dg5f3i0x78bzXet/
	 lfNlc9I9PZLS64C9pmoV+K+VTd/xwhf79ZSyd/BxSwpMR5sVCamcXjDaCtKeKCCBWMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=loongson.cn;
	spf=pass smtp.mailfrom=loongson.cn;
	arc=none smtp.remote-ip=114.242.206.163
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6ED0606A324
	for <linux-spi@vger.kernel.org>; Tue,  3 Nov 2026 07:08:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6ED0606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.17])
	by gateway (Coremail) with SMTP id _____8AxHNJYiOlqmNwbAA--.15373S3;
	Tue, 03 Nov 2026 15:08:08 +0800 (CST)
Received: from kernelserver (unknown [223.64.69.17])
	by front1 (Coremail) with SMTP id qMiowJCxtMxXiOlq4BQyAA--.11182S2;
	Tue, 03 Nov 2026 15:08:08 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Yinbo Zhu <zhuyinbo@loongson.cn>,
	Mark Brown <broonie@kernel.org>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>,
	loongarch@lists.linux.dev,
	linux-spi@vger.kernel.org,
	Binbin Zhou <zhoubinbin@loongson.cn>
Subject: [PATCH 0/8] spi: loongson: Fixes, cleanup and IRQ support
Date: Tue,  3 Nov 2026 15:07:47 +0800
Message-ID: <cover.1793689461.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.52.0
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCxtMxXiOlq4BQyAA--.11182S2
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/1tbiAgEACGrpUP0DZQAAsD
X-Coremail-Antispam: 1Uk129KBj93XoW7uF4kJw48GryxCw1UJw13trc_yoW8ZryUpF
	W3Gas8CF17JFWxZrnxAa40vFy5Z393GF45KayxJw45ur90y34Yvrn8tFyYyay7JryxJ3Wj
	vry8K3WxCF4rCrXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUkYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
	Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE
	14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8xuctUUUUU==

Hi all:

This series fixes several long-standing bugs in the Loongson SPI
controller driver, cleans up the core driver, and adds interrupt-driven
transfers with a polling fallback.

The series is grouped as follows:

  Bug fixes (suitable for stable):
    1. Fix the SPI mode caching logic so mode bits can be cleared.
    2. Fix the chip-select idle level for SPI_CS_HIGH devices.
    3. Separate PM register state from runtime register usage.
    4. Fix the clock divider calculation with an explicit divider table.

  Robustness and cleanup:
    5. Support the ACPI "clock-frequency" property and validate the
       input clock rate during probe.
    6. Move private register definitions and the private controller
       structure into the core driver.
    7. Convert the driver to the regmap-mmio API.

  New feature:
    8. Add interrupt-driven transfers, keeping polling as a fallback
       when no IRQ is available.

The IRQ path also brings a significant performance improvement. On a
Loongson-2K3000 board, reading SPI flash with dd improved from about
50 kB/s in polling mode to about 382 kB/s with IRQ-driven transfers,
roughly 7.6x faster.

Binbin.
Thanks.

Binbin Zhou (8):
  spi: loongson: Fix incorrect SPI mode caching logic
  spi: loongson: Fix CS idle state for SPI_CS_HIGH devices
  spi: loongson: Make suspend/resume registers PM-specific
  spi: loongson: Fix clock divider calculation with explicit table
  spi: loongson: Support ACPI clock-frequency and add error handling
  spi: loongson: Move private definitions into the core driver
  spi: loongson: Convert to regmap API
  spi: loongson: Add interrupt support for SPI controller

 drivers/spi/spi-loongson-core.c | 566 ++++++++++++++++++++++++--------
 drivers/spi/spi-loongson-pci.c  |  25 +-
 drivers/spi/spi-loongson-plat.c |  17 +-
 drivers/spi/spi-loongson.h      |  48 +--
 4 files changed, 457 insertions(+), 199 deletions(-)


base-commit: 8ab8c079820e6134bc0d8c312244644afb66ae9c
-- 
2.52.0

