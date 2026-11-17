Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794881205;
	b=bAMeG3EqBc6mzcgNKrDshbrwrZs48zIGq7tD32VECQM9UZdU9Tgaej+3ljuTbEUOIKuT
	 M2YYr/Rcxbx+QLOtD6RzUBwFFiYoVVw7RjmtN6Mbo+MSKg5ErDxYF+pX1gfAXsELVYbWJ
	 jKnPF+lplZgpkpRVu3/8KeBDFEQEND8YV1Hw6f9/s8YOEVMowev33N8uInoiASK6BwTK4
	 m143ZqdenfhW7VPjO4gPEpYtzr6Wj1hmpoLz4jKppmS7zlgfmi9+AB+lc4e1PjxLVzhbA
	 ZmDnNAsYOnklGhdcvSyrzrPQevZ/k10N/qE45hy32GrPi+qWvfp5J7snLw8UXZv3GjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794881205;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ipD9z61No5E/UoxkAuOX/M6L7hnvJUNvWGwglb7bkpU=;
	b=IJJ3DVzzRPwpiZpbsID2XGYzYSVdY2G44PyHPEFlVPy5SZ0S9NxqW4nb2RvG+QgJS8Yb
	 kfZ86fWneVpo/Aq1jl+wKaXs2tV7uDlcqT+1q/0S206S7E6yl7/UfzG0CoOMdiGnFVfTz
	 NF9iUJxxZ+92JF9ONb4ctlmKfOX6HGVps3fMFBZt50+q1sK+NsjEXTRqv9S37UJUk0dgH
	 /VTIPIqp5SejVat/iHZ9shlQPWweKEssgBfl0AjC+xQ++hIhdciKXr9oJWyP1zu00ySrl
	 I40xh7AxE6/qpRQEbXqfBSIu+uVinhk1AaxmXkEBPC39CXUuy+ByYAoW0NCryCWXY5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=jJ7Neod7;
	arc=none smtp.remote-ip=111.22.67.139
Received: from cmccmta6.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D42B606A31C
	for <linux-spi@vger.kernel.org>; Tue, 17 Nov 2026 02:06:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5D42B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=jJ7Neod7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=jJ7Neod7ur1ZxSEkH9hxI7kURcTDIwS7pZ7C2wSUYtqxY/3JNaqkP1Pe1Gi5qoZ3Ju7NUmbBuuPg8
	 zZXbQRF2sNyL3VOc/OeDDt1JE4dIXs1p1+Y7Ry5ox6Xxc1zS6PW0diNQGHZsrzimkleIVyPFX/zo9D
	 5DKHoRdaUov8O3u0=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee56afbb6b2996-0139f;
	Tue, 17 Nov 2026 10:06:43 +0800 (CST)
X-RM-TRANSID:2ee56afbb6b2996-0139f
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain.localdomain (unknown[10.55.1.72])
	by rmsmtp-syy-appsvr10-12010 (RichMail) with SMTP id 2eea6afbb6b1370-9e880;
	Tue, 17 Nov 2026 10:06:43 +0800 (CST)
X-RM-TRANSID:2eea6afbb6b1370-9e880
From: Luo Yifan <luoyifan@cmss.chinamobile.com>
To: Linus Walleij <linusw@kernel.org>,
	linux-spi@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH] spi: orion: handle clock failures on runtime resume
Date: Tue, 17 Nov 2026 10:06:46 +0800
Message-Id: <20261117020646.20111-1-luoyifan@cmss.chinamobile.com>
X-Mailer: git-send-email 2.24.4
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

orion_spi_runtime_resume() ignores the return value of
clk_prepare_enable() for the AXI clock and returns the result of the
second call.  If the first clock fails, the function still enables the
second one and reports success, and if the second clock fails the AXI
clock is left enabled.

Check both calls and undo the first one when the second fails.

Signed-off-by: Luo Yifan <luoyifan@cmss.chinamobile.com>
---
 drivers/spi/spi-orion.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-orion.c b/drivers/spi/spi-orion.c
index b8882229c0..9c3c16449c 100644
--- a/drivers/spi/spi-orion.c
+++ b/drivers/spi/spi-orion.c
@@ -825,9 +825,19 @@ static int orion_spi_runtime_resume(struct device *dev)
 {
 	struct spi_controller *host = dev_get_drvdata(dev);
 	struct orion_spi *spi = spi_controller_get_devdata(host);
+	int ret;
+
+	ret = clk_prepare_enable(spi->axi_clk);
+	if (ret)
+		return ret;
 
-	clk_prepare_enable(spi->axi_clk);
-	return clk_prepare_enable(spi->clk);
+	ret = clk_prepare_enable(spi->clk);
+	if (ret) {
+		clk_disable_unprepare(spi->axi_clk);
+		return ret;
+	}
+
+	return 0;
 }
 
 static const struct dev_pm_ops orion_spi_pm_ops = {
-- 
2.24.4



