Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F773B6352;
	Mon, 10 Aug 2026 22:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786401798; cv=none; b=Mji1UEor9TSR6zAVg2uwST5H3xesO1lyxEiXW0DpuABMCdgFGN6Ml93z36eBbdcpJcuaviekhwrTCc7O9K6L6xn5swQ4UUj/1rhgsvDnULqpxbPoUAb6lpHtrV0KtXok/NyHnSKJx0SAcgKg/SoOtlXzevyAJdjYUBC4/rSLgY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786401798; c=relaxed/simple;
	bh=9NnheU22Odpz1y5Y2xIs9SQi9OreAJaEt6jPIy5crRE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Sh+fP+K8YWqSGFxP+iFWEf8pUCcmHsdeWFJaTDrjKDJ+eiKAc8vSeSDjZFksRXnS9YnpiNP2o/+OvYE10uKKAGeMD9cQej8tHVupTabGCcf6z+FN5t1UjyfvETBeErqcsHjgrjVN3WZxkLYPvtCBDkY1VLsKwDSE77w9GMueSPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BmBTx0m0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BmBTx0m0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AB841F000E9;
	Mon, 10 Aug 2026 22:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786401797;
	bh=S3Nx0KYGlbaQ5NYEXpDEi2n/Rdo9pkHGeCmFJ3YLfl8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=BmBTx0m0bfoCv/H1nZjcSWYQvJIH5Yl5lwa7m1xWjmWIo/HmUFDWCU4hivj7EipuJ
	 LRZ8a3EMEtXzsc/mtXtTn+oQ5jl6jtVDsc5pYPQkqTgpO1SsWFFpL3latQiFEcX2Lb
	 mVUR7LdzocNT0kuT6GWUJKydG9lRN/2PLMJfseMD2EO9yfu586wziKKcWuJLJ8GJOk
	 hVncBsH9LcRP59Lr2ori4liD1nm7sZlTSd3CoH3fdZh+safTgV/ujNGV6vyocLRFeW
	 aZ0jpPJCwhhzo08j65xPKoeUx9iLV/xsx6PXrPRvuvd/UJ92/fk5xxV5jfGxVNy2J/
	 TdcDpOjMPhO7w==
From: Mark Brown <broonie@kernel.org>
To: Richard Weinberger <richard@nod.at>, 
 Vignesh Raghavendra <vigneshr@ti.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, praneeth@ti.com, 
 u-kumar1@ti.com, p-mantena@ti.com, a-dutta@ti.com, s-k6@ti.com, 
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mtd@lists.infradead.org
In-Reply-To: <20260810-winbond-nand-next-phy-tuning-v3-0-a97c3a61e675@bootlin.com>
References: <20260810-winbond-nand-next-phy-tuning-v3-0-a97c3a61e675@bootlin.com>
Subject: Re: (subset) [PATCH v3 0/3] mtd/spi-mem: Enable DQS support
Message-Id: <178638127767.155010.4353834320826597950.b4-ty@b4>
Date: Mon, 10 Aug 2026 18:01:17 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1341; i=broonie@kernel.org;
 h=from:subject:message-id; bh=9NnheU22Odpz1y5Y2xIs9SQi9OreAJaEt6jPIy5crRE=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqelQCRn02kb6ZYgBDmt++bfRr+a+9fws30hFSf
 Np2DXuwY5aJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCanpUAgAKCRAk1otyXVSH
 0PWvB/4sjE9j1H3UUoHHc9S14oxHHOeqsGN/7mkNYcFWkCclbwLGhfyWunpAT6J8m4JRiQMUlxk
 dS7RNEtwn5GJp0YwOryZW3Ino9C34NnzXYN+kOmAmA/5ZNUXcG7hsnY792a2FLtx+vrpzjzj3Rt
 ccFHM1SVyAbE5gKGTwuW3rtMXQH6STRwecNG7vJbJGMlBSvvH6mTySdNmfk1PLyPJaRZVgvnMAe
 Is6IZvACZOQGMPWbs/2gcZ2uknWlpyo2EKF3gFf7yRFoXg+f0MxFEafLzPvkAG4Z0ZyFv/VzWzl
 i6fRbQBceE+50tV1gJNIbH4z3hy7ihF+KVJ3FFTAzp7cmDJs
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Mon, 10 Aug 2026 17:10:41 +0200, Miquel Raynal wrote:
> mtd/spi-mem: Enable DQS support
> 
> For his PHY tuning series on the Cadence QSPI controller embedded in TI
> SoCs, Santhosh initially needed to access the availability of the DQS
> (data strobe) signal. This is a chip dependent capability, which may
> sometimes be enabled.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.3

Thanks!

[1/3] spi: spi-mem: Flag DQS capability
      https://git.kernel.org/broonie/spi/c/391144742324

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

