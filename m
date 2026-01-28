Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F33610A1E;
	Wed, 28 Jan 2026 15:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769614370; cv=none; b=Yvb/C5dCY615PY2K2/4a3BQlJDE2jTxn4yj3fHSTwGcSQ/zFZx5vJJKSRzm+G6kKYeMg7CTj6p9ZjkHY/+PiMTLe5dehtVBG4/CaQYi7uJCR4G/TJiwy9HO9a6t4Rgor4QYNVrwgnk0ge8hvsZDAlFczoLcQffZOlBajC5Az7+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769614370; c=relaxed/simple;
	bh=TrJryuXI1lB9zPDFLqXIm4OqWxIjImoe8ULljM5HgmE=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Z7nAP6El9nWTJ1u+q4Z0UP4+FlLaisKYXJoRCqzCVXm6NBDPxBGDqH3sWTBymMmOvkda3U0RLfj3fz9rqkEc/djHofPt+kh7uUFmXdb9KYbQQ/dhFT7DNFGWYJGkN4TuPrbtGGHP7U0mxcgIsfmxQauRyNzLUY+bNcgf224YmYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rtwwf/Zz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rtwwf/Zz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31057C4CEF1;
	Wed, 28 Jan 2026 15:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769614370;
	bh=TrJryuXI1lB9zPDFLqXIm4OqWxIjImoe8ULljM5HgmE=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=rtwwf/Zzz6sML5OwYTWT1uD5bo9VL79y+fyFidBC18rDwz511Kq/o0kgcx1mZvi1g
	 orOavGYp0rnr0xmgo86IT2AHqKMnQJFt5EHuA0D2L8U2Sk+RLgcEcZvHZogYDsEuWj
	 b0pVn5AR/YhHM45GAEQhB44XdtW6hwDPoA5AnaZyiL8LhnQxzYdPnwjbE+vfJXT75B
	 0LOdJK82q6uUKRxRjcLWPokjMH6jRlOOYb+fKjtsxEj+pfpLFN56F+UMvCVQJt8fZs
	 sGuKR0Yda5GJZ9DrvDG7F29JOMZMlMvosZiMNJx6MbI6yhmtHEtu1Vc3YtrxT//FNT
	 3LZWMB9mDNB+A==
From: Mark Brown <broonie@kernel.org>
To: =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>, 
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
In-Reply-To: <20260128095748.4156926-1-andriy.shevchenko@linux.intel.com>
References: <20260128095748.4156926-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] spi: dw: Remove duplicate error message
Message-Id: <176961436892.2011543.4042180719051848241.b4-ty@kernel.org>
Date: Wed, 28 Jan 2026 15:32:48 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-47773

On Wed, 28 Jan 2026 10:57:48 +0100, Andy Shevchenko wrote:
> devm_platform_ioremap_resource() prints an error message depending on
> the actual error. The caller doesn't need to repeat that.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: dw: Remove duplicate error message
      commit: 5c6808d10499f6c8a8d5ee948a22fc93814f6d66

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

