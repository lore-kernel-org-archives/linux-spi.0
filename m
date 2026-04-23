Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA6F2E62B7;
	Thu, 23 Apr 2026 07:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776931157; cv=none; b=dxaSNwxo6ePWD0Czpgr2epwE5D6onkEnGoYoj78TAqIzFH2WWiocmTVsEYuOawfIojL3tiWwFJnzkaOPmiugYlxF3UsQLWX3oaHaO7d0GXHdZ2lFiXkqwvLJLsrmOq/zkMjDojrElQm3ZHKRHCBtOMOXv4tYyF2dcri8Urjyjpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776931157; c=relaxed/simple;
	bh=pU+9oiq4rMSeVi2EEG5CqIqdVDnOzieeiXQGjdvom8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WlkfcCoTWbOXaMAVSoyk3S+WS603z3DXBjNI5mvtAOV7KHrk3I6VrM7aiPzJqMezrbhgK0esQqFmkHv9lG1/GE/cOWvZNd9I5iV/j8isYna/HmJYLegmuC3/7rNDIpk3vR4oT3kb+zY1sg4GnennK1kliqqT2agH2HV6x14398M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gY6JEJqC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gY6JEJqC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76686C2BCAF;
	Thu, 23 Apr 2026 07:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776931157;
	bh=pU+9oiq4rMSeVi2EEG5CqIqdVDnOzieeiXQGjdvom8Y=;
	h=From:To:Cc:Subject:Date:From;
	b=gY6JEJqCe0DIHjHReLQTEdibmgnl8zL9hP2y92Qow8K5cobgpu7rMnUafFFMJweaX
	 3WAR6v5aMQHKYMFWhMjyZXXmaFnk4nPvP7v7F5mYYwUM3j+LtAQg5pOZhIviAo+LOz
	 eNiAyGKH596dG2pfDrvZDh8OwlJYxrDYaR95/nqV/1USbA52D1Wc1ynG9A9jZKtTKp
	 TWPSjkjpzaLVMthlWZiN1Cq6Wg4tA8UZhmwoFaTRz7D2S+EUKJCArAavG+IWA7lh2n
	 m9jH2r0E8oN0uXJ1SORJpZ434UpkcGM47bcSqHIA7dRz8KyeQOKaqlbp2V0qsR0RBO
	 I0pdIbY6qeKnw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wFoxu-00000009Rwz-3wAc;
	Thu, 23 Apr 2026 09:59:14 +0200
From: Johan Hovold <johan@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH] spi: mpc52xx: clean up interrupt handling
Date: Thu, 23 Apr 2026 09:58:01 +0200
Message-ID: <20260423075801.2252318-1-johan@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver is relying on the assumption that the invalid interrupt 0 can
be freed without any side effects, but that is not the case on
architectures like x86 where it would trigger a warning about freeing an
already free interrupt.

This should not cause any trouble on powerpc where this driver is used,
but make the code more portable (and obviously correct) by making sure
that the interrupts have been requested before freeing them.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/spi/spi-mpc52xx.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/spi-mpc52xx.c b/drivers/spi/spi-mpc52xx.c
index 924d820448fb..04c2270cd2cf 100644
--- a/drivers/spi/spi-mpc52xx.c
+++ b/drivers/spi/spi-mpc52xx.c
@@ -472,13 +472,15 @@ static int mpc52xx_spi_probe(struct platform_device *op)
 	if (ms->irq0 && ms->irq1) {
 		rc = request_irq(ms->irq0, mpc52xx_spi_irq, 0,
 				  "mpc5200-spi-modf", ms);
-		rc |= request_irq(ms->irq1, mpc52xx_spi_irq, 0,
-				  "mpc5200-spi-spif", ms);
-		if (rc) {
-			free_irq(ms->irq0, ms);
-			free_irq(ms->irq1, ms);
-			ms->irq0 = ms->irq1 = 0;
+		if (rc == 0) {
+			rc = request_irq(ms->irq1, mpc52xx_spi_irq, 0,
+					 "mpc5200-spi-spif", ms);
+			if (rc)
+				free_irq(ms->irq0, ms);
 		}
+
+		if (rc)
+			ms->irq0 = ms->irq1 = 0;
 	} else {
 		/* operate in polled mode */
 		ms->irq0 = ms->irq1 = 0;
@@ -498,8 +500,10 @@ static int mpc52xx_spi_probe(struct platform_device *op)
 
  err_register:
 	dev_err(&ms->host->dev, "initialization failed\n");
-	free_irq(ms->irq0, ms);
-	free_irq(ms->irq1, ms);
+	if (ms->irq0) {
+		free_irq(ms->irq0, ms);
+		free_irq(ms->irq1, ms);
+	}
 	cancel_work_sync(&ms->work);
  err_gpio:
 	while (i-- > 0)
@@ -522,8 +526,10 @@ static void mpc52xx_spi_remove(struct platform_device *op)
 
 	spi_unregister_controller(host);
 
-	free_irq(ms->irq0, ms);
-	free_irq(ms->irq1, ms);
+	if (ms->irq0) {
+		free_irq(ms->irq0, ms);
+		free_irq(ms->irq1, ms);
+	}
 
 	cancel_work_sync(&ms->work);
 
-- 
2.53.0

