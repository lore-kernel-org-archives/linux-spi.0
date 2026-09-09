Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF345678DE;
	Wed,  9 Sep 2026 14:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788965806; cv=none; b=NGptOGJCxj9ICw/ZXadlOiNGtQ4YqX3j4r1x29E9F01EM1UflHVci0Mb54g37TtT6HyJ5JdncQFXNqEiPZsG9BIw7psGi4VrMlm312003Ot3+gSqcjO7/r9PsMyHE/g/mjb+QblXtWyKxMGFPw3k/pfytiUu8pcstXIO7Wmbudc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788965806; c=relaxed/simple;
	bh=s9t9vqFss4fnL6PsVZLuhqTrhB4WXEejgasTPMs2yxg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TFMsw0fRPqpL/T6wKKzLaDi93AbARyNMUFf1M8Gz5y+y/7qamZlijZmmW0RpygnquycGKtGQ+AWzYAHGJFaiFTpMxtWgDstlAJYZKM+fCJhFMYkcsXBBbr5TNA8h3Uu09fcay2GY98Ro2tHbG67rYFLJmjYqpsKkAIl+/pVxasc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A48RPVhL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A48RPVhL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99AFB1F00A3D;
	Wed,  9 Sep 2026 14:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788965805;
	bh=ov9JwG7dTxYqZs760mQ1kon32dW5uXkE9+e7+SDMk24=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=A48RPVhLJFNJg3sIYe01Vh1B3cg5oGnJdSMKmbPyiwLlr1P4FeqFFwpvdYpfdZy6A
	 8aSxNkA+R6aKfyxp7mspCCbjZw61AUNe3k/wlKuJCJ99InvzK+hwuUmRFojCBecgf5
	 VfiYCpOuxbIQm1u6Z2J3be7k7DDNayP2mic8eDTolTQkWNb3OTMLiUlox3x8McfjwD
	 qKWUQJI+l0FV0YQna6a0eYXnOgv6EW0huz/b+Ibr4rQKLQ/w0G8AiLpHU5qaaXtZhD
	 6kbh4ZscSGHnGxWjW4u6dyMnO5sKiWT2GK81JAs7n4jfw517WvjUkawPOgqnsVySRM
	 KkHF1l/U85Jsg==
From: Jisheng Zhang <jszhang@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/5] spi: dw: restore previous irq handling behavior when !ctlr->cur_msg
Date: Wed,  9 Sep 2026 22:36:51 +0800
Message-ID: <20260909143652.9234-5-jszhang@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260909143652.9234-1-jszhang@kernel.org>
References: <20260909143652.9234-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Recent "enhanced" support changes the dw_spi_irq() behavior a bit
when !!ctlr->cur_msg:

    if (!ctlr->cur_msg && dws->transfer_handler == dw_spi_transfer_handler) {
            dw_spi_mask_intr(dws, 0xff);
            return IRQ_HANDLED;
    }

But it misses the dma case, where the transfer_handler ==
dw_spi_dma_transfer_handler, so this changes the previous long time
working behavior, let's restore the previous handling by only filtering
out the dw_spi_enh_handler.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 drivers/spi/spi-dw-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index 91de357f97f3..da7d4872e513 100644
--- a/drivers/spi/spi-dw-core.c
+++ b/drivers/spi/spi-dw-core.c
@@ -280,7 +280,7 @@ static irqreturn_t dw_spi_irq(int irq, void *dev_id)
 	if (!irq_status)
 		return IRQ_NONE;
 
-	if (!ctlr->cur_msg && dws->transfer_handler == dw_spi_transfer_handler) {
+	if (!ctlr->cur_msg && dws->transfer_handler != dw_spi_enh_handler) {
 		dw_spi_mask_intr(dws, 0xff);
 		return IRQ_HANDLED;
 	}
-- 
2.53.0

