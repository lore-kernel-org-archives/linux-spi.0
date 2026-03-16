Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C890733BBD0;
	Mon, 16 Mar 2026 17:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773683576; cv=none; b=gmFqybqaj4WR47ddiNgP8W3iBa8e3iFkOQK04pdxvcpKGRJqRIYceZ2XXcevAuYvlKw2n3Dn5A7yb24TNjzzJ09s03AlYgVvxXMoSKt8+kwxDg9VfGPknqbBMsFqd6ZIT2emihGjTqLFbMZn3q9yz/5GMS2V4xRaJ4UTTPzZQN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773683576; c=relaxed/simple;
	bh=QK9n0w9Nsd82E8ZRQPvx4wNiypPjvrWgPongLIvYxw8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=iyWgfAHT5lvo967KbvPuHZb0qJYWm45a7UAnmF1kbCFqphAy10FfyZc4sBM5dcwRG9W20sNhGfaCHnllQWklmV2xzIXKK6AYmVpD7k2FJChABrSzUOk+fu7eEKSc5RL0zmyT5BPwCh0Cpj09K5AXDucJjs/TqqWsR6ShwUrQapE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hWdcq7Gk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hWdcq7Gk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5536AC19421;
	Mon, 16 Mar 2026 17:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773683576;
	bh=QK9n0w9Nsd82E8ZRQPvx4wNiypPjvrWgPongLIvYxw8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=hWdcq7Gk0UpZSd2FAQ+mpJVmd/1+N20oRMgYfrvW5NO0DDtCuPdw+GdkpSIfKwd0U
	 w4SM6KpZFB5ObAXtkSTmphSQTJ9Nwjv890HFx7fI6bGdTWUjs3bSrshHQS9FrTBNAj
	 k+lb2HrnYG0wALwHZuj884GvCcpSarhqzDsSLMgMwlWQS4koAqqL3Tu5Khi3uY94bV
	 6ODEjm3jtIyjmxHqW//8Kkk6bUyDQKYtR23PZ2edrOV1yNyXSMnpKHFcV16NNk000q
	 6FmJ51deW7Qq9BQEYkQ6cWWE6IqUnYoD8GVs/U3HSuvjVGxtBSg/m2QvXgaQEC86Wh
	 uB6Xj/02I/fLA==
From: Mark Brown <broonie@kernel.org>
To: Liang Yang <liang.yang@amlogic.com>, Feng Chen <feng.chen@amlogic.com>, 
 Xianwei Zhao <xianwei.zhao@amlogic.com>, Felix Gu <ustc.gu@gmail.com>
Cc: linux-amlogic@lists.infradead.org, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260308-spifc-a4-1-v1-1-77e286c26832@gmail.com>
References: <20260308-spifc-a4-1-v1-1-77e286c26832@gmail.com>
Subject: Re: [PATCH] spi: amlogic: spifc-a4: Remove redundant clock cleanup
Message-Id: <177368357508.147197.6859003613320300575.b4-ty@kernel.org>
Date: Mon, 16 Mar 2026 17:52:55 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c239c

On Sun, 08 Mar 2026 21:34:55 +0800, Felix Gu wrote:
> The driver uses devm_clk_get_enabled() which enables the clock and
> registers a callback to automatically disable it when the device
> is unbound.
> 
> Remove the redundant aml_sfc_disable_clk() call in the error paths
> and remove callback.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: amlogic: spifc-a4: Remove redundant clock cleanup
      https://git.kernel.org/broonie/misc/c/a00da54d06f4

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

