Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B4F5947E3;
	Thu, 17 Sep 2026 14:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789655383; cv=none; b=O8WG4O/cPnblzeZo87ktYMgX1MeZHTN8lM8XC/XHUQlfK6nX8EMIpeDykuspDRfD4BGdQuDHDN8xgtET2RnSezqIz6RG/b0Qq9AH5XzYWTnYc79+xGlmRSeVn6yp79UqUjoVB5bM4YNz9P6YqwCpM4aPZENyDt2bKh83VA7USHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789655383; c=relaxed/simple;
	bh=FYV+WCwWboQHgBA9/k32z2Puzx8mErq/I9KVtfprX9s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UHMOtYKJu8Ij7H81Kx8ehW8sNRsRHG3R7fJWcXnMDACigB8gYIrhFCWZX0P1GEVDHNMURLkpTjErm6HNh5ose13oWorNhp032lBKvgHeaz79ytuebsdkzQnXW/WiO/dG81IzfNXKFBatJoGjvF2aUUEDsm+LbAN7VtEZoWmDGIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [127.0.1.1] (unknown [223.166.93.127])
	by APP-05 (Coremail) with SMTP id zQCowABHtD5A+atqNnqCCA--.4692S3;
	Thu, 17 Sep 2026 22:29:26 +0800 (CST)
From: Han Gao <gaohan@iscas.ac.cn>
Date: Thu, 17 Sep 2026 22:29:19 +0800
Subject: [PATCH 1/4] spi: sg2044-nor: Return transfer errors
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-fix-sg204xspi-v1-1-5c95dac429a8@iscas.ac.cn>
References: <20260917-fix-sg204xspi-v1-0-5c95dac429a8@iscas.ac.cn>
In-Reply-To: <20260917-fix-sg204xspi-v1-0-5c95dac429a8@iscas.ac.cn>
To: Mark Brown <broonie@kernel.org>, Longbin Li <looong.bin@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen Wang <chen.wang@linux.dev>, 
 Inochi Amaoto <inochiama@gmail.com>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>
Cc: Han Gao <rabenda.cn@gmail.com>, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 sophgo@lists.linux.dev, linux-riscv@lists.infradead.org, 
 Han Gao <gaohan@iscas.ac.cn>
X-Mailer: b4 0.14.2
X-CM-TRANSID:zQCowABHtD5A+atqNnqCCA--.4692S3
X-Coremail-Antispam: 1UD129KBjvJXoW7uFW5Aw4rCF45ZrW5Aw43ZFb_yoW8ZF4Dpa
	47ua1Utr1rKa1UAF4fJ3W7Xayay34fKa4UK347Kw1fZF4DZ3WUJF40vFyfXFy3tFy2qr1q
	vF42vry5Cr1DK37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUm014x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0x
	vEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVj
	vjDU0xZFpf9x0pR75rsUUUUU=
X-CM-SenderInfo: xjdrxt3q6l2u1dvotugofq/1tbiDAMNDGqr9nAGswAAs8

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

