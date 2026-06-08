Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D183EFFB9;
	Tue,  9 Jun 2026 08:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780994475; cv=none; b=mFDy3syVf+gQa35uyDBtWkoyxz9p5vndYdvDZmJIf4PXqO7XVwNxdXe3Gun0JkwLTeGuR4JhhPaLrYOMW9/L3ZrC1/unvL0G5LLVRkjTu0pr2ehIks9z9GlGKM/FDauA3OI7RxYG54EUlLKxB77VhYbGeB/uQ8Z0JCW3vXoq8PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780994475; c=relaxed/simple;
	bh=e89iKGdFpZlfQvtUBosD8v3ClPWa5jcZnJU+1Lzxw64=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=nPa7rSKmiM3LuXGHKdD2nQVturCF0pUoXY/kiJ8RaC47pCLmTSzCJh/eW1lHJJ+HNly2xP/1GyFCfu4/3OlW9in9EbLg4p8p2FYhun2mIRjdnFSwCJl90gmyoYHDRYdSl6SmtLKeyhsjzEkCbPK0EUCU3yaHb435dIFAx1bP0rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=go0jcdLi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="go0jcdLi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5D9C1F00893;
	Tue,  9 Jun 2026 08:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780994472;
	bh=MM/XVXUJrsZKSunfb9j4DwvrfYK4gdO3JlzxUNQoAPM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=go0jcdLiVUr7XyWWh0xlReHtThpOjfvzudv6rtSu8w07Dc9/renGjZjT9VfjwkA+S
	 5USxESQzJVzcFgmfb9qEd9h79aK1Z3qYSh0uYdnyA2Teg6+OSwdy8r0g7ex+udLj/r
	 tuo0DZznYQ+nwKaWx3FADdWpmpjHNjwR4Wg4Sqr62XwuFwfa+V1sZUcO/6lPP739qy
	 7mHC4ezpMQu05kg03QZgNYTCjWtBV2lgO66UK/1Ep1VFwLPDwRTKbrQVrR6HjvoUxo
	 WbVElDVi+OPGNlqraYEPoIpyVs4kqR4wkpixOSSuteRr68hk812+547OFapQY3ZpPh
	 4glEi+w2Tehbg==
From: Mark Brown <broonie@kernel.org>
To: Felix Gu <ustc.gu@gmail.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260530-dw-pci-v1-1-5d2cf798b3c3@gmail.com>
References: <20260530-dw-pci-v1-1-5d2cf798b3c3@gmail.com>
Subject: Re: [PATCH] spi: dw-pci: remove redundant pci_free_irq_vectors()
 calls
Message-Id: <178094188449.20828.17810901886783398263.b4-ty@b4>
Date: Mon, 08 Jun 2026 19:04:44 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1126; i=broonie@kernel.org;
 h=from:subject:message-id; bh=e89iKGdFpZlfQvtUBosD8v3ClPWa5jcZnJU+1Lzxw64=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqJ9GmnbTQveszT5dQXmtX56STvML/5Eiyo2/J2
 Vw6T+ASBdmJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaifRpgAKCRAk1otyXVSH
 0PErB/9UXvc/CBRCeiO4m+vFVBrkNuAMGAvcaGA6As6dZmMnf5rNI6DrVbG7AR41i+RVDJOMWqG
 TaTNb43YWB1KLez1s++uaYyFCHfDXw774Bh+3XIglg/WutXYz0ffrn4ZXYU/DKWJ5ik65KnwLjk
 0wRmwW00hplazbpSCWykUjCqWb3k54BacIwraSe9zS5j5dsWTGozBnA5vPOaY8HwydvUg9yvfUO
 SXQvhsldO6LjP6yryPIUBNfB9NNTAWMgV56zGJH1dUV3einYVoprQNCtRvdksRb58j46J7yrNkL
 wTsosJ0v/xYtjhHMmHbKXLtP3STZ2KLWrbhNrqcH2gU8ZTtA
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Sat, 30 May 2026 02:54:31 +0800, Felix Gu wrote:
> spi: dw-pci: remove redundant pci_free_irq_vectors() calls

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.2

Thanks!

[1/1] spi: dw-pci: remove redundant pci_free_irq_vectors() calls
      https://git.kernel.org/broonie/spi/c/af4310929afc

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

