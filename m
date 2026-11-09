Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794251316;
	b=E0jH9vYJsPjZxuhh/67JTSXeF6LMiQ05kKPbX/rtL6Rw1ZHl6Ccpx+DhajFxnLSJM3hw
	 mzSvCi5jFn1pULPVZHs/RnTku8w6GaSekqII1R1p8Naa8p+FC1tIkPR9pck0yyRGRwL/M
	 0fZamg7f+/ZFFnJnbFu3sqqlAVINcFd6GBOWznAldvd3MbgfPNiyEosUu7agmSAOm/URj
	 DkYW3SdyPsABfM4vxIycRtewzNBef+EyaF5exYUkRkuJQYPbYcTye6uDe0/5gAvpfaAyl
	 qzj8B6mPyaog7QQISCHB2k2iPm55qy/B1WBUh43ZM9v5KLPxiLm/HIuqkk+ZT6UvDog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794251316;
	h=Received:DKIM-Signature:Received:From:To:Cc:In-Reply-To:References:
	 Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=rrD94qIvhi50i6maguQXwdRSuQxDFOhylUJdsghGwpI=;
	b=5CJM8j7TO4QUN0xtsN8HxtXinBF0p5Zo4kK0wTZAJG3eSDAS6TApULbnnnGhdQ38h10E
	 lH5yZtYgLjgpAbSl4SQ/UlmcTuTh+MGnxj8BwDsqPZ3TVqJjy+9Sr6Ol1loBq0AgdhfeE
	 beFkR9xdox2Tmq9wY75EsFJH5jM12P2j2DO/2SwaJEeCFc3+Ee6uab8kWzfC3raQBI6q/
	 MEOHqKSbRcJmtWxmg8ttusak4nWfNUoKN5D3NkWZj24h4YA8spo7/Elnsn9VKG9XVs57d
	 Gu+3Xb5Ayp43LJ6blenu6QDFnnhsllcXCwgVAr6PDsZY87DHLQBeomUqFCafCtPFLfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q8m9KkTb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1000606A31C;
	Mon,  9 Nov 2026 19:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q8m9KkTb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 803BE1F0089F;
	Mon,  9 Nov 2026 19:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794251315;
	bh=rrD94qIvhi50i6maguQXwdRSuQxDFOhylUJdsghGwpI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=Q8m9KkTb2m9E9o5TTiapGnnREQP3M5JLhJibRnvd9Gsds6CgFqG7O8QfHhDiuIV81
	 xWTsbMtHIFGIiadfAfyV+6JZAf9x+xL/EuhAdfxf457QhX2HwsR9+h8x/+aJc1PQKl
	 5oPTunaPSrAStwy3I1vNIi7ozAmrtTcBgg2C2d5eGLUE1vBXtjDhbdwSjWtibhTiMh
	 CDbj3z16nLYxbg1MrBrT0dxkS1utOsB5Y1xsTDDdOJL852Kc/c5TrYSB/Y6KIzCHoB
	 Rf3KUklm9iJFkF6ujk0o/U0/bWSnw98l8Q6ZZvlsY0hdeeTmsBihTqhk4uDJxeMiwL
	 PimcP4XQDyDsw==
Received: from traversing.sirena.org.uk (localhost [IPv6:::1])
	by traversing.sirena.org.uk (Postfix) with ESMTP id B0BF02F7076B;
	Mon, 09 Nov 2026 19:08:18 +0000 (GMT)
From: Mark Brown <broonie@kernel.org>
To: Felipe Balbi <balbi@ti.com>, Sourav Poddar <sourav.poddar@ti.com>, 
 Felix Gu <ustc.gu@gmail.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@linaro.org>
In-Reply-To: <20261104-ti-qspi-v1-0-c286943c22c3@gmail.com>
References: <20261104-ti-qspi-v1-0-c286943c22c3@gmail.com>
Subject: Re: [PATCH 0/3] spi: ti-qspi: three cleanups
Message-Id: <179422774002.3711751.14777776915872588054.b4-ty@b4>
Date: Mon, 09 Nov 2026 12:35:40 +0000
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1400; i=broonie@kernel.org;
 h=from:subject:message-id; bh=Mj47PorNLWQ9hRI+nRCyQ3LXENORO5QMtHabCj6i0j8=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLI+SSnVnZOWqNr/JPWgjHtf8Mdfn7fd7XRx4LK+ZX/v1
 vdqJmafjlIWBjEuBlkxRZa4LO6X9SWv1/AdXNgGM4eVCWQIAxenAExkgQzDH+5H57UNAyZc+vLx
 8jTBKVsDowrXK/9JqtqzNn+T1SPuIg1GhsPl8VPbjiwzu76e7c/dj9FiOmtfSfc7P+vienZOXu3
 3InYA
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Wed, 04 Nov 2026 22:08:09 +0800, Felix Gu wrote:
> spi: ti-qspi: three cleanups
> 
> This series contains three small cleanups for drivers/spi/spi-ti-qspi.c.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.5

Thanks!

[1/3] spi: ti-qspi: Remove unbalanced runtime PM put on removal
      https://git.kernel.org/broonie/spi/c/8b8678d3e894
[2/3] spi: ti-qspi: Abort probe when clock lookup fails
      https://git.kernel.org/broonie/spi/c/bcaf60556b8c
[3/3] spi: ti-qspi: Correct runtime PM error message
      https://git.kernel.org/broonie/spi/c/ee961969cfe9

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

