Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D8A38944D;
	Mon,  9 Mar 2026 22:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773095833; cv=none; b=XMOf2H2/rAOyKj2v5a9YdIinJAugg80Nuj3OYebRk851PNbmmgyyXuXwhNwlCMG054YFQB9M4MY6QitgA9JSMEzFlPzj8kAchaA4n5SRmnCAHvNFONWp3t0/XYc2CpyT0daK0yeK5JPNL7JEsDoBFR9F0IJ4Teifb3ssuLIDpGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773095833; c=relaxed/simple;
	bh=6BnqkIlhVLViOxVryE2C/8Z+o2ZWDSXu/1ZvCYaDXaI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Kc6OBQZt0jGyh9pDAL2yiQB+j/2g65CEpmaKjVWB/aHGlvZKV66FJqpfPgh9tYQVS6tg88loEs8oTe+b2woR18RkiFb38crHPZNQK5UbZeIChBJ+4igfrcP4JCiOtUyMS/cReGkZYuNVQN1P8+fAHOS6se4/oTjL/dD0/LtHHcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tf3H4xez; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tf3H4xez"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC18EC4CEF7;
	Mon,  9 Mar 2026 22:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773095833;
	bh=6BnqkIlhVLViOxVryE2C/8Z+o2ZWDSXu/1ZvCYaDXaI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=tf3H4xezIDRsTefv5vg+Fi29V0HK0hXba7SX8Qjpff2LIMJyrIdAUlfUphLpz0vXt
	 VQpGFEczR5IAjz3w0nxB8MKfbmHs4/aNlNfd+DGOIIOp6l134w/5Rp2To/2e5JfMwX
	 jka3hl9HgNEm6orCxeH/SfP3w8jvX/m5fYle80bUygWWmiwJcRPR27vaKPH8K2+jSn
	 2iA8h2SwCIPEPEdAOWaWyB1A1B9vQ5bLuZBgaON2BkDvHjIYMQS0GC1DnqWefCyonN
	 /H0sDUjE5hGE9wW/AFoF2BHq5ToC8S60Ncuv3QlHZK5gJX2tIU+UUy0yH9Lc0MEaig
	 BwfzfclgNVaDg==
From: Mark Brown <broonie@kernel.org>
To: Heiko Stuebner <heiko@sntech.de>, Jon Lin <jon.lin@rock-chips.com>, 
 Felix Gu <ustc.gu@gmail.com>
Cc: linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260310-sfc-v2-1-67fab04b097f@gmail.com>
References: <20260310-sfc-v2-1-67fab04b097f@gmail.com>
Subject: Re: [PATCH v2] spi: rockchip-sfc: Fix double-free in remove()
 callback
Message-Id: <177309583151.321088.16829523155005247397.b4-ty@kernel.org>
Date: Mon, 09 Mar 2026 22:37:11 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-83dbb

On Tue, 10 Mar 2026 02:01:34 +0800, Felix Gu wrote:
> The driver uses devm_spi_register_controller() for registration, which
> automatically unregisters the controller via devm cleanup when the
> device is removed. The manual call to spi_unregister_controller() in
> the remove() callback can lead to a double-free.
> 
> And to make sure controller is unregistered before DMA buffer is
> unmapped, switch to use spi_register_controller() in probe().
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: rockchip-sfc: Fix double-free in remove() callback
      commit: 111e2863372c322e836e0c896f6dd9cf4ee08c71

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

