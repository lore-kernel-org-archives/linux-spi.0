Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6233D75C6
	for <linux-spi@vger.kernel.org>; Fri, 14 Aug 2026 11:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786707770; cv=none; b=K2th96u5zMY+K7EysItWaauuvVZ36Z/5jSrs6dG0e2wII13youRxMDHa8+K9l1KsTNTUv4tMCp1NuZRn6WxSxlBs92uzU2MBbUcwJZ/j+WhBqPR/kqfIj6UHyQYgeJo8IimTe++rfy+SnEpILEKZg2H9Xvnfw6KgKNqr1WnjTwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786707770; c=relaxed/simple;
	bh=7gWXVfQ7ShoN4+41qX4lrfbPX6NyRyLp+xtB/jzPRyo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=puAI1whHVpk0E+WDUuYk1FVX8U6cl72Ra8mp10pGqRRH+/SnKHhfU0oqhbElAfDPKMxnh5Gmz1CxLYYivyzbgSCLJtXs86FSltd2jDMTknbpFBlEx71a2uIt4DI0u3PkNiKy0Ax5ShLpQ8hlbHyxvFp4U7yJO2F+C+B7XcIM7Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YtUP+zYW; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YtUP+zYW"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3811f512167so1153134a91.3
        for <linux-spi@vger.kernel.org>; Fri, 14 Aug 2026 04:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786707768; x=1787312568; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=P6jaM8HMwIXj7m5RVMkRiYdLvw+IGLPtGBXFdfrTkwo=;
        b=YtUP+zYW5opkCGkQwUw97YbFvXG3SiiGpnlxMJNFNBpbVNn2HqpVE00vlmHxdMi7jg
         0ER3/95zjliPeYpXbseXTkwy/8EJv/Y1uGRAFmVP/1/fMn9JFBG8ZY/D+V9G7QEpSmwz
         6qqZFE0Yg7iNpjJTKhHGdVIzZPbuS5vptL/Ojj6JBoTVtVl1ecUSrFCLAbvaJf6CIHpG
         K5I/awiGJ+y/f8Q8SqwDJzH08PxmYnTo2oY0WITP6qv0o6BJbve7VJnSSnC0nlxtngmK
         Q+r/5Qi6xuiLWT5yifhFuC7T2ri0S0mnLfDoCZi4OAyy7po5ajAamb3p3ryI7Ziou2/s
         1s1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786707768; x=1787312568;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P6jaM8HMwIXj7m5RVMkRiYdLvw+IGLPtGBXFdfrTkwo=;
        b=GNINTLxa6ZCNYl2AL0CKlj7k/yk+efbOz34wc75tXrVcZ5zT9GFlgUck0kkcrdLVHI
         TD9jRha17cQU4bZ/SF6ea/fUOhjzfPgLAedwShdNvf/v4zPvnSrxpnPN9Wlh5An1fymx
         7o/lKhDcS7XPStpdtfyCPYR05Q3V8joSatxToudF6LXcxHp/ucV3NV7rttzjNwWHVtQa
         b+PrPDbpEzWUGbz3eBvPZrPrrMzG5Oz4EOc+R44S+xuTEN/QZgWqEA6QzwiLCv+nfsQq
         Joh034kkzJE3KdnzaFlGFVbv/llHJbrR2KwojMsR3Cua3Qu6ztvy0Z5u7S8y4zMgrSkQ
         spyQ==
X-Gm-Message-State: AOJu0Ywnb72y3kmL6Zxj/kva8PvumtYkMViL3ooFbWw0Qso7Kdc0Ftmq
	addRFmyIf0Ie2Rgw9Jot+i27dJU0RS/rtEkTQrp3g1rz/8bmREfiS15b
X-Gm-Gg: AR+sD13aIMzYd5HW33rRS6U2H/wbZEN6AuEvieVHqzhrbR8x2K/jxNu9boQO5HMZ3sV
	8G5H+U/FqIhzitrxvlgjlfRa23YQ353Z8fPBggN9LpPmKINbv3+R8h4YgP/+rkJMIu88giE+zp8
	OPmR+rE/aFdqE6qywWQ05xnuIk04Sn2S3HZh60yjA/1ingN962x8itIevuFL/JHknZ2hlyqaQtC
	7tmNXWsv7Yv5ImiflWttm1G4A70HmJ+hxam6RQ+aP74os4yOq5B0npU1Sf9dhG6Dj26NPEymanX
	KCgiOZ79OJdrftcwj+CwuAg3mx//S1Qu03eGkdISAkCEdJ16buo4Qvutgrtm3uzinsNpllxVANb
	fV6ENKUC1TbSn8gf0iS6eF6wXcG0o5KUfJVFTkjLmSzgajNdZqYlg3bzE9GOCjgAgiJ/MyZNazB
	mJSsVTOpJXvNEpap16WQrrtRtRscmUNTSZmvf4enT50R0ohAScMPbrv6iWXhB9eVf8CVQ7N14KC
	Q==
X-Received: by 2002:a17:90b:3c0e:b0:393:1d92:db5 with SMTP id 98e67ed59e1d1-3933b8f1451mr5561677a91.10.1786707768138;
        Fri, 14 Aug 2026 04:42:48 -0700 (PDT)
Received: from localhost ([220.196.228.78])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39339b1edb2sm1267974a91.0.2026.08.14.04.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 04:42:47 -0700 (PDT)
From: Liang Hao <haohlliang@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Liang Hao <haohlliang@gmail.com>
Subject: [PATCH] spi: dw: Remove shadowed dws in dw_spi_setup()
Date: Fri, 14 Aug 2026 19:42:35 +0800
Message-ID: <20260814114235.31281-1-haohlliang@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The controller private data is already fetched at the start of
dw_spi_setup(). Drop the redundant inner declaration that shadows it.

Signed-off-by: Liang Hao <haohlliang@gmail.com>
---
 drivers/spi/spi-dw-core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index dfce2fa20adf..206d3f9dd83d 100644
--- a/drivers/spi/spi-dw-core.c
+++ b/drivers/spi/spi-dw-core.c
@@ -1098,7 +1098,6 @@ static int dw_spi_setup(struct spi_device *spi)
 	/* Only alloc on first setup */
 	chip = spi_get_ctldata(spi);
 	if (!chip) {
-		struct dw_spi *dws = spi_controller_get_devdata(spi->controller);
 		u32 rx_sample_dly_ns;
 
 		chip = kzalloc_obj(*chip);
-- 
2.50.1 (Apple Git-155)

