Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9BD4E0216
	for <linux-spi@vger.kernel.org>; Fri,  9 Oct 2026 13:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791553006; cv=none; b=g+aG8P2Iknz4INaSLGRcp251JtTgNCLbfUjMZkqAQe9ym30/oycPfAKVWlJi+jDa6OO5xrQapgip6KtrC8lleVSpERK0rQ8vReXfNZB0MYNKH48MJLN36djJ7kNAft323KMc7K7Usred+B5IPgpUNZUqLpXokobvYBd5w8cgCSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791553006; c=relaxed/simple;
	bh=eY2CrKExfBVzr2gLJRsnKuiIPRNIod5nXcIPeWWekEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qkOHHkIxvK0E+H/DCBfbh53P0/rR3qb3A2jyKCo9Fguu7UAWJbgPIXvEXupFsuNWaYh/PS3a5VIcJr0C0mPsiyQ2t6eIwk45WzqWnVnShdCcPbjZerzIIs6/E63LD8PRPIlzSpoi/2GpivGdzVXLtOIFwkncj/X6OuTcR97p9YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=aayushk.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=aayushk.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2e812e2b31bso10724725ad.3
        for <linux-spi@vger.kernel.org>; Fri, 09 Oct 2026 06:36:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791553002; x=1792157802;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TfDTHpkHQvdcJwwHuBnkpdP8BzhFOOL5NGXiKFdpigM=;
        b=CrJlTdC8DcxojQz7razbaO7r4mibGkGBRjF1CwrQQ5iUoRCGxYknEUmvejVqHDUegG
         2AhOMmz+YBAIuxazVwoJ0U/9hwEQGPncMirLsPdZpJPViWG9u6HwLVKpPm/BqR1mOaxB
         dl02rum7dZoBu8Crh4ZMowRrLdMvGIGpwiQGrhiAErB7NlAwdiSI+ibKN1KFIUwQls2l
         E7ezpNDIglQvVkzTl4sGuiehQvO7KGTDFRYkarK8tRq3aG1t6cKg1bKTfmd2qXRkaPPq
         pAwlETVSvC2hWAZiLBe9p/B3mjzVWng53KySY2Ee7gdjVwePPquEClgwVXYikzSK8/fM
         xBxQ==
X-Forwarded-Encrypted: i=1; AKwUvByn7AH0qFDjza1omDUFaBW1I8r+n+arR4OEK1KUXtwhQ7xS0O83023uFezfrx3b7GGKBuaoIm1bbyI=@vger.kernel.org
X-Gm-Message-State: AFq9FYJr40chY9d3URLPBXuFW9RpOrQ9HRvtjLwfY0SSFiwV/fWeFnw4
	mBXGcuGhwtXEj97UVSHbuDZ30v6z/CLV1uTrxyV+ZdelXTip3uVi/LvX
X-Gm-Gg: AYBFou33Z0YhddM+HBx7vVPKwH21UILWysHoMx1OcdI9GZ5LznnTVjOiKc19RPlX+DR
	eBJONuGbVpDNMIw7BiEpLkn0CoBdjY7dU4IRT9QHADIRpIUdYrTvtkYsJgakvCAFZMJwcpjss+Z
	7TvjwRgdGrRll/BspuqiMQg9A0veWs1W5CyXjwx6qSlxUIDDCCRPoiY1HkILj52U1tIAllweEc0
	reNapc+q3lOcAv4u3rq5GclzJJVtgqV9YAmk/AdVEppiNl3NVUJNh/0JVeBtwuIvLfgJyl/M/Ku
	j/WWUeiNCGNO65Za/RS7oNdo1I3PhqNxbmYVOPOsmWHwsgJ+8CW3OwqwaPnF3H99Gh1qQ52t40y
	5emoPai/Za/4dhLVpiS3cDg/Qa5kqLLpFGyRuCprdJ7u0c8IVgRQvMFFYKkxZpPG77WatfRk+n/
	sttJ7yR5dn9dtz36N/1HRepBtMNBhBrZTT3sTPk4/QI1J9TvvAWSR6SUifBUw=
X-Received: by 2002:a17:902:fc84:b0:2df:8909:f72e with SMTP id d9443c01a7336-2e8427effecmr17322405ad.3.1791553002460;
        Fri, 09 Oct 2026 06:36:42 -0700 (PDT)
Received: from linmach ([182.156.30.23])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e841a05f70sm9260455ad.7.2026.10.09.06.36.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 06:36:42 -0700 (PDT)
From: Aayush Kumar <code@aayushk.dev>
To: broonie@kernel.org
Cc: william.zhang@broadcom.com,
	kursad.oney@broadcom.com,
	jonas.gorski@gmail.com,
	bcm-kernel-feedback-list@broadcom.com,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aayush Kumar <code@aayushk.dev>
Subject: [PATCH 1/2] spi: bcm63xx-hsspi: Use sysfs_emit() instead of sprintf()
Date: Fri,  9 Oct 2026 19:06:30 +0530
Message-ID: <20261009133631.579644-2-code@aayushk.dev>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261009133631.579644-1-code@aayushk.dev>
References: <20261009133631.579644-1-code@aayushk.dev>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

show() should only use sysfs_emit() or sysfs_emit_at() when formatting
the value to be returned to user space.

Signed-off-by: Aayush Kumar <code@aayushk.dev>
---
 drivers/spi/spi-bcm63xx-hsspi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-bcm63xx-hsspi.c b/drivers/spi/spi-bcm63xx-hsspi.c
index 25f169a2a..824e36bed 100644
--- a/drivers/spi/spi-bcm63xx-hsspi.c
+++ b/drivers/spi/spi-bcm63xx-hsspi.c
@@ -152,7 +152,7 @@ static ssize_t wait_mode_show(struct device *dev, struct device_attribute *attr,
 	struct spi_controller *ctrl = dev_get_drvdata(dev);
 	struct bcm63xx_hsspi *bs = spi_controller_get_devdata(ctrl);
 
-	return sprintf(buf, "%d\n", bs->wait_mode);
+	return sysfs_emit(buf, "%d\n", bs->wait_mode);
 }
 
 static ssize_t wait_mode_store(struct device *dev, struct device_attribute *attr,
@@ -188,7 +188,7 @@ static ssize_t xfer_mode_show(struct device *dev, struct device_attribute *attr,
 	struct spi_controller *ctrl = dev_get_drvdata(dev);
 	struct bcm63xx_hsspi *bs = spi_controller_get_devdata(ctrl);
 
-	return sprintf(buf, "%d\n", bs->xfer_mode);
+	return sysfs_emit(buf, "%d\n", bs->xfer_mode);
 }
 
 static ssize_t xfer_mode_store(struct device *dev, struct device_attribute *attr,
-- 
2.56.0

