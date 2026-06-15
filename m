Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1955C30594E;
	Mon, 15 Jun 2026 04:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781499599; cv=none; b=AS0yhuRlUyP0Q3UgtEz+trOOsEeYUAe6cA6/rpNL0tni/Gzd5pUk7nSwYVhKbPqoZ3IzvtEsvFNbX7D1MWJa1zcb7Cp2sD5SGBeaVSZTqBktL/0yoa2B0GQPEQlkiQW6Mc9zk7fRpWb6HmR3Lxd7h6XEj7YL4kdKWZbXL92fsSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781499599; c=relaxed/simple;
	bh=eyHNvc/fDUOypS3rrgzOejfFcQNpOZmYhip+lrZ/DZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DUC0aGrpy7hCo5A8RAlGJ7XSaoGDittR13r8eLAEx8yLai8ASrDAEeMIVrIgMxtb/EuevjnT02+z7jwC7i1KuNiNO5LzIBsu0y3Ox6XC1h+D/No8LVJOoHrqNVq90LhNaY6i7ksmU8TOKTh3eX9MHDZqdxFfwvwwcJjMa5VoGgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z+ucjEmb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z+ucjEmb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECAF11F000E9;
	Mon, 15 Jun 2026 04:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781499597;
	bh=sQ/OtNCDIIoFO520g7afcB0c/EjZPMRBQW3NpXLYEsM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Z+ucjEmbCk12mcT6i7a/d21AHxznWYcqWBQF4Wjic82bbFv8852QiT/iWRlGTgrAr
	 Lp4Ex6Inrj/D7b24G/NSKP0s+p3vASPeSNI/G0jvGpF6UheJvfK6jlOf8uy4ovIzaD
	 JwPhynyzuE2KoCjdmBA4puQelwN7KPJWGQiQxb+1Plq50q/4ApJbLcEwNC2r6LfREq
	 ZsZFoQKg1dKPibtBMQN1LD2g74/hfJGCgEb9Tb1vYMmHKyQzgaa2LiwofmZ6xyXPse
	 2s3tQFKLc1xbCACHY8Aalpa6ifoPuwV99ZIzVn/Gx+5pFivr5PioqzcLXFcxT5SL9V
	 Sum2yikgOedSA==
From: Jisheng Zhang <jszhang@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] spi: dw: use the correct error msg if request_irq() fails
Date: Mon, 15 Jun 2026 12:40:36 +0800
Message-ID: <20260615044039.9750-3-jszhang@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260615044039.9750-1-jszhang@kernel.org>
References: <20260615044039.9750-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If request_irq() fails, report "can not request IRQ" rather than "can
not get IRQ" which may be misread as platform_get_irq() failure.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 drivers/spi/spi-dw-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index b47637888c5c..02e0b4b66a5b 100644
--- a/drivers/spi/spi-dw-core.c
+++ b/drivers/spi/spi-dw-core.c
@@ -947,7 +947,7 @@ int dw_spi_add_controller(struct device *dev, struct dw_spi *dws)
 	ret = request_irq(dws->irq, dw_spi_irq, IRQF_SHARED, dev_name(dev),
 			  ctlr);
 	if (ret < 0 && ret != -ENOTCONN) {
-		dev_err(dev, "can not get IRQ\n");
+		dev_err(dev, "can not request IRQ\n");
 		goto err_free_ctlr;
 	}
 
-- 
2.53.0

