Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481BF3E6392;
	Tue, 14 Apr 2026 13:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776174341; cv=none; b=kWX7EmS/qfT4Sbiv2uP6/8ZRbQySm2BJFTUdRzt19TrSxYejrUR5Ys9xOaCSdxYq/omgWVyetq3C4ssc+thbA5Xhco92sVM+mZhKv5NpdtFxfgf6NMWBwlrgKFRgIHReAOW1TuJiN4qngG4mub7UjaXdYZ3gkEMKsX/szntUfRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776174341; c=relaxed/simple;
	bh=mDyM0wqs7VKfbYheApuB/5tZxef1MmyGMgkj8Ul9x5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ukL9VpINRFkZgSQ97eWzaabYv8r0He3rVcja3uQzaqWzFM329V4K6ptucwdXotqVY7a6A4xyxOAv6UZDcTk1GkVi4O6IBpPRNODDttuOKIviyjxYs/CVrKoP1wF0Kdg7nZdAWzYV2Byi44MRXGhUMEo8BBHVHAM64zzE/wdxbQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fKDSXz0w; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fKDSXz0w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07337C2BCB0;
	Tue, 14 Apr 2026 13:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776174341;
	bh=mDyM0wqs7VKfbYheApuB/5tZxef1MmyGMgkj8Ul9x5s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fKDSXz0w7iaZks4PdhFyiEwXGjIf7uGLQ++kNFNGJrjRtrDgEm6umgZQcZWuNYs8e
	 PP/TdBiThqf51ff3FKw2L0LCaWaTiMxkm/Jp7B1Gv5GnKmxXK2xE3rMwVYdWoFW84A
	 O2Ph6kIGkFPuLkO3DWJMdYcZqRdW/MM/JxrBiH08bpPxrYnruPezqUynGxpAN4JFWs
	 nQYNReYdnQrnA/HNPMd9+/Jeu51bQEbOlm3ufYYq/+g9MEQdf5BQIvW1AQE3qlfqdQ
	 FRjvRuLXHSIwLKItO9C8qlgs29M18FfI4yAUnAyT8SjHr7zcWsDCYGZOIM4n1aiD9R
	 J8J6cYbzV6zPQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wCe5C-000000046Vy-32gg;
	Tue, 14 Apr 2026 15:45:38 +0200
From: Johan Hovold <johan@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org,
	Pei Xiao <xiaopei01@kylinos.cn>
Subject: [PATCH 4/8] spi: mpc52xx: fix use-after-free on unbind
Date: Tue, 14 Apr 2026 15:43:15 +0200
Message-ID: <20260414134319.978196-5-johan@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260414134319.978196-1-johan@kernel.org>
References: <20260414134319.978196-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The state machine work is scheduled by the interrupt handler and
therefore needs to be cancelled after disabling interrupts to avoid a
potential use-after-free.

Fixes: 984836621aad ("spi: mpc52xx: Add cancel_work_sync before module remove")
Cc: stable@vger.kernel.org
Cc: Pei Xiao <xiaopei01@kylinos.cn>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/spi/spi-mpc52xx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-mpc52xx.c b/drivers/spi/spi-mpc52xx.c
index 823b49f8ece2..c8c8e6bdf421 100644
--- a/drivers/spi/spi-mpc52xx.c
+++ b/drivers/spi/spi-mpc52xx.c
@@ -519,10 +519,11 @@ static void mpc52xx_spi_remove(struct platform_device *op)
 
 	spi_unregister_controller(host);
 
-	cancel_work_sync(&ms->work);
 	free_irq(ms->irq0, ms);
 	free_irq(ms->irq1, ms);
 
+	cancel_work_sync(&ms->work);
+
 	for (i = 0; i < ms->gpio_cs_count; i++)
 		gpiod_put(ms->gpio_cs[i]);
 
-- 
2.52.0

