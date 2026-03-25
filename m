Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55863BC670;
	Wed, 25 Mar 2026 14:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774450414; cv=none; b=XgeR0DDKWuVp2egOlQ+P1IH8GoD6p0i3MJF6zGxJNn3ydyedwtE9R3Bk+Qk56HMkNO1D0oO7MlmCVO9qN2/AO9p73TkmbA1S3j9oXqYzXhtnzOjx+SRlczgomUyuIgCwO5HbjEkummqOdx/V15ToWqvOC6sr7ohUXKBlGFfPIWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774450414; c=relaxed/simple;
	bh=aeIUHCs+I1FvnACDtVOzqzmisSohDwE6rwC/ECyDq7M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tFRoqar24JIac+gpFu4stn7b5HnmRGNAXy4gjucV2LhnRhBF1lR/Pnp/XLruRHAzOz90Sn/+WBIGOZ/TlW3jfGGaopeAomH6tLhsol9DFaZX1FEVudIMgvf2PTRoL9YMqQ+SMZKJXrLmoMFVuVKmp8ymfVWoRWFZviNeMngLRco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nHyTQe5X; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nHyTQe5X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97959C19423;
	Wed, 25 Mar 2026 14:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774450414;
	bh=aeIUHCs+I1FvnACDtVOzqzmisSohDwE6rwC/ECyDq7M=;
	h=From:To:Cc:Subject:Date:From;
	b=nHyTQe5Xe05pFbs40LbnXiFy29cTzb7vEdlrdJVGU+0EeKxHXTJUjDYfkKrdLF53e
	 qO9LMQCf1/Lyl4wyZuXHSveSvEo37LbS813oEFrmzJxPgqHIF/0w2KARJkereMvGRs
	 SmgB3h3qrV2Mw0fv5b008HO5UyylLRIl39h50J/x3VZ43ubNpXu6WYw986f4zfCN53
	 rXSFJuIzkDtVLTRRfNVyOvd0qBzOoiHYnk1qHwKT4y+7tvspRmwmJb6iyv2mgu3FOT
	 CezZVXzMQetiggi/D3i4cTA96Mq1xHzTgVuF+lr3d2CMBoC4W0BIJ4/5hV5ofkmC5+
	 ox3oWphzCNf6A==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1w5Pbw-00000004kVY-15YF;
	Wed, 25 Mar 2026 15:53:32 +0100
From: Johan Hovold <johan@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	Felix Gu <ustc.gu@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH] spi: fix use-after-free on managed registration failure
Date: Wed, 25 Mar 2026 15:53:19 +0100
Message-ID: <20260325145319.1132072-1-johan@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SPI API is asymmetric and the controller is freed as part of
deregistration (unless it has been allocated using
devm_spi_alloc_host/target()).

A recent change converting the managed registration function to use
devm_add_action_or_reset() inadvertently introduced a (mostly
theoretical) regression where a non-devres managed controller could be
freed as part of failed registration. This in turn would lead to
use-after-free in controller driver error paths.

Fix this by taking another reference before calling
devm_add_action_or_reset() and not releasing it on errors for
non-devres allocated controllers.

An alternative would be a partial revert of the offending commit, but
it is better to handle this explicitly until the API has been fixed
(e.g. see 5e844cc37a5c ("spi: Introduce device-managed SPI controller
allocation")).

Fixes: b6376dbed8e1 ("spi: Simplify devm_spi_*_controller()")
Reported-by: Felix Gu <ustc.gu@gmail.com>
Link: https://lore.kernel.org/all/20260324145548.139952-1-ustc.gu@gmail.com/
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/spi/spi.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index cb00619864cf..aac378e668a8 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -3537,8 +3537,19 @@ int devm_spi_register_controller(struct device *dev,
 	if (ret)
 		return ret;
 
-	return devm_add_action_or_reset(dev, devm_spi_unregister_controller, ctlr);
+	/*
+	 * Prevent controller from being freed by spi_unregister_controller()
+	 * if devm_add_action_or_reset() fails for a non-devres allocated
+	 * controller.
+	 */
+	spi_controller_get(ctlr);
+
+	ret = devm_add_action_or_reset(dev, devm_spi_unregister_controller, ctlr);
 
+	if (ret == 0 || ctlr->devm_allocated)
+		spi_controller_put(ctlr);
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(devm_spi_register_controller);
 
-- 
2.52.0

