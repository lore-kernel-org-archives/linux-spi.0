Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E2951588E;
	Wed, 30 Sep 2026 16:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790786827; cv=none; b=jFVfLTZA8D2WH81++MEDTkRTZFIwQIHKzpelSbjabchr2Ke+pkgEQqnqq0wCn5A+Y0gU878I1sSCCfpbhoomXDlqrGJ1iNQoPN2rSy69ZDmz4Ml37R1w1+J8/dZdeQv0oGJ/JwasUw5a5+PQftT5VGIAIQTb88awazEMSEkV0J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790786827; c=relaxed/simple;
	bh=DMvz7z/AODsKbzvIxQkpfFFObOl7FJLT2PDw2Kuh8zc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=EJq3KuOAYvoIc41EH0dVUic23yrjoeXbzUza8QfvzJHH8NuBQcAE92HBAQ1ObUZFNeS8heoQYLRwkHNfW3TFf2UJPKqwCWS65Ce8cEmRrc6gfVh8B+YzZppb//Lk9gES20tcagdX00MQm5QOMVrrADmCerYEzqvSu/Xd55tAF40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K2PJIK/E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K2PJIK/E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0D931F00899;
	Wed, 30 Sep 2026 16:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790786825;
	bh=kDczaQbTj7R4ecjz+VJCbU9haOq48yaYR/msBZn6IsI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=K2PJIK/E7UbhSr1KPwCNNV7PhN/uClVgzAdn8b2d87fs5U6mtgZl8qoFaS24XVuQP
	 0Zmj5pQIfNzgR/hF8LG6k6HyzPSWvr3k+RSaFnqsCCy7aHxYvHKd3I/sDzou0Qtlv3
	 m3giQZBeAHXtStTJhEoxQbNu6VD6gbbuFEZtdO5D5nYywpbYXDwz3NWu6IGeUK9rV4
	 lV/p05fIISgJ+yMj7smcPf8aLTfBXGfv8uvMdB4l9fanFKOLzT3dCSqMPmWLFch4DI
	 xyK/gsY69E9HlOx/YRMF2qMesbbMW+UqGcKiI4ZE/hfmhtkhDX6k0t8A3exLEL9KTM
	 zKLl4xcnndymg==
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Frank.Li@oss.nxp.com
Cc: vkoul@kernel.org, imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
In-Reply-To: <20260929190621.3516424-1-Frank.Li@oss.nxp.com>
References: <20260929190621.3516424-1-Frank.Li@oss.nxp.com>
Subject: Re: [PATCH 1/1] spi: ingenic: remove dmaengine_desc_free()
Message-Id: <179072046512.463415.9364914013392491468.b4-ty@b4>
Date: Tue, 29 Sep 2026 23:21:05 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1106; i=broonie@kernel.org;
 h=from:subject:message-id; bh=DMvz7z/AODsKbzvIxQkpfFFObOl7FJLT2PDw2Kuh8zc=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqvT0GLIPwk7W5ZpGQaq03o/qkbCjAJYe7yDdEc
 pxT7L+gjYOJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCar09BgAKCRAk1otyXVSH
 0BntB/42mWRRsNx+N7h/VMeOY0Yl9ZgV0XFsHAEtV5nYVAq3SHWCYbvhmOsx88WNv6RXbkv28SL
 t2JZTcDfUs6nCnYlQSYjvgV8zq6X/lKo2Iebh4NC+OISZjQolcwAxvLHLj3W3TuQuxVvW/TM9+N
 WjeES46tyF/dSdHp0qboG0wI2SdUAcqQjwH/HrOWqcTylaT6iy1C9D0UL3z24CI/xqeuupihwM/
 8ruukgy6S5IzJMDoiJnQmqwVvA8hF2X09F6wio6J5p4HtHzIwtKPqFtlltlxl6sHKFxrgb9EWG4
 QPN8Y0ZLOaitAzwBufu8SlToz5x8la64PqueUx1gra3lv9sL
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Tue, 29 Sep 2026 15:06:20 -0400, Frank.Li@oss.nxp.com wrote:
> spi: ingenic: remove dmaengine_desc_free()

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.4

Thanks!

[1/1] spi: ingenic: remove dmaengine_desc_free()
      https://git.kernel.org/broonie/spi/c/69338914b1d9

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

