Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E32A155C82;
	Sun, 26 Apr 2026 23:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777245765; cv=none; b=H4ajiQ8s75waxLf3+xKkBrwKtMSuZ+0IYArhfKiJGdsH9AwIHLEIvULkEZYyEaxS5ntnu83b+edJywXp2+dcXtXzJzywwnlFzCuMWsPbAQnuKEaukwzNwu1o4A/OzO1QlVDm8A2qdHDLqYljNgpsGir2zfsNcWCvV2swd2YYbXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777245765; c=relaxed/simple;
	bh=SmIp8IO/MdHTxdBpkYMqcIoU2ScMnSFAPgfF1YMBViM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=bNUdu5mdn08pw6YV7axvGFQbV2JQ18s76MVpwhj48C2ZP6KQth6kzCjqT1lpb7Jkhmr/JYypJ1lfH+BqYsGEKDyizfLwpGRDg9zvq1KBhxXpqjfRBnw7uXOV8L+GphCo10zuV//A1bH0Y+B0DehvqhSJ0zrzuISYQLaXfJXj+qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a1xV0sUL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a1xV0sUL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A51F6C2BCB4;
	Sun, 26 Apr 2026 23:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777245765;
	bh=SmIp8IO/MdHTxdBpkYMqcIoU2ScMnSFAPgfF1YMBViM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=a1xV0sULfbhgv7lcb+vY0wyfH8ZOWus2jbjZZlSxQ+P8ZgQIK2K9NKWb7MAtvDZ7U
	 xHemB4kG6r28mWO2YtIdNJBI2GrrETWxp1hVwOv3MhEEcs54oWVB+/MmiYqwDGeVR4
	 /xefwMHjzCrp2K+sOMSfqWCZqqDHU42YQ6vc3tKh04miNypV9rGsxHw9M7/lQfPFuO
	 66OuyJiDEHzM37xgLpflV26Lg+/XUuBUj2iKPP6yMD7b3Eyb7wXmkdtKfFjKJzvg/y
	 bO9Y4t2DcVwKYfjnE46rZc6Lrg7CW0JDPkKucxkGtJ2t6RV2z9BvnTa+Ol2wPzdsIK
	 h295rgmL8YCSQ==
From: Mark Brown <broonie@kernel.org>
To: heiko@sntech.de, John Madieu <john.madieu@gmail.com>
Cc: jon.lin@rock-chips.com, linux-spi@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260425092936.2590132-1-john.madieu@gmail.com>
References: <20260425092936.2590132-1-john.madieu@gmail.com>
Subject: Re: (subset) [PATCH 0/3] spi: rockchip: ISR fix and minor cleanups
Message-Id: <177724064669.266775.12560276533670856955.b4-ty@b4>
Date: Mon, 27 Apr 2026 06:57:26 +0900
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1521; i=broonie@kernel.org;
 h=from:subject:message-id; bh=SmIp8IO/MdHTxdBpkYMqcIoU2ScMnSFAPgfF1YMBViM=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBp7p5CWz1j9sFp9KrJIpcMW164Et7JC5XZDwrTs
 WT+w2ulsc2JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCae6eQgAKCRAk1otyXVSH
 0FjkB/wIMXsUIBOTKU4d38uqNrqkSbKfQAosDvnKwSjle7gXrMfcR8D1ZYy5zmtHT7n2ovtDxR1
 AmSf05TShUO/PEXaEoxxvhv/Y42Euhle8RHQ6k25qQQna52cuhPpZLztgfgL4Usnnx7GCJA9sxV
 CaDQXq06WhUm69R3EplDijMrCJ9e4gVaJavsgYBeoX6fHi9HesglVSR3OUaQb0zgM6jKNj8km4F
 5ggtni1+LuPBshh1rzjQ3w5CQpVazb+F88al4O4NPJ7Jke0DrFGZpH5MSCXcWv3LyMzTkomGYQr
 3mjCGwiOgBUioDe6WtHfiKCY6C0UwqVGJZa23y21TxbEa/1i
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Sat, 25 Apr 2026 09:29:33 +0000, John Madieu wrote:
> spi: rockchip: ISR fix and minor cleanups
> 
> Hi all,
> 
> This series fixes one real bug in the Rockchip SPI driver and tidies up
> two unrelated cosmetic issues spotted while looking at the same area.
> The patches are independent and could be applied in any order; they are
> ordered here by decreasing severity.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.1

Thanks!

[1/3] spi: rockchip: Read ISR, not IMR, to detect cs-inactive IRQ
      https://git.kernel.org/broonie/spi/c/b4683a239a40
[2/3] spi: rockchip: Drop unused and broken CR0 macros
      https://git.kernel.org/broonie/spi/c/7643978722aa

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

