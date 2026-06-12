Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955BE78F4A;
	Fri, 12 Jun 2026 00:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781225269; cv=none; b=QjRDBbudEnGOI1fIy7Q+zLsZCHE7HFSutj2z1pB1ctzhs7+DlcYJc4oW/YIZsjYresjZB87NtOTKOKa8zqG/1e/OED2yBvDLmutPqb1MjpdUW/NTbPEeBcSx0+7dzDYVUHTF+oYL49kem5otUI+IO6pKJ6jL3gnNkyLO3bw6GKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781225269; c=relaxed/simple;
	bh=2/FyFa/g9srdUHhZiIqoJUgXh8AxhgnJJZmjxbEbIwA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o5eWwsHOeLIAWqENxyOjMeOYR1gHd/Cd7oUiflDaFIcHblUCSmr/OT5edC/ZKhRFSJzdg2ZRrzkjG8fuP7v/6qBMFJ1anvO7R6c71frVwCBZXEgWjB8GGcu06N7GlSxXqvPlrq1HDm0iTSGvblJML2EGVGQ+77UdaYpPggBNgbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UMAgkuyG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UMAgkuyG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66B3C1F000E9;
	Fri, 12 Jun 2026 00:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781225268;
	bh=FDjd9wtG+K2l6YpRKfcwQxC8L5tlalg0y/RaEzkNZOY=;
	h=From:To:Cc:Subject:Date;
	b=UMAgkuyG+OimaEmklyVq8PO9FjYw/qW9r1v1sKGeLvt8BBw+g3jUrdXPfFoP4881l
	 PdaQesMTUCtYdY23avBjiZR7byFn0X2t7v5I9/dPK8nuKPhbFQRoqOQ/egaW9fTX2G
	 GA9eYaG2xuacvZ/btSmSdZZ/fFWvKM5miL3iB+GWDvw0khl1BwlAmmvxabe3VttcVK
	 uGe5O4HCgEdVHy+vfJLKx3lTl7XpuHAmvStnf6u810s9HmJVEmj/7Gc2C1rBIh4yle
	 TZB8mubOkAcSWMlvVmv/yRtDM9ez5sxmJ6+Eh8EJADWE0hcZ/NhRXVaE6j1jl0IcoR
	 LjVHJ3PN+FUPg==
From: Jisheng Zhang <jszhang@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] spi: dw: fix wrong BAUDR setting after resume
Date: Fri, 12 Jun 2026 08:28:35 +0800
Message-ID: <20260612002835.5240-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After resuming from suspend to ram, spi transfer stops working. Further
debugging shows that the BAUDR register isn't correctly set, this is
due to dws->current_freq doesn't match the HW BAUDR setting,
specifically, the dws->current_freq equals to speed_hz, but BAUDR is 0.
so the dw_spi_set_clk() in below code won't be called:

        if (dws->current_freq != speed_hz) {
                dw_spi_set_clk(dws, clk_div);
                dws->current_freq = speed_hz;
        }

The mismatch comes from dw_spi_shutdown_chip() when suspending.
Fix this mismatch by setting dws->current_freq to 0 as well when
clearing BAUDR reg in dw_spi_shutdown_chip().

Fixes: e24c74527207 ("spi: controller driver for Designware SPI core")
Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 drivers/spi/spi-dw.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
index 9cc79c566a70..2f2debc64e73 100644
--- a/drivers/spi/spi-dw.h
+++ b/drivers/spi/spi-dw.h
@@ -282,6 +282,7 @@ static inline void dw_spi_shutdown_chip(struct dw_spi *dws)
 {
 	dw_spi_enable_chip(dws, 0);
 	dw_spi_set_clk(dws, 0);
+	dws->current_freq = 0;
 }
 
 extern void dw_spi_set_cs(struct spi_device *spi, bool enable);
-- 
2.51.0

