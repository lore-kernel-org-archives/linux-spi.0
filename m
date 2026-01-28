Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D0945038;
	Wed, 28 Jan 2026 22:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769638742; cv=none; b=XuwMJUF02UEorg4LEOGyzyoGLH02RnMhkwNI+dAcoh1S0QP3nn3+dBSxE0+WwA97t4jhu3kqPk/oyryHIHxao8zxTYdelPPm/nJEjFfq81gkVmSE7Tsp31KhVK9pStkq3MUI6hmu6rSpPYodXJvvMtUiqhciS4IL9IwPF8Vulsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769638742; c=relaxed/simple;
	bh=gBT9XbpdFRENZ9OMyR4gcVKqV611QABoR8gHTQ3K7pQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ZVQGlLXt6N64DIKuAm+fhIOdOJNX2aoRKtK+25J90tYZA82kgNzKWCOvcxfbMm4MTbDowve5UfhMj3kLNZWCAUNUkhw04ieSeMg0Bm3eEsSAdtKu/IJFiVoMqFSefaBZcV+WcZK0THG57IWI9taRtL9+nJeiXia5pf7llXdMAmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TMSLhF0l; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TMSLhF0l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B567C4CEF1;
	Wed, 28 Jan 2026 22:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769638741;
	bh=gBT9XbpdFRENZ9OMyR4gcVKqV611QABoR8gHTQ3K7pQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=TMSLhF0lkCg7C/3SWI9HTo9jnVY+frLEoVQdulBpSmcBQQDz30hzTY9Un+as5JUkQ
	 cW7135FV1Pw0EjSpUopfau7di5wdx+PRy1wcOJaoYmmSiwG5BONwioNq1TuTC773Wz
	 ro3E+iVy9eLqGJGnVedHdSLba/Cuzcz9CEQeFOTK5EifsHgoTjBkrmk7AdopJ7zlC3
	 ozs7wXzICIMOnH7PA0vrm4sS9tVl8taJKvB2M259fBwCAS6vb2OlR0u4QxqqK/eSIF
	 MmswocJjPanPOafrC0yVyYeUefRpPNf+hQYE4b7teMdO0OcCnY6JiR+U0YT4eQavIi
	 lM4gq4lWgfAZw==
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, Marek Vasut <marex@nabladev.com>
Cc: Fedor Ross <fedor.ross@ifm.com>, Frank Li <Frank.Li@nxp.com>, 
 imx@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20260127222353.1452003-1-marex@nabladev.com>
References: <20260127222353.1452003-1-marex@nabladev.com>
Subject: Re: [PATCH] spi: spi-fsl-lpspi: Handle clock polarity and phase
Message-Id: <176963874010.3217393.15887158473398999292.b4-ty@kernel.org>
Date: Wed, 28 Jan 2026 22:19:00 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-47773

On Tue, 27 Jan 2026 23:23:22 +0100, Marek Vasut wrote:
> The LPSPI driver currently does not support setting SPI bus clock
> polarity and phase, add support for it.
> 
> It is important to configure correct initial clock polarity and phase
> before the GPIO chipselect toggles, otherwise a chip attached to the
> bus might recognize the first change of clock signal as the first
> clock cycle and get confused.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-fsl-lpspi: Handle clock polarity and phase
      commit: 7ae4d097b752d77c41dd26068d92ef34e9c66be9

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

