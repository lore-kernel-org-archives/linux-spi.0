Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27FBE4825CD;
	Mon,  5 Oct 2026 13:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791206091; cv=none; b=hJ0NesKE0k5IQ7tJkMEefhxARhsFwSXAjIRa1uzRZrWqXfJzPvopA4Kvge+ZhRSHgLWPgX1IYtN0mkuzAT/f01rS05nCdvjLpunHeRNT4GLRrMyL88VoudCUdOeVtSHpbOdfbSfq0VBB9lZlQpGUw2qJIsFcat1qCYVVXDN2rrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791206091; c=relaxed/simple;
	bh=c3W0MtA/up0SF1z54fsxCnhLZJH3fgMdhotoyG2wMMU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=YPeygghya4w0QfxMkGOQUkE9J2ivAqGBiiG491Tafm1ie9UWC1PFpBWIWPoQEWKxq7eB7ol8yogzAwV1aRQaYR7civQJspabXZkr9nj2tVX0MRNXknGdKXi8rKYJA/vEENsEhMyDusISESOb7cLNHZVnyawWM5APv0sdKFcwPxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=boaxELM5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="boaxELM5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0DF81F000FF;
	Mon,  5 Oct 2026 13:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791206089;
	bh=hpSLT2lSrMjS4/nGQtH75GJ4kKaVq8BW7kPNmkIy6Do=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=boaxELM5M33wQiy9MeUeyqB4u47btEKyfc8fvzYNQXp/wZMGAtoUJrn882/TkBady
	 OzJ9RBIkOi1UoXKgdS1ljas6O0UKZd9Zd1t7sSqC/JWg7KJQ5wKMzke9eg3v0VIosV
	 RC4KOEwE4EYaMKebV07vIUFU6gs4nHd0rqX6bziX0/EIegVqYQJ5Y/iwF85+E0BIlM
	 44W1QBfxCs5pxmYrEhPT1aYVChmjeJunLxXLon/f1WWpCMrQbnMW8a9iUeMU6kTpyt
	 aU6wDAtL+lmOqzfGZaQTNIQAMlmHRQaYYkjsYcSoXGo2i/a62m8rMWze3Xzueuiwt5
	 YAS7PI3WganOA==
From: Mark Brown <broonie@kernel.org>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 Chi-Wen Weng <cwweng.linux@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 cwweng@nuvoton.com
In-Reply-To: <20261001131818.110028-1-cwweng.linux@gmail.com>
References: <20261001131818.110028-1-cwweng.linux@gmail.com>
Subject: Re: [PATCH v2 0/3] spi: Add Nuvoton MA35D1 SPI controller support
Message-Id: <179113436271.150114.13644699403660836731.b4-ty@b4>
Date: Sun, 04 Oct 2026 19:19:22 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1505; i=broonie@kernel.org;
 h=from:subject:message-id; bh=c3W0MtA/up0SF1z54fsxCnhLZJH3fgMdhotoyG2wMMU=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqw6LEaotzfh7FggJqLqVaFGNDZlmO8pDGEFZ8J
 n10psG9K32JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCasOixAAKCRAk1otyXVSH
 0IGkB/9HT8jswSIUFZFJ6w20SnmIJQ6qo4wJjs4mluglo82p0SrulzpmulGBZ4OfvATp3H+9TnZ
 pDpnHO1NrCi+YKkOysf0KrKOJAGyHz0Lewdk7S9neoYkcF0H/0q9aD4ZmZlLsYq2ad3OMXHpSR9
 sCpaWd8pawiZGX/CaaQvvGla3XGjsXKeFzpNB+xg19vbjH6brcfSfZffUa0ZKIbprCLh0wQUnwN
 AohSBpe/hsZSVNPw5FwaFsF0Lrtu3hCUBbK0/Ba0my3KpIpItSqnDkiU0RPlpu0wXw/wDDOA4iA
 eyW3L8RNjT3z6ERj/kzqy8mqMtwIN/EIYozXMFKOANBPKDcY
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Thu, 01 Oct 2026 21:18:15 +0800, Chi-Wen Weng wrote:
> spi: Add Nuvoton MA35D1 SPI controller support
> 
> From: Chi-Wen Weng <cwweng@nuvoton.com>
> 
> This series adds support for the SPI controller found on the Nuvoton
> MA35D1 SoC.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.4

Thanks!

[1/3] spi: dt-bindings: nuvoton,ma35d1-qspi: Add MA35D1 SPI controller
      https://git.kernel.org/broonie/spi/c/1cdbe8d7c228
[2/3] spi: ma35d1: Add Nuvoton MA35D1 SPI controller support
      https://git.kernel.org/broonie/spi/c/dd3fb3b25952
[3/3] spi: ma35d1-qspi: Add GPIO chip select support
      https://git.kernel.org/broonie/spi/c/8767f4599551

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

