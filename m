Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F5E2EC541;
	Wed, 28 Jan 2026 03:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769571381; cv=none; b=WIGgrqf6d/SbQcNg4mxipqzu6HzrJKfaA45kvFNBLSED94eTWxNoJIKBJGfC1hHRsMW0RPCVgqtPNtMUcaLRPi6LR1C4VsBg76V6bKgQGQGrG5SLl4SVIuUkgzOi5egE5PNsrgAgpJ2fcXGDJguFsKzffFvLPfoAwv11cVNkI9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769571381; c=relaxed/simple;
	bh=h2jnOBlPu3rqXA2DvpSqz1NvAIQ2FgRBo+ESxw+v0rQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=AR1qrEnEFqAoUzfnfcSP1LMTBHbxEJhB4jf+0ZLGSpsXWklawLFDYxfiKKcMXUwiHd0seKXBNPxdQbHKwaHV22OtDmtrCiEVEEspcCSgw/Lb4iiBSnFsM3dGtfagVye8VyMfWBPGW8mk5LChZ3lKVc1P4miXYqJ6MJYR4crnGuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fw0VLHSF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fw0VLHSF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAC7DC4CEF1;
	Wed, 28 Jan 2026 03:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769571381;
	bh=h2jnOBlPu3rqXA2DvpSqz1NvAIQ2FgRBo+ESxw+v0rQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Fw0VLHSFw3I9lUuS5+WDImJda8I8YmJOnXnEwlJlC9uL6Ai+gj2+Z/ArkIITdkRWT
	 qdQNA1BtN86N3aH3Tz96gm4BhZv/NMTDDRWj0Q7mWh2K7g4AIMO1oM0JQnUlU/XnFF
	 Y/ANqL5TXwhshcZAv+UU6r/IdRxMa5TPWdC3E/tv9JlB4VKWw2X43iMtOjDzVyXTHb
	 /v8mLKw9W4cvKuSXZVdkodJZ9kGqgNo8vMMq1xmkO0JHk52iSQ06eK+One9YyJhM7A
	 EayyEE7pLmYFvETkKijX7zh3pCFG52Gx5tTym+1QFg1w42pmdjpJjJ++wC2ZG6mEdh
	 9D4Z2+ufDDEyQ==
From: Mark Brown <broonie@kernel.org>
To: Vladimir Moravcevic <vmoravcevic@axiado.com>, 
 Prasad Bolisetty <pbolisetty@axiado.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <386273d50fb3c51cccdba4b3101a0705208abd4d.1769540444.git.geert+renesas@glider.be>
References: <386273d50fb3c51cccdba4b3101a0705208abd4d.1769540444.git.geert+renesas@glider.be>
Subject: Re: [PATCH] spi: SPI_AXIADO should depend on ARCH_AXIADO
Message-Id: <176957137951.1524024.776031797757604394.b4-ty@kernel.org>
Date: Wed, 28 Jan 2026 03:36:19 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-47773

On Tue, 27 Jan 2026 20:08:31 +0100, Geert Uytterhoeven wrote:
> The Axiado DB-H SPI controller is only present on Axiado AX3000 SoCs.
> Hence add a dependency on ARCH_AXIADO, to prevent asking the user about
> this driver when configuring a kernel without Axiado SoC Family support.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: SPI_AXIADO should depend on ARCH_AXIADO
      commit: e540be7d56d740144b1bd6f220b61ffe2f3830d4

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

