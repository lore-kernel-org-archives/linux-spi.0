Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794865493;
	b=Imz1XsUcQ577I1QAOD88/XoQEK1UdknBnlo8RDmUMo7hmYMRi9S3M3gfxnsdRJV83jui
	 VOqQT0hDUAFgx2eYDi0U6cAjujxBG3TAdC4BG5G/Ql4saW7Ho0LwVrD2hTbZL2z7gKYDz
	 G2llGPaXMB7mEpucl5YgtnUr0NN60sjGQ+QgX746qKUAVenfOgwryk0tl2tXMRLv9IDA0
	 B49YK5sBrGjlMgRbNgOXZc9dbDMIGy5Y7gYYUx6/EPfcLnPkVQFMb5pBsv79RWbunk9Vl
	 iauEWtgeAkQqWibi913d+akPWJGQyvzkyNyC+yjR9zqF/SsEFBnouFMgjyk9vzJku3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794865493;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=X9ggcrO9pm/AsFhu0meZ8kZqS0sTe70HGRP1g9VxRZQ=;
	b=CKNpGv/aHQIrh1Oe8gR8P/r3MWXV8N6Y3dwpJy+7XR59HeLfhe0oHHmiI8qtz3Ij96GS
	 RtwjlakPcNEViSI4x1cURrJjFhXefeyIJqU95HZUhvOnzckYL3FZu6fxUtFU+aDeUj3Rg
	 h5DpdB/6d+AprsiNMVelelyYu81jQ/CvMh0zG/FhvOdnNg4a6yykjZ9IOgAG1sVujG4j7
	 K8RDQuP4VNc4NBNISW9u4ww+6UA95QgZm0wMfbq1apzSuv0pex/5q1LKPU8byuEepfoL0
	 ve9L5pbml23OBL7gCv83wD/YVBMVf7msG0VKNThEZSiML87Vtyjx57Serwerg9TNQ/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="a0/+V6kL";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C55606A31C;
	Mon, 16 Nov 2026 21:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a0/+V6kL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32DB21F000C8;
	Mon, 16 Nov 2026 21:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794865493;
	bh=X9ggcrO9pm/AsFhu0meZ8kZqS0sTe70HGRP1g9VxRZQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=a0/+V6kLr4rVqNHdDK6FSHYg1ylY1CFq/y2UlYzAmPzqsK9zT1mZ5z0YusfG2rFRq
	 ELwQZq1/BBm7xoCH3Tij5Azakx3H9SU1xp6TzmYBu7m5J6mov++l35YmLBdGrYR+xc
	 ufzV0gt3RzeyI7eGW88B+J8WBcDwj3+J8E8MGM7/hJSMUNm9/ZSiLNmNQ/FDaxye5q
	 Uu7WSudt/I1FE9Ik7UV6nJPYmudEasI6qOn9psRTQrHr+92Uj63PiGQCyqZAHwakwU
	 9pTZfUD1Kq9C6LeMs6j4C5mQBdO2CBgmnBwvvc1QC4IWC6XebwebFlB3aeP5tnRneD
	 2jvpZAARxPLLA==
From: Mark Brown <broonie@kernel.org>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michael Drobot <michael.drobot@garmin.com>
In-Reply-To: <20261107070718.17395-1-jszhang@kernel.org>
References: <20261107070718.17395-1-jszhang@kernel.org>
Subject: Re: [PATCH] spi: dw: configure CPOL/CPHA for each message before
 sending
Message-Id: <179486274504.2504946.9443490646191062381.b4-ty@b4>
Date: Mon, 16 Nov 2026 20:59:05 +0000
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1135; i=broonie@kernel.org;
 h=from:subject:message-id; bh=WCNcMBaAk508KRcgXl7+/hPwqGbhcsYAB4LtsUTHqXY=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLJ+VwZ+0AtTa9xQxrVfjMviw2+3W97zXmTKJspleKg0l
 UinzL3RUcrCIMbFICumyBKXxf2yvuT1Gr6DC9tg5rAygQxh4OIUgIlEr2H4K5H20TQy5KZ0/I/s
 55fXTddLef72q4Rc+8n7zyN2fN5RsoLhf6XODEkTD815YndDNKtv2kuLHs2SXKiaemVpzO+3TNN
 C+QA=
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Sat, 07 Nov 2026 15:07:18 +0800, Jisheng Zhang wrote:
> spi: dw: configure CPOL/CPHA for each message before sending

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.5

Thanks!

[1/1] spi: dw: configure CPOL/CPHA for each message before sending
      https://git.kernel.org/broonie/spi/c/0877b0b54a4c

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

