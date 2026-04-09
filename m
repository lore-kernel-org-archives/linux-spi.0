Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1D839525E;
	Thu,  9 Apr 2026 22:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775774166; cv=none; b=W6/N23AZ6B3tXGwHEZIcxj6BYmyIyGmg5yuFc3mxXQlNFkeyj8ZBGsXiOFLYM6dXHM1CqYIQJSmWTlInYT1pKu7ns8HnQNxHhDUPBh/+YX/gxhU5aDf/QbhxEQ8SZFsP6qtE4cVYnuBnFcWwXamYElABrUiVlf3wzXmYkwL9poM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775774166; c=relaxed/simple;
	bh=7KDt2OTJOjIV4P7r4uTqxHHU3n7htBGXxDjQtzg38qQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=eRNj+N3qfxNeC/CdeTnfF79m3ydI5TD51ApqVjrOye3K/QRz163gcoisPADH3/NA5cTLIqyUR/wWnl3pum+L+cNNkTKJS6pqo23FOCBZIDSCWIstmlAfV/nCLXEjKaAM6LmKXyuA00Jxgjk4i1fbWKMyBavCCvgFkS8YlU8JG8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IzBElgKx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IzBElgKx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7FADC2BC87;
	Thu,  9 Apr 2026 22:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775774166;
	bh=7KDt2OTJOjIV4P7r4uTqxHHU3n7htBGXxDjQtzg38qQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=IzBElgKxsTa4Cc/fgKaT6D/XuyYCj9X1GpaLYD7JQUQ7qDhGWZ7NDy1m4PuBsO4sC
	 uWpTSpwEfv5EEtY9FzunO1MxU/0ErJGNjVucDTfGXOoZSycmAoc/IqA6WwU+ph5rUw
	 F+jYS1uLurQwOGYEtfVVQeWNe2l8yXqySO5no/m51+ge6BOfE6qd9F236SQ8ObYjDG
	 CdVtDi1c4PnnbfpCj3chlTB4BXy9VauDrR3kjZM2w8Z8GfVrfsA4yXrso6FhutYBGj
	 BwIeo9Uo7bmZ2Sswowua5oCgIxAyDclwBVVmVc3m3YJVe8ZVlZlU5+oThVSpiox/hw
	 W9zvZRq8xW0fQ==
From: Mark Brown <broonie@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Avi Fishman <avifishman70@gmail.com>, Tomer Maimon <tmaimon77@gmail.com>, 
 Tali Perry <tali.perry1@gmail.com>, Patrick Venture <venture@google.com>, 
 Nancy Yuen <yuenn@google.com>, Benjamin Fair <benjaminfair@google.com>, 
 openbmc@lists.ozlabs.org, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260409120810.388909-1-johan@kernel.org>
References: <20260409120810.388909-1-johan@kernel.org>
Subject: Re: [PATCH] spi: npcm-fiu: drop unused remove callback
Message-Id: <177576071181.997653.2589855752498069240.b4-ty@b4>
Date: Thu, 09 Apr 2026 19:51:51 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1098; i=broonie@kernel.org;
 h=from:subject:message-id; bh=7KDt2OTJOjIV4P7r4uTqxHHU3n7htBGXxDjQtzg38qQ=;
 b=kA0DAAoBJNaLcl1Uh9AByyZiAGnYKdGgfRtH9SuJtAbdlvZGFvEW8RJjao2uR5nnO2sKsQ3nx
 okBMwQAAQoAHRYhBK3maKpnVxi1n+Kf6iTWi3JdVIfQBQJp2CnRAAoJECTWi3JdVIfQ8GUH/R+m
 kkhWHVydtgAvdA80HGPKy2KJsnr9kerD+WhO8KsuZkDS01kQ9sm4mMeWlvrVumxzCyz0ihIcTd9
 O5tgNL7CYtS4iFj/eG4uNvHbP0I10l1UwYjWzCsUwuI5gK/zS2J4pBse964rvbRyUznvr8/WIpr
 Av+Jobep/14tEnHsW0VOluqjBv/YQMxsg9QmoYuMw4bdROjAS4ycisSoF3yl6quJZmUxBX6Kqcz
 TKw4Ub+yRof/U7nLZeOSIzjj02KNBsknuGMPHqdwkhCih7Rqcpe+CJ2qmYLT9NkSxa1txRfKClu
 HxIDuyG3sRpZe7GmAwtM/xgDUWDgVQyY++VnHiI=
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Thu, 09 Apr 2026 14:08:10 +0200, Johan Hovold wrote:
> spi: npcm-fiu: drop unused remove callback

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.1

Thanks!

[1/1] spi: npcm-fiu: drop unused remove callback
      https://git.kernel.org/broonie/spi/c/48c0d3c6a4a2

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

