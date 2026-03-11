Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F093E3C4A;
	Wed, 11 Mar 2026 18:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773255445; cv=none; b=Xnx07ws4xgL3IqsXOmrS7PxbItqB9NhZ3Jyp7gx4Z/3qqxIRnwrvnq58JKeH80mQ1WHtHj7JJU7t6Z6dd0fr6/DjQM27UCqt8fA/wvVwAoW70HXA6y3Zed4jhWA33xZjFNmsGU0ptQBqEy7PDV/UVPHcidGOSXVArKaqvF2IRlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773255445; c=relaxed/simple;
	bh=EllHdPAyyZV7VwzLSIJTJ8+9ynxlnCPpH9WOd28KvPk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Baty6HaRVGpsZ1zMw4i3vSJOL06ouIFHYa5ki7rVnBAheqQdDKt0T1AkwcNXJAIirBp3lxMo46EuWNvsGimhsIrWBJyzMwz8ygg4yUrFhae9e8eLMkhWZFBvDBn5mA+ZW6W6U+VhFXNh51AF782iYvq6q+VKGbYGOn6nN6nNhQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cTD5Je3v; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cTD5Je3v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B661C4CEF7;
	Wed, 11 Mar 2026 18:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773255445;
	bh=EllHdPAyyZV7VwzLSIJTJ8+9ynxlnCPpH9WOd28KvPk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=cTD5Je3vCdG2C1YtPvwToGcDh4rU+61MliHgWGu9bN/vhxX6FtoMA8LmXe9bkbcI7
	 ofr++LFvkaIGYluj/UsggEwBJ8Kq2R7WDxlR9uZwz/arUHU3ER1tvO9uojzN7ZFsVU
	 CBFJgsxbClNMJV1v2ZcBLVH+M0O62GGKY7FHK+02vQkyQ+a05Ss1GkJP+keZNwsv76
	 pelhNoHWzGo09xZTOsLRR/+xEJs7x13SmAR5vtyPNoWBzsSamzl5Rr86gIjGkmTTFp
	 zsVehJlCOlzmAivTBT/TFFRxR0FcwdIzT5Qcb5GVyjDjLjA4lAKgRFtm8+iSLgQeJz
	 JLttTqdOcliwA==
From: Mark Brown <broonie@kernel.org>
To: Jernej Skrabec <jernej@kernel.org>, 
 Samuel Holland <samuel@sholland.org>, Chen-Yu Tsai <wens@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, linux-sunxi@lists.linux.dev, 
 devicetree@vger.kernel.org, linux-spi@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260302153559.3199783-1-wens@kernel.org>
References: <20260302153559.3199783-1-wens@kernel.org>
Subject: Re: (subset) [PATCH v2 0/3] arm64: allwinner: sun55i-t527:
 avaota-a1: Add SPI NAND
Message-Id: <177325544317.227890.7006024907910628189.b4-ty@kernel.org>
Date: Wed, 11 Mar 2026 18:57:23 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-68380

On Mon, 02 Mar 2026 23:35:55 +0800, Chen-Yu Tsai wrote:
> This is v2 of my Avaota A1 SPI NAND enablement series.
> 
> Changes since v1:
> - DT bindings (Krzysztof)
>   - Moved "allOf:" block after "required:" block
>   - Dropped "type:" from child node in conditional block
> - Collected tags
> - Link to v1:
>   https://lore.kernel.org/linux-sunxi/20260227175157.2339758-1-wens@kernel.org/
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/3] spi: dt-bindings: sun6i: Allow Dual SPI and Quad SPI for newer SoCs
      commit: 743956bb9990214ff1dac66ef59e27221dc3c2d8

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

