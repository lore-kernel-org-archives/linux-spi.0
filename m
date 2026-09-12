Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7E243C04D;
	Mon, 14 Sep 2026 09:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789377874; cv=none; b=YzlRGJYaCF+x6CLoufeT5aNAh4cVLO1WzcMvj20xYYtN8qVTSxJAC3relNlU6yFvuKDqtkxdT/z35qNghn9y+2D+4AXOSzxjfTtn4jLsfmoJJMmsg812J+y5m4fN53ItiiUkUk8w57zQJTzxebUi8wAd3qbq5svSAVy9mXBVHws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789377874; c=relaxed/simple;
	bh=upI04YM/nFp4Ty9Ok70/8xjFi5aTKW4eLBk9YY9t+Tw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=stidBHoBE1YpoEYiEgRkR5iT9+B8F5t3LVSIIbKZlgz9voB7mZwakJKIV6eA4vFyk84Dt4OLt2NF2cknuHeCKsxEOn0+A2kdePMeAP00rdoe8cYhjYbfH5e76v/7GdMv0696awK1s1i9C8/+ZXwuykfbsf/bUlXdcDwpIayQHqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K/SnLnPl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K/SnLnPl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56F571F00893;
	Mon, 14 Sep 2026 09:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789377873;
	bh=J3qR3awHBwMYqsk1omsRAY2JN+eX2oA3RJ3kwPe9a6o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=K/SnLnPllpQg0dbENPOlnhaZbS0MJP/0vC5Sib2oiaS+p42iBeo9W6ViAEUs0gVjB
	 H/kXJOeVgXjv+nJWp4iyFl0RJmVO6bFGsnEQ38mCstWgzFCLJC2TULQ0PwRIl6lcx6
	 Luooenb4BOa2usI45RgmNTmp/nVBMzJrlZmpO5v/u/w60fZuCXV4FEgGC2Yg/2SAxp
	 Uju3W1w62IqowhDQ58yhs9T+bHQg0T5SgAOU9eEnqwoCMxTxpDdlaFXbEBMaJB5/vl
	 np0g7BBEr5MPaAf2GJ9VlijJPWrNlWjm+UMxgWYuN6gmXplBjfUw7ZKEDuvNzbjY+u
	 f0U+REqnp3wZg==
From: Mark Brown <broonie@kernel.org>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>, 
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260911230211.11755-1-kmehltretter@gmail.com>
References: <20260911230211.11755-1-kmehltretter@gmail.com>
Subject: Re: [PATCH] spi: Fix the return value in
 spi_new_ancillary_device() kernel-doc
Message-Id: <178920902888.923363.16271638086720639440.b4-ty@b4>
Date: Sat, 12 Sep 2026 11:30:28 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1150; i=broonie@kernel.org;
 h=from:subject:message-id; bh=upI04YM/nFp4Ty9Ok70/8xjFi5aTKW4eLBk9YY9t+Tw=;
 b=kA0DAAoBJNaLcl1Uh9AByyZiAGqnvU2jpTQHnzoe8ahBFjN9uWq8fk4SzGjQ9U3GPFgium06H
 YkBMwQAAQoAHRYhBK3maKpnVxi1n+Kf6iTWi3JdVIfQBQJqp71NAAoJECTWi3JdVIfQhfAH/jCS
 TWWd+ZK99cmbwOsIDiAplBZygvEXe+C1INXfZqvW81p8yAqF1TOc/HNUvC4xfppYpCXQHggRgb6
 sCcOHUaUxEa+kjl3YXa2dBdpNSw+2G30t8T9k9ne4wzZ3uC625sPikiXQfI1w/7BaHyhd07o9Qz
 88qv06U+XQWri4NLUHJTdP7QkK1asOsB6kXGSBqhB0ESL1UuW9phSsyZIgK8SgkTde2cQLL5iLL
 Wi+NET3YEh1yR45XSC4wEwVjaiV4RetetmI3u/0WBGUuKQ2A5EOgiw2MW2g5sJz1WBb6NgrlV2t
 hYp/TbFiZz3HfCiHLrUGYUaSd3lR4ccJb9tqpVY=
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Sat, 12 Sep 2026 01:02:11 +0200, Karl Mehltretter wrote:
> spi: Fix the return value in spi_new_ancillary_device() kernel-doc

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.4

Thanks!

[1/1] spi: Fix the return value in spi_new_ancillary_device() kernel-doc
      https://git.kernel.org/broonie/spi/c/3742867ce965

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

