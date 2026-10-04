Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C0C4A2A6B;
	Mon,  5 Oct 2026 14:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791209818; cv=none; b=YSgl0z4AO0u51b7a8li4QutGYepDOIsL6RHhohbLt10JIFE2DqqX6iA4g4uFu1tdOLweSGxjlnu+w9KrbtUpy+5Ir/eDCgXYYRvI+jdqgXtnk9WWguR1Y8gCeVhYHXrSF4bzmnZK+Hs+eMsyVx7ANGpmxz1BT/Nc/jEFGhpnlUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791209818; c=relaxed/simple;
	bh=lmQyZuRuypqW5IP90gJoDJHpex/WSszIgFlSetChKEw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=VkN/osLOpltOXmJVtB9yAzKrygTADfeHAerap0klqTpHJbJ0AeUGpUnm8SKkoF2Fg2ac9JLAjKx1mnB4a5xbOW7o1Goy04EgjS4en8O4gBAGlEQ2l9nR0jz0J0rg1Aj9WnqoeRgrF+AiZxcuHggC+/HSRaFksGd7h3Jx0D8za64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BIE6pP0q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BIE6pP0q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 978A01F000FF;
	Mon,  5 Oct 2026 14:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791209808;
	bh=qAOIBTWG5MHXhYgqgNKwWCJbtAn95NIqwCzfd7DVED4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=BIE6pP0q7hskFogl21G1PA3XPWIKMV1PUYa8DavErLzf+/WlPgirw94tXKIhkjqVG
	 tNy/g7yCto1jB7Z2b1cIbmWlip5PEqxDfYKSqOgZhZ1uuDukLbzAbD5mtVWD75t4Pn
	 2DKOsdYi/CYipj8/BZRq0qgZ8FPxMSMqRQthd4y1rX42UatbLXZAz6yi6Vnlx2GI3D
	 KUSLoJNYSaR0XrGkykCyG11OXXhxk6lB+X4pzp+2gsoGh8laL7nFtcUlRJz/nw8Vju
	 xRjXxVeP5wLKPo7e8oaIFQozOYkbSj6ebrXszVvRKXF5PJIr2EwBJe9iTQDnxe9Txy
	 ZD3DaTV8MzE8Q==
From: Mark Brown <broonie@kernel.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Santhosh Kumar K <s-k6@ti.com>, Vignesh Raghanvendra <vigneshr@ti.com>, 
 Steam Lin <STLin2@winbond.com>, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20261001-winbond-spi-next-cadence-rdsr-fix-v1-1-ec5ff594ba5d@bootlin.com>
References: <20261001-winbond-spi-next-cadence-rdsr-fix-v1-1-ec5ff594ba5d@bootlin.com>
Subject: Re: [PATCH] spi: cadence-qspi: Fix status polling with octal DTR
 chips
Message-Id: <179114832879.150114.5133167826136185491.b4-ty@b4>
Date: Sun, 04 Oct 2026 23:12:08 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1131; i=broonie@kernel.org;
 h=from:subject:message-id; bh=lmQyZuRuypqW5IP90gJoDJHpex/WSszIgFlSetChKEw=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqw7FKEsfdY9phvWPghMJF2PUubOUJ/igqdf4WG
 jO0VtwHQlSJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCasOxSgAKCRAk1otyXVSH
 0EzYB/90rtdVJnUgVs53uKGzh0q7hCabgD2Fu1rxI1MN0C4zrKaNIn5jDZHeX9jGEWl8cUHDiyP
 Pp3tCMKfmn2D5ISKZXQJzVoSdeCf/ZgiHxN0CkMntNmLj+Hp/ZuyYrg8AMD+zbw/j+38lAUh3Qo
 C/ZTvQWTs+L4O4Z8tOZ5spLK5QzXFcRcz4+XJDxQWzHzV3oGMGJ77gLbrB0anInSj0TusaT/m4N
 xpiVD+maH3fAhcIwDXwpYoOyXx8+XZOHaB5o/D3VxhQRaiVMo9629W7NTjdAUpK0tCxlK3Almq6
 g+qqtyZ3A/w1y/upc/ZnVoV+JImqp2/j+Qb0gbHKosAsle4i
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Thu, 01 Oct 2026 17:14:44 +0200, Miquel Raynal wrote:
> spi: cadence-qspi: Fix status polling with octal DTR chips

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.3

Thanks!

[1/1] spi: cadence-qspi: Fix status polling with octal DTR chips
      https://git.kernel.org/broonie/spi/c/fd99864b0ac9

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

