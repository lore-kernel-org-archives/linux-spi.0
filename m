Received: from out203-205-221-173.mail.qq.com (out203-205-221-173.mail.qq.com [203.205.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4DA3272E56;
	Thu, 18 Jun 2026 16:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781801150; cv=none; b=tnUkO+8EhI3DXpfJcqj77lTfb5blqzFGCtuvxoLOKlgvWPpZ5HT4EzCxQcRZHhsmwaKDsP6edj3vGXtDwPb44YtETHWtqXHZVcC6oFFtBjEetwcz3ZTWckKDIKzmWCGl5mSwTX3wZ7xVFSZmmcNQNs+iiMZn+ddBGwqsSCjHq9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781801150; c=relaxed/simple;
	bh=4KrGZCKUUvZmExN8Kosr1+HUhD09PB4DRGEo/99DfNE=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=Tgvy7cBx0+aDJKlQ6itiBAvbkl6W6IUC2isc77vHquaSMT+DK5S+t7xcmithg2jLGw2IGL83Lo8+DETHfz6t2121GhILDxPUlWrQjiHgebK6p0NJcyCmUGahQNkZmU02AF5eS/3Y+NNRqmItzPqb9463sObjERWiV/gB0SUVV94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=caUHW3GI; arc=none smtp.client-ip=203.205.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="caUHW3GI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1781801139; bh=uWpE45w7kGs1DsWdczrVp1oinDErbzjvc6QngFx2vNg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=caUHW3GIfvMnDHEEsMnT9jF3B4woUECaYxOFwlbqiexIoX2chjnhowABWCSL8BfXm
	 9EJJ0X8jaVp522xzcVy1gHp6J0ZmUM0hUw7D0miuKdyNkRNHlfMZZKFG+MUryWVbeM
	 TfCveCKSSSb8ikX0blrrmDAcge0qLrN8My2Mo/VA=
Received: from ws006419.mbzu.ae ([5.195.0.150])
	by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
	id B558E2E3; Fri, 19 Jun 2026 00:45:21 +0800
X-QQ-mid: xmsmtpt1781801134t5ilkoij1
Message-ID: <tencent_B5A06807924A77C8690730EBF7A052AABE05@qq.com>
X-QQ-XMAILINFO: MyzM/wvJS/65FX9PXBJCbcnjG8bK6D4EtLyN+PX/HQA+NWEPzbqdVNgUmpKny4
	 UrACE5xxCe0Uhbb9cP3Xoz7QZrfEK7haBDuAZ6T0GZ8db5+vv6QflVt/CVUTSwg03M/C1pgVQqvt
	 Q3aWzDy58glv6q2R7WGdkNEZWVyexO9AAF/5yuvP1FgynF70CiLipBxO1kxIH+3JXy5JVEHygZ7I
	 XxUeNOrAMc4IfpGmcoOaS4jfnjKsS5QYbioFQK/0AaqOQZjEeB/8kTXU7SHcMJZHz9LOTeqlSgiP
	 Ig0BA6u497n7XAw0TpUV9b6Pq/pvreeJJBSen6b5rE9FH650MmFyDnmu3t0sOv/fH7A9lRk1fAq1
	 o4UWyt4eIbiJqkAIDMQIMHpMiQuAdXtrNrmZHFvnkbRscOBkVyngivSwt82sOCTfvir+9FcasC5i
	 lxytG6ArV5lFLeKxWXVGCt9nVO3ZaKpy7UGYBHQKw9xK2cmyglwiltCrO5vLXPtuT3wq1/bX1wDP
	 tZVmPZgfaJqYmOH5DB00LREhlWiVjcO2c+uxlJVAMvvnEZF/KYtBrIoDitAJa5Q8MUwmwNdsqdAk
	 sjypT9zMYAaasvkkMN69vArkAfvyhyDHweLY723AeFCotYqeFr1/jWo57u1GDLIGfegeEkVu/ztr
	 QK1qTiwn0iXwXEWcD1DXMyTGM6gAZW2iMncApnDsm74+vwwad+pxO2a9r8bfRXCyp+FkhO+RQsxr
	 DpNbfy0jeeYBY8aTvAfBQzQbZQLA1CSLUtBE/QPP4IudXb2Ejv0mhPik6HlORKOtvwvZky19SrY5
	 d/klND+J1N7dlctAWUM8LFXT5xQ6Lz5XpRswMq5K2cooeeKbibqERB+FUrTLwQaXnuurZuePkGzU
	 eQztiAqCLWxUVswG8AjigdurwgqmEtABj4mGLLMd9C08Ir7zaEbdcISn6irm9FRP0depp+3FVDvq
	 iIk9XMxjij7dbTd/BWVbetw/S+BbhNoIMjROEsSfBeS/LoQrzCQ0lYGcue63v7Uwzv1Ccqe4BnBk
	 X12b9R78IIwc17Tp1wf2MEVBaCslhpHaGvXODupiSAtzbhWNV3MEtJDmIF9bzR9H73VRkPz7TzbZ
	 E1Q5KQ
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
From: Jiawen Liu <1298662399@qq.com>
To: broonie@kernel.org
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kamal.dasu@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	jonas.gorski@gmail.com,
	kursad.oney@broadcom.com,
	william.zhang@broadcom.com,
	Jiawen Liu <1298662399@qq.com>
Subject: [PATCH 2/3] spi: bcm63xx-hsspi: return error from failed controller suspend
Date: Thu, 18 Jun 2026 20:45:17 +0400
X-OQ-MSGID: <20260618164518.3885130-2-1298662399@qq.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260618164518.3885130-1-1298662399@qq.com>
References: <20260618164518.3885130-1-1298662399@qq.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

spi_controller_suspend() can fail if the SPI core cannot stop the
controller. bcm63xx_hsspi_suspend() ignored that error, disabled the
PLL and core clocks, and returned success.

Return the suspend error before disabling the clocks.

Signed-off-by: Jiawen Liu <1298662399@qq.com>
---
 drivers/spi/spi-bcm63xx-hsspi.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-bcm63xx-hsspi.c b/drivers/spi/spi-bcm63xx-hsspi.c
index 58012e1b5ae7..37b3534d0b0a 100644
--- a/drivers/spi/spi-bcm63xx-hsspi.c
+++ b/drivers/spi/spi-bcm63xx-hsspi.c
@@ -889,8 +889,12 @@ static int bcm63xx_hsspi_suspend(struct device *dev)
 {
 	struct spi_controller *host = dev_get_drvdata(dev);
 	struct bcm63xx_hsspi *bs = spi_controller_get_devdata(host);
+	int ret;
+
+	ret = spi_controller_suspend(host);
+	if (ret)
+		return ret;
 
-	spi_controller_suspend(host);
 	clk_disable_unprepare(bs->pll_clk);
 	clk_disable_unprepare(bs->clk);
 
-- 
2.34.1

