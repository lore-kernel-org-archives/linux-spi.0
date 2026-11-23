Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795519893;
	b=IvHvdYfuxOp69q8owz/T0kP6xFYn59oKeqjO46MYWYSFa0PKyG7pac8OOZSq6mfFAxF7
	 h8K2ULmAaUnM04FuVTlB4DDm1cx08RLDv2LzVeS9r4XRTV3ig1+60ex/7yflLmIcm2+F8
	 MKhj2GSkm1XZ/g70WzOEbX6yAXC979BboG4MZrkXHMSc4kgHGsS+8hNsA/V0beArBpqhG
	 F2eZWYJNlpj9UnfatSr21vPNRYRrQSmC5nBThwICUTR3bKQCgP0wjLD+UsF+vbN/c0QcJ
	 i59fOA1WmHsMl0PYDO0ppoT7bpkOkYUIMZe4HFdFtPyiLLzG4Qg6MzuNAOmA5Bqm2bA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795519893;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=q3qGM9Qy57cVjK1+KGIJlLy1Vw4Q8SXTPS0xOWRA8sQ=;
	b=gJVKSoAUeyHZeSUcLZuba21W7N+2VolR9t69YEwJDPFpdDbNhLmL6Lvkeko+UUentKjS
	 GvDYT10ZUWtmcz5Rb7KaziDEB3fHP69DuGZQYX3c+WEUv57UKtQWY3QCpeJAu/CCLp06X
	 1WihbCKHiaV1kfVf4VGH89h2jbKk3QrNtuZHB8bnbQBus42YZw7me83bJClpdBGjsJuDQ
	 KYN6Ku63zem77JbwmWSP/C4nRRmIJAVEK9emfy8bSwLP+XvlsQhyfmBrKzMcqbIiz2KLs
	 eyoEw4JK+eLPrEvQEw7oIOBFF+qfAjsBZmeYvNtsvFv8aDsr313ZLarO8O5EWV3uCiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hP6mj4zp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164D7606A32E;
	Tue, 24 Nov 2026 11:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hP6mj4zp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82D821F008B2;
	Tue, 24 Nov 2026 11:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795519892;
	bh=q3qGM9Qy57cVjK1+KGIJlLy1Vw4Q8SXTPS0xOWRA8sQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=hP6mj4zpBvCMnt331ApoLcM/EzFJdkOQ0GKsGIwM6rXUl9fXR9PpeeeCKOVahaf/+
	 TapgVEyLnfqMcvxpeEJFtizvFXH1G5+yyA0Qmc4qw5lBZKlfakiSt32WPDNuMarveG
	 AfSi1ycHFWrX5ztj6VycNVo0inJxipzydzfIgIxZlYZU2AqtaPxrEW1ui3/m/k62l1
	 r01EDYCEkz7UPpvB+th4u5h7Ou1D/TLepSI4nezhObegXj+Rs3ndDDsiqucG1a9eU2
	 53oHD0bs0k+DZ7pgrjOfaV4AI1rcRnq4gGn2fRW0PsRcf+prP/G2Srb8CiqU2q7fF1
	 u/RlK23s5higw==
From: Mark Brown <broonie@kernel.org>
To: Ryan Wanner <ryan.wanner@microchip.com>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
 =?utf-8?q?Jens_Emil_Schulz_=C3=98stergaard?= <jensemil.schulzostergaard@microchip.com>
Cc: linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
In-Reply-To: <20261113-spi-atmel-poll-short-pio-transfers-v2-1-f280762685e2@microchip.com>
References: <20261113-spi-atmel-poll-short-pio-transfers-v2-1-f280762685e2@microchip.com>
Subject: Re: [PATCH v2] spi: atmel: poll short PIO transfers
Message-Id: <179545926826.25092.9908100181391728430.b4-ty@b4>
Date: Mon, 23 Nov 2026 18:41:08 +0000
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
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1102; i=broonie@kernel.org;
 h=from:subject:message-id; bh=lS+VtYxRGDrxj2oCgEImHpbzYp61PHJSeMh1QIq9P8c=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLJZSyesmHslPHWmot8Or+1PS+KSkqV3Hz2sweTxJSA6h
 TdOQ7elo5SFQYyLQVZMkSUui/tlfcnrNXwHF7bBzGFlAhnCwMUpABNJL2L4X8wvLqLlO+Ow+yOB
 hG1xbafs0n85hxdsNfes3sz9qUdZguEX09VGlYP/FB0WiKuwbSnIvPzoM7v2giJ9k+w3Z3YqSrV
 zAQA=
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Fri, 13 Nov 2026 16:20:32 +0100, Jens Emil Schulz Østergaard wrote:
> spi: atmel: poll short PIO transfers

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.5

Thanks!

[1/1] spi: atmel: poll short PIO transfers
      https://git.kernel.org/broonie/spi/c/24e635993ca5

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

