Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B407F3EFD1C;
	Wed, 25 Feb 2026 19:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772046469; cv=none; b=UKfa/a5Mivb8QH9JfXrSPghr41H4Vti6+o+jGbITY5S3Dlu6vXn/5jHf0YK3ZCcwd1d/XRtaNPAY461+YuvVOgqTtC9T3daqGo5kaTpXCYUTjcax/QcDMPCjT6kpR+J/0jMW/cMIT3QNv4XuygOM9yYeRpvrZQBQF8OfP5sCpWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772046469; c=relaxed/simple;
	bh=/fC8mtMNV8v0M5K9EhKSE0JzfsOboD027+MkCKRsFVM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=c/o3gVF2fXQwgpNhf8fus9chn9cYI1RpNys7/8x7yv9G8jG6IcoePCFoOOl5ItIzkUZs3kFpCehb0eIrMfTWyclElH4PN+piHo3bWYNo/x1GqJjO9g7bA2rsYMN2qg3LSUCQqyXhRi5wJJEDzRXgNIHUMJA60vfvkSPunezKG8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D1MYwCei; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D1MYwCei"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36EF8C19421;
	Wed, 25 Feb 2026 19:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772046469;
	bh=/fC8mtMNV8v0M5K9EhKSE0JzfsOboD027+MkCKRsFVM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=D1MYwCeihEtPbugUoN66TcSmkPwEuC13KnKlBhIfCu5HOeOkL7ZIAgzcDz+Kdn0jR
	 17sslS44CPGIb2a4sqcMsZDBnUa0vsZYcdYYptVT0Xz8vSZnnM27Y2IMfEGmA/Bw/c
	 GifLKy37po9Yk/D0JK2HmF3r64o6C0jA+r8eOlCmVdNhymGybK8kGmQR2KKKny8mIt
	 hBZ3Nsa12A8E7aiRiWbm7vcv3dEbQndr25h7ePUbypRszc8OaJGCpLS4resRVhScmQ
	 M3fktNxF+mKN1fSDOOuLa41jNlpOoZfn2FDqyAYzk91YytmmqYxZ7i8npATl4ykvqQ
	 JM87f7eNUZ44Q==
From: Mark Brown <broonie@kernel.org>
To: linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Daniel Mack <daniel@zonque.org>, 
 Haojian Zhuang <haojian.zhuang@gmail.com>, 
 Robert Jarzmik <robert.jarzmik@free.fr>
In-Reply-To: <20260223144437.2836369-1-andriy.shevchenko@linux.intel.com>
References: <20260223144437.2836369-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] spi: pxa2xx: use min() instead of min_t()
Message-Id: <177204646782.169139.4278556764726477870.b4-ty@kernel.org>
Date: Wed, 25 Feb 2026 19:07:47 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-47773

On Mon, 23 Feb 2026 15:44:37 +0100, Andy Shevchenko wrote:
> min_t(int, a, b) casts an 'unsigned long' to 'int'. This might lead
> to the cases when big number is wrongly chosen. On the other hand,
> the SPI transfer speed rate is unsigned and driver uses signed type
> for an unknown reason. Change the type of the SPI transfer speed
> to be unsigned and convert to use min() instead of min_t().
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: pxa2xx: use min() instead of min_t()
      commit: 507a071d9868cb60e4e76f8a06fc8eb014f59ae4

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

