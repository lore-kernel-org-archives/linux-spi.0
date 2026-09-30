Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3A651FCA4;
	Wed, 30 Sep 2026 18:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790792856; cv=none; b=VglZ1RSh69sEt5Zf+tvNYRyqu59GuX9bS/E/QtB+LhBUoT/cK3Rf9IFYIkcHWsI4Kf4BXZrIMBRclXPbmJKxUA9AS5orV5vmAyuPXxdeNaB4+kdrbVbQwErBIOFzsR5XnROTWs1mJ9hx1f0B3Z6FU0zlAqe+frDTKGv+pzZH6bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790792856; c=relaxed/simple;
	bh=HvduEqLXXmVtvaxrl9fZQ8D354YowTFSpMsbD9lAeMk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Mpf+Bc5IhsHeTO1ri9m2ZYxC49rPKWyPhvTMmsUm1iDRbXdrwwj08t9q9h/ONs2NJJQQhGSIBFlCZ+6RJt+ufDAN1IVOFekVNObsUMc+tslBD7vKvaMivKhr4ElmoiSVg3jOTMssddJnlybUmUoUcJt63xRbLoEFfuGHU1rUwZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YKnz22A/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YKnz22A/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5335B1F00898;
	Wed, 30 Sep 2026 18:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790792855;
	bh=H7kA4KMmXH/19k4ioQ1Vh9hgbpfy7iW0Z3HjzxATkHg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=YKnz22A/mM/fBlGjaRgtGqQtDuq70I8Z8kWX+nqGSOTUthIaj4HhlKowvTXPSmB3s
	 jRqaYrAHNrePHdQYTPf8tyfuG+c6nu/mGhhG6E/tk8Ojll4C84uksiy2K4H1xbarQx
	 mGMyoAk9YJnzOP9YxHZ0LwzEYcTZUPrxIF83nhe1cEYSXYnNLr4iFEbmr1fFDBJ0/Y
	 3mdY1pp7schpifKJY5gPNfsMfQAuePF4uWES7TzUhVWpiAS4mbxZcoHxJZt2o9R8OV
	 8H/EKp3VSr4h/xcoGHwzTqg9qaiCW5C0yo5z48m/z5RnJ+hieykQ8SKt2DIf8WO7RG
	 OZoeAr8GPrMqg==
From: Mark Brown <broonie@kernel.org>
To: Changhuang Liang <changhuang.liang@starfivetech.com>
Cc: Serge Semin <fancer.lancer@gmail.com>, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260930071535.7947-1-changhuang.liang@starfivetech.com>
References: <20260930071535.7947-1-changhuang.liang@starfivetech.com>
Subject: Re: [PATCH v2 0/3] Add enhance SPI DMA support for JHB100 SFC
Message-Id: <179078651849.116826.6994353806705253612.b4-ty@b4>
Date: Wed, 30 Sep 2026 17:41:58 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1694; i=broonie@kernel.org;
 h=from:subject:message-id; bh=HvduEqLXXmVtvaxrl9fZQ8D354YowTFSpMsbD9lAeMk=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqvVSTu8tO47LPmPnLYnmBzopEaVI76c8riUuPx
 5DYnsMTpxeJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCar1UkwAKCRAk1otyXVSH
 0PPcCACCKlL1UhzWDY40VUC1GNL8HxDkt6JdVnvhaYeqi14adOXWt7R3uSm7mftbM2YliWUnkVW
 eSzn705vyKIMUgsuKUm8LQAZHM3P3duUyhioGxQd9QDRuLjjWUacYNDot9jLjDDWxAwa2fyYikI
 xMG5no7LTdBaCOcjPSf5AvSqopb+teB2kBel/COWNO5qIUjjzcvt4BjwSvOZMSghuf4acVrqzB0
 ys1y7YPcQO19bJ/LmCa1nIcyMX/tlkAv2ijfEqqKq5K4GGrM+UdkymnuTgBbNVgT3UhUO182HZr
 uzI6El+DzScB2IdO3X1grQrOwRJOnFEzKfeY+L94HB4FHmO/
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Wed, 30 Sep 2026 00:15:32 -0700, Changhuang Liang wrote:
> Add enhance SPI DMA support for JHB100 SFC
> 
> On the JHB100, there is only one channel available for DMA transfer.
> In flash access scenarios, it operates in half-duplex mode, so we
> can request this DMA channel for the direction that transfers a
> larger amount of data. Different transfer directions need to share
> a single DMA channel in a time-multiplexed manner.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.4

Thanks!

[1/3] spi: dw: Convert the Tx done delay from SCK cycles to time
      https://git.kernel.org/broonie/spi/c/5c99cb15169d
[2/3] spi: dw: Support DMA with a single channel
      https://git.kernel.org/broonie/spi/c/929b82c85fc1
[3/3] spi: dw: Add DMA support for enhanced memory operations
      https://git.kernel.org/broonie/spi/c/8cc7be24bc5e

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

