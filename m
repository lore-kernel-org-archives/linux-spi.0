Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3433D5259;
	Tue, 21 Apr 2026 14:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776782380; cv=none; b=PTuRMDwFbj4O2B5g3p/chyvUeCczHaZfjyfOVNkrW9maAxuzaC5gC3UCXKCZRbfdAx7uroeESQE3+o+B+I7dgwte5UW5TqvbRlHYoE1KSOe53KmGf3igRmrYv9DrZ4VDMrHp4FrZknW2fqIL3WRQ40C5CKkaJynJqwPsCz1hplE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776782380; c=relaxed/simple;
	bh=fHWcE/+n7LqtpmgMfWsn150j5v8p3oOvZ78DZvaakpk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YK8r/KtwUZlni+15lOlJ2DfGlno2WW45+UEaavKUwR0lmarBtH2H5hFYVa9aDQDHxkEDiNnFE0uCuhOFvFNaCGd3NYBXeSuN8S/pkCn9J+HEEjvsRsjNha52P8VYjk2Zj4dfhlHGa2oo1+FkzrCYk/pX4UpTmajyO3b4B63M5qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kHAFGcJA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kHAFGcJA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F614C2BCB7;
	Tue, 21 Apr 2026 14:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776782380;
	bh=fHWcE/+n7LqtpmgMfWsn150j5v8p3oOvZ78DZvaakpk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kHAFGcJA6m6yhRE7MT1URPlhlPLyzrKY6mz5ds2NRSMha6dOVHPMD+SwmPKljZhBv
	 aPovLgUN3D4aDGLSjfH9Jf02JzcOU2R6tJLe/9Po++xJLH5nbq1TkvGkk1NzIC6ZMO
	 wV7+kjzCiTZSv3j6cXKglfiG3m4BZbhCpkM7L5mye5xGYtvD4rrcNj875wo9ck+xHm
	 Ycfh5Nu5oJkBmzAj31+MOZynw6PjQ5DbGW+JTo3sNjmVBn4G8eM7eolBZO7+5LkDkP
	 bSJvojvs8e8QIMrJBZgMmXEmEHwF76aQbO5qhmVdnE1viYRVQEUXZpUyPyT5002ch+
	 6J0a+bXJ2XiRA==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wFCGI-00000006VhK-1GkN;
	Tue, 21 Apr 2026 16:39:38 +0200
From: Johan Hovold <johan@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Vladimir Moravcevic <vmoravcevic@axiado.com>,
	Tzu-Hao Wei <twei@axiado.com>,
	Swark Yang <syang@axiado.com>,
	Prasad Bolisetty <pbolisetty@axiado.com>,
	Harshit Shah <hshah@axiado.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 3/3] spi: axiado: clean up probe return value
Date: Tue, 21 Apr 2026 16:39:25 +0200
Message-ID: <20260421143925.1551781-4-johan@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260421143925.1551781-1-johan@kernel.org>
References: <20260421143925.1551781-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drop the redundant initialisation and return explicit zero on successful
probe to make the code more readable.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/spi/spi-axiado.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-axiado.c b/drivers/spi/spi-axiado.c
index a347774ae824..9057a0a8df4a 100644
--- a/drivers/spi/spi-axiado.c
+++ b/drivers/spi/spi-axiado.c
@@ -751,9 +751,9 @@ static const struct spi_controller_mem_ops ax_spi_mem_ops = {
  */
 static int ax_spi_probe(struct platform_device *pdev)
 {
-	int ret = 0, irq;
 	struct spi_controller *ctlr;
 	struct ax_spi *xspi;
+	int ret, irq;
 	u32 num_cs;
 
 	ctlr = devm_spi_alloc_host(&pdev->dev, sizeof(*xspi));
@@ -852,7 +852,7 @@ static int ax_spi_probe(struct platform_device *pdev)
 
 	pm_runtime_put_autosuspend(&pdev->dev);
 
-	return ret;
+	return 0;
 
 err_disable_rpm:
 	pm_runtime_disable(&pdev->dev);
-- 
2.52.0

