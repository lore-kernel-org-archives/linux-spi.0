Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07FFF4DF4AC
	for <linux-spi@vger.kernel.org>; Fri,  9 Oct 2026 13:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791552278; cv=none; b=OI7Awmg6yc+WzssyQxEMg62qTmhEnJYRaZalF2BTDaNKAv6n1xdB29ZhhH5e/VMds9hrML6hZbJxr3XoVY1JcGmgnJkrmKs9bNWQc1O0aGcb0U6AxMTE0PUp6xCccFbKZl3Ipilvyp54v96kkjVjQOh54/eoFx9zwmA7Y+Mybjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791552278; c=relaxed/simple;
	bh=WbSQqnSb6lfEmKq3flLhSVPofVRAn/XOqGi36l4ja2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZrxmR1VceEoe3zBQLPfA2upCwkCJcFqaqn9oNiVciCOLu226ljwTy4LAfcOWtgU+fROPfFez0mdV0vArmar8LXKoPwj2n/0mzU3rGeEPiPyIgPHVltuOkM8aiVKRAzMGw8sk7oiBkR9YO8PnErz770qNbjNgwLaQCkE8L5ccP8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=aayushk.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=aayushk.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2dfa54c8ccfso10221925ad.0
        for <linux-spi@vger.kernel.org>; Fri, 09 Oct 2026 06:24:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791552275; x=1792157075;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gMJKAweeucpfGaBYlo2vZBKtZgQvSoidwZpt6NP6zwY=;
        b=LMeDzxKz6j6TTVexWSc4qTrjgdIkn8saUwVZ7j5Qif+btZBqCjaGr3eglmC7YX4sNQ
         8fbhqCcg3b11VGCCRJq7TM9iEN8bD9dinRJO6mYZ6hBiL9/TE3cXvXmQeNsFjjHv3iFf
         T7R3pgJ5apHpv3/U0wg9ZhpXRpKwaU1z+ycJ11flxqJmXOnKN491fKvm3/1hy4Z/45JO
         8Ea4UPKpQ/rM4Uh5zulgse7HwKQGfhkJV82HRyiF3uPWbYflmVzGC5tiu2Ef9rBn51Xm
         bNbGVKPXUHWi6sCsRrS+STUSv9yB7Okr55XxqQUWZIX9qABzspWblx9o3la0+LmZky2t
         vlQw==
X-Gm-Message-State: AFq9FYJ26+D/XtXEx8+IgFYdkcIOoyzWl5n+FBg4QQ5i9XTkdyfL06EW
	AjVH+yZJEgfP47qL79R7BqKzipmr+N1uqD6CUYls/pDabWTGt+62w04xXQJeoEOjfm0=
X-Gm-Gg: AYBFou3xtrkCI+m/mLp3C7V4XivRbxK9oKybiRnv50k6uL6BqJWueV3eiNyi78lBIG/
	jMRpTeqp18OAK3gfI1IuhnGOJvQpdTq41t31CADPpkWElFESNCDu3gu7FQ7kbLqyQi5gra+rT3c
	gBvVThYLrIKWCTZjlzMlaUfNJSXF41SWE6M9rYDPHc6VS14ZjwcFB2KnvErT8c+ZY8iOKuj2kSg
	V5kp2oRhQyj035etyW3k5kTxHbfWK9HCJ7hVtCscsoa+zMYgt0GoSGhF3uCJ6f1RQqEwKiHg4be
	uuOVxU4iHNXAl6g9IYyh4WN6B1uafOjez2CraWglVetSGB6PeqpjWNZmJzt+8uzz7wLme4I85u9
	9Kfq/7ipUf5E89E8DhTiRobzCxT7BDVLsUCKYN3iFNq747W5aOGzsFl2VRB3rIOxb3Id//44jl7
	Sz4Y/dHi++dwoEEjZBhQFZH8mCvFwmaod9sUl5i085JDMap8qeMVv8loLvue27zepjU5PWvA==
X-Received: by 2002:a17:902:e543:b0:2df:98a1:d0a7 with SMTP id d9443c01a7336-2e84053c728mr16407305ad.33.1791552275311;
        Fri, 09 Oct 2026 06:24:35 -0700 (PDT)
Received: from linmach ([182.156.30.23])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e8422e2570sm9327705ad.79.2026.10.09.06.24.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 06:24:35 -0700 (PDT)
From: Aayush Kumar <code@aayushk.dev>
To: broonie@kernel.org
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aayush Kumar <code@aayushk.dev>
Subject: [PATCH 1/2] spi: sh-hspi: Use devm_platform_ioremap_resource()
Date: Fri,  9 Oct 2026 18:54:20 +0530
Message-ID: <20261009132421.557758-2-code@aayushk.dev>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261009132421.557758-1-code@aayushk.dev>
References: <20261009132421.557758-1-code@aayushk.dev>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the devm_platform_ioremap_resource() helper instead of calling
platform_get_resource() and devm_ioremap() separately.

Signed-off-by: Aayush Kumar <code@aayushk.dev>
---
 drivers/spi/spi-sh-hspi.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/spi/spi-sh-hspi.c b/drivers/spi/spi-sh-hspi.c
index f840467cf..56df076b6 100644
--- a/drivers/spi/spi-sh-hspi.c
+++ b/drivers/spi/spi-sh-hspi.c
@@ -211,19 +211,11 @@ static int hspi_transfer_one_message(struct spi_controller *ctlr,
 
 static int hspi_probe(struct platform_device *pdev)
 {
-	struct resource *res;
 	struct spi_controller *ctlr;
 	struct hspi_priv *hspi;
 	struct clk *clk;
 	int ret;
 
-	/* get base addr */
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res) {
-		dev_err(&pdev->dev, "invalid resource\n");
-		return -EINVAL;
-	}
-
 	ctlr = devm_spi_alloc_host(&pdev->dev, sizeof(*hspi));
 	if (!ctlr)
 		return -ENOMEM;
@@ -241,10 +233,9 @@ static int hspi_probe(struct platform_device *pdev)
 	hspi->ctlr	= ctlr;
 	hspi->dev	= &pdev->dev;
 	hspi->clk	= clk;
-	hspi->addr	= devm_ioremap(hspi->dev,
-				       res->start, resource_size(res));
-	if (!hspi->addr) {
-		ret = -ENOMEM;
+	hspi->addr = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(hspi->addr)) {
+		ret = PTR_ERR(hspi->addr);
 		goto error1;
 	}
 
-- 
2.56.0

