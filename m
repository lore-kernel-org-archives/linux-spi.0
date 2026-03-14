Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772D624BD03;
	Mon, 16 Mar 2026 01:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773625094; cv=none; b=clrnh1oZJYKSJGtUeXHNq7jmoU7NOlsiQYZSRDn1xAYYGgFVEqzVfiRzrr9Ao/pcv3csaT7MySn8NHwCkeqiZD/E6GPfgbPcQUmH0uH+fdxrrF6nld3JkyIYdXgPj13bH2+Gt9Eyd4gNnN5he4hJc4gZ1UG6To90XPrJd7awTrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773625094; c=relaxed/simple;
	bh=gNZVgSqOOK7OrrMph7m08TJdfti5P/J95WLhvjRscdw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=TJb3LFHgNKNv6IVg61MGjpiHrEirQEYJx1RUlsEXJ/v0F9+evfuJs0uMD4J7Gt7yB5seYchrp1fAfDXC04c0Lc+zpxUxBd5XqqPOz9+WU4wQ5xvxOxEOqfi83w4PF9QZUId7fQiLD9iUhzB9+au9J1IrWSweZWDgudhjA/IzH6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WHcjHenp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WHcjHenp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 266BCC2BCAF;
	Mon, 16 Mar 2026 01:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773625094;
	bh=gNZVgSqOOK7OrrMph7m08TJdfti5P/J95WLhvjRscdw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=WHcjHenp8nOdHNKJ1+vy6uGA/bxPYMJ20ey9dyNZFquvl9hnARd9KdFLSfztntkKi
	 BjEAE3EUX2TN6jp6XrYJAhdol4RRH1LQh/zg7JQWNq/K44THuvHp/lWeRzgzmpvPFi
	 AEV4XlP1GU4Sp4s85gTFBtpMwIKpa0KVYFvJnJCTElj1udqVMpfcjiHOtJf/f7RlXg
	 Z8AvTGaO4iwbZwy75ZhdIRDRmvLIJN5IjJJv7Wc7k60BuQw9JbxxeJ/mUPP7At0tKk
	 e9NPBNYcFtwpbyQ92qvF/qvq8K9z2GOcYtcocEHr0FSe0bBNyqAP2dAJU8wLZD+ykK
	 57gTNHuoBH5OQ==
From: Mark Brown <broonie@kernel.org>
To: Thierry Reding <thierry.reding@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Sowjanya Komatineni <skomatineni@nvidia.com>, 
 Laxman Dewangan <ldewangan@nvidia.com>, Vishwaroop A <va@nvidia.com>, 
 Felix Gu <ustc.gu@gmail.com>
Cc: linux-tegra@vger.kernel.org, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260307-quad-v1-1-f103515db501@gmail.com>
References: <20260307-quad-v1-1-f103515db501@gmail.com>
Subject: Re: [PATCH] spi: tegra210-quad: Remove redundant
 pm_runtime_mark_last_busy() calls
Message-Id: <177352553778.149922.14349765844535159648.b4-ty@kernel.org>
Date: Sat, 14 Mar 2026 21:58:57 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-5154a
X-Developer-Signature: v=1; a=openpgp-sha256; l=1151; i=broonie@kernel.org;
 h=from:subject:message-id; bh=gNZVgSqOOK7OrrMph7m08TJdfti5P/J95WLhvjRscdw=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBpt18DZHHfbmhc+VGmZ65ZSaLmg6nxJATlYpEs2
 sfZHnq/25OJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCabdfAwAKCRAk1otyXVSH
 0DnZB/9w4yYLrJucXLZITTiD/ZwXvdnb6+TjWQWImseY1AmuRGrSjR6hPQG+R9g/CRVX+3aKC22
 f/BpQrUCpySf4XXKBDDARY95UxU28Z1+X7p7eocRuttObVSkZZjaWOWHaJYhaE+sDhx26QhufxF
 UcgCE/trpnuh1QM6BK3E+oVwSLDqRaF+GZ27BoVHOb6d7WYAlqvSSGQ+2BekO+Sv23eqxZG86bW
 igoKHEBmmZfY4Hl1csgtQL4xqIiV4BHZCwgXo+cNc7Sc0qL2fuR/9YWWdvHbW4d2wCKZpYm+dzk
 F+tEPCeT9gEbCT9umWZVsN+kjAyJb9HxSegHW7ry9ogrWKxh
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Sat, 07 Mar 2026 15:24:45 +0800, Felix Gu wrote:
> spi: tegra210-quad: Remove redundant pm_runtime_mark_last_busy() calls

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.1

Thanks!

[1/1] spi: tegra210-quad: Remove redundant pm_runtime_mark_last_busy() calls
      https://git.kernel.org/broonie/misc/c/d1008a8e29b0

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

