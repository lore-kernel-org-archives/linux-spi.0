Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03C4328B69;
	Tue, 20 Jan 2026 17:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768931908; cv=none; b=MR741rA21oJtwxqtipjJa+wljUy/wds+34gZYZV5PooDkuEGRw99cF0gyAYQ0o9VjirSheBmvW8Eeb41sdo9RSMNl2j0eYoeJXAWseVPV4ibfleH5oN0xOvXuL+zKNXLm4AmvRapxb52Jy59hXuk+9Fj5+GPE3N+Rd+fmvAUPPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768931908; c=relaxed/simple;
	bh=Nk9VnswpvEWj76/iU42LuuRakmT+FfshH+6D9vCd9hQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=QZLnVWMynlcq5KT5CirSmilhkhyj5hj2Wf85yk+oetIId+wxsjijj6xvyDtBMQOunlRPRoTtfftbF5f9MN8duVS0DP43SUV1IvuY9T+NHX+m5EN20GnGynQ4SgfpW7E2ob/WnNYw3rlJ5oxZyyW8LdPukdl21YO8K3oAjyJdDHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fKHzqjAI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fKHzqjAI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4C62C19425;
	Tue, 20 Jan 2026 17:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768931907;
	bh=Nk9VnswpvEWj76/iU42LuuRakmT+FfshH+6D9vCd9hQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=fKHzqjAIwjHA7/QZSWBOqz8oUkMNNdeeYWJe7XhItW3eP0AfaR0pQXMsf82N1KrBx
	 CebD3npCjUru2KLNlzU7eKqOvlD0QXZwWzeLuZnuE41Co5vG4bLBL+dECSzpPQV+J0
	 ZC/1AcxnuphKob8FTzr3LpZlmwY0kLBnhFVasD8vm8qX4WKczYPGvvZmbSBUaqfkgF
	 v4O/WHZAvRQrk1JnuL94/rxbxRmNXiMi78hLHRzd6KZIGx9OksQxoRPYo7HAcRy9mm
	 rISMvSAzZT6IKOxxPXmFM1p9bLkMdoptgekLqpCgNKJn5A2d9/gnjMAIDjGE3sYKZ2
	 94ZfTz5q41BlQ==
From: Mark Brown <broonie@kernel.org>
To: Han Xu <han.xu@nxp.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Haibo Chen <haibo.chen@nxp.com>
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260114-xspi-imx952-v1-0-acc60a5a2a9d@nxp.com>
References: <20260114-xspi-imx952-v1-0-acc60a5a2a9d@nxp.com>
Subject: Re: (subset) [PATCH 0/3] Add MT35XU01G SPI NOR flash on
 i.MX952-EVK board
Message-Id: <176893190467.701694.2959767523548654547.b4-ty@kernel.org>
Date: Tue, 20 Jan 2026 17:58:24 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-47773

On Wed, 14 Jan 2026 14:49:44 +0800, Haibo Chen wrote:
> on i.MX952 EVK board, there is MT35XU01G SPI NOR, i.MX952 control
> this nor device through XSPI controller.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/3] spi: dt-bindings: nxp,imx94-xspi: add nxp,imx952-xspi
      commit: 3495a5df94a9ad7a8940bcb3ebfda58255f5b952

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

