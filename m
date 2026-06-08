Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE33A3F0749;
	Tue,  9 Jun 2026 08:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780994471; cv=none; b=k3hOTBLdGn0eSkPaXho2kbqcWDrtsKXbth+ndzaPDDI9NuPzOxxRgV0mEkkwJ9cH3Cwh2wMzYC3ZN8Nr22epGNeWMvAQEFcDveKIySV8RWSjvXagSUqZczYLzdh4tXItLRJaQXz6StUiz3hcmhyQGpd5F8XxarzUWWX3YOXGImE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780994471; c=relaxed/simple;
	bh=4bkcYxtn5EKh19OGIfPPH7CvDuki8qpiINJix59ynmg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=sXKDvsD89soPYxrikLc0vC2pX8exEr8ZqDV1rN7ZwTpGybDy/XJ3CPsi2J1Ux+92wNPY/oFt3vrjkH7IFE9H5kcunSdDEeS8q3rScOooqIiVgAuXE4yWBnJtc0sFQ7JIp+zbRuUqHE+PyejgWyeSUV4ic6w8nzPHchcWqhNm37Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=odWC+9rJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="odWC+9rJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D16501F00893;
	Tue,  9 Jun 2026 08:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780994468;
	bh=U/jMoOACJ2lZXjL3ah2VY5kCPgLVSlZIr5yP1Om6eSQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=odWC+9rJl5FiLiXn6TbsaEpXYuzkV5X9z1EVEz1JqXUJhuk0NSRRqYDJV1nh4TjtP
	 yjSE0nN5lLqzuaZRPZrfUhQ9ZbIWb8dPvc9k56FagUDdMarWsRJNLsgK11bD90t5VQ
	 g6cEzmdTcMK/qP5a1b4kD3A1+fxkTw5LyYSyiCx9/4mXnNT6aHnkqUduklXLT6bIu2
	 rNsoe5qfkQkAmbm9qB2jaaO7gx+AIlE7vTERs7aiQWM6p9qdrmj5EKQ3CulaKZlIHC
	 KsvUwDfIRO1lilwgJBPcmbajbNs6RB7sNZjjgSJPV928R14ztBAwT8ri5yK9gnFk3S
	 XbICs+C0qYNmQ==
From: Mark Brown <broonie@kernel.org>
To: H Hartley Sweeten <hsweeten@visionengravers.com>, 
 Grant Likely <grant.likely@secretlab.ca>, Vinod Koul <vkoul@kernel.org>, 
 Mika Westerberg <mika.westerberg@iki.fi>, Felix Gu <ustc.gu@gmail.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260529-ep93xx-v1-1-9185070ca1fc@gmail.com>
References: <20260529-ep93xx-v1-1-9185070ca1fc@gmail.com>
Subject: Re: [PATCH] spi: ep93xx: fix double-free of zeropage on DMA setup
 failure
Message-Id: <178094183343.20828.16263348776829440165.b4-ty@b4>
Date: Mon, 08 Jun 2026 19:03:53 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1132; i=broonie@kernel.org;
 h=from:subject:message-id; bh=4bkcYxtn5EKh19OGIfPPH7CvDuki8qpiINJix59ynmg=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqJ9Gh/RdJWSSVlXhThOdbJ4zEVt3goV94BMsMz
 EsmLddQHq6JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaifRoQAKCRAk1otyXVSH
 0DLHB/0bCyEE4MZauomFqtP5WF3wqcsEbfCHeOhXIfAgdcAL/shuP4JnvRyYzwLsGW+Jtuk6DK5
 vU7zisERH+2lPWz1+dCzZv5+/97r0zRO0tPhD3XUHOmwpUzmznxj1zNnAfl9m94eTI9fcWfRUcK
 +/YtAwamW6NcC7OkkxTsM8LvMBg+ny8wAZNqTkXr1S1bsd7z8vpHBAkEV4wiTGohlHyLZtmb17N
 ugW+C/PsYgngiRviklUSEWTd3MlHwZUo24FkU2gutGaEzr+6KresyXEAK5/hBOYh50ywhUqIfTc
 4oKwFNFrES0aSLdDGP/0VAx9dBOqQD1kONjwkfVha6SYQDdH
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Fri, 29 May 2026 23:31:06 +0800, Felix Gu wrote:
> spi: ep93xx: fix double-free of zeropage on DMA setup failure

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.2

Thanks!

[1/1] spi: ep93xx: fix double-free of zeropage on DMA setup failure
      https://git.kernel.org/broonie/spi/c/7886054b06f7

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

