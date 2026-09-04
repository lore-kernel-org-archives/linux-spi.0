Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C3E3B530A
	for <linux-spi@vger.kernel.org>; Fri,  4 Sep 2026 15:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788537100; cv=none; b=Z28L2K8DKxTP87JbaPRxk1bHF8LYqBFn3ce/p5t5EEC2M6VWxFtqtjvCq1/MBCMpUt+SfLvvtUqaqfqgXKbtT1gJOpYE2Yvf1+5+prHTtRoWNr5MRJq+sdgCCl7JJsfYqWK8No4+mVkDh4VkQVS7ZzSHWHweYXtQqS5USKynrQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788537100; c=relaxed/simple;
	bh=fC8E2y6Z5Q/OrCnge+02KY1tB0zJIUqzvl0v1HTFuJY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=O6vXLmYcGAU/pC4B2phcwZ/SKm5OwFLEoTUBW2sXv45UKCaSbJPkyvWdUie0baXC2+z5Zok/JWn2rmDFuHlQip17twwNRxJKpXAKDSeKVJE7XS0GMx0s9P5QZCCF7s9SvORgk+1ger7CX/9hJVUsueizqByjv0qhXOE4kh2RUrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dqiPsZdN; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dqiPsZdN"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-398e9698a70so996172a91.0
        for <linux-spi@vger.kernel.org>; Fri, 04 Sep 2026 08:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788537098; x=1789141898; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=1wI7K97Z7sffgIc6844mzrHNbwJsm2GeFEd77pMsddk=;
        b=dqiPsZdNo9wN9qhzSDWkPqqEshJaT0lw/MlfwA8xtLa1jF8/L1CQgItPLmf0d/bwJi
         5mOVx2dwCGGHC+6mdlKcFH1g1zTRZjM90h/oL30jfO5Zt8TLlUwsdiv6tMoq5lb2dUbO
         DHb3JCGvAv30t0CGMID2L3/kBI9ljzWN/ze7ndQDtHLj/OCbGpelxp0n1PHxjuXOqKny
         3H+to5LsKRS/Qkuf56feqcPTvDXR0KxGWFgRxyu18qM3JmGqJ2BOCDvU1vee0DNpJwcY
         X6N/HlvF+bv36et5VJtmglxPy1C2SkdQGOJGUISXY66RL1LhOoYTvecjfxO96yhkf4mY
         kNYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788537098; x=1789141898;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=1wI7K97Z7sffgIc6844mzrHNbwJsm2GeFEd77pMsddk=;
        b=UpYi/etHRbvH2lBa9xQMgVa6Hs56vaeK4EAIVoy5iU7HpkOYJS6CIrs8FFyxRFiJEn
         /fpTxuxBuEw59aNo3Q3sYPNZZnTByUhjpLCL8rnsXOu4lLXinwXTYdR/rdyC9g2lcJNl
         DswLTojPEwYhVF2Zx0Ue1X5KhjNwryErdqOha54jUpN8rh5fngEVhoLPHdaGZU6Sg7i+
         JLmBE5XzEsW8vWZS8RaQOIgIzsy8ATq8JmoJJCBP86oFfZiVEq1N0aCEBNNHZ9b3G14Z
         tIf17S9C0WTCCDlu0tsvrcy13eet+BBRMh4ucIs/VBwzFLUo0ylWCa1JbuE+kTu6Iejb
         71Mg==
X-Gm-Message-State: AFuF++k+IM/qO/NgQ2oyUnjc4nr8LCKKiGGORAh5w7acOeag+TYfAXSt
	8jmy4UTzWqM2RrX1yGxhGK4pFStaF1NF+NWI6oq6BNV0Pem+1h+E7biU
