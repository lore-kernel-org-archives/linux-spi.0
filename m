Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A9536A37F;
	Thu, 24 Sep 2026 16:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790268455; cv=none; b=NZ3V4D2145E7tfEBtBKSQ5MRK2cjpQJjGG6ngPFXZ/mMK5XWceQixV30lwPAkjqKOxFoHRzp8SlzLNkPc3MhywAdv8dKT1lMysyrKaRM89uP9YQRSa3mPhWwfxj6AI97craRfyr5DCkhkniWrZ310TlZEYIiIVRpTUsF5kZoCs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790268455; c=relaxed/simple;
	bh=lYyah1hDuQZOEsTqm+q31m9h+3STEU5oM5cnqNTIbJU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=soluZqBEr/zhfjLCy7rauoFtTx3gkR5LG7qdLWqw0GqKQUP2rvGyKPLsBugVame/0IseVX+kuHPNqetZmnuAx/1w3tm8GV63qhsrk63aq0FAZhM2j4bY9m4u/3mGlgbaW6feJgf7FSNk5ZpCyorviW2LoyA4pxkQeYf/GZnZ3zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QcQIFSt7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QcQIFSt7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 298021F000FF;
	Thu, 24 Sep 2026 16:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790268454;
	bh=JxHQ5khFYb09ykclMWE/AKm/CGVEPpleCd+ucxmPXQk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=QcQIFSt7l8g7QdaBXdJF3SxjnGyiUxvAds3cuZOLBUk8UeglKgaeDYYXT0EUrJbDg
	 fViUeQKh9hUa6Ak8ysvU0CuoplWdU/5aq8FqTxdfErGO3ak2fMGM6xiI4LcHauNIxj
	 tP6LOZTjRGYvdKejkaU98bieQT5RZmZ/D0fNtaEOzWcvzpLZDn3sdnm1KI3KNQI0k1
	 ngL9iatwu7EWW2aeaPJ9XkhQsjGtD8/Fn6DeLJVWAAWsiRxsrYzwmFVJ5eh0SWkA9C
	 +lrtefIx089beHN1EsZoc9VrxO1b3T3PnLahoFR0jniErWghbjs++ICfgFywM3j7wi
	 KfJh4B8g8z1vw==
From: Mark Brown <broonie@kernel.org>
To: Frank Li <Frank.Li@nxp.com>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: imx@lists.linux.dev, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
In-Reply-To: <20260916-spi-dma-v1-1-2b30657d373d@nxp.com>
References: <20260916-spi-dma-v1-1-2b30657d373d@nxp.com>
Subject: Re: [PATCH] spi: use dmaengine_get_dma_device() for DMA mapping
Message-Id: <179026829086.149798.15115655452552448631.b4-ty@b4>
Date: Thu, 24 Sep 2026 17:44:50 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1118; i=broonie@kernel.org;
 h=from:subject:message-id; bh=lYyah1hDuQZOEsTqm+q31m9h+3STEU5oM5cnqNTIbJU=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqtVQirb9ifQFsihKFH9arGDlW4Uo/yNa33ZEvU
 xa1cvnsdX2JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCarVUIgAKCRAk1otyXVSH
 0BwTCACCpw3pLwe0RMw1kJmhl0161LU+D51ddxeVSu+8vT2r7fhkeSWwf2mYt0/vgeuun1N9MSN
 uXpiSxjOMW9Np34XvpDO8ucConLURd37CjEEemGW3XE40Azgrkw2rTBIJsJprVQE3wsqFMPSrAt
 JuYuiwPSFP9zfLIf4UxPR8pkailbLx4FtXjHVAcMWUeHPhQBSLB9IdEMysJZl3m3JSL0QOBV3R2
 zePsc5FxgU2Xlru/vw4aEdsZSp9yAX+l9WVVuj6hDNudtXY8vQtD3C+QUjU4Kp1oPfeyFcyqo1k
 zEPNL+7j4nakl5u0HvE9mustzCTi1qZK3wzQwI1dKjQEJWKK
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Wed, 16 Sep 2026 23:30:55 +0800, Peng Fan (OSS) wrote:
> spi: use dmaengine_get_dma_device() for DMA mapping

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.4

Thanks!

[1/1] spi: use dmaengine_get_dma_device() for DMA mapping
      https://git.kernel.org/broonie/spi/c/cb5a15943d7d

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

