Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795126492;
	b=c6vMuQQGqUKBvkWZ5zv/OtqYGU8oV3ru66Uv41ovNs5PKFpB3ejcmid91uc1IOnUplJx
	 3YaBSBlnp16+MStJdCRMeEOtOIuX8dfRSzAYo1/jCEyT9TOg795zqg9ag8VGo5yauf147
	 CcIwkMDh73q024uO15qlB6TOvpVzmLHmh5KL9QFNIdNDuy7uvjRUOThbWTTm1wHiBup5f
	 tzu/LkMly1Uk1FQSfb5P8NijdD69yiUhiTEihGirOOKh8DvuevR+FY0ujVTUNF35vgm0q
	 fy33Wv8FIVp6R2VA48eqLmmbylO7ZibG3/mlifyuXGnYwLGq9GortmIk2+IISOVP2ig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795126492;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=fd/ERjmKCn8dZN/jdExfBIcTymNZ18o9U5B31DslFGo=;
	b=qdSkovejmkdtx47yQaWp9ET7CbqLMNngqVBYyCJbv+LumUlIO9HrNzKxbY+PrJblwv3D
	 ey0+OD5LaiIe28BmRZsDMwHXKdUrMiz1taMr5xR8WRuGDGSzG6WlukqGphjVmZGWZokcW
	 RyFwNJgnt7CJbCLzbohd4/Ob6ffxJ8dzdyDfjkBPH5sY0PvQHTeVc99fcdccB/ID6EU8M
	 H2lbRDSwFPgqd5hrA7Bn86E8H/jrCXrI+CNpYo0WKoR5zCZH0K6Oa5od8TTRIzkRl88Gg
	 tN/9TTNf3Ravw3NCdb1Lx8wunC/a9cT4yThr0n274qkQjzjvBtqVXO/bwzYGWxdp66A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Koach7UQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9332C606A325;
	Thu, 19 Nov 2026 22:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Koach7UQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 488031F000C0;
	Thu, 19 Nov 2026 22:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795126492;
	bh=fd/ERjmKCn8dZN/jdExfBIcTymNZ18o9U5B31DslFGo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=Koach7UQGAulQ95kvVLEeSfmzau4r2VcE8Dec6HBsi8/jxgnidXisM30OjMUB1Qzs
	 Oj4ETeZevHtPwE18NRX3cX0rv+wEOQInBD0rMXNlmDOHhOjsK8i+7+YiQGNy7opRGj
	 QlFiOSY28vJhQTLnbOA6y9uSoKCJjXgiyMSBC5lAtjVBqlah3p9PoSVKxxaqq3IE6z
	 QDimH9LIxvadxHMkJJvWX/sG30aQWKr5ARitGLoIj7+j2ibqaLi+1N8MWhakZzFKPu
	 be/irJBO0RuXM8zgoH7u24JsJOHdJdZQEVbUgwToydMz/PZ5NBXNRYBwBZaL2FC3us
	 SyRe9cJT7WfAQ==
From: Mark Brown <broonie@kernel.org>
To: Li-hao Kuo <lhjeff911@gmail.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Felix Gu <ustc.gu@gmail.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261114-sunplus-reset-cleanup-v1-1-115e32fe8c1a@gmail.com>
References: <20261114-sunplus-reset-cleanup-v1-1-115e32fe8c1a@gmail.com>
Subject: Re: [PATCH] spi: sunplus-sp7021: use
 devm_reset_control_get_exclusive_deasserted()
Message-Id: <179511218138.116416.14285037012749506618.b4-ty@b4>
Date: Thu, 19 Nov 2026 18:16:21 +0000
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1150; i=broonie@kernel.org;
 h=from:subject:message-id; bh=JQrUVJL9mcKkkK/CZRdnGYM23+X1JxrWuUaGEj0Ru4M=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLL+l9xM6wkwCTT5tbDFc0uWIlPMkw4JwaTunqjLTqbO6
 75GKGZ1lLIwiHExyIopssRlcb+sL3m9hu/gwjaYOaxMIEMYuDgFYCIc+Qz/A9a835H072B/zadN
 s88G39k9IeKwjyuHB8teTT2fW6lrdRgZ2jpjNvJfuJCSx7/3roQ+J+/7s8LGcWKntwm//XmM/Yk
 wOwA=
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Sat, 14 Nov 2026 00:47:18 +0800, Felix Gu wrote:
> spi: sunplus-sp7021: use devm_reset_control_get_exclusive_deasserted()

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.5

Thanks!

[1/1] spi: sunplus-sp7021: use devm_reset_control_get_exclusive_deasserted()
      https://git.kernel.org/broonie/spi/c/86478099f8c1

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

