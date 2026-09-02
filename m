Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987284A3F1C
	for <linux-spi@vger.kernel.org>; Wed,  2 Sep 2026 14:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788360497; cv=none; b=RGCpBJrG5wCFOeurPp4fEomNSYaRk6TdauIlo1MoViHmDZscQZRej9yuxCoestnm07vjmsvqhuSSVOm4QT/aW+BZnGLtpw84AW5EBL1rCFiS7tn8G8usrpeO5OSfjBPaa3IRDFWqvS+YUFxwJpSHTVzrty9qJy/3lp7kcVArjjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788360497; c=relaxed/simple;
	bh=KBvGyZndRFNH7A+aRyxm6OCUlXxf5CVdNPV3tEt7/zA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=H0kWnBTnBUBYVUQLfaqZkzN+L6DZztiFTsgwStT7Rxv2lnMQ0DYC4FURIvqqCuKrC03Aa7QEqNfYylfSJy5HKDvMWFGvJJNL813/op3tAhGKEbAAPu48xyogMolQO463brDp6Ru0/kQsSe9Io/W5iqrIg8aSD2eNFtSNtAQfsi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tk9/ioTh; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tk9/ioTh"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-85c9a79590aso1379523b3a.1
        for <linux-spi@vger.kernel.org>; Wed, 02 Sep 2026 07:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788360496; x=1788965296; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=igrO6BmbZGa/2QiOILMtmo7WB0Pb5Pir6y+0YnlM150=;
        b=Tk9/ioThzceOrw92g8VPJy72PUOwz+x57e+N7oQ0hFI5ms8enJEb8qSbIISDBGTE4M
         f8iVcN6gBHcEZ+HZlAae3HmG2bKPVilR++U/nfoot0qBJXSRscKKilaL6xZioP32609S
         GeBhDaaOCKA6SKbh562trFNBOQ9Ngdb1OTrkchCZYvvJjKTv3hm1A3hKRL2Q94jmy+5D
         D5+VAvOear71VKLoOOzkPR7FqGe6NQgggP5Scwn4qHdTFEMCWheUxCpDlSj7Yu7xjJ6x
         nU/rc4WzAtUpnNFeIUB6nhGZB9uJ9enIujumfH148UNNNoqlGypySwBIBzRLI2Xu4Fcb
         AIrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788360496; x=1788965296;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=igrO6BmbZGa/2QiOILMtmo7WB0Pb5Pir6y+0YnlM150=;
        b=hSD+RP1rqXj6i93jArZka0cIV4C//OkTJF0WLjHJZjOsxzMB/oQMSHO5CIM+nC4Q/E
         R+od9oAmiExKU4/uSq8Vj8Rl4RqV6r//hccKebkyHrIyX3QhVL9UOVylg5h7/Uup9w1w
         0MMrsvq8tjjigpZ9hl0ndlCBvLEM9idn/dEEai8h2nrbzfRIxMnFdyBpTGc6qogupslT
         3myfSdVZyqX5rQVPMcokwXdzxBSz3kpsQz76lx+8dsO6Qa6donAlYTDh2do4nnDmJbYA
         O/7Hs833+easas4M++7ZPwQFKNXMiie7QheJn5fOX/IftolTCyww43ROyrALEcppGkHd
         qLTw==
X-Gm-Message-State: AFuF++lPAWwlMeq5U6fz14gnSkzMfWqs5bDv7KZP62e0abx1xFph+GQJ
	ZSo0r7jCxtls/Ji268xa3ql/e7atNTVHSaonMWCL6mB4gOFXdjYQXCQJ
