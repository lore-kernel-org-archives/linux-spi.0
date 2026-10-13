Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11144A498E;
	Thu, 15 Oct 2026 10:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792060626; cv=none; b=FVxNrCfPz8jCDh1Av45QjwFQR4ZkkitECLnp03mLgKYU+ZVK+1UI7Vr3MWSZ5AJG3zRkEn8r7P9neLe7Oczdo70TLhdIVVwLKu/I4IRX1PRd6WJDWwQZiZnyjUki2iECilN5GVPcBoJwV3yHDTXl6t9Eso/5927+w4O2AKsj54Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792060626; c=relaxed/simple;
	bh=0Z00fuz+F51T68T3sMVkkOQ3cYITYeH1BRSZL09Hm2g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=JdFWfEDLEV5yWLvF4kZ7B+cYSMAdsxn9Y2aEZjiXYieKxo98JmmBcl+W7nDxjyDfWCXZXnSbRBlOOXbWmf7FeUWycYlqi28BN9Nrij97l6aUO7z3RLnA2Uf5AOJH/pWEglqPSlU2k6y/4yFKrKaQiTG3aJznCA+wS/VOqSFnrtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YZfEiCbe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YZfEiCbe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAE061F000C4;
	Thu, 15 Oct 2026 10:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792060625;
	bh=v5RWvFNNq8oSh1jVXcH3izOcYbsWvNE1qpoYoMGhrdY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=YZfEiCbem2r1mXnggzRpBT+OQrlGyq483qKRTo+FJ1Ma9wFZ2U0N9jao4F7n6xS+8
	 HOBXqytjDLGV/knGtsJpOYuiQ1ocaoJw4zEM7BCtwXYjA89jR4rvi+ZEb6aVI1jAnm
	 gvilwK94uTXyxvmhmiwYK2zAFBzCCTX0sEEh12j/tS0TIi7AMR0s0DKLDFHigeVNK0
	 K/IzXJ8MqiRkI9ymi5yLt8y7jOBngTck1N2ZK9oJt6dxooi9/DyVcyc9txwmzTe1I4
	 rQzdbQClX9/Y0X/el/QMvRTb4Nmy2+1YrGdVmd7JgUHjEjCyal04FhFW8K1KbhpEB4
	 TMkllur6l4TYw==
From: Mark Brown <broonie@kernel.org>
To: Richard Weinberger <richard@nod.at>, 
 Vignesh Raghavendra <vigneshr@ti.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Michael Walle <mwalle@kernel.org>, 
 Takahiro Kuwano <takahiro.kuwano@infineon.com>, 
 Pratyush Yadav <pratyush@kernel.org>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Steam Lin <STLin2@winbond.com>, Santhosh Kumar K <s-k6@ti.com>, 
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mtd@lists.infradead.org
In-Reply-To: <20261001-winbond-v7-0-rc1-cadence-cont-read-v2-1-703e040b2d07@bootlin.com>
References: <20261001-winbond-v7-0-rc1-cadence-cont-read-v2-1-703e040b2d07@bootlin.com>
Subject: Re: [PATCH v2] spi: cadence-qspi: Prevent SPI NAND continuous
 reads
Message-Id: <179192006107.42298.12241283635432521930.b4-ty@b4>
Date: Tue, 13 Oct 2026 20:34:21 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev

On Thu, 01 Oct 2026 18:45:57 +0200, Miquel Raynal wrote:
> spi: cadence-qspi: Prevent SPI NAND continuous reads

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.4

Thanks!

[1/1] spi: cadence-qspi: Prevent SPI NAND continuous reads
      https://git.kernel.org/broonie/misc/c/3716c71d1c77

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

