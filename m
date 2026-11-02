Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793623392;
	b=N7r2z5nx+glmn1KJl6EFl2nOg34eY1cJJO6SRDA2nwYRrECnx02uiCr1NdZg2VRohngJ
	 eFFvD+csxkBr1ry8DZhFlS+RKWUzi6jNEHP133z/pqmRGGK5hYZg3L18kN0vJifvzlOY1
	 2Wf1ToBcjGCo/iJjBSjYedYfyh4Ab7ZJe0rrugZ0rGmYzCCcdhqRUU0hnIUJvR3Trk+fn
	 VewiGk0BHyXJLcsb2xK55HXsMn2IhWTg2rnjJTeC+cg4VSlVTYrPbzrgHgIqVyOca4Bvv
	 2WrG59W7APAL7TT0nMWrA0Nz9TvQePomADKOqQCtwVBqGMBpInGAfokIGCY1IZA1ANw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793623392;
	h=Received:DKIM-Signature:Received:From:To:Cc:In-Reply-To:References:
	 Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=j26BXKveFLl9OUwlbLdiGVAV/fR5Q6DkHAlgTaWqqYU=;
	b=M3alVrcuiKU6583JoWA7w6Tqal3vbNMkyUlfVBROo9SKNqNSfRZVACo4+FbwxEjDO3R2
	 0dgOTl3GJZfyoRRTmLaX+1bGYSoPC3++QO8ryB5LBDrjPoTO0ghVBe0jXXNFuHVdH9w0q
	 XXFzq6EfwYI8yFX91XuSo1CAeBUDTCxJkC6OOIjeqHJaIEtCG2nSDpRvI4xcLo+/kLQfr
	 d1kDKgk4v+YRWfgJlm5BlsVgBeSjzXaH6jFVVq/T/y5KiUOno3cR2TTP7yHaie31np+hq
	 iCbaK7ca0o52lxToVDed9MfZzwNq3RlSjlZ6w1hj76SOe2B/ciLHzxR4uBtjk8TZpoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Sau4qt9m;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD5660A383C;
	Mon,  2 Nov 2026 12:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Sau4qt9m
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F02341F00A1F;
	Mon,  2 Nov 2026 12:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793623392;
	bh=j26BXKveFLl9OUwlbLdiGVAV/fR5Q6DkHAlgTaWqqYU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=Sau4qt9mup8F5Bg7y+JjMfEQwueiNbEa/Vqtt7l8VOwrKRE1160H42Zjiky0XbMiu
	 ezaw9Yg0nFb42KStTiB9NoSq9wVbeqyg6ir7mEKoaO0U9y3H+ENgAsGB3nKI0bPGwQ
	 wXFGci5cki9tNxFMecV3EPm/r7Zc2P1ORZzmeEkEHkrn/ZMGfdCo+PCbl8uUCNi1lr
	 jCJhnq/wr+RrEVC1nmf+lWY5m23mKTtkVWtlccPhERYwLIyg1XpwHEduii2/L2A0CY
	 kXuN4Q3XHBp5yA718zQXkJRLogpJmvuqpYNLA/wjy3CSIlXCKz4w7B0HqPTcAqSQfa
	 j3QkD0p481I5Q==
Received: from traversing.sirena.org.uk (localhost [IPv6:::1])
	by traversing.sirena.org.uk (Postfix) with ESMTP id 4457C2310570;
	Mon, 02 Nov 2026 12:43:10 +0000 (GMT)
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, Rosen Penev <rosenp@gmail.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20261101200155.15740-1-rosenp@gmail.com>
References: <20261101200155.15740-1-rosenp@gmail.com>
Subject: Re: [PATCH] spi: acpi: only look up the IRQ of confirmed SPI
 devices
Message-Id: <179358129853.1776482.1284866044623503919.b4-ty@b4>
Date: Mon, 02 Nov 2026 01:01:38 +0000
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1125; i=broonie@kernel.org;
 h=from:subject:message-id; bh=ANQCXKl0QJBO8NOTx+xo3WxYg3bnHH/dk6hD6LjVXSg=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLJetMZtbXyyjYErwlTg7sNbEkJWG97OPf9gS6rApYruc
 tEWfl6fjlIWBjEuBlkxRZa4LO6X9SWv1/AdXNgGM4eVCWQIAxenAEzE8j/D/6o7Fb4Z095+vhl+
 y0XRJWfvI48du18v8fkVp7E7tC3p91qG/yWxIhuC1P6cTIhxODZVev0mVQ8T5yX2qrIfubMT13H
 ZMAMA
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Sun, 01 Nov 2026 12:01:55 -0800, Rosen Penev wrote:
> spi: acpi: only look up the IRQ of confirmed SPI devices

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.4

Thanks!

[1/1] spi: acpi: only look up the IRQ of confirmed SPI devices
      https://git.kernel.org/broonie/spi/c/2d0953ab69d3

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