X-Gm-Gg: AR+sD13BLZ5N/earKi97MTyXv4utPFiuLolSE7O8FpZhJzWSGiAbbgXw5CzBXyR9aZJ
	QBzUc5ynI6EVLiRpUk3DLEQc/qV46r7wxJWIXK1wz2GwBQdOA0XD5Zrf416G3J8skR0vtOuxwTb
	i2EZWmLzdcHd41q1WDUIZjZW3WStuekXiNpQ8VzR3gKR8w9UdbFWDmWGo+QzojPiuza/ED3CCea
	QM6MoqvsUO08u2KFjZZU89fORX3OWEuFf7Pu+/EBhxmds4asQNaD8aDy4V7FBXONTrV4jo2Oirj
	qHf7g5fRWpwccvF/0zFyk70oeRUYCOD4udn39RaW5WYayIuVagPdz3cwtdsgHQBFJb4aRu/np9N
	9YDne/dS+VlFnETCVHEHpfh7WWTdNfyWs1GNNIAN367O7+FqLQncaMn0o7waHjU0AAtHjBTPxXp
	5XnOgqFHFwDuYXOcoBTLvkwVD2lOUpqqK5xVf2vae1chydCqhZz17QBBSUSieI7ekRjYKCfGydX
	DDhV1vp/YnpjVUHSVZ94nbpQe5fS3Xt2OxsSQS8yn1hKVM=
X-Received: by 2002:a05:6a20:d52b:b0:3d2:2011:d184 with SMTP id adf61e73a8af0-3d9afd1cf93mr9852517637.14.1788360495601;
        Wed, 02 Sep 2026 07:48:15 -0700 (PDT)
Received: from [127.0.0.1] ([2400:70e0:b000:0:be24:11ff:fe0b:281d])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc34cee275csm1169201a12.14.2026.09.02.07.48.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 07:48:15 -0700 (PDT)
From: Felix Gu <ustc.gu@gmail.com>
Date: Wed, 02 Sep 2026 22:48:09 +0800
Subject: [PATCH] spi: mxic: fix ps_clk leak in runtime resume
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-mxic-v1-1-76806325826d@gmail.com>
X-B4-Tracking: v=1; b=H4sIACg3mGoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDSwND3dyKzGRdg2SDRPO0pOREIyNDJaDSgqLUtMwKsDHRsRB+cWlSVmp
 yCUivUm0tAEaPaCNoAAAA
X-Change-ID: 20260901-mxic-0c0a7fbca221
To: Mark Brown <broonie@kernel.org>, 
 Boris Brezillon <bbrezillon@kernel.org>, 
 Mason Yang <masonccyang@mxic.com.tw>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Felix Gu <ustc.gu@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788360492; l=1048;
 i=ustc.gu@gmail.com; h=from:subject:message-id;
 bh=KBvGyZndRFNH7A+aRyxm6OCUlXxf5CVdNPV3tEt7/zA=;
 b=7szDc4NAg3wvG6W0sQN9j7/g27Sh9eKLAEhxAo1JXz1LxCXrzoEkK5pL8iCM7Z5IuSJOcTXHp
 8MODiqXnJK4C9OJiPfIZkpEXHuZlm9Qd1uTf4b+J/dUNcjd1PA9OTxG
X-Developer-Key: i=ustc.gu@gmail.com; a=ed25519;
 pk=fjUXwmjchVN7Ja6KGP55IXOzFeCl9edaHoQIEUA+/hw=

mxic_spi_runtime_resume() enables ps_clk before calling
mxic_spi_clk_enable(). If the latter fails, ps_clk was not
disabled.

Unwind ps_clk with clk_disable_unprepare() before returning
the error.

Fixes: b942d80b0a39 ("spi: Add MXIC controller driver")
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
---
 drivers/spi/spi-mxic.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-mxic.c b/drivers/spi/spi-mxic.c
index e3c85e5191e3..481edd4b35cb 100644
--- a/drivers/spi/spi-mxic.c
+++ b/drivers/spi/spi-mxic.c
@@ -744,7 +744,13 @@ static int mxic_spi_runtime_resume(struct device *dev)
 		return ret;
 	}
 
-	return mxic_spi_clk_enable(mxic);
+	ret = mxic_spi_clk_enable(mxic);
+	if (ret) {
+		clk_disable_unprepare(mxic->ps_clk);
+		return ret;
+	}
+
+	return 0;
 }
 
 static const struct dev_pm_ops mxic_spi_dev_pm_ops = {

---
base-commit: 89c07d98716a13454ec3fd9f97689e812cc71bd4
change-id: 20260901-mxic-0c0a7fbca221

Best regards,
--  
Felix Gu <ustc.gu@gmail.com>

