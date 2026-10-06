Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D653AEF22;
	Thu,  8 Oct 2026 07:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791443677; cv=none; b=AT+5V0Har0kBkd5Hx6aC42UVv8PKWVeWCH1mLE5BNFqsi4XSfy6MdyLImmXszekbw1tINSf0R3iO4bkBg/lTyIey/ioGgIvQ/IOZllrNj3+8O4xR36L8cUeHc1Iwx3tL3YDCblulBYT+yFKwRzbZeDKFuux2en/3Y3XZ7nUw0rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791443677; c=relaxed/simple;
	bh=Al8+VIKGWcxGhYyRaeMpCro0EDWhQL2GdHl//h0s4MQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=CzJzzphrHzstPxS3wm5ouWP7l5q31ofMTqQ1ZVnRgQNMk/pnJFZ9sOYn47m9GinjtyRehCaYSJuLpI24YNjlz0WAdzXacVZXuAd6wBpohcLM1FkKipxd366FWe8ibv33FZWeVXr6GhKrH8Dg5OtYsSt5lOpmWlUGJCKvFGEefxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hhbNkvpu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hhbNkvpu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F8D41F000FF;
	Thu,  8 Oct 2026 07:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791443676;
	bh=fYftf/Su62EUrYUf6blYPGhehrDzs/z2OLT9geCyA8k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=hhbNkvpuOPygjgYsFStv9E0RgIjhNCYJwUEu/8GYXgVNf1UPp+cxBC5dJ6Mc09LAh
	 l27Uzx3XKns+0nsbuOK6mPS2q2iGcile21+ki9LTGc3zDrJU74cQB8CTYlFXQ1bZLL
	 SsRhF2LcLCA+RTm7WKGvLW5Kxv9xeLB2FNLf/f2Sy0O0C590W0nZUMAtFJpkIsPHxi
	 HPYFMqCK6ku4aaq3NJvsvaWF3CZV8LhAQjfMV3Tuy53hJSB4FVDtGsdJ7ePODzrdyM
	 6Nb038rtu4ahglDWK72ExH9XnIq1J2rzKSxiKU/bVx/MVjZbhaKPHY++gcqiJOEX0S
	 /7xqm1nBJiRuw==
From: Mark Brown <broonie@kernel.org>
To: Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Maxime Ripard <mripard@kernel.org>, 
 Alexandru Gagniuc <mr.nuke.me@gmail.com>, 
 Olliver Schinagl <o.schinagl@ultimaker.com>, 
 Jonas Rebmann <jre@pengutronix.de>
Cc: linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>, 
 Tobias Schramm <t.schramm@manjaro.org>
In-Reply-To: <20260914-spi-sun4i-fixes-v3-0-9fe919d5cecf@pengutronix.de>
References: <20260914-spi-sun4i-fixes-v3-0-9fe919d5cecf@pengutronix.de>
Subject: Re: [PATCH v3 0/6] spi: spi-sun4i: assorted fixes
Message-Id: <179130066333.150114.1591753111573299755.b4-ty@b4>
Date: Tue, 06 Oct 2026 17:31:03 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2091; i=broonie@kernel.org;
 h=from:subject:message-id; bh=Al8+VIKGWcxGhYyRaeMpCro0EDWhQL2GdHl//h0s4MQ=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqx0LUIXMhyrvOstkVy0FxPa1zNc8ZuG7T2x7tb
 1y74cN4wp+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCasdC1AAKCRAk1otyXVSH
 0M35B/4kUlR7nD0lYrEwWvVkYsWDVwvaKgRLOc2ITC8JrxazDJ86Vtclvy/EIT6tBMMdiAQcAeE
 PgrkLGNeICYjJw6j2kw3hvAthfGmpslblAEcWtpPc1KIS687D6HzL5C6vJf7hAJ2k84iXyunNN9
 jH/3CwFRvxPzqpp3h7wOUhaCgEfE2wQlM7szs2yJ/jm46v9ZlICntQuSJKuSUTsb6D3/QF3h8rw
 g0NsyYZHZ6ZWf3KfBD4sfVOYuWsNHaB0CFxfQUx8miVE8hegvWg4q4az80NTt09bVa/ofbvIoXh
 SeGUE3nWL8cGNm1i97WrLnTZ3TVh/yc7koKpVkZrPUr2d9JR
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Mon, 14 Sep 2026 17:35:54 +0200, Jonas Rebmann wrote:
> spi: spi-sun4i: assorted fixes
> 
> This is a series of patches for the spi-sun4i driver, some of which have
> been sitting around for a while.
> 
> 1-4 are fixes and 5 is a small patch that introduces reporting of the
> effective SPI speed.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.4

Thanks!

[1/6] spi: spi-sun4i: sun4i_spi_transfer_one(): fix transfers for SUN4I_FIFO_DEPTH
      https://git.kernel.org/broonie/spi/c/f3ce7a3ca82b
[2/6] spi: spi-sun4i: sun4i_spi_fill_fifo(): always apply A10 FIFO fill level workaround
      https://git.kernel.org/broonie/spi/c/ee109e2bbea0
[3/6] spi: spi-sun4i: sun4i_spi_transfer_one(): fix setting of clock rate
      https://git.kernel.org/broonie/spi/c/672ba6d88324
[4/6] spi: spi-sun4i: sun4i_spi_handler(): fix race condition between transfer completion and RX FIFO interrupt
      https://git.kernel.org/broonie/spi/c/b8f09251da78
[5/6] spi: spi-sun4i: sun4i_spi_transfer_one(): add error handling at clock setup
      https://git.kernel.org/broonie/spi/c/a3df049084c7
[6/6] spi: spi-sun4i: sun4i_spi_transfer_one(): report effectively used speed_hz of transfer
      https://git.kernel.org/broonie/spi/c/b42ff8dc7e54

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

