Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=114.242.206.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794548565;
	b=dudMiJeQcCmfaEyRtFcLAC4QEGrM3iiN51wi2D77otsEhFxJxrB6b+8CdF5HmcvuAmgh
	 eophxXBpQT7bHoA9GMYedxl2plxBar7y93gmJYetSh5G0lKiouIyxthEydJr87KODHdkV
	 SuodlN9dlbdo+1JwWUgoMNo2pdZYYZKyTBeljaiEzjeXikmZ73hg1pemPbd1rhbs4ckqL
	 05hOUukOyAFkBG65S6fcLJsdNE+E23Ic+iqnUQeF25RIbL66c6qdTKsFxz3xwRwuAuiEK
	 CkfOmtQ15qxaSK7WQX2+w2XusuNFUuZNxr39VOvRkpq5EJtHLYZptTXwBUTCkIs/8Uw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794548565;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-CM-SenderInfo:X-Coremail-Antispam;
	bh=HgvdQLtu0pVX82kUlJzFRUFKgu2TFtEGxVrXAnHR91U=;
	b=IY4y7Xa7lUiwz4pe/b14//574gnypapAMbMVn8nXeHb5QuK+fsXwlXG3A/Kmc0OLjUaB
	 P5v7I9zMnRLKUQgMa01tCjt1zKN4fGJ7EJCoAs66rghARjafv8ICAOZlk1ctj0X6awPlg
	 qBLxBWarISO+KX9qweNxU8jKtdbHL1YeJRtnQ4P1926xsL1ofKNSsqb81I8+0thsELihd
	 OasSO6MnnRg5DtSwwrGGXyAuqYyzHScuXYQ6RjKX74slOCgl7+G57dt0XpA9OxnZCz8O2
	 ErsESL0JJZZzcE2WUAHx5qW3SmIVyfEGx4zeVy6yyGF+DWFZ15TjI3j3j00mpsSZUfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=loongson.cn;
	spf=pass smtp.mailfrom=loongson.cn;
	arc=none smtp.remote-ip=114.242.206.163
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B157A606A327
	for <linux-spi@vger.kernel.org>; Fri, 13 Nov 2026 05:42:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B157A606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.17])
	by gateway (Coremail) with SMTP id _____8CxutFLo_Zquh4fAA--.24045S3;
	Fri, 13 Nov 2026 13:42:35 +0800 (CST)
Received: from kernelserver (unknown [223.64.69.17])
	by front1 (Coremail) with SMTP id qMiowJAx3c5Ho_ZqLSg0AA--.40410S2;
	Fri, 13 Nov 2026 13:42:32 +0800 (CST)
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
Subject: [PATCH v2 0/7] spi: loongson: Fixes, cleanup and IRQ support
Date: Fri, 13 Nov 2026 13:42:21 +0800
Message-ID: <cover.1794538736.git.zhoubinbin@loongson.cn>
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
X-CM-TRANSID:qMiowJAx3c5Ho_ZqLSg0AA--.40410S2
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/1tbiAQEKCGr2b-sDSAAAsB
X-Coremail-Antispam: 1Uk129KBj93XoWxXFyrXFy5AFWxZF4xJw45XFc_yoW5GFWkpa
	9xW39Ykw4DKrWIyFsayayjvFyrC395KFW5JFWxtws8Z3y5Gr12qFWDtayYya9rCFyfCa4j
	qr18Ka1kuF4rCFcCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUkYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
	Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE
	14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8j-e5UUUUU==

Hi all:

This series fixes several long-standing bugs in the Loongson SPI
controller driver, cleans up register access, and adds interrupt-driven
transfers with a polling fallback.

Grouped as follows:

  Bug fixes (suitable for stable):
    1. Fix SPI mode caching so mode bits can be cleared.
    2. Drop the redundant and wrong CS deassert in setup(); the SPI core
       already drives the idle CS after ->setup().
    3. Separate PM register state from runtime state so set_clk() cannot
       corrupt the saved suspend state.
    4. Fix clock retrieval on ACPI platforms: try clk, fall back to
       "clock-frequency", fail probe if neither is valid, manage the
       clock over suspend/resume.
    5. Fix the clock divider calculation with an explicit table, avoid
       the off-by-one/out-of-bounds issue, propagate errors, and expose
       min/max speed to the SPI core.

  Cleanup:
    6. Use bitfield helpers and set/clear/update_bits() for register
       access. No functional change intended.

  New feature:
    7. Add interrupt mode support.

On a Loongson-2K3000 board, SPI flash reads improved from about 60 kB/s
in polling mode to about 950 kB/s with IRQ mode.

Thanks.
Binbin

===========
V2:
- Patch count reduced from 8 to 7;
- Deferred the private-definition move and regmap conversion from v1;
  instead, register access is cleaned up with bitfield helpers.
- Reworked the CS fix to drop the redundant and wrong deassert in
  setup(), since the SPI core drives the idle CS after ->setup().
- Reordered the clock fixes so the ACPI/clk-rate fix comes before the
  divider fix.
- Reworked IRQ support: fifo-depth/icnt handling, spinlock-protected
  transfer state, handle_err() cleanup, bounded message splitting, PCI
  IRQ vector allocation, platform optional IRQ with -EPROBE_DEFER, and
  polling fallback.

Link to V1:
https://lore.kernel.org/all/cover.1793689461.git.zhoubinbin@loongson.cn/

Binbin Zhou (7):
  spi: loongson: Fix incorrect SPI mode caching logic
  spi: loongson: Drop redundant CS deassert in setup()
  spi: loongson: Make suspend/resume registers PM-specific
  spi: loongson: Fix clock rate retrieval on ACPI platforms
  spi: loongson: Fix clock divider calculation with explicit table
  spi: loongson: Use bitfield helpers for register access
  spi: loongson: Add interrupt mode support

 drivers/spi/spi-loongson-core.c | 519 ++++++++++++++++++++++++++------
 drivers/spi/spi-loongson-pci.c  |  28 +-
 drivers/spi/spi-loongson-plat.c |  17 +-
 drivers/spi/spi-loongson.h      | 129 ++++++--
 4 files changed, 550 insertions(+), 143 deletions(-)


base-commit: c0ccde965b4874afea9bd40f8cc2362ab9910711
-- 
2.52.0

