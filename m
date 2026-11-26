Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795720670;
	b=tH32Fsc3nwK4YM9eOuha0YXyAzC48KeIyoGgf8FVWw8a3r5K5OCn6sGWaH/jwJ3WB6Kg
	 Z9T5LMNVfyT+UjdE0W0pOIZ8szL+7KPSNRAve2MA8+Nx6DJRS7bxPxmZOWRiRqP4jxNq4
	 3qtMmyHkSHx62SrJEgt31LMbzZSppOFEDoFVV3el0DKrGt1QMTkW0g4Bg5KXC18GwpZ5q
	 Sufu2ybXLsmfQZBpdR7Zki5le6tYkwXRqPZ5fF2WOmMARWeDKCTFrXN16LH/A6d5qES0H
	 sm2pngNrkz/9dQ3Uy3jEanyZFnQmMXY5ODQuXlfB9ZnLM7LQ6WJc8Wo0GjuUVub2eXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795720670;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=NSz29YDdr5IcKt1M+I6R5pFgOYV0fBratn2mK/NCPaE=;
	b=QtS7jZyUb2Rrloom23aHHE94SuD+RoCJvrBMaQ2QOUhLlXq6IoW76P6OHclpfjfwC7Ei
	 aoam+hFCmTRIoJqmBDpw6tTm+zKdojeVuiwPv/aQj+SBRCorVVJKc1sVZBfdB5TVOdPlz
	 wI4YPmGEnv/qpolnPkkmiPL4DsqJpH9rQCcuLnNeDWA+tNqBZeDbCJuqCqTGq3JNhKKXK
	 WfTrS1Eb5BwjiuXDgSxgqSw9Yrq+vMA5JU5NrYKClql3wmqarUTheyz36iAm1t4mDi8D0
	 aOg1Bq70dVJgohd8/wXWJsj+5fmpo377vSBuyz/a6ySjxQxJF8GNWVhLU42G8RC5ifA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ad5qE1RP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05BB6606A31C
	for <linux-spi@vger.kernel.org>; Thu, 26 Nov 2026 19:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ad5qE1RP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65A1E1F000C4;
	Thu, 26 Nov 2026 19:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795720669;
	bh=NSz29YDdr5IcKt1M+I6R5pFgOYV0fBratn2mK/NCPaE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=ad5qE1RPalRxQTsVP//mLrRQTigELv3lqfrpnRF5TgffMHkUxtH32KHd5Ai2SD5zW
	 fNUG/xtUwT0Xbqy3VPSx01MOhQQlpkgvysT7Rr9QId8C2lL2QO55fJi3pwYTr6pUUR
	 5evz2GJCCEpDRjv5AmvvjdDhM3b7SjUKr2iV2rhEIcOn/GbanHbfCWHb9sJ2EmD+Vs
	 vTuHhsVZ4V6Ggz7luVuaXX0eXqdQ7Y+0EPP+GAdfi5S7JFMk78B4pziFwNr/X1AqQK
	 iAXDtHRTizKJf2ur9IECNEVPZzolUxh+3rFHWhY/b4QWPHlYC7fRdzT/rOJ1FNX+GR
	 fnyC7+oI0NCQg==
From: Mark Brown <broonie@kernel.org>
To: Joseph CT Chan <jctchan@gmail.com>
Cc: linux-spi@vger.kernel.org, David Lechner <dlechner@baylibre.com>, 
 Bart Van Assche <bvanassche@acm.org>, 
 Joseph CT Chan <josephctchan@google.com>
In-Reply-To: <20261119191001.878454-1-jctchan@gmail.com>
References: <20261119191001.878454-1-jctchan@gmail.com>
Subject: Re: [PATCH v3 0/2] spi: spi-ti-qspi: finalize message on transfer
 error
Message-Id: <179570579089.142532.12583573654846154440.b4-ty@b4>
Date: Thu, 26 Nov 2026 15:09:50 +0000
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1854; i=broonie@kernel.org;
 h=from:subject:message-id; bh=M8k5qIe7nS11xA6wwIdtMZU0vq3LY4NPmwez0Hjt/DA=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLI5Wm+uVNI9ovaGhUd957NTqzIcWD6qSea+3v7BsN968
 +GOFpOnHaUsDGJcDLJiiixxWdwv60ter+E7uLANZg4rE8gQBi5OAZhI+UaG/0W3Vv3m65Rr/Nz1
 pPJ9zoQF9kb3UwIm/dc42rh9i02t7UtGhvOr3tt9TlW0FnvtUBJX0DlbW07wFEdlRU+7w73L0QY
 qHAA=
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Thu, 19 Nov 2026 19:09:59 +0000, Joseph CT Chan wrote:
> spi: spi-ti-qspi: finalize message on transfer error
> 
> From: Joseph CT Chan <josephctchan@google.com>
> 
> Hi Mark,
> 
> When a transfer fails in ti_qspi_start_transfer_one(), for example on a
> write completion timeout, the driver returns without finalizing the
> message and without writing QSPI_INVAL to end the frame. A queued
> caller then waits forever, and a spi_sync() that took the no-queue path
> gets -EINPROGRESS instead of the error (with the message's optimize
> state left unreleased). Patch 1 sends the error through the existing
> exit path, which ends the frame, sets the status, and finalizes the
> message.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.5

Thanks!

[1/2] spi: spi-ti-qspi: finalize message on transfer error
      https://git.kernel.org/broonie/spi/c/b3b0703ce967
[2/2] spi: spi-ti-qspi: add a KUnit test for transfer error finalization
      https://git.kernel.org/broonie/spi/c/945f73846d8b

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

