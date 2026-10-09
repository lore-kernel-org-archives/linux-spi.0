Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD234E2F1B
	for <linux-spi@vger.kernel.org>; Fri,  9 Oct 2026 13:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791552985; cv=none; b=YP3ClodCCyfTLKTdWUIUA/PsmKUUwXppLXbCXv5nMvYb3nkUmqYBuxPUZUU3DP1nXE90Z+WpOO2qzcS57hwQBYQ5fTjqNOzl0u9BZaBQAUPL8/tfUNG4xPUyNURfAkHvbofiPDwMWkXQsK7XYDd9ujl/jBy0IP7gSsl6LKADKOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791552985; c=relaxed/simple;
	bh=NT3qx5vGtTcBOqmB6Oy3LSJ3xeFGYtKMsidrXboeJMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o4PJtD0+wd2MWeGCB14HnpQkB7/mIogHWLNkuzHyyDgoakOKZRIKq4/2JuxAcO+5Au+4iALEii6VJyokB8kmrm2OT4laZ7NgA2DWr8K9JWZhMKyfTd6ZgR+QlwbMpf+Cykz6yACJ9i+CdQoYl3eam2aZ3UYazuSLk0CajfwgATQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=aayushk.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=aayushk.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2e8662d5e95so199005ad.0
        for <linux-spi@vger.kernel.org>; Fri, 09 Oct 2026 06:36:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791552983; x=1792157783;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IrCjjh5RLBECWwL30aDBZqZ5pEoiJnI/InLjq95dlJo=;
        b=0Nxw1Ti49Ibk1356kyHQBfN9JWa1yWl5zFTaqb9aui08YSlQaPsdTZDa9CG/TdYVR9
         NtmjFSoE+AVob8hGUKrVDSPX3SXHqtttS/T9xtSMnFvE38nwdeW+mwR9g9qUzARFmLeJ
         KTgwHAHIuTsPFsmJ8rNTEVtHCAom9esQHbRnHhkDFsy/Db0UQ+ct108+4DBKrKHAbeWG
         7Y4hkiihbbtD3tCIayXdeWwA+mlRZJ9PFvEO6cspa8/HRWG03ZRqxAnIIQe1iCIEEZlZ
         ATQtt+lepxBq+Sm9wrPWWCHvyxeeWpK9o/NYIp33W79AG5110JFl40ouFqr7Xx7MFxs5
         S6Aw==
X-Gm-Message-State: AFq9FYJ7iDquYYQbIzJUaKDfBX/GkRxfBfJsSA2jariZaqclE68qZRk+
	UPjnJ60xuNz+YYYMZ1fAs+fr37JnZY3Ica2QJOo1j0IHbWUIqB5Gefcp
X-Gm-Gg: AYBFou07X/NEVvoWwls4T7E8/H1STWTCCJDki+WoatWK0vjWuwKEoRj31WNkiTmnTfv
	xhimnU+gTlC8z++CBtiMPVkPQvMKsTtK0uFdJPbyC70BtZG2i+jKd8bfFN7dr82vXP0LMJ+AKag
	GHfrwwnFzraXRVLUI9FWHQ0qeTEuu7zpBJ3fR2eNtd8V9mbllVCjNtS9ql56jYPjJC6AoLIANX4
	t8yUFIpEIliMqfMx+PjmQEG3GS+EObbYIz+JCWx0bt6dt7cp+B/u49a5WCIXI1QBHLlMyffIRe/
	fpaYX/eRwgrq3HMlPO75ShxL4J42RRxUmAt81URp+UbaFkyQCqyLYAiOlcLyS4brx6mH5KNzW/L
	Raw68Q8Vu3gjUQP26ub80biRtKGcpVkz1QVdyotvu/bnjdxzYZCUTUa5Ki6edKByAYakuBtdWzE
	t/SNa+GT4BCu8t0u60nzOcJbX23QZ1X9k35LbbVRyrtP4fdb7aaZH67CY9eoSZ
X-Received: by 2002:a17:903:40c5:b0:2e5:7b60:981c with SMTP id d9443c01a7336-2e842715c75mr17983665ad.0.1791552983044;
        Fri, 09 Oct 2026 06:36:23 -0700 (PDT)
Received: from linmach ([182.156.30.23])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e8484c1641sm7656985ad.15.2026.10.09.06.36.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 06:36:22 -0700 (PDT)
From: Aayush Kumar <code@aayushk.dev>
To: broonie@kernel.org
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aayush Kumar <code@aayushk.dev>
Subject: [PATCH 3/5] spi: tle62x0: Use kstrtoul() instead of simple_strtoul()
Date: Fri,  9 Oct 2026 19:06:07 +0530
Message-ID: <20261009133609.579046-4-code@aayushk.dev>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261009133609.579046-1-code@aayushk.dev>
References: <20261009133609.579046-1-code@aayushk.dev>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the recommended kstrtoul() instead of the deprecated
simple_strtoul(). Check the return value and reject invalid values.

Signed-off-by: Aayush Kumar <code@aayushk.dev>
---
 drivers/spi/spi-tle62x0.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-tle62x0.c b/drivers/spi/spi-tle62x0.c
index dd8bfb3f3..986d78ab4 100644
--- a/drivers/spi/spi-tle62x0.c
+++ b/drivers/spi/spi-tle62x0.c
@@ -151,10 +151,10 @@ static ssize_t tle62x0_gpio_store(struct device *dev,
 	struct tle62x0_state *st = dev_get_drvdata(dev);
 	int gpio_num = to_gpio_num(attr);
 	unsigned long val;
-	char *endp;
+	int ret;
 
-	val = simple_strtoul(buf, &endp, 0);
-	if (buf == endp)
+	ret = kstrtoul(buf, 0, &val);
+	if (ret)
 		return -EINVAL;
 
 	dev_dbg(dev, "setting gpio %d to %ld\n", gpio_num, val);
-- 
2.56.0

