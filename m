Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE4E37C911;
	Tue,  1 Sep 2026 21:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788296942; cv=none; b=Cw7Xq7KFjr2S6bR3K4q4bgvFqpR+dYWNcvbGeCEz2qOC8TEsEeUCKk5WjhDgQSq3jz4vO2RA0nxbSDZYTy7nb5+LESPnZGcjEuuOeLZkk2TPPDuAuM/t/WSu5+GFHEFLNGptBiHiVEhFDz0/yhqxY3fsfbnPUHD6y01Gm/LMFlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788296942; c=relaxed/simple;
	bh=JX/26bGGUmRq2h2//+GZyw07D++3XMqRoIT9K6XN0sY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=JOvqF88XrU2CEA6CoUSjWx9ShKXbKafT6M2b0n2Fui02xXHsibltpzbGO2e45k39+85eXaaxig+ZXUHpEjf5ynoujbwpxFG5pb8uP2vHFVpO/JaSpXEwS/+eow4IX5/JEZmQFfvhuQeuvn1/yQ/qdqFoxpexRofMc5GyXSNH1Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=enoF4Rl9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="enoF4Rl9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BD381F000E9;
	Tue,  1 Sep 2026 21:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788296941;
	bh=XUMv00uhmmWGwBOFUJ8oZ8pHerEsNkVTCktSbF4UHy0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=enoF4Rl9lGm6gf9QZCm9I2gIxdkXAUrDxyUWpFbbchRIOTUE3MmNUm9wnJjWvEdiq
	 bRo/2kG/tOSYrIUijJhBueBnSdYbyRFoZk2gKDKqwwpEr/C6F8lonNStQWyJ9a8KJE
	 mpF4LW4Riw7BTqpArmqAtbSRCJ4cq0xnGr1cfwYX6qBFNATD2R/b4cWjZfXfi6pF0F
	 UDShhImEuortB8lI8D4fk+1HAcn8+4Vv2ApAwpUKB7JGbeSsU8DmcuutEpIBch3fg+
	 HWA0TLwOh64Nbu4efqDg1wpm9E1TPRLEUroSIWx6Xt3aFShnLPyRROCse3Gce+c8jJ
	 jdc3OAPgayzMA==
From: Mark Brown <broonie@kernel.org>
To: Tony Lindgren <tony@atomide.com>, Felix Gu <ustc.gu@gmail.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260826-mcspi-v1-1-0a8dd7f6dd56@gmail.com>
References: <20260826-mcspi-v1-1-0a8dd7f6dd56@gmail.com>
Subject: Re: [PATCH] spi: omap2-mcspi: Remove unbalanced
 pm_runtime_put_sync() calls
Message-Id: <178821330672.439600.3685098405160829295.b4-ty@b4>
Date: Mon, 31 Aug 2026 22:55:06 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1136; i=broonie@kernel.org;
 h=from:subject:message-id; bh=JX/26bGGUmRq2h2//+GZyw07D++3XMqRoIT9K6XN0sY=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqlz7pHW+iO8I1vOqyt20TJOlhNJVUcpeC38498
 oby/VEcd+yJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCapc+6QAKCRAk1otyXVSH
 0JfkB/9dNgi1Y5fMQup4CuhNsoV1r7xD39b7f4Cdkp6AloFMCJ3FksdZqskIrSEz7pCDEpA1+xX
 PyPoWFdShj3aIBVvTNJtwLYvoQWOCHhNMfVuPMXFPkGtvSmKXWxzEFmc9YsI3kcMtga3r3xh78z
 NXYHU+2VEqbvIaJFfd42vQbHrzI8VctlHwmUPQDtEIDDoscjQlQlWkntFsubEcaUyM6nsnz5hva
 dbeKFdoJmH/tVw+dnUgY+AidwdSag8o6LDM5TouglGGFLs9hiNtOc/HU3lhnQDY9qCeTzP3cMRJ
 L6izHDe05/gpsqKUoA0upwX2722XrczaQggRgLzR/AhQLpvT
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Wed, 26 Aug 2026 01:08:40 +0800, Felix Gu wrote:
> spi: omap2-mcspi: Remove unbalanced pm_runtime_put_sync() calls

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.4

Thanks!

[1/1] spi: omap2-mcspi: Remove unbalanced pm_runtime_put_sync() calls
      https://git.kernel.org/broonie/spi/c/5f01cb141169

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

