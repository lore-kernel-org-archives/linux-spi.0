Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729EA2D3ED2;
	Tue, 30 Jun 2026 15:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782834542; cv=none; b=jqIES2cGNJR23kXaPlyHbcE1tcAYnkO3LfwCZJSKkCwHaaJJhoG+f9HhT9NZdaQmzMMMP4x5Scg3ZxV0AOQylneI+El4AFPqEAM0PkOP+Yrx2QQCZFnr5eWArYWMiMWnFJKQ4xaisomjspLORROPrp4FVcsqEAtu8RDb+gWU6CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782834542; c=relaxed/simple;
	bh=C3JSY7LsM258ERdXIoF3eG96fX8fD7qObUt5ovIpD+8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=BttOmeOIZZtTBPOhHf8Wm30UIU2pcHn+iFTjxYGseIT7KOGhIyagxPFe77vi0Ybc479cmqOSbf0kpGTBt9j4JN48ZpJyPMunH9n9BxHCTDvgnQqyqVkAp+wdpXuRcYEheOob1ScOw9VNTbdQ4dM7pyepHx6T3atkTG7+wuqPasM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BYWPeRN/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BYWPeRN/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C05B1F000E9;
	Tue, 30 Jun 2026 15:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782834541;
	bh=pRvchszo0nQt/Xjvizm3xNardmGDX4zYQCWhb6sGWm4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=BYWPeRN/yAk1EE8Vh1jkKDr+ETZAMjiYcgrfIZ/OUZF0XTDYhsJuk4imqTp9Nnxzr
	 EMuMVTsfRr+OkyEW/BvTa2yGeLKUcLKLx9mUSEYWWGAG2U45ccRpJDUeZLbOigyO+5
	 UTmDSJCLNBmn6b6QRa663hg0QmsgvmquJr5PPkBA6u6h3mlQyxdrhkdx18DW1S+MhA
	 hN1PuyMCh9M3SPrL68brDaKfjApKzM50jvfmGIpvl9fzUcaoUTCSGCHyjaJSUjuGxZ
	 6z6CxmPtuhWXMCxbyDFrHIAaMrUrD3pkROqPnVtPhFK+jvRNRVVZRRwfXrgvmdjuKM
	 z3eoijOJgt3+Q==
From: Mark Brown <broonie@kernel.org>
To: Jiawen Liu <1298662399@qq.com>
Cc: cl634@andestech.com, william.zhang@broadcom.com, 
 kursad.oney@broadcom.com, jonas.gorski@gmail.com, 
 bcm-kernel-feedback-list@broadcom.com, anand.gore@broadcom.com, 
 f.fainelli@gmail.com, rafal@milecki.pl, olteanv@gmail.com, han.xu@nxp.com, 
 haibo.chen@nxp.com, yogeshgaur.83@gmail.com, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 imx@lists.linux.dev
In-Reply-To: <tencent_306FA547FD68D10EE4B2AE9C132060F12F06@qq.com>
References: <tencent_306FA547FD68D10EE4B2AE9C132060F12F06@qq.com>
Subject: Re: [PATCH 1/4] spi: atcspi200: return error from failed
 controller suspend
Message-Id: <178281951147.79320.2850287290547638465.b4-ty@b4>
Date: Tue, 30 Jun 2026 12:38:31 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1493; i=broonie@kernel.org;
 h=from:subject:message-id; bh=C3JSY7LsM258ERdXIoF3eG96fX8fD7qObUt5ovIpD+8=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqQ+VpiPuVzxpAvS84L65zppHxOvbxCK8c5TCwA
 NFj8w3hn4aJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCakPlaQAKCRAk1otyXVSH
 0J5jB/4peKxomewjfJZCS8MkQQ8Xw/hCWmsvdbjnbe8zsMwT5r+kdffG7v1bV1H0Nw7ZOQ7/0am
 rPGpfMbGydlaDFzRa0D7QogQL2oWbF/djJ/Ag9y+t5wUBF3syAIEZ+CrmVBozRe4CCQkkm5ddJ9
 CyTNuZYGSyO7Py7KW2ygzFDZOGKq5jCg2Fb70g0M/n25yZKJEdejH3Ie8kfXqXbDjpial21WiXk
 rKyMHuGcJwMjkyoQWB3ff0Xdc8xTGnG0nW3Qanq/0F1iXGvuNJXNNLjs4ozSKHZQtQiAuKaPFV1
 Sz78MKsJYk1u14bBspBi/S9XCFiuMGD1tVDKM1EUs3wjyBRr
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Sat, 20 Jun 2026 12:39:28 +0400, Jiawen Liu wrote:
> spi: atcspi200: return error from failed controller suspend

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.3

Thanks!

[1/4] spi: atcspi200: return error from failed controller suspend
      https://git.kernel.org/broonie/spi/c/f4b14e67baff
[2/4] spi: bcmbca-hsspi: return error from failed controller suspend
      https://git.kernel.org/broonie/spi/c/faa878d4805c
[3/4] spi: fsl-dspi: clean up after failed suspend and resume
      https://git.kernel.org/broonie/spi/c/2543355f3da5
[4/4] spi: nxp-fspi: disable runtime PM on probe failures
      https://git.kernel.org/broonie/spi/c/5d14285d60ba

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

