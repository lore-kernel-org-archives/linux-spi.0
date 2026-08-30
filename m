Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132EF70809;
	Sun, 30 Aug 2026 14:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788098500; cv=none; b=hrgFYt8qrTAWmQea6a9+gX6cIPcz3RetEOsLtMZbFQM5HYlpmReBYWd8JXb4R1qTaKBeEzokwB3fZb/mqNMvdl5xHqfCRNb7CFCyIe2n1Gvkc/O808gcgWEM99DTUmKMKKKHfhRH1HYpbZN8gMrnqRQ0xX1zEctbqfXDtwIY37s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788098500; c=relaxed/simple;
	bh=gFikO6UFfebVtmJXqk2YlhurRboIP+j5W8AzkmpQGls=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ae+lB1H0ukCFyi2B8C8gOMXhlrANXf2bzUp6VAHp0G1kiMUbNi1YgKxUYE8cspdT9oxS5U8F3qFm8wnj6UV2Ke6HkSbogF425FucvHtXYKA7IGGHQt+lGlQz6iFjW7p9H39UlpSKXxkPspfc+htnDRwrPhesO3WS7YSAPfV/CDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.241.250])
	by APP-03 (Coremail) with SMTP id rQCowAD3AUC_N5RqRHmbBg--.27689S2;
	Sun, 30 Aug 2026 22:01:35 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Mark Brown <broonie@kernel.org>
Cc: Pengpeng Hou <pengpeng@iscas.ac.cn>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] spi: sh-msiof: propagate setup runtime-PM errors
Date: Sun, 30 Aug 2026 22:01:33 +0800
Message-ID: <20260830140133.24156-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAD3AUC_N5RqRHmbBg--.27689S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Ww45JFy7JFW3Zr4xWrWkCrg_yoW8Gw1DpF
	4xXFyxAr4ktw40kF47Aw4UuF1a9FWxKry8J3yIgw4kCr1Fy34vvF1UWFy2qF15trWDCa43
	Za1qy395XF1Y9F7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyG14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVWxJr
	0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1l42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E
	14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUj9a97UUUUU==
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

sh_msiof_spi_setup() ignores pm_runtime_get_sync() before programming
native chip-select registers and marking the configuration initialized.

Use the checked runtime-PM helper and return failure before register
access.

Fixes: 7ff0b53c4051 ("spi: sh-msiof: Avoid writing to registers from spi_master.setup()")
Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 drivers/spi/spi-sh-msiof.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index 1aeab7ec0bc8d..4c425ec627767 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -453,6 +453,7 @@ static int sh_msiof_spi_setup(struct spi_device *spi)
 	struct sh_msiof_spi_priv *p =
 		spi_controller_get_devdata(spi->controller);
 	u32 clr, set, tmp;
+	int ret;
 
 	if (spi_get_csgpiod(spi, 0) || spi_controller_is_target(p->ctlr))
 		return 0;
@@ -468,7 +469,9 @@ static int sh_msiof_spi_setup(struct spi_device *spi)
 		clr |= SIMDR1_SYNCAC;
 	else
 		set |= SIMDR1_SYNCAC;
-	pm_runtime_get_sync(&p->pdev->dev);
+	ret = pm_runtime_resume_and_get(&p->pdev->dev);
+	if (ret < 0)
+		return ret;
 	tmp = sh_msiof_read(p, SITMDR1) & ~clr;
 	sh_msiof_write(p, SITMDR1, tmp | set | SIMDR1_TRMD | SITMDR1_PCON);
 	tmp = sh_msiof_read(p, SIRMDR1) & ~clr;

base-commit: 08dbfad3f5040f5bdb6c529da20d6d4e81fefd72
-- 
2.50.1

