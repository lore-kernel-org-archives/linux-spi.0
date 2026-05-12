Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8C3372075;
	Wed, 13 May 2026 01:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778636364; cv=none; b=qwIqenrKqI0vagsZGqdwi2mswaxnuiNfC2vFT4BbJLn1veb47yt06fTrQlzH0wTYfAYIPSezq5PF5usFvgSvKioM8lxgwkxH7WAWwU3oDdtN63BHyISvan7JKBqBb1fhlgowTzPKZMzMT9LZJsyLHMtQ9lNwTqc+es7oBepWlvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778636364; c=relaxed/simple;
	bh=Yi1M5Ex0PA9TkqF0DhF016umpEhTuOPuAczBQj7ymVg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=nPylkmgqaV4a94DQLgiQbm0rqfBxriAv8Kbw/HCdqiReZbncX14uYMqwIEDCcjLVIHC1blWmteiJ2iOiI2HafNoSiAzcPP/TzU9S9cFy9qiAsvgntzgrSG7ll2k19Str1ePn87eLMy3X3nbyRTiUo+4taoGetmY8NKiXS+iFcyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=huRWBEQH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="huRWBEQH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81683C2BCB0;
	Wed, 13 May 2026 01:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778636364;
	bh=Yi1M5Ex0PA9TkqF0DhF016umpEhTuOPuAczBQj7ymVg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=huRWBEQHdn3q7RVMqb+xKZo6ds+9miTxCMfmFsVFRHIfve4sgZQnrwrgXBemqAOxb
	 5rh/bUESNz+H50sWYAAcXao/UkNFlLvZNjNlAz+lUVmOEmlDQe/CoZrn2UmYJ6WrqU
	 iuhMSuUdEOHAujwTvmpNht9XLHPAhhijnlXhzdjuyq+ENYAgywowB+knug3qfHNoTw
	 wSHLTjxirBKuZ0RwKJMgHZx7a8HEBaaTJGqWB/SXXdLyjR90NduH6zoVWQnBu1dRep
	 mNWtEWij9oGOj9h/mcmLfef1xwijdColqL+yHSXRv2MdH7hXMKdclrDiiV+W2XbFeJ
	 AYigxcJlNDkgQ==
From: Mark Brown <broonie@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Nikita Shubin <nikita.shubin@maquefel.me>
In-Reply-To: <20260512074849.915143-1-johan@kernel.org>
References: <20260512074849.915143-1-johan@kernel.org>
Subject: Re: [PATCH] spi: ep93xx: fix error pointer deref after DMA setup
 failure
Message-Id: <177859015741.1043532.14667164924283837291.b4-ty@b4>
Date: Tue, 12 May 2026 21:49:17 +0900
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1134; i=broonie@kernel.org;
 h=from:subject:message-id; bh=Yi1M5Ex0PA9TkqF0DhF016umpEhTuOPuAczBQj7ymVg=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqA9ZK5xXBdfetY9KDJ0IO6hvd6lGa7sW+6/1sA
 CVbx5vxzx+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCagPWSgAKCRAk1otyXVSH
 0EPsB/9BdkuSSxhLkfuMdy7XWG8+RcBgHhPzdLXGBp1Al925rf2WaPc+PkugmDdUpkxwoZuBRpq
 QTNJTRNDKsskhjzMliEghjV/63ro1IHdzWMQePi/qiYaoal5djVdMRoXtzdHnEdTy8ARRGdWc3u
 1u2HYsDhAgHIKrnnHKtB7og1lpauKw76vcS+E69PnXenPXhELL9yGitgtqM2pJDlV9wMDmx3Ih9
 OpHR9Hk4xjZ0x22NLBUZIXW2BHfZrY9oTWU9lujjXNtt/gb1I+3MSdkSyiVp+0CW2y06+ZemWwZ
 1Y8h7pSFe0VlXztMJY5WBeEs9he96/MGvFbBCYS+th6SFl0s
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Tue, 12 May 2026 09:48:49 +0200, Johan Hovold wrote:
> spi: ep93xx: fix error pointer deref after DMA setup failure

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.1

Thanks!

[1/1] spi: ep93xx: fix error pointer deref after DMA setup failure
      https://git.kernel.org/broonie/spi/c/5e121a81667a

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

