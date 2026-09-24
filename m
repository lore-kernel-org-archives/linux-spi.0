Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17686352C34
	for <linux-spi@vger.kernel.org>; Thu, 24 Sep 2026 11:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790249027; cv=none; b=mf2yjS98BC5gUjMkY8h2J6tTqm7MZ5yf9tr6MD1654JzCvjRvGMI026zDDfzEYL1l5T81G/5sNZvYln/KZ75oyA/fid9/+Ti3cSEDaygo9n699YmJsEtZZR6eIomHACkBYSII7GUd69kM6gS31tC758Zq9fnlevLGpV8Cc649tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790249027; c=relaxed/simple;
	bh=O8kXc/a5cvIVXv5GHjV43+HIoDn4Fmq8JkV2l4Enp4M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Olw/b/fMETIOn2+IpLvgLS31lKwsHR4Ep/RiT4HtStfNAmnaGcQUL+ckKl8TE0/dBo6Xq/J/frIOwvZZMAcIXwCJAuGnw657IN3TkXRnYgqXMcGWgsjz1wELmQ0JNCLp4RiIRPgFLlF/f3VIm4oWdRJ1irlSw4Q4fVBQmppwzmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WpKmGBgR; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WpKmGBgR"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc1ceb47d53so431831a12.0
        for <linux-spi@vger.kernel.org>; Thu, 24 Sep 2026 04:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790249025; x=1790853825; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JCxRdNlieCfNGhjYZk26pUpqaG4f6xkrRSGT2nKsEsw=;
        b=WpKmGBgRPyXVvmAUPcgOE1TWZkngL5RaFLzV4Rk/ilP0MGUpLa/7HRsxD9FnF9BgnN
         /mHcSBGsbK8tjpJe8eybirYs8naf1wP5E3C9EWwZY513Vwxs1YdVWYusrhk8wI3RvEf/
         fTbHy4tBbXAvKsj20oEe4J6t8gAb9BscyAeP7NDuX1ZbtNQvt2NOBa/a5W8fDQlpMMGp
         fJT8NatOj4HJSnwXwnp4Zhb2Bsnec0KujlULdMEVghX08dL3ATtoznaK0AGS82u7C47W
         tU/mEA1t4+TldzZ6MrOTF+yFOADJfsIerpmhtTMZooPgVfNnmBZ3SbqBh8Xe64VcnjkI
         hIxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790249025; x=1790853825;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JCxRdNlieCfNGhjYZk26pUpqaG4f6xkrRSGT2nKsEsw=;
        b=iaBPobyhX1amQysu8oEjgDBiI7096vBYMoS4ho1cokYCSI+EULW6JAI89dYPVnxEST
         dvPXapJKIulstf3PmtFl4oZBgOl2WOl9NTLR8Qjbk7qxQEc+GfkBDkhi1qDA0GLBK0he
         VjgCnIg9fIr41D/GXFq+l5iWYB5DA/5REt39KQG7gGEaDjYNTSjSVLb85EAdvEwWOfag
         RBwB2mtLeKnn2cG/8ZaybyP7Dr2RyhYkUM/OCOMfAPscvEQJ+iK7Am6yjwLY7mIYsfyv
         x81Z8FI5BeKVXjHMubA1yp8DXfNymFrTATG5Hlvbfpyag45VK8JurjUTbFp8QaZvDRH5
         vARQ==
X-Gm-Message-State: AFuF++matOPuewPlR9jh2MOOLH2AWV28LJxV6dcwWKKdoq55IDYGYlIx
	7kLsw75KGknoSSt55gGu8t68bODfvHF4Ke/nCkoUD30/N5M4p4S1uUdh
X-Gm-Gg: AYBFou0g9194WVaWc9Ow1ULwY1wE123Na9mVkVVkncGGL5/10LvdlZwLu0p+YlnbOCj
	5eWRQyK9sXAbMwJF0U8M9Eu223IMElHmJUqQcPFjBcOW0eXNaxTtTnpW4hV3AIXXM9E51emVtc9
	YY4z40no5GH3gumLG0Pr7gr46DXnVIKHgxom8VOMLRpDrShteiQS8xC2hLIeS+WS0KdKHur3FKs
	2qMtaX/RjVGkAPM7mv+T6fCWeVYmf6KsdWqPLxwRqQ0kNmvXSLPsl0SJWFvr3rKLTg9l3TA7dl7
	vu8HUWpnrWq6j6LBE64BWS+4bO46AbDDxUMnOdDjwRXFxKdkpqLArREt2oDWy1iXF8VUYO8EfG0
	XwgrPAmFcLFmND6EZABRwWGO3H+GOrBj9+jm+oom7fMgNKnBSVl0n2ZMH1tQZeZGsB4WvlEghp0
	b8hfd/CEcqSzqrxowlOLk+WmRKHrBCU+rWr+l1YkMDNa9IH4vObrCTr/g=
X-Received: by 2002:a17:90b:38cc:b0:3a0:9564:2d3c with SMTP id 98e67ed59e1d1-3a09860e008mr1308139a91.8.1790249024756;
        Thu, 24 Sep 2026 04:23:44 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0813318c1sm3586800a91.4.2026.09.24.04.23.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 04:23:44 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: broonie@kernel.org,
	heiko@sntech.de,
	william.zhang@broadcom.com,
	kursad.oney@broadcom.com,
	jonas.gorski@gmail.com
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linusw@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	jon.lin@rock-chips.com,
	bcm-kernel-feedback-list@broadcom.com,
	noltari@gmail.com,
	lgs201920130244@gmail.com
Subject: [PATCH 1/3] spi: fsl: unmap immr_spi_cs on remove
Date: Thu, 24 Sep 2026 19:23:27 +0800
Message-ID: <20260924112329.1566051-2-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260924112329.1566051-1-lgs201920130244@gmail.com>
References: <20260924112329.1566051-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

of_fsl_spi_remove() does not unmap pinfo->immr_spi_cs after a
successful probe when CONFIG_FSL_SOC is enabled and fsl,spisel_boot
causes of_fsl_spi_probe() to map it with ioremap(). The probe error
path already performs the matching iounmap().

Retrieve pinfo from the platform data and call iounmap() when
pinfo->immr_spi_cs is present, pairing normal removal with the mapping
established by of_fsl_spi_probe().

Fixes: 0f0581b24bd0 ("spi: fsl: Convert to use CS GPIO descriptors")
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/spi/spi-fsl-spi.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/spi/spi-fsl-spi.c b/drivers/spi/spi-fsl-spi.c
index e45816ef7b65..665902703973 100644
--- a/drivers/spi/spi-fsl-spi.c
+++ b/drivers/spi/spi-fsl-spi.c
@@ -702,10 +702,18 @@ static void of_fsl_spi_remove(struct platform_device *ofdev)
 {
 	struct spi_controller *host = platform_get_drvdata(ofdev);
 	struct mpc8xxx_spi *mpc8xxx_spi = spi_controller_get_devdata(host);
+#if IS_ENABLED(CONFIG_FSL_SOC)
+	struct fsl_spi_platform_data *pdata = dev_get_platdata(&ofdev->dev);
+	struct mpc8xxx_spi_probe_info *pinfo = to_of_pinfo(pdata);
+#endif
 
 	spi_unregister_controller(host);
 
 	fsl_spi_cpm_free(mpc8xxx_spi);
+#if IS_ENABLED(CONFIG_FSL_SOC)
+	if (pinfo->immr_spi_cs)
+		iounmap(pinfo->immr_spi_cs);
+#endif
 }
 
 static struct platform_driver of_fsl_spi_driver = {
-- 
2.43.0

