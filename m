Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795749062;
	b=OBVHCpeG2dFLaQE9C/NteM5+ToOrFw1BqbcjxXD4reCO4qhYGD89ULwaFGvgUihSqbT/
	 Gl6SkvBuWgFwOjo6CVAffLiFzbUT4gSDi3Le0bFraCreqZ7U1s/y/+z4QWKYZLq0M7Anq
	 AMzkuJkNmQxHdvJjeZd/x2nMUwbuZ2ffAAyiQOijBkgBFaPi5BEW5SytxdSo8l20a8kZ6
	 aQuRxRpJKtoKN4LmS5RcqRiwJCi/zxHvcxA62qx1nnbQTVOWsFgLdPzrJd18Wf3WPle+B
	 EPnw3WUB/CVLJOOp7/BytESigqioEldyFBpzLVrQ1zDj1GLrc8IclS1RhgY8OFNZe7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795749062;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=IZVMr2wd7T6aAUkFuX98aq2ZvTlYjcJnNDl0veQEVg4=;
	b=cBVs0vqwMisi+LQQSaRaSb+KPYgduy0UQPaE0KnEeIZPJjnHymSG01nsf6rGkE5AXVej
	 cvks3C1aSDO5uFxSF/2tLckIsRgYb3sZXWiKt0tOEZIUs+Qjcgaij3u6Ls56LRZHUKa0q
	 dkQyEixB/nk1tNZICp4JtNm8EOkv2GLWoM7Fl7FGG1lHcWaEmbl3F5/+IY1SmRGR4YdCd
	 1yoGUbxckEE/ktUm/fJOt2wWi/k9qY7X0rHF8898oehuTco45vBFpgbLxQ9P1CcUHZJl7
	 0RJXgTXU2fB0cpcuh9hBdZHyqHNjUIYWYakaEosYlsPm78UslTkW02dOwcDl4h+zXeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nNKZb4Jl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3265A606A32F;
	Fri, 27 Nov 2026 03:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nNKZb4Jl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E28021F00893;
	Fri, 27 Nov 2026 03:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795749061;
	bh=IZVMr2wd7T6aAUkFuX98aq2ZvTlYjcJnNDl0veQEVg4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=nNKZb4JlWShj4i+7qKXX8opq39aKbx6X6tbZzfCx0yfkTSEP46ozgeNRyItPDB5hE
	 vx7RXUGO20hXE5VxTZYJCojeJUSYw5LCXl/dPIAc196MEZmULkDasSQbqGmf0BoOd8
	 tpjrpNOuPMHl//KIu3PUwK53QFcl3LT7J0rkatjKQI6EJxzUkhNXUQlciDGaaNezQN
	 aXbevuihS7IHTgDfocO3ipMYLjOuSkBZmNt/wc9GmNhpEi8m21pCavAo4cI8qNN/Gx
	 M7ewgqoVomTgN9gyeIYQHnau0lLvYPMe0PCAJX8JVzJSyx8SBvq68UtgboI2EsY67S
	 8GhAY4Vzdwyiw==
From: Mark Brown <broonie@kernel.org>
To: Paul Cercueil <paul.cercueil@bootlin.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Bharat Bhushan <bbhushan2@marvell.com>, 
 Sunil Kovvuri Goutham <sgoutham@marvell.com>, 
 Tanmay Jagdale <tanmay@marvell.com>, Jisheng Zhang <jszhang@kernel.org>, 
 George Cherian <gcherian@marvell.com>, 
 Witold Sadowski <wsadowski@marvell.com>
In-Reply-To: <20261120115925.173568-1-paul.cercueil@bootlin.com>
References: <20261120115925.173568-1-paul.cercueil@bootlin.com>
Subject: Re: (subset) [PATCH v5 0/7] spi: cadence-xspi: Fixes and ACPI
 changes
Message-Id: <179574308660.838304.8281915634065237765.b4-ty@b4>
Date: Fri, 27 Nov 2026 01:31:26 +0000
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1961; i=broonie@kernel.org;
 h=from:subject:message-id; bh=0A1142ghhzc0yzbCwwdb5rGBdCUiQqJlqofbujjfO5w=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLI5vhwyXa3IJ1F59ijPwh/+3wp/u6jGrDbJS3C5+9tuU
 1jtp/tcHaUsDGJcDLJiiixxWdwv60ter+E7uLANZg4rE8gQBi5OAZiIzQmGf5bTgrh0Wj/u2W3w
 RWIfF3e/aMC82QU5eTqmnrkrv57MFGf4X7Zk1+r8pMR9qy9nVEd/dU5kmGz08ryc1DsWr0ALJoZ
 +VgA=
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Fri, 20 Nov 2026 12:59:18 +0100, Paul Cercueil wrote:
> spi: cadence-xspi: Fixes and ACPI changes
> 
> Hi Mark,
> 
> This is the v4 of my patchset that adds a few fixes to the cadence-xspi
> driver, some cleanups, as well as a workaround for probing the Marvell
> IP on firmwares that use the base string.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.5

Thanks!

[1/7] spi: cadence-xspi: Properly handle errors in .transfer_one_message
      https://git.kernel.org/broonie/spi/c/ca89645f0d5a
[2/7] spi: cadence-xspi: Reconfigure to STIG mode before SPI message
      https://git.kernel.org/broonie/spi/c/7983521ee731
[3/7] spi: cadence-xspi: Inform SPI core about size transferred
      https://git.kernel.org/broonie/spi/c/4b3b8a72544f
[4/7] spi: cadence-xspi: Clear "SDMA ready" IRQ flag after polling
      https://git.kernel.org/broonie/spi/c/31a9eb539567
[5/7] spi: cadence-xspi: Drop useless cdns_xspi->cur_cs
      https://git.kernel.org/broonie/spi/c/b27e195dded4
[7/7] spi: cadence-xspi: Add workaround for old Marvell firmwares
      https://git.kernel.org/broonie/spi/c/502760b2ba69

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

