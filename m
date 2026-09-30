Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E441951C067;
	Wed, 30 Sep 2026 18:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790792852; cv=none; b=B/OE59D13+ZSsChwNATysgh25RVJ4GAHx2DOnbrK6nawnB9PAbEHj7d66LOYcGdX1uFfd1hZdnWL5YMJkKHI778dBn0ZByWdz6/ePF44m4ZvhAuSTtHRC60V2LRo/oWi1I/X4Dg6xU6iRg/hLFgzujrVROd4unF+R47zzuvbaD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790792852; c=relaxed/simple;
	bh=WLjiOlD+dy9bJpuWvU5QCszfL7QR4gR3WwC3h0YTH7E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=VmLUt+rHKRuVWXYzyYrCP1EKPaDmA3OC6GM8bfRwSYd8CHOzeYTP+lk6aEYMmnINQ/ziNCD55vEBSLBfQldohYN8E51GWbwwyXFfcMnSuKsubA+9637sAdCACPrS4WrqN9vJkW5CJIWm6pU1qe6BsttzSPBGr0F85cUlN91L9hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sxa972NF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sxa972NF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A63F71F00898;
	Wed, 30 Sep 2026 18:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790792850;
	bh=mWBQYEdITnJ3bd7uXTE9n2wMp9LpxBphVpb1y8WkIyA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=Sxa972NFSAFlpJ9wrQwad0K7xg4KzEbVIPL5pfXMOZ5GHDl97MME/x0BMb0wES9vs
	 seY982E5hycZFkAi7aX0VBbjyyrMZtxoUXxYrKQXIvIIr1LPQSo5Tzfoxxe5KYFVaF
	 Oty8NAP9+5fkhrTUDrCJg8iUZZbHAI/iEZK/YsM/QdptWb5f7DnQCPUhEmfw6Oxyo0
	 GVvcurDA8eqpI0GRKtjHPvQlSHLIWGBakQSrT+AiUD2NyFvXx6GEfZqG5+nuEVs7kJ
	 5MV1EksPMyVmXAEJYRqnjkwWl7vyN0bRD0/fzWS3wAYyNqdszvvK4U78hW1Vr8dB9F
	 LmWkwZi59FySg==
From: Mark Brown <broonie@kernel.org>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 Yu-Chun Lin <eleanor.lin@realtek.com>
Cc: p.zabel@pengutronix.de, james.tai@realtek.com, cy.huang@realtek.com, 
 stanley_chang@realtek.com, jyanchou@realtek.com, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260930065945.88008-1-eleanor.lin@realtek.com>
References: <20260930065945.88008-1-eleanor.lin@realtek.com>
Subject: Re: [PATCH v5 0/2] spi: realtek: Add support for RTD1625 SPI NOR
 Flash Controller
Message-Id: <179078200215.116826.7101545069790986903.b4-ty@b4>
Date: Wed, 30 Sep 2026 16:26:42 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1375; i=broonie@kernel.org;
 h=from:subject:message-id; bh=WLjiOlD+dy9bJpuWvU5QCszfL7QR4gR3WwC3h0YTH7E=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqvVSOeQvRltv0WLoCl0l39BAsqEbjDVtK/eqnf
 Dnr2zmKHc2JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCar1UjgAKCRAk1otyXVSH
 0Ej+B/wNEBilThpqX2K/igElQEvjsU4gCVDkfWrgszuxpz0m6BwNVRxjUJTnhhM0ffMiU7NTuLG
 A/gCJZmwH3XLnv8/wYDoqDnULIMSv7xfPQu50K2WKmDLGaeefVZuCnwUJYqtUBTndsLsuUevkyr
 wrbfdvECUNBz1fZhjx1NF36+NYDdOhwarYCmiPf5k35y3w3GjK8RSLqbbXcjffHdazWHDshoFbS
 8FyeLwzS+zWfab9I/1KH6CIj/aVA83c3yJteOkAiW2wbqMB9VmCFLJD8Hxm48J5LNI8SSUM4IOH
 11MmHp9ehecSFkM/G36HH8MJfWrmDPMing0Sphg1tP1bEGLT
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Wed, 30 Sep 2026 14:59:43 +0800, Yu-Chun Lin wrote:
> spi: realtek: Add support for RTD1625 SPI NOR Flash Controller
> 
> Hi all,
> 
> This patch series introduces support for the Realtek RTD1625 SPI NOR Flash
> controller.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.4

Thanks!

[1/2] dt-bindings: spi: Add Realtek RTD1625 SPI NOR support
      https://git.kernel.org/broonie/spi/c/cf0f217a52d0
[2/2] spi: spi-mem: Add Realtek SPI NOR flash controller driver
      https://git.kernel.org/broonie/spi/c/aca8cbecdd2e

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

