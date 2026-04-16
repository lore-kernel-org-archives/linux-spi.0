Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD311F1513;
	Thu, 16 Apr 2026 18:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776364947; cv=none; b=tuDxJvlyLAYRhvGBkSg/S1cArn0DiFCjDciHj572GwvUsbF4xB+fgZRVhIt6tCM/fBFDGxdvf6ZZG5ksK8kUJHcewpg+KHr0aFlmyFLWLLnd5hbY2USZV3AV1ffEBYgNUlEOnKwhP7yC/pXX0E2nch5ykvzJ7ErtxuClLoRFxQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776364947; c=relaxed/simple;
	bh=yfEjS2tQKHrgFQdsO93bwP/sogr9z5pxAeerSgqXaeo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ZrsAfb53FVWYuBaD299h5i0q+qN1jAQVUZddTGmwzE+RFMZBjy0njAVbqJO1ddg9uzQFqymgtWhsh0bMfgxeFAZSyqWgPOp4OXaPeLOJG7VYVJs5JsE+DF5vvAdRFrpVi4qvqFMJ3afp/8ZdbU/HYMO6vOQABJGrXe4kXmGGYis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UaCwEXbc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UaCwEXbc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DDA5C2BCAF;
	Thu, 16 Apr 2026 18:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776364947;
	bh=yfEjS2tQKHrgFQdsO93bwP/sogr9z5pxAeerSgqXaeo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=UaCwEXbcE7mQ7sQWF4XU3FHmjZORD/AjsbBMEuZ3cHjkvqB2ItxQVo7hHIi5Znj01
	 Lxe2wzD6jRhpcyWL2pNRzjJJmxzVzZigii0Ylz5CUMTGqnBRk8mPBs8uoeis/htso/
	 gJ27yF+9vp7kuJHGQ7YkRTioXaSFK7unrVvHzp7QINAta9naysBLo1zw7beG2TQUzM
	 gsssVGCPwsfx4Jt+mvi10Zff/38NXANe5fEPHBq04YGZ0CaOykT6he4BTIs2oFe28y
	 cDsEbXQDXUjLf4g08Nz+ACVHCXBXOR0LsjXXRgSpuWLZHKIEsLnDq44BgLvQ6t+FGX
	 fZG9cvnhxWSKA==
From: Mark Brown <broonie@kernel.org>
To: linux-kernel@vger.kernel.org, Raju Rangoju <Raju.Rangoju@amd.com>
Cc: linux-spi@vger.kernel.org, Krishnamoorthi M <krishnamoorthi.m@amd.com>
In-Reply-To: <20260406091042.4065767-1-Raju.Rangoju@amd.com>
References: <20260406091042.4065767-1-Raju.Rangoju@amd.com>
Subject: Re: [PATCH] MAINTAINERS: Update AMD SPI driver maintainers
Message-Id: <177636493309.43536.4669595840791487825.b4-ty@b4>
Date: Thu, 16 Apr 2026 19:42:13 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1106; i=broonie@kernel.org;
 h=from:subject:message-id; bh=yfEjS2tQKHrgFQdsO93bwP/sogr9z5pxAeerSgqXaeo=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBp4S2RTfwSxwCnZA4NWW4fG3PgBO56hMspOZG1k
 yZZKyaRwESJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaeEtkQAKCRAk1otyXVSH
 0D/wB/94JFsQO10FWZOL9Hp7uW5mktw6X3qxxatf6OqBZTIrBE4SqPGQ2kTG2twS0ba7AqVMBvv
 ESaAK3hKCMuNepQFxQDf6gP5HyVWOnUV5gH31MlrRBCEzvcFBuJae5Du7iQElEzxnxzWGvkTc6T
 zIXJog99P4pqr8F4mMXc9Twvq7Ryg9+JqRSwy+fC6bdOagRU3rI1XBmp1BD0f3T4cCh6cctQDaJ
 OC4rC5hreHw0MAkILDdLarz2tQCYU2vIpBoUPn7VfgAhv/t2PyQ0izZW1loUojTJ0IAJV4gKrNA
 64QKlaVjMOtr9DFssS+e8kVsVTxTz2Wy2cpxRyOaRjS2Hzjs
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Mon, 06 Apr 2026 14:40:42 +0530, Raju Rangoju wrote:
> MAINTAINERS: Update AMD SPI driver maintainers

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.0

Thanks!

[1/1] MAINTAINERS: Update AMD SPI driver maintainers
      https://git.kernel.org/broonie/spi/c/705355a82b8e

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