X-Gm-Gg: AYBFou1uj18/JCh7NnnkfWL9CrsBy3r0UL66f5x2b+Y8bxNjxWVMIF3fI3gl5cqTqbY
	nE/Aq9KJpwco+ZGistXagjzNTzLuzHPGksCCszSIWTVzkGvTVBfW4vwRtllKAbuuPIiud6/LybY
	QownyuXVxWINEejRKKvyXFQv1NEAFoZ3+64Kp7zD52jKe63GHuqUQvCTc/RIXpv29hcc9tPvfXX
	rutcLvncGkp/q2x9HFAOdeIA1oqNDNszrJf50erCTj9K5ZfQBDKT+zSl2Z038IwQdVTAr8keHrU
	aE0SfRaWlt9bOmtnfzPbDiVFGl1GL1Fhksj2dBgEjR1lNyugnxECeYi9HRb8GcFANlIvLDWYKYw
	Wgk2VExxirtJDsvpKjiRlaaJIZ1Eb63aWGPZc8oP5P3GjNFf11soVzrKEvy+HDmgDbuAlS7h4qd
	ERGZEArjy8q5iwHfbQNlh/IHCTfaR+dcdK5djEeIV6nv3BsH1bBam9TEMp1GYZSxA505Xi9Vs9E
	JKEV7z/KduiB7xbLwvxivDPqgFD/r0ZZbFWrrq4v+OOlBEVGVysY4cl
X-Received: by 2002:a17:90b:2749:b0:398:d292:e6d5 with SMTP id 98e67ed59e1d1-39b26304385mr11311044a91.24.1788537097799;
        Fri, 04 Sep 2026 08:51:37 -0700 (PDT)
Received: from junjungu-PC.localdomain ([223.166.246.74])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b083e4fafsm11390320a91.1.2026.09.04.08.51.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 08:51:37 -0700 (PDT)
From: Felix Gu <ustc.gu@gmail.com>
Date: Fri, 04 Sep 2026 23:51:29 +0800
Subject: [PATCH] spi: mtk-nor: fix runtime PM usage count leak in probe
 error path
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-mtk-nor-v1-1-cefdca098f83@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXM0QpAMBTG8VfRubY6pDVeRS6YMw4ZbSMl7264/
 NX/+y7w5Jg8VMkFjg72vNqILE1Aj60dSHAfDTnmEkssxBJmYVcnENGYUndKSQOx3hwZPr+nuvn
 t924iHd453PcDww0MN2sAAAA=
X-Change-ID: 20260904-mtk-nor-000ff9cb886f
To: Mark Brown <broonie@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Ikjoon Jang <ikjn@chromium.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Felix Gu <ustc.gu@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788537093; l=1008;
 i=ustc.gu@gmail.com; h=from:subject:message-id;
 bh=fC8E2y6Z5Q/OrCnge+02KY1tB0zJIUqzvl0v1HTFuJY=;
 b=Hjljg0NeZLG5gJIKscFNfsTfPBNzmXNZzZZdjt+VFCksVrkMrlsQ8WNQBjn0I6eayViNdBFXR
 nC28js6qxURAaeHZi6f0vbvRDNT3CXLfJnL8bkidZcn+YRJwCce1Rff
X-Developer-Key: i=ustc.gu@gmail.com; a=ed25519;
 pk=fjUXwmjchVN7Ja6KGP55IXOzFeCl9edaHoQIEUA+/hw=

mtk_nor_probe() takes a runtime PM reference with
pm_runtime_get_noresume() before registering the controller, but the
error path never drops it.

Balance the get with pm_runtime_put_noidle() in the error path.

Fixes: 3bfd9103c7af ("spi: spi-mtk-nor: Add power management support")
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
---
 drivers/spi/spi-mtk-nor.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-mtk-nor.c b/drivers/spi/spi-mtk-nor.c
index 63f5139176c8..6b6e55d68048 100644
--- a/drivers/spi/spi-mtk-nor.c
+++ b/drivers/spi/spi-mtk-nor.c
@@ -929,6 +929,7 @@ static int mtk_nor_probe(struct platform_device *pdev)
 	return 0;
 
 err_probe:
+	pm_runtime_put_noidle(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_set_suspended(&pdev->dev);
 	pm_runtime_dont_use_autosuspend(&pdev->dev);

---
base-commit: 9d80aa4617b32f5054c5aa471d06b66704854935
change-id: 20260904-mtk-nor-000ff9cb886f

Best regards,
--  
Felix Gu <ustc.gu@gmail.com>

