Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA14E312836;
	Thu, 15 Oct 2026 14:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792075987; cv=none; b=STkRWc6THcHurZoX1v99QQ3MvdM1P4niltanZe1Tzbs8VVFVZVbeuZ2IlmNUx3JdBV2E8xFQi5e6e968YFeELcw+JIHhFabwLppsd6YwDoH3aL9SOVhLqdByCfzLKye/aXbQZOqfGIqDWs7pRDWt88c3t3SayyjJvcHajdr/bqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792075987; c=relaxed/simple;
	bh=35mXqBcuE5GomJwmzKoRWgHZFcoCWDqyJw5PKYOby4g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=GPE9Rm7A0ksY16dEjhik3uRZO0g9Bw7plfOGcyT2YAjexscrXsEj+e9RsiPvAL+jjCsjJ4rASZuqbfOb+5IeKbc6oxRBsLfheWHIRp1XC6pMwfjhTmyrK9IuttnBORmDHW27WU3hDoP7d/QQWyuWlaW/K+PIR0qYLundgC8yQeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kWKRi3m1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kWKRi3m1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FA3B1F000C6;
	Thu, 15 Oct 2026 14:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792075986;
	bh=BFMsNwhl5g/LXITxR1CeDhEUZkJmgOtKJDrUg0J8/Xo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=kWKRi3m1m+xol4xdFKFSe8vOAFiQEU3yLTY1rco2Gl9CGDOIB/Qh+/RhU5/6Qj406
	 qAVzaDuXPU6hMSp/Ac77Xx77dUReQSDb4Ycnivas7XByaA6iukpG2G4ZBA35crjcQc
	 bDHtgg57z3/I9oX9J4V8RPC153yh+aXI0aT20CO7xk3bToIWD/bQyumhBiLmQaCHQH
	 zav0oilz83Putf6XuH6ffAIriOu8l9lSmtLtGglhdYlgiKPv1I5lGy8KW4uCQQI5Kn
	 VJZVAaz5s17YuCW4TbyD85A3l+y6JOXbHtJt3WivNtsFBKCI7Do4YxLB7vdWg0D53m
	 TZEFFpM5kh/sw==
From: Mark Brown <broonie@kernel.org>
To: Sahaj Chaudhari <sahaj123.sc@gmail.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Linus Walleij <linusw@kernel.org>, Grant Likely <grant.likely@secretlab.ca>, 
 Russell King <linux@armlinux.org.uk>
In-Reply-To: <20261015064341.1100422-1-sahaj123.sc@gmail.com>
References: <20261015064341.1100422-1-sahaj123.sc@gmail.com>
Subject: Re: [PATCH v3] spi: omap2-mcspi: handle DMA setup failures
Message-Id: <179206934638.134795.11861483536300675539.b4-ty@b4>
Date: Thu, 15 Oct 2026 14:02:26 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1103; i=broonie@kernel.org;
 h=from:subject:message-id; bh=35mXqBcuE5GomJwmzKoRWgHZFcoCWDqyJw5PKYOby4g=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLIuvDjv35ljfSv1wZ+CpQICvMtMfBz3nbkXb2mg5R675
 qjq67sfOkpZGMS4GGTFFFnisrhf1pe8XsN3cGEbzBxWJpAhDFycAjCRV4WMDH8ZxUq/mblqbmRR
 s7x47zDXw6/bujKamRL5r1twns8u1WX4nzj7K58U42IZzf9cbeuvyv9/7XXM77os45GgZ6Jv0/x
 kOQE=
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Thu, 15 Oct 2026 12:13:41 +0530, Sahaj Chaudhari wrote:
> spi: omap2-mcspi: handle DMA setup failures

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.4

Thanks!

[1/1] spi: omap2-mcspi: handle DMA setup failures
      https://git.kernel.org/broonie/spi/c/c126e07bde21

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

