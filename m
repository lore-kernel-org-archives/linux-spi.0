Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F273C1FF7;
	Tue, 20 Jan 2026 12:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768910709; cv=none; b=se97R9sY8ALMRVhk6k30tcdz8kAZQi+e0mLPrq5CnI1IJiQchtC1uiHHDjfNScIENg1ZxZgbWUXXUCKkqB/kRADPm6//7debXp2dPu8jM3/SNOEDOu9J8iCBMOGMQCYxD+/flrTDoJ1ERcaBuU6NDc3V428t56EG8dHt5RgKWLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768910709; c=relaxed/simple;
	bh=tWKygxm4Rg1vI4GyJ9QRTEs3zlrz5NkZLCWCbQYismo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ltoYgCH53bO/Tp/wCidt+oRxDezcZOmlL8m94Q/2nOydk4KWF2KlfdEPae6lNNdDZu1sb5I6ufh+Zn/ZNS+bfEEPw/A8SAV4Q3A3Pejk99IcaaV9GohdDzi7R8GY4PVGKcE1GuBz0Q2xIgxie7CeJDXY05swAbZpOYj8JNETG2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=osSGWVFe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="osSGWVFe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FAADC16AAE;
	Tue, 20 Jan 2026 12:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768910708;
	bh=tWKygxm4Rg1vI4GyJ9QRTEs3zlrz5NkZLCWCbQYismo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=osSGWVFezwo+IxnhWRta1WDqC8SCElwyMbV7MwREOha4Jjs59JzbhjJQ4bMlQgecH
	 y6nf2Pt0g6hoN6cgp1O0QRofMMIkRjn1624PIHOsB9WxptlgOxrlTnq8jYYYLkAM4X
	 fzjo6WwRn+8AQV9dL2/a3NcjU+e2Y6hMtv9P3C46jl0qevTkmDfxKyCbUPy0zLh9YE
	 y70TFUP+gNf2b4oPvYSAm8pwGMECs6LsdzhZpb89BqGkQ+sfF4ecl0EOxSMhF9IOb/
	 xqwfunYWdt2fB9b/uEQkCBd/8uUayCfw8j6+eR6kRUPW8JwoFm4xwY0s9JBtlq+I67
	 aoFQO3iFp5vNQ==
From: Mark Brown <broonie@kernel.org>
To: Heiko Stuebner <heiko@sntech.de>, Mark Brown <broonie@kernel.org>
Cc: Aishwarya TCV <Aishwarya.TCV@arm.com>, linux-spi@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260116-spi-rockchip-threaded-irq-v1-1-c45c3a5a38b1@kernel.org>
References: <20260116-spi-rockchip-threaded-irq-v1-1-c45c3a5a38b1@kernel.org>
Subject: Re: [PATCH] spi: rockchip: Use plain request_irq()
Message-Id: <176891070705.53784.16388482856469002569.b4-ty@kernel.org>
Date: Tue, 20 Jan 2026 12:05:07 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-47773

On Fri, 16 Jan 2026 13:23:40 +0000, Mark Brown wrote:
> The Rockchip driver has since interrupt support was added used
> request_threaded_irq() but not actually supplied a threaded handler,
> handling everything in the primary handler.  This is equivalent to just
> using a plain request_irq(), and since aef30c8d569c (genirq: Warn about
> using IRQF_ONESHOT without a threaded handler) the current behaviour has
> triggered a WARN_ON().  Convert to use request_irq().
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: rockchip: Use plain request_irq()
      commit: 83ba6efa711fad83a0fbf02178ad64d3906d8d09

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

