Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8A04E236B
	for <linux-spi@vger.kernel.org>; Fri,  9 Oct 2026 13:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791552981; cv=none; b=oTMKHwKoHhZtxAJuW+uP+vtwjsPmkjK4SomWdwFbF3rKpBVp3qN2S9NIS8ImnGVGbV30rbLgZTy5fGy1q1Sd9GpCYQYTB61jsGGY5eWNstrtuf6unYfDTeGXRzsi1Mx84aXy/a6y7Lsg1BYg5HUEBBwHR3iJUg//TRhVNpQpXj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791552981; c=relaxed/simple;
	bh=yscaSuQX7vQbTKa5pF3g8bzBr8g6/JaNcPuIEZ7nE+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=guSic9Npbc7ZbUq/se5NPQ3fL62RQgqZMm9FTZBonerzPTsPkRnqafaHYsw3uv5tMTFvC4Kfstc47IOY+h8XJHQTlp5+aC0YXXUFZ5K7yGMHasg+RGr0b1VxF5j/MAlp8G619UcP+KG67jD2JgUXuMAQSx+PZwiSwWxpGBEs0LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=aayushk.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=aayushk.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2e812e2b31bso10720155ad.3
        for <linux-spi@vger.kernel.org>; Fri, 09 Oct 2026 06:36:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791552978; x=1792157778;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xdmLeBaeUGBjvsy2RLz1gC8MpSCDdRWZzQOsdvN3xy8=;
        b=hJQzkqrkINrXi3O/kwssE9GloQeCH4On7hIpM3fyKZ2KbWFfdfwOq/ru72540zgC4v
         npXpvrkGnq0iQ4s/so+KT911T5qf/b5f1z4gZPmwlp454JlQ30iy1XxlK53pLXFcyBfa
         XkfdXvP3lhv8vEdjN2LbhtxxN+YuVLltelDUDLBfWOUMnbxrpr+moNwWs232wGqP8nTl
         dbTsHUgoBL5dldBtssWutuLvNMa2FPUGF/0J+KlnOX8RjEdjY2RW5E2tHbo9RHsFBQZF
         4aqcZpKYE8yX9HkMtX/9FRjlcFEkJZYq0FIwJD0iTk2Hgi1W7i6QW6L4ZqOJsK13crp5
         Xq4A==
X-Gm-Message-State: AFq9FYKdo+d3MG5PkgGf153239gyLoJmzskVG1vcI32XQ/WfB1Hy5pGa
	xyA17rGHo2UD+bYKtRKFwWDzC2QsX1XIr5n8DHBHmM8JvHH82UO+I75M
X-Gm-Gg: AYBFou1iAd540WaDgpVefo1N9J23spRY7loTtfJaQ1lUGWmhyssnQyoAbFao53NycEA
	++NxzW7hrY5zcI6NbqoTFjU0b+51xIrP44a5EznQkeSEAKZKfKCI5Of4d9CC0jtuAvFwYGvieej
	C/Uzgcmc6aVI0XEKeXHYrbC8CoVttADdc19Pt0RtS2xNCGbvoopW0wJpuRw5EDLsgOxPCxAI3NZ
	QCs67F2CVCA3pUChp/XEytur2xC9xznLhsaERngPxzw5wwlxORTiKx89zOofQYgnVsdPgx8CE72
	4wm6F+pZUa85SHKcjgryVFDKowZBDV45JoJZAkywjyQKYXbSOIco/dFPItczi8zT6UNcu+3jqM1
	24/0iohLvCI/nDqj+QuBjQC0l1Ze20gnEBGdS1iYd1xwFtnKtTcxXw5eYoby/c7b8KcTLfKP+TD
	zLjC304DNxinb1NHq/TVedldg03qalMG0G+0MvhXcn3vlUcyWL0Aih3iiWZ3z4
X-Received: by 2002:a17:902:c946:b0:2e7:e73e:7091 with SMTP id d9443c01a7336-2e842bc6d99mr18201305ad.31.1791552978397;
        Fri, 09 Oct 2026 06:36:18 -0700 (PDT)
Received: from linmach ([182.156.30.23])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e8484c1641sm7656985ad.15.2026.10.09.06.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 06:36:18 -0700 (PDT)
From: Aayush Kumar <code@aayushk.dev>
To: broonie@kernel.org
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aayush Kumar <code@aayushk.dev>
Subject: [PATCH 1/5] spi: butterfly: Use strscpy() instead of strcpy()
Date: Fri,  9 Oct 2026 19:06:05 +0530
Message-ID: <20261009133609.579046-2-code@aayushk.dev>
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

Use a safer function strscpy() instead of strcpy() for copying to
arrays. Only idiomatic code replacement, and no functional changes.

Signed-off-by: Aayush Kumar <code@aayushk.dev>
---
 drivers/spi/spi-butterfly.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-butterfly.c b/drivers/spi/spi-butterfly.c
index 84eb454ed..5e1e205bb 100644
--- a/drivers/spi/spi-butterfly.c
+++ b/drivers/spi/spi-butterfly.c
@@ -259,7 +259,8 @@ static void butterfly_attach(struct parport *p)
 	 */
 
 	pp->info[0].max_speed_hz = 15 * 1000 * 1000;
-	strcpy(pp->info[0].modalias, "mtd_dataflash");
+	strscpy(pp->info[0].modalias, "mtd_dataflash",
+		sizeof(pp->info[0].modalias));
 	pp->info[0].platform_data = &flash;
 	pp->info[0].chip_select = 1;
 	pp->info[0].controller_data = pp;
-- 
2.56.0

