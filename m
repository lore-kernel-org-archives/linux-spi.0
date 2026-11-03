Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=114.242.206.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793689692;
	b=g7dEf0O/7R3KovJvW1R6N+T4zzTv0Qko4yfYSX7nM2Hn01EwZ+F5pf83Lq2ty9kBhrT7
	 Rm+gxfOc9JHdh9fgiPnlmwn+E9wmjI6dkU6uOi+kusm5cSybKkE1tDJ87oKoVHetfTZJG
	 YweHVv1ZrAk306YlINg5RHQtzVyyDMQPLZiZu1c4VAX8tyv3rv8cWFuBMvJB+VoVb1V0G
	 uYZuKMfD5xdru8ORIDX4TNxz4XcUV5SuV0kQvJUeJBd2RquKpCuiBBEsADRZCuBFRwHOA
	 Pi9RkBH58VRing1rMIJkZrbPi5wuM53Ehl8vB2FCdMS6j0Cg/7mFIwXdcuGe3fZx6CA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793689692;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-CM-SenderInfo:
	 X-Coremail-Antispam;
	bh=p7Oow2uLp+Jls7a3wouiafa+AzM9o4l2mEgHcW18EfM=;
	b=UFQh+T+F2H3ttcE5VSAcsT4TgfgFCp2fE0B0oO26erVvFHWjtjWjDjXwqQ7Bk5CSEC68
	 joqBt/4bZRB9UPtl4oNC+UTDLxMHJ71Qa1vlxMBgcnZ+DPx0RBf5WFatMo1yx0jujTVZ9
	 4J5VNLv5Etv6LduqlzMjpgxzI04RTs+Be990V1bJxdJqAW+hq46uiUPzRLymJ2pD7FEO8
	 z65lQiJqy2Koyaeqft+bQOryncIoJFhq/0o1ztSEAfsn76LLZ9paMu4qB36XSoH0z48x1
	 8t62hMvYsuD2VoDmfaC/Mjhy09KmKACbR8R/fQr+miflbPL3dJvG1MXm0FEwQwProzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=loongson.cn;
	spf=pass smtp.mailfrom=loongson.cn;
	arc=none smtp.remote-ip=114.242.206.163
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68558606A330
	for <linux-spi@vger.kernel.org>; Tue,  3 Nov 2026 07:08:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68558606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.17])
	by gateway (Coremail) with SMTP id _____8CxfdJaiOlqotwbAA--.15148S3;
	Tue, 03 Nov 2026 15:08:10 +0800 (CST)
Received: from kernelserver (unknown [223.64.69.17])
	by front1 (Coremail) with SMTP id qMiowJCxtMxXiOlq4BQyAA--.11182S4;
	Tue, 03 Nov 2026 15:08:09 +0800 (CST)
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
Subject: [PATCH 2/8] spi: loongson: Fix CS idle state for SPI_CS_HIGH devices
Date: Tue,  3 Nov 2026 15:07:49 +0800
Message-ID: <bb60200c6802f255fc730f3f5c664e86bea8061c.1793689461.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1793689461.git.zhoubinbin@loongson.cn>
References: <cover.1793689461.git.zhoubinbin@loongson.cn>
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
X-CM-TRANSID:qMiowJCxtMxXiOlq4BQyAA--.11182S4
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/1tbiAQEACGrpQPoEjwAAs6
X-Coremail-Antispam: 1Uk129KBj93XoW7Cw18WrW5Jw45KryfZFyrGrX_yoW8JFy3pF
	47Cay8Cr4kJw48Aa9rJrZ3XFyYk34fXrsrWFW7Kw4F9r98Xw1jvF1jgF1jyr43AF1rXF15
	XFy0grWkCFn8WrcCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r126r13M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
	Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE
	14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j5l1kUUUUU=

In loongson_spi_setup(), the chip select (CS) is unconditionally driven
high (loongson_spi_set_cs(spi, true)) to set it to the idle state.

However, for devices that require active-high chip select
(SPI_CS_HIGH), driving the CS line high actually asserts the device
selection. This may cause the device to misinterpret bus traffic or
enter an unexpected state before the first transfer begins.

Fix this by using !(spi->mode & SPI_CS_HIGH) to ensure the CS pin is
driven to the correct deasserted (idle) physical level based on the
device's polarity configuration.

Fixes: 6c7a864007b6 ("spi: loongson: add bus driver for the loongson spi controller")
Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 drivers/spi/spi-loongson-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-loongson-core.c b/drivers/spi/spi-loongson-core.c
index e95a9af94772..deda754e214d 100644
--- a/drivers/spi/spi-loongson-core.c
+++ b/drivers/spi/spi-loongson-core.c
@@ -99,7 +99,7 @@ static int loongson_spi_setup(struct spi_device *spi)
 		return -EINVAL;
 
 	loongson_spi->hz = 0;
-	loongson_spi_set_cs(spi, true);
+	loongson_spi_set_cs(spi, !(spi->mode & SPI_CS_HIGH));
 
 	return 0;
 }
-- 
2.52.0

