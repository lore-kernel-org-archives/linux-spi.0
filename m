Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D54143FD01;
	Thu, 30 Jul 2026 15:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785426639; cv=none; b=aiILk3yaQY5Jz7g4O+QZ4f3d0/HoGye6kflyanuA2Sbxp+2MxbGQszrsBCsVQioXP7KzyDXbORIbhaaxS5y1VxCnsRwNn2RkzGh8QxuVKoI0wqsA/ldtDMFxu840PCfx4ZMJKqr4AijZ6t7rXTHdi52DcjFNNQde1otYf3Wpd8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785426639; c=relaxed/simple;
	bh=dr6iG6osjaLocDGYREZaQmbHB5gCia52HLqij4xsPMw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ktwte8GuGMHbQIfaWgmjWt0wb5tU13Fi6WFqU6u0gKDgv/VFIzY06GdoafkBwhaZEDNk8ny334057hxLH41QnxsfKWiSAoByfTVxos+NwIdqtjbtnxnAY+dOSNBHUS2b3y+HQPUw5DiIFkF5Nmzj0QGLrriD1Ei5Ga1d8my2z9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dwHkKMXX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dwHkKMXX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37E531F00A3D;
	Thu, 30 Jul 2026 15:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785426637;
	bh=G5h+AipDvccgog7pk45ebn2XpsOQhgcN3dHDXPGKXzk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=dwHkKMXXg+ToqLBYD1ZBPQkeI5w1hq+yCfa1d7YWLn5JcylVxWjpaFzTbbwNEES6b
	 hKLoHbXmGIxu63oQkFx1HqTQNLULwKy36f8wRW6uKwlOyU5EcHLOu9AEvlAaV+TGr5
	 32fbczqGSfhCTuD3AQhyhJTaudKPjKGSPJZwroRyQUlDtCswopCxjtN0jsEtLPTMI7
	 31AM3VuYt+cdfTPkZ5kAlPTuvxyFe4TzzIikMB3u4MW9ti80s7oyE4YwGkP3wmPSPI
	 YAbN18+OUjJk/N0JpN3jJKvOnJqtIs46o+8tHTP3D/4Cx8a6eDErqAz6ATvz2RbybR
	 BB1JVJaMfGwmA==
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, Rosen Penev <rosenp@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20260727194714.11354-1-rosenp@gmail.com>
References: <20260727194714.11354-1-rosenp@gmail.com>
Subject: Re: [PATCH] spi: spi-mpc52xx: use platform_get_irq_optional for
 IRQ lookup
Message-Id: <178541244855.81171.17307971925800575584.b4-ty@b4>
Date: Thu, 30 Jul 2026 12:54:08 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev

On Mon, 27 Jul 2026 12:47:14 -0700, Rosen Penev wrote:
> spi: spi-mpc52xx: use platform_get_irq_optional for IRQ lookup

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.3

Thanks!

[1/1] spi: spi-mpc52xx: use platform_get_irq_optional for IRQ lookup
      https://git.kernel.org/broonie/spi/c/09d083d6757a

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

