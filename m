Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C368D24A06D;
	Tue, 24 Mar 2026 00:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774311098; cv=none; b=tMDP69ZGwrDXrdDH1TCWGijo6SgE4gn3TKKC9zpAmeAN/xN3Be2MtshtpZaj+7kwwnCx0jV5ZapAW7tbENeRcmfQUPuvuAcKc/y7/F/Xu87/ROzRBqearU63nfP2N+G0erpprKf6s69A8tUHB62v9B7CSSGdHAedL4JGRC76CM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774311098; c=relaxed/simple;
	bh=ryBijkDd13QBiDROnPCxr6GvGdBr/SHFXm5n8r764HM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=DSTZHm5dZHlE5YLS9vQBI7pAgHx+0H2msZScJyNl4XNjNgEE+b9b1r6Y8Ti9AQT0jpThMBzLFVeOW61tVdMeoflQOWkwPu5LEWxacbjjuRuCxHMP1nl7z4rGa0rTY9aIb0P2cj3QT+PnNXFWTfAn14PkZCUPbIWa6b+xz8J9XUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=irz0hmPi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="irz0hmPi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9C22C2BCB0;
	Tue, 24 Mar 2026 00:11:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774311098;
	bh=ryBijkDd13QBiDROnPCxr6GvGdBr/SHFXm5n8r764HM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=irz0hmPiYBnKP8ZiCmAmzt4S0mcIfNTgue7BR71W5mdZTzAIfvxD+JOAABnVUmdcp
	 HpOIm+y4HAnRSvppL7fkXQX+RBlPOJo9OGp7pObQkWDKtQkNHrlzk/XRoiVYMtKphG
	 9arRJ3po0Q157PyVe7/hnhbmLjpYTpe2yvq9VpReytWayCBYTUKw4cF6bUkfopCQI3
	 s95q5kcWinj6R6SFOqaVrUHRvHzJ63PR7OC1qsx71XWpOb03dQii7dvE8e6bbkTwRB
	 oX0eajliphajTzsgVZZu9muts3FTzbtiAXTC7sWdYHflqzcer+RChYEj9xVdUk1uMT
	 QCDI/r7AX3ygw==
From: Mark Brown <broonie@kernel.org>
To: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, 
 Felix Gu <ustc.gu@gmail.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260319-sn-f-v1-0-33a6738d2da8@gmail.com>
References: <20260319-sn-f-v1-0-33a6738d2da8@gmail.com>
Subject: Re: [PATCH 0/2] spi: sn-f-ospi: two small fixes
Message-Id: <177427755676.99914.12555228929862500843.b4-ty@b4>
Date: Mon, 23 Mar 2026 14:52:36 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev-17187
X-Developer-Signature: v=1; a=openpgp-sha256; l=1211; i=broonie@kernel.org;
 h=from:subject:message-id; bh=ryBijkDd13QBiDROnPCxr6GvGdBr/SHFXm5n8r764HM=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBpwda4F/6MP0J+7z9RO9jqAkmKw41hbCeSJa0x7
 wogGtUCMxuJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCacHWuAAKCRAk1otyXVSH
 0NfeB/0TnxrOnmIVRfTMjP4Vgv1zrTLnJt06J2yzAII40T87kMuLx1MWHvtD0PPa1q1LdrvRF2W
 rzGXWOFN5W8rn3kJfOVI06Qt3a/DM65GEnliWUHVc0FzjuhEk7kFoLJnqjMIyxPijbXWKiv6mid
 Rk7pB5abmzc7xvGzpy/rAlZeVNoG+9r8BcC2Wy6mzBJdSAxn9EH+n2r/RiouuB/Qxgp4HifezUx
 x7k3XbynNpbcgeUihFDt+NSmGuLxJD/bfGXLKCb+0P/7KqD+IWkfaomXBowR5oWF7ea+QNPPHxy
 PdRKI39pd+wKrKQ8eUX2XEAIbUcvIM7EAtoI5LgqSayj9eLO
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Thu, 19 Mar 2026 00:12:33 +0800, Felix Gu wrote:
> spi: sn-f-ospi: two small fixes

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.0

Thanks!

[1/2] spi: sn-f-ospi: Fix resource leak in f_ospi_probe()
      https://git.kernel.org/broonie/spi/c/ef3d549e1deb
[2/2] spi: sn-f-ospi: Use devm_mutex_init() to simplify code
      https://git.kernel.org/broonie/spi/c/a42c9b8b0c00

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

