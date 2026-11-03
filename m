Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793750494;
	b=XJOw3YPneUKduguQ7RhoyPJr4CFEoJDzdB4fV4c8JaLVRxvrucKlUHtqZKhemB6mKhJz
	 qfgczNg4+ppg+8o5Zm0mN4/uFRhq+bEJNWGAmN6KXObcq4e/UAaiXNV2sR8QUGMBiu56o
	 TNVtye6oUTEFvSF45IXi9maW6HA0v1+o/6Bm6IK/UGZ8VUcQhYQ8Ti8o7u9bjnUwF9pbN
	 KhpaioX0R4qiSv9EeCxnQ3H981J4OIEb4rCZROXoXdmsITiyC5s5ThAiDd67ghjnDnPJn
	 J4vvAzIZmYcPcBrgZYlc1AR5ZfwhQsfkgALVnwb5Vh/ZXIGumKZYlIovAZHbSoXET+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793750494;
	h=Received:DKIM-Signature:Received:From:To:Cc:In-Reply-To:References:
	 Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=nc6RxU+OqQopRhiBNovmRAc/YnhfEy+dcErAkMU5NGw=;
	b=nqnm3GsxZmhQmswIopWMF/uprD8aCcE5is8uxoznsIgl+WskNZSHPfA1PjV7fRSSWINU
	 2c3+l+euWmXadVqYiZ0u9uWKWUhwM2vE3ru1RNMsk39aJz+r+ks5ExUEdL6nncr8PwxgZ
	 OQ5/5Zs9RZwEeq57FqK3SvU91VltHDSDwx4N8wh+iwfedK0+zm58evAr1irLSJDnP/mNt
	 U8nL2WkuGQuqPyHyC3k5Wvby7FndyJYnQKuuCbdJno+KpxUSUbX1UWLrBRKADGQfyuSHx
	 5PL/bbRAKr6yVprY4+InWq9vmM2h8gqR/I4lor0mbjLXRdOvnk/BOFgKQtu1vddvwEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gkv6Ozs4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4A4606A324;
	Wed,  4 Nov 2026 00:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gkv6Ozs4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CF611F00919;
	Wed,  4 Nov 2026 00:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793750493;
	bh=nc6RxU+OqQopRhiBNovmRAc/YnhfEy+dcErAkMU5NGw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=Gkv6Ozs4/HpWnMmj1cULtJ0WuT3u3EblpO59FtMKlIzcTmnPybcjz/XkscQlsE/AQ
	 BrszHhwStF8DYU11mQY6E/su8Qt9/o1PbnWyEsCsqscHY8qbpMS5YRws0QSmJB6V0z
	 55cqjhh7RKD7mEDcTuv0MpzDAbs5C6l+O2Z0ENtNdv+6rQKhIClaGuDlbF4jJ/0r57
	 /KtQhJ6pUUbiplg9yeBTBXxpPiouP+BnxNb8HyyL/VhhdfPHdDndc9OYgKXiAjVANj
	 mbOFzIiWGctfunnIMXV6/cM4FjWB/u9qZxFK+t3ujpW97MYVt3L391YpDQ/uadIM48
	 N823wnHHgvCUQ==
Received: from traversing.sirena.org.uk (localhost [IPv6:::1])
	by traversing.sirena.org.uk (Postfix) with ESMTP id 7C94625D848F;
	Wed, 04 Nov 2026 00:01:31 +0000 (GMT)
From: Mark Brown <broonie@kernel.org>
To: Kamlakant Patel <kamlakant.patel@broadcom.com>, 
 Felix Gu <ustc.gu@gmail.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261103-xlp-v1-1-696d0a50b84e@gmail.com>
References: <20261103-xlp-v1-1-696d0a50b84e@gmail.com>
Subject: Re: [PATCH] spi: xlp: reinitialize completion before each transfer
 block
Message-Id: <179373105256.2270148.2745191993512783429.b4-ty@b4>
Date: Tue, 03 Nov 2026 18:37:32 +0000
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1130; i=broonie@kernel.org;
 h=from:subject:message-id; bh=cDr8g/cDhSJy2HNkHEhkfJL7PSqtSdZ9YDQ4vYzcJFs=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLJeld4W+RLw6bFJ0J+k7tw50+8GTFOdsjCriseu4buc+
 v12z4vJHaUsDGJcDLJiiixxWdwv60ter+E7uLANZg4rE8gQBi5OAZjIAQNGhhuHZKY0iS+INL6Z
 c1hQffGknrLCmwEz7JTZ7iYw1/BxKTIyzDmXFtzgbP+XtzeCjS/yo+Fco7uHCncJOM4WXMt2UsS
 cGQA=
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Tue, 03 Nov 2026 20:00:22 +0800, Felix Gu wrote:
> spi: xlp: reinitialize completion before each transfer block

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.5

Thanks!

[1/1] spi: xlp: reinitialize completion before each transfer block
      https://git.kernel.org/broonie/spi/c/bf0507562dd0

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

