Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7882D450415;
	Wed, 14 Oct 2026 10:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791974179; cv=none; b=nj54r1s2Y80sj9g1maAU3aiQlPvBfhU1MO0dgLLq85zyw8OEzLS8gQDCSyGiOhXKpLgtEr/91jTwhrpRxxrcTKEvbOUIZsd9xKURdGcSB0N8YuA3YY1/b5No0lM7bnBaTuNLcJ4Qr2zc1Av72iQrAzrcAKMrHG7NAP2KQWfM5+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791974179; c=relaxed/simple;
	bh=zaQSMUxzF8erB51E9B66BKCDfM8HNwtde8IZGP/vAnA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=sfIDIrcpjDVYvzEd4e1Cn08KJw/xJBHX24aV75rbdrbHz5kR8nwMiCu+9aNAAJQHlML6qJTAMLRiF7dIq9O5aZBnBu8NdnXWPUuptr7LlYIus2Y2ygNOghpDKyRpXSa8iwEOnTr2QROwCqF94XwTBNcCQzj+5+OqMYoi+o0q8Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nLLfULh5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nLLfULh5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88A2E1F000FF;
	Wed, 14 Oct 2026 10:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791974178;
	bh=TXXuj797oe2SL7aI8xCKis3dp6zlE0u01lBVd5p3BeY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=nLLfULh5HXfWA+zpIhC5YkMeZDoSYN3TPLKZJy2Y+OXzEuIpry0v9Sgr5BD1lNwtD
	 X815c/oPNgwaG0Wrrg3xWOGZ064NgNO/s6E+nrV4k4PduHqM60eOFYVgXhk4n8Zwih
	 ZdzLhe6FjW4I/3INDZ4mtHV/YIovE4lwTAEKGzrafhkArWnCuWH3YILXjtxU3/JsPd
	 qEcnjP3TFzGBUMbVdnEfTKAUPGqhrzQj+6nPfmnrgvze3C+AwptnTjJZUOKbu2Xme1
	 leq+MxRs2ONyq8XxiJA1aQe53s8US3r3NGQQqdCM+T0P82An3FCpNe/FzSlOOEXH9H
	 TH4FP4TvtRoIQ==
From: Mark Brown <broonie@kernel.org>
To: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>, 
 Sricharan Ramabadhran <quic_srichara@quicinc.com>, 
 Md Sadre Alam <md.alam@oss.qualcomm.com>, Gabor Juhos <j4g8y7@gmail.com>
Cc: linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org, 
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261005-qpic-snand-skip-bbm-copy-v1-1-04f6aeda4044@gmail.com>
References: <20261005-qpic-snand-skip-bbm-copy-v1-1-04f6aeda4044@gmail.com>
Subject: Re: [PATCH] spi: spi-qpic-snand: skip BBM copy on regular raw
 reads
Message-Id: <179191209569.42298.16799303691069144788.b4-ty@b4>
Date: Tue, 13 Oct 2026 18:21:35 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev

On Mon, 05 Oct 2026 19:18:50 +0200, Gabor Juhos wrote:
> spi: spi-qpic-snand: skip BBM copy on regular raw reads

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.4

Thanks!

[1/1] spi: spi-qpic-snand: skip BBM copy on regular raw reads
      https://git.kernel.org/broonie/misc/c/2da46f1e9b98

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

