Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB44405C59;
	Tue, 30 Jun 2026 11:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782818231; cv=none; b=jYjoYuFiG0F+04pjFu/iJhsikShjLg3/OoHOzYS9g7r7XMVx8gNw/CeePJSG4oNTkeY9lJz2BoJDoIkvOW3aT2SuaXi2h08lg3TEHo8R1JEyRTB2DsVXU1S97osgrRTp3lu6ls2eLDwG3B3MhqaoLsK+Hw5trMb0VIpKwjord9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782818231; c=relaxed/simple;
	bh=KS2MzBpMOmjYLXMJIzVoKdVUNmc/xWgdS/ibnykyIqc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=jOjN9UMn7qehI4Idj/QpFayjvgrl8TDz42uis3rLs7bqY4IE9q+nIWKOIl2wwz1OXMWKe+fsNJIwuvIeo+1qfk9Ob3Lx7ks1BdFtBnZtRqv/88b9z7JyuxB6DNADlkCmpH02KvWRb0JIqav+2CGqi/vHeZo/JOFjiYjnFWt0VXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V0OVEuBC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V0OVEuBC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F8381F000E9;
	Tue, 30 Jun 2026 11:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782818230;
	bh=7GApfP/I2SM32tM2wtm5rAvWSj6S9APBClvbNp2kq9w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=V0OVEuBCBIO6lxVdxH0Pv7hIbbgu0n3R2UtoffH7jl/5IX+iEfxlBDmPIsfydaguE
	 Vj7YNNk9bePhZCkywM5TiH8LthdfjvQQHjmOyMLzdAjIQ3gxaLS0FcyX08O9sP15NE
	 a9jUmW/y1ZhNGpuQtow+vP4gkwrXcYGyLmbgv+05U8J1Nilz/Ee5QFhzF+Gs5s9ytM
	 w1tm0nDof0JYLmssHTawbAWzB0AFBWDdXfVHMI3OTZzrorSTPlz1tfTxHejCTD5rkO
	 VMtSjuKMV5Dirp3asCrwC5iOhPfrxKdpy2TZrVDC/CD1ZPbdaSFwPe0H0WHhFCrqVR
	 dWK/s9un1PDZg==
From: Mark Brown <broonie@kernel.org>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260615044039.9750-1-jszhang@kernel.org>
References: <20260615044039.9750-1-jszhang@kernel.org>
Subject: Re: (subset) [PATCH 0/5] spi: dw: use threaded interrupt
Message-Id: <178275408684.47562.1326273732439858611.b4-ty@b4>
Date: Mon, 29 Jun 2026 18:28:06 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1526; i=broonie@kernel.org;
 h=from:subject:message-id; bh=KS2MzBpMOmjYLXMJIzVoKdVUNmc/xWgdS/ibnykyIqc=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqQ6W1DKh05DRcLy8MD4Kq20xsUEzcMLuDQQ10/
 pP1tkIh9/KJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCakOltQAKCRAk1otyXVSH
 0N/lB/sGvsOuYrjXWaGDsPhBcXwxbuYZjWRkQequwci0THD0vIdLVRjDv3I6mykNxyP1MBwrjMb
 J/QbHxkA9GFrasACZjRJcNmDKjGLM8HQQWadSrJeyt7M0kXdrAYmLT9LmmTlUMDlRT00EhV3TFp
 A7iFfCQ0VSc69lR0DQI5tlQPJ7mRXqrCWwhv4tpu7fVzFil7/0lV7DTOo12f+hS2BUv1e+dfsBA
 aZyJHem/x8GerGve/eCSfVavMJuZf6C/KLK0nzTan8GAiN1ry3pK2dBnXXg/ULtKA2SzTWuiOuD
 ehlKUgmVDXwWiAftaYujvCGEE9uizgjjfy710bdBfvtGj1rU
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Mon, 15 Jun 2026 12:40:34 +0800, Jisheng Zhang wrote:
> spi: dw: use threaded interrupt
> 
> To avoid blocking for an excessive amount of time, eventually impacting
> on system responsiveness, hard interrupt handlers should finish
> executing in as little time as possible.
> 
> Use threaded interrupt and move the SPI transfer handling to an
> interrupt thread.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.2

Thanks!

[1/5] spi: dw: fix first spi transfer with dma always fallback to PIO
      https://git.kernel.org/broonie/spi/c/d322d820e0b0
[2/5] spi: dw: use the correct error msg if request_irq() fails
      https://git.kernel.org/broonie/spi/c/991af5d809a1

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

