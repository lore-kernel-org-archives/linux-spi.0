Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1C93A63EF;
	Thu, 15 Oct 2026 21:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792101072; cv=none; b=bhCsfJUNAM/ODgqcQjHFfTP4s6I92YToSeuDxeleelxQyQ/2uzSTz9t8rhXfbVAwd/c/MfRA8Qg4KGz9hDveuWKFW9NmZCVgeTKV96mibr05DYo8xdDONSnd2GobY+zvhAEW/Z0M6r5R/KydeQRUqc5P07Bo+1LDZDfrZARBPBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792101072; c=relaxed/simple;
	bh=bHyzxQjlDxUkW24BngGwmRymVsmTHravlYPRgS07n9A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=dIfRJMi3PAtBOdAPb8yGM6xyGd2FTL2BJcZTgxACbnXm87YlgadoCwAah8TCmS2mibNZ/Ig57q2yg9CawLNLi1TeTowWOwlOE49gjfOjhGfn1viqG3V2IgsaTfBobfW2zuiP2qzT7ROK9udJKJ6KTzC7XvMqVaGyecFSVMJ/Lgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JLy17HKS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JLy17HKS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50D991F000C4;
	Thu, 15 Oct 2026 21:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792101071;
	bh=vu/ZyXo33On1zT3iSqg1iA3eTXIpWrgO2mF4iJDAeEQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=JLy17HKSjFF6BoAsDeHo5VY1kMc8Rd7FPIqp2+pFmQ0r14nU3fDqZQdRLcKU9DuHg
	 BgQO/Wxnvl+dKZiDzWNJq9koDP33HMqEtHQYQSUrp9vr1DD6BFkel+ZZKt+cC8YDua
	 1kEfjaKjlYPFpuULcCeRAkOmvtv+9QYSR446n5HRUhd3U8Fo38GqDxBD3/ZP1xGqdp
	 X++BpDajKDU/w/uOT2dJO2KM6HicbAEHU7t25CQcEDELCTYwQ6PiNFcYo15lCpVzbI
	 EqPs139CuaWbbzRsTBykQEj8eIdS/L1OUTNaH+QENnwIRKiiqb/YFG6CMk1YHKFw3d
	 KQ9k+STFN1+Rw==
From: Mark Brown <broonie@kernel.org>
To: Laxman Dewangan <ldewangan@nvidia.com>, 
 Abraham Zukor <abe@maticrobots.com>
Cc: Mikko Perttunen <mperttunen@nvidia.com>, 
 Thierry Reding <thierry.reding@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, linux-spi@vger.kernel.org, 
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261010195503.623287-1-abe@maticrobots.com>
References: <20261010195503.623287-1-abe@maticrobots.com>
Subject: Re: [PATCH v4] spi: tegra114: initialize native chip selects
 inactive
Message-Id: <179210104180.134795.1562108609098546334.b4-ty@b4>
Date: Thu, 15 Oct 2026 22:50:41 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1123; i=broonie@kernel.org;
 h=from:subject:message-id; bh=bHyzxQjlDxUkW24BngGwmRymVsmTHravlYPRgS07n9A=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLIuep3utpOJ3/LaxXlR7681sS+sDqxNX+nXLBXVXmrP9
 VJriahZRykLgxgXg6yYIktcFvfL+pLXa/gOLmyDmcPKBDKEgYtTAG6yOsMfbsWaHbETtwacCN9R
 JL7N9x7nR9uN9T73Np8vW8UYp71jMsM/NRfzWUK7ebLkfppMdDSo2x3mJRqZ88TLiuW+YIOgUSQ
 TAA==
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Sat, 10 Oct 2026 12:54:05 -0700, Abraham Zukor wrote:
> spi: tegra114: initialize native chip selects inactive

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.4

Thanks!

[1/1] spi: tegra114: initialize native chip selects inactive
      https://git.kernel.org/broonie/spi/c/f8334fdfd858

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

