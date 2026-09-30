Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B4A51A747;
	Wed, 30 Sep 2026 18:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790792610; cv=none; b=b9oUlGYt36JMsK1HGZERD8gLOREA6KF8f2Rsio0oV9Zvms8YKA/ALeqUgLo8dEaj6tiDeSfQMmaYaVZjlaFfaiZ09rFXzveKugJhu6+x8LlPvMdXG/6hzlg9H4Z2cu09UVHYaRk12DulEapR4MMYdJs34+hi0Swpqr1TtkycYBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790792610; c=relaxed/simple;
	bh=FYV+WCwWboQHgBA9/k32z2Puzx8mErq/I9KVtfprX9s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Qern04vVMphz2J6MO1aHH7wp3MY5DyA3W0Qhx8pBxO7ubnk4xKjxyxTIbbrl67e0B9Z/ZjkMPEevSDfaOHrPSSBIVKals2Qxg2x29UEDJN35CUMKPnYWK977XE8jftqIQKZYgk036zpPnrARJgQIi3Edjp/Fa3etrYNxBbagHRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [127.0.1.1] (unknown [223.166.93.127])
	by APP-01 (Coremail) with SMTP id qwCowAAHofR9U71q8y58CQ--.14027S3;
	Thu, 01 Oct 2026 02:23:03 +0800 (CST)
From: Han Gao <gaohan@iscas.ac.cn>
Date: Thu, 01 Oct 2026 02:22:50 +0800
Subject: [PATCH v2 1/4] spi: sg2044-nor: Return transfer errors
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261001-fix-sg204xspi-v2-1-014dbaf22b5e@iscas.ac.cn>
References: <20261001-fix-sg204xspi-v2-0-014dbaf22b5e@iscas.ac.cn>
In-Reply-To: <20261001-fix-sg204xspi-v2-0-014dbaf22b5e@iscas.ac.cn>
To: Mark Brown <broonie@kernel.org>, Longbin Li <looong.bin@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen Wang <chen.wang@linux.dev>, 
 Inochi Amaoto <inochiama@gmail.com>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>
Cc: Han Gao <rabenda.cn@gmail.com>, Hangfan Li <lihangfan@iscas.ac.cn>, 
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, sophgo@lists.linux.dev, 
 linux-riscv@lists.infradead.org, Han Gao <gaohan@iscas.ac.cn>
X-Mailer: b4 0.14.2
X-CM-TRANSID:qwCowAAHofR9U71q8y58CQ--.14027S3
X-Coremail-Antispam: 1UD129KBjvJXoW7uFW5Aw4rCF45ZrW5Aw43ZFb_yoW8ZF4Dpa
	47ua1Utr1rKa1UAF4fJ3W7Xayay34fKa4UK347Kw1fZF4DZ3WUJF40vFyfXFy3tFy2qr1q
	vF42vry5Cr1DK37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQ2b7Iv0xC_Zr1lb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
	8067AKxVWUGwA2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF
	64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcV
	CY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv
	6xkF7I0E14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4
	CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvj
	eVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I
	1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
	14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjTRUGYdUUUUU
X-CM-SenderInfo: xjdrxt3q6l2u1dvotugofq/1tbiCRUGDGq9GDh2-wAAso

The transfer helpers return errors, but both dispatchers discard them.
Return these errors to the SPI memory layer instead of reporting success.

Fixes: de16c322eefb ("spi: sophgo: add SG2044 SPI NOR controller driver")
Signed-off-by: Han Gao <gaohan@iscas.ac.cn>
---
 drivers/spi/spi-sg2044-nor.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-sg2044-nor.c b/drivers/spi/spi-sg2044-nor.c
index f3bcb8a1b92bb1ceee298fa0b720f55f22cf20c3..ff026ca0f76635fee959d7502f457d43dbec0706 100644
--- a/drivers/spi/spi-sg2044-nor.c
+++ b/drivers/spi/spi-sg2044-nor.c
@@ -307,15 +307,15 @@ static ssize_t sg2044_spifmc_tran_cmd(struct sg2044_spifmc *spifmc,
 	return 0;
 }
 
-static void sg2044_spifmc_trans(struct sg2044_spifmc *spifmc,
-				const struct spi_mem_op *op)
+static int sg2044_spifmc_trans(struct sg2044_spifmc *spifmc,
+			       const struct spi_mem_op *op)
 {
 	if (op->data.dir == SPI_MEM_DATA_IN)
-		sg2044_spifmc_read(spifmc, op);
+		return sg2044_spifmc_read(spifmc, op);
 	else if (op->data.dir == SPI_MEM_DATA_OUT)
-		sg2044_spifmc_write(spifmc, op);
+		return sg2044_spifmc_write(spifmc, op);
 	else
-		sg2044_spifmc_tran_cmd(spifmc, op);
+		return sg2044_spifmc_tran_cmd(spifmc, op);
 }
 
 static ssize_t sg2044_spifmc_trans_reg(struct sg2044_spifmc *spifmc,
@@ -389,19 +389,20 @@ static int sg2044_spifmc_exec_op(struct spi_mem *mem,
 				 const struct spi_mem_op *op)
 {
 	struct sg2044_spifmc *spifmc;
+	int ret;
 
 	spifmc = spi_controller_get_devdata(mem->spi->controller);
 
 	mutex_lock(&spifmc->lock);
 
 	if (op->addr.nbytes == 0)
-		sg2044_spifmc_trans_reg(spifmc, op);
+		ret = sg2044_spifmc_trans_reg(spifmc, op);
 	else
-		sg2044_spifmc_trans(spifmc, op);
+		ret = sg2044_spifmc_trans(spifmc, op);
 
 	mutex_unlock(&spifmc->lock);
 
-	return 0;
+	return ret;
 }
 
 static const struct spi_controller_mem_ops sg2044_spifmc_mem_ops = {

-- 
2.47.3

