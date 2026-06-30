Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B60643C046;
	Wed,  1 Jul 2026 11:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782903780; cv=none; b=orNFrqhsa8yBVFaqFwcYzSi3dz521HHMZEAoQMn5IGmD+ndOkrihjpBlE8HhYqsRKjjEW1gfPkd/mVpNq08ScTdUf6abXoSSpXfrs2ryfl1eQdAAI9mYjNx1q9GKXEseDIb1MJQAMc52SjHFp9H1tpQScwCTyu0nDpvsCVlNgCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782903780; c=relaxed/simple;
	bh=KkcApZep57iNGVL+X0XwY2PQjTaRbF5nC0YxjIuHXfc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=gE5Bf7Ulzb9wY7V3q2qX9aNNVgVMgBL0PDVkcczm9rUIpibWkmr3saK502+PWpJhwYlwgdIeshtOcE6Ln1ZLDaezCq3YuAucUaqLlYJaKD/eTQ2bRZsrf/BWI8LmUMHvfWyBNowqEzkjYtxRayJPdGFpMD3otNW8yu4bXusyaU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eeArBZM+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eeArBZM+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AEBB1F000E9;
	Wed,  1 Jul 2026 11:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782903776;
	bh=2jIbI2Xbh4fWr1WBw/WIrOfSkCplB1YP1Da4WFSsGGo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=eeArBZM+6D8kbU2YNUxN7RSxQU4/sPAlmnggx1i4DOL8F9AhhZCuE/f6XKEQ6Lh6y
	 LNgsNWgtZNJ6GmUKsoLOfGFdpQXdIYqx0aq0MTZh3piGfBSHTNPL+LLh/kkK/NP4+X
	 QrmwIz0SnGBAPrWcd9fQHcFPwJ2meTHt9xMC6WFCPgLucfuRUY1blH0YjXPtlqYjRe
	 WEP8yiBC14HfXU6N1xOUQnvnDVVAlPT8fgUTH61+nyogUE+kRfC6fesqfy7/MlRU/e
	 e4+6OQITpHK1IeoUt7O7cPS0O8CcoQBHWSaVcC7FOvSdIVuyhihQmsZeKtNR5yqB/U
	 dioy+gixAh+oA==
From: Mark Brown <broonie@kernel.org>
To: Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
 Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>, 
 Felix Gu <ustc.gu@gmail.com>
Cc: linux-spi@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260627-rspi-v1-1-170c93ee14da@gmail.com>
References: <20260627-rspi-v1-1-170c93ee14da@gmail.com>
Subject: Re: [PATCH] spi: rzv2h-rspi: Fix DMA transfer error handling for
 signal interruption
Message-Id: <178284590924.368110.17887374079271436010.b4-ty@b4>
Date: Tue, 30 Jun 2026 19:58:29 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1154; i=broonie@kernel.org;
 h=from:subject:message-id; bh=KkcApZep57iNGVL+X0XwY2PQjTaRbF5nC0YxjIuHXfc=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqRPPeRptSvMtWMheRDmAl7qsOQlWcSLaUXW/j2
 zIvrbzftLGJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCakTz3gAKCRAk1otyXVSH
 0EnBB/99idlvFw5v792Ve3XQdQ9UEtWLoXl3iR0+vLxav8WBV3RVhNKDj9Gt2T/9dbTlIEnpvqK
 sOHGfqfKUYMPDn/B9oIpDsr1d3gaJMvgi/0ypltcZ/nhD5Add/AmDmStxdqjq5FfGrjyG6GLffb
 xGKLMpD0n0gDqU6hEQCKZPi42t4oC0tUykCum3ttru+Jyn1B56som1JSBAeTajexVcB3cCKPAGF
 L2Fi28tVMDJioliyduIch42rSqKGqHGJWSWH7uGqU7+99NZNpMwvM9q0TULRXHBiy1OOVVCxDGW
 C7t07ylnJQGZk9ei0yN4/NBVvsvPuTGjAJ5V/GwpitPs7Sns
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Sat, 27 Jun 2026 00:02:29 +0800, Felix Gu wrote:
> spi: rzv2h-rspi: Fix DMA transfer error handling for signal interruption

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.2

Thanks!

[1/1] spi: rzv2h-rspi: Fix DMA transfer error handling for signal interruption
      https://git.kernel.org/broonie/spi/c/7fc2c3dcae28

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

