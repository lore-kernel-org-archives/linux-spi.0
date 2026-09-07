Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490C32D5925;
	Mon,  7 Sep 2026 21:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788817673; cv=none; b=rpvgjY/Z4Jj7yvapH28pMS+aeJqmXOtsRIRPw5mYLa7gQbEJK4rhPjzETU7cSqAP6chwVEBR/dmzMMurjgkwhvOo+QEuf8q1mFHI9B8LDL+l3dkLnz5Yh0F1CL99XVcFx7fG7kxbHv7WJiEkFfedX+XSP+x29ak/RXwfhp+eDX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788817673; c=relaxed/simple;
	bh=ZVyqdTwyNH/8PkOQcGSbJcEKsRG8w7dGOUBzIlcRFoA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=V6QMgOLo+WPwXZqnMzRdAmA9dl4Mg21PhSFRsJqPPzE5gr4KlZcE2hCBUgZkk9WgDpbbyUUT3cPEnbupJEYFa46hHNTi7ioH5GFEtZop28LUmkg5+VPypb/AaD+XO5Lq++n9JD+EpWTCElWsaUID48WsU1vk2X5CsSAYPxFgBhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pk4Lzq+n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pk4Lzq+n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA0F81F00A3A;
	Mon,  7 Sep 2026 21:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788817672;
	bh=IMLWheCelX971hf/SFgv6hTrjgSuDX5H/Y1V6KcRpwc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=Pk4Lzq+nMw55twOTYEeihcgaiKJ86Fk9QMjpZ+gzKvMJRkxG7KDKRu46vAjsnXnRW
	 HrRBFp853B3sjBFITrMgXdPwg1F10SK/tvfl1F80S0X9EmIs8ZWos9WGaqn2dv+w5k
	 CzXpPAbbkGVW4xQGBf5r6F5UgTE/1+bqrQRTpjPvZyQ0wLiMgivSe57txIwPfPUlXt
	 96bJQQcnOtGiRnQLJ2AMs28zN4GhdMfKJHlp9T/dWMr1G1DyYNhWDG1FrgwHR/MV6X
	 PGuccVk41SqQs9qpn9yEgHDC1osxgV3W1FZ6ZaksAfBaiSjYBi6Rk/VH4H5s2JuPXn
	 jgeodIYfOlB1w==
From: Mark Brown <broonie@kernel.org>
To: Jacky Huang <ychuang3@nuvoton.com>, Shan-Chun Hung <schung@nuvoton.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org
In-Reply-To: <20260904-perso-ma35d1-master-v1-0-b6936e8c6fa1@bootlin.com>
References: <20260904-perso-ma35d1-master-v1-0-b6936e8c6fa1@bootlin.com>
Subject: Re: [PATCH 0/2] spi: ma35d1-qspi: Flag the DTR capability
 correctly
Message-Id: <178879386785.118202.2783412659972248231.b4-ty@b4>
Date: Mon, 07 Sep 2026 16:11:07 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1601; i=broonie@kernel.org;
 h=from:subject:message-id; bh=ZVyqdTwyNH/8PkOQcGSbJcEKsRG8w7dGOUBzIlcRFoA=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqnzEEzaooHtGMR6zzXr4exMV0CtpQsDa6HtXyd
 E1KcfxhXIWJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCap8xBAAKCRAk1otyXVSH
 0OTUB/0U12Ak0zJd7DHKfwpa4sv4hLP3Si7QEtcDdWG0ivqFy+KQKNYXaV47fU4dTdWwpPyUcJc
 pPgE/OW+lS1BnuicHsxmwznunh7ktS/uUt1LghJBersSbBziakpc9VOAz3EZzH+bnt8m1wABHji
 0RrELLQb7zDiTATJWfcBbWxY4Ys4v1rs1jAwOPCXcdn56rlXe+fhfSEmDATRd1++hVnozC9IwJj
 0UkJmcsh8/Q31IpW6f0TgiItDDdok74u11M8rY1gB0v86KZrpCTSZdNsWW4AWxvHeSEGDyV3wXG
 M4LRAN4io77020O+kaIBr5avFc5cTIelmAiHr0JdLTZ4yGJh
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Fri, 04 Sep 2026 18:15:09 +0200, Miquel Raynal wrote:
> spi: ma35d1-qspi: Flag the DTR capability correctly
> 
> Mark pointed out that the DTR capability was not correctly enabled since
> I had to set the extra ctlr->dtr_caps flag. For testing, I commented out
> the spi-mem ops/caps and figured out DTR variants were still not picked
> up. This was due to the spi-mem fallback implementation of ->exec_op()
> not forwarding the DTR flag.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.4

Thanks!

[1/2] spi: spi-mem: Enable DTR transfers using the standard API
      https://git.kernel.org/broonie/spi/c/86f4ab98e716
[2/2] spi: ma35d1-qspi: Allow DTR operations with the regular SPI API
      https://git.kernel.org/broonie/spi/c/2448f25cc839

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

