Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92CC344D8E;
	Mon, 26 Jan 2026 17:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769449869; cv=none; b=b+fv1wef5/ruOsJbKE+S6zBDA7WSXLU0SQcAZrfyBZKjcvbKLnJZGc6l9CR8CWCSX2qqFK2qzcrZRPi7/R903JoLG5EBAwYtSzi7aeraS79TERoWXrSjOXfB4yn/0cmxua7Z9Fu6TuyhFDuB5HwIcBGnRQsqcAKVxz5Un1pZ6Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769449869; c=relaxed/simple;
	bh=gHLJrmPDfIMrCZ7kw5VCcPkBEMeaARyKAbFX4qvq2nY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DElEv9sDSl2b2Q8vr1DBP9UYCBTgVc05LEz3D42YfU0BQswQaj3MosYVeJLLqE7IrWa5sbdtysf5UhYwggNRXt+WB+Bo25meFy7+rx7KM4yz70jGqEM6TPqshcbfsNWAiwMAuqzFKflkSZkeaRcURK1ttlla64KFaYC4Ok2rXrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=ZogrBOyY; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="ZogrBOyY"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=6paBiB9nG7TuXtwzMfi3/5mMZxX24GhX3FrplJJ1QsU=; b=ZogrBOyYoOWbb4QHO+I93abfjx
	Oe53rpb2mQeoCcGPGIBsnXAyXdTFKiwWiVOuS+BNA8kFIq5XFD8B0s55lZ3+Q94mFBIbSs0iOeB05
	6tkQsCzbr0HMfoI98Dlt1wWlTqBLzFaDl/VFvX2wFJlCYZUglw6ggPftDiOrzlzmraZQgzH3C0Drj
	o/5x0Xe74xCrC6zN1O68DXUlmvOF28sKC+brIDiHNv2X0wtA19pibS2f0TaOzj3L/bGXsqVpCiu5s
	QrAeet2OWSUrTQX0x125PK//Cn0At+Q7SK1DGesNDcZRN0GvzU0eolZU5iDqhVw7w7UWOfQwZ5238
	+oppfV4Q==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1vkQju-00GLZu-Pl; Mon, 26 Jan 2026 17:51:03 +0000
From: Breno Leitao <leitao@debian.org>
Date: Mon, 26 Jan 2026 09:50:29 -0800
Subject: [PATCH v2 4/6] spi: tegra210-quad: Protect curr_xfer in
 tegra_qspi_combined_seq_xfer
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260126-tegra_xfer-v2-4-6d2115e4f387@debian.org>
References: <20260126-tegra_xfer-v2-0-6d2115e4f387@debian.org>
In-Reply-To: <20260126-tegra_xfer-v2-0-6d2115e4f387@debian.org>
To: Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Sowjanya Komatineni <skomatineni@nvidia.com>, 
 Laxman Dewangan <ldewangan@nvidia.com>, Mark Brown <broonie@kernel.org>, 
 Vishwaroop A <va@nvidia.com>
Cc: Thierry Reding <treding@nvidia.com>, linux-tegra@vger.kernel.org, 
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, kernel-team@meta.com, soto@nvidia.com
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=1797; i=leitao@debian.org;
 h=from:subject:message-id; bh=gHLJrmPDfIMrCZ7kw5VCcPkBEMeaARyKAbFX4qvq2nY=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpd6lvH9rLSC5n3s9QXsBxWNyZH0Gh8vScBp28D
 rtmUsVWfhmJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaXepbwAKCRA1o5Of/Hh3
 bXjeD/wI/RV7L2Sx3FodUFoTYp2vBFjLazvIpEVPmNMNj370Dtvyc8hpSQzbf2nC0JWaguvlIpO
 ecZ00Wr7ERQEw1YyJ3mpUjPA/VfOKBxk2M1SnypMq4sEmRQaO6yGk6CPuIz+HVUSgiGge0sdL9N
 jWPcVACYKV6Brk3yJglhjoElRn3PIz4u5F8ftwL1RnHv0tuQeMBM0NxWohWj4cfL+ygj9UXCOfV
 L2LSdJgFrn6tHz9TvarBY0swKUgrrOMN/GNG2eM/axJwINKM4kYCLZzU8gjxtuO7BD1j02cHW7n
 r+ARh04PASOHlAm9yHI+f55OfwmOFQPv5Sm/5aNhfjKGz9xbFSQBVfbvOYMvJXOl0T+nzrXfhqP
 AVOh76TwWXLhZZU4b9hr1rCNQnYpSb/B1rW/416twkYWv6mJj/VLnNg7Iido4F0b6RjKxEfXJGQ
 rgfO6nQv2Ms1Mk42x9Z1BQVN0Lc92t/nphZGEshsSvn920yEkZXTQcZ5M18+y4MJ1qzqighmwYh
 DdN+25MC7Qv/qlyKx3ADJbDrv80lsPbEghfTUnsifOznnenyZC7UvovF/0L1UTLJ3nqVp8MtyER
 5CTEm01ke1za+tzMRUaBejtfWvN0SDFTZgWoTRYc5djJAO8VROMFwthI3Dfmche6o8gEoO43384
 DdgV0pbUqusq5mw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

The curr_xfer field is read by the IRQ handler without holding the lock
to check if a transfer is in progress. When clearing curr_xfer in the
combined sequence transfer loop, protect it with the spinlock to prevent
a race with the interrupt handler.

Protect the curr_xfer clearing at the exit path of
tegra_qspi_combined_seq_xfer() with the spinlock to prevent a race
with the interrupt handler that reads this field.

Without this protection, the IRQ handler could read a partially updated
curr_xfer value, leading to NULL pointer dereference or use-after-free.

Fixes: b4e002d8a7ce ("spi: tegra210-quad: Fix timeout handling")
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/spi/spi-tegra210-quad.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-quad.c
index 15c110c00aca5..669e01d3f56a6 100644
--- a/drivers/spi/spi-tegra210-quad.c
+++ b/drivers/spi/spi-tegra210-quad.c
@@ -1161,6 +1161,7 @@ static int tegra_qspi_combined_seq_xfer(struct tegra_qspi *tqspi,
 	u32 address_value = 0;
 	u32 cmd_config = 0, addr_config = 0;
 	u8 cmd_value = 0, val = 0;
+	unsigned long flags;
 
 	/* Enable Combined sequence mode */
 	val = tegra_qspi_readl(tqspi, QSPI_GLOBAL_CONFIG);
@@ -1264,13 +1265,17 @@ static int tegra_qspi_combined_seq_xfer(struct tegra_qspi *tqspi,
 			tegra_qspi_transfer_end(spi);
 			spi_transfer_delay_exec(xfer);
 		}
+		spin_lock_irqsave(&tqspi->lock, flags);
 		tqspi->curr_xfer = NULL;
+		spin_unlock_irqrestore(&tqspi->lock, flags);
 		transfer_phase++;
 	}
 	ret = 0;
 
 exit:
+	spin_lock_irqsave(&tqspi->lock, flags);
 	tqspi->curr_xfer = NULL;
+	spin_unlock_irqrestore(&tqspi->lock, flags);
 	msg->status = ret;
 
 	return ret;

-- 
2.47.3

