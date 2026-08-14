Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09BFD46AA66;
	Fri, 14 Aug 2026 17:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786727965; cv=none; b=OpYizwVS3Hd4Q9wHxldJnRSZeZqYcnIq5m1krArcExQK4GiUcFR3dJVZ3BsuHXJ0JDgkAbB+1+hh+pOqzX6V0YbL/Y9Bho+Wy4+HzvKhMPaFD6gs70jivP8bkWfhCiMk9fdnR7buxM3ESUrT6k76vJacCIF95IuIKtO37nVGlSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786727965; c=relaxed/simple;
	bh=bNQQkYakACPfetut/Hrnd5fReIktWvuG7g8ZN9UEy0E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ENFawbc0yQOt1ASGNUT5ZPcaAlqMEkN9dQxPnkZp/Tb9xZgPaHl/Aimz2aYzXospHCqoelEYiO3P1/eSFylmrjBP7fmc/pc6yMPBBARKD0yBCrFzGYrAKF45u2LvbT3sfY+002FVa52X02AcE/aQDFoU+uh7m9vi/am4dPCEKgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C2nLD+Hx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C2nLD+Hx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 431451F000E9;
	Fri, 14 Aug 2026 17:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786727963;
	bh=KSYx9ZZUYMAPeym+Mt5kiHPv2+BGUb/x9Q5bfeD9cUE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=C2nLD+Hx0UoK86yumknAXU4BZ9ECT/oifGe3aNgkCw5FxuXt5MzhiXTQFwFOdmzU2
	 i5vC/0NOFw/d9ITN2r7p60FZR9XqDesqDdo3BLJHSIl1MJ/4gRq5Qnez7gdCyZQ538
	 2tpqv1up1ne9ohDfq8m9pXp5aNcIqptN3euzpvFhMxtVByd9OXvYLFItw6wCtUCyNB
	 RPb5jPZW549TDvGL+WoQ+IAUW2KMD5HxFKz0IrHQUK033ZhMWpdyD8dNHEWhApyc94
	 1Bjs78VZ410BVyVYp4Bo7Q+EPnLEBYq9OCb6SZXyZOE1YHqFfedgE0cTtfvdBUs794
	 VxFatYe9xc/Mw==
From: Mark Brown <broonie@kernel.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Maxime Ripard <mripard@kernel.org>, 
 Jerome Brunet <jbrunet@baylibre.com>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260812-allwinner-a733-spi-support-v2-1-937bff0fa78e@baylibre.com>
References: <20260812-allwinner-a733-spi-support-v2-1-937bff0fa78e@baylibre.com>
Subject: Re: [PATCH v2] spi: dt-bindings: sun6i: Add compatibles for A733's
 SPI controllers
Message-Id: <178671194118.152149.7100117207191275264.b4-ty@b4>
Date: Fri, 14 Aug 2026 13:52:21 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1149; i=broonie@kernel.org;
 h=from:subject:message-id; bh=bNQQkYakACPfetut/Hrnd5fReIktWvuG7g8ZN9UEy0E=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqf04WV38MYa+TjkgnEVdm4OLNbjANLf1XeaHY/
 rqHkWpcIiKJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCan9OFgAKCRAk1otyXVSH
 0PrcCACBvJ+H1tmJSIBWPSR2CJHK34Rn8M3B6C3H5/a4oFZhJorHkNmXZMykTGbuMmcRajKySLz
 bcZ4z/yknUVJLJ1tsTSBBQuLMiyYZ/7Lkbz0hiBzYuKyNQtvVa5LOQd5ofI1Kxnyz0oW77E/Kr5
 Rsh/9gHCJfkYLCBvEgqf+IDR7OzJyNmzxk/NQmJiNUtxldO4C5E7bZO9AZSVg9uIgcLsRgZpugW
 4hLAtUVdByY6YichGEtt6vdGuVXPDDPsdYgkbRNaVTkYHwHWeUxSUD/8ly7+NkEEVsXM3mB1I43
 8w6+YzSRcYwvcyQkWtEOjhLFSe1KKTBs4b68a1SB+7y8oo4G
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Wed, 12 Aug 2026 23:02:02 +0200, Jerome Brunet wrote:
> spi: dt-bindings: sun6i: Add compatibles for A733's SPI controllers

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.3

Thanks!

[1/1] spi: dt-bindings: sun6i: Add compatibles for A733's SPI controllers
      https://git.kernel.org/broonie/spi/c/122970a4a6f3

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

