Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D3C41E6C9;
	Tue,  4 Aug 2026 19:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785872507; cv=none; b=AXU00wONb19jMHjPd6ZZ/j+7teu/Xw6Voa6MdhQGUip1iKRHucUQrNyRcxc+Z4taB5WBjwDOMv1AFa8Xs6alUz2CgMgW9mtlowt1hyBNl/gyhPuwDlbpOt8xm+clYsMRpmlmJnNps1fQylyBxtOMyk7X2vTlJEByEyJzV4+v5Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785872507; c=relaxed/simple;
	bh=USlFxTYxBfdRtNbOprpMAEFcqrQR/2fxm8aG4BeQqWQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=LoaWwollAjYiTjdcAzEnDuvIBRFGcCklHBWwzigldC0DaxqxTfY7woAQIVgFXPwGIaJMNYr9QarqNuAzlfGRj5KfBtkHpSQDQisZsLYpfSkNQr1h9xT2HrKCm5gHjwKSHPQ0bfn+nuwvB/CT2QRxo9EOQlFhYGEheSPWH6aUs8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZShgQ7mL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZShgQ7mL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E7791F00A3A;
	Tue,  4 Aug 2026 19:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785872505;
	bh=/LGREAyP1JDG5dhqw6bsPzQU+seE0xa1V0deaLkbCcA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=ZShgQ7mLTFEjbxgQaXpvWn8dFrISmkJwJmtIUJQQ7xGtMMqRUlEaTrfMn1exYNIKb
	 Vt0/CAU/eBGi5/js2j2Fp5FtPpeb7mmSqisMpgp4oUEMAnVLiJ/bS7W51vetnRzwZE
	 fr2JB0CdEoM618IgF2qZvG/E4+7p5F9asaxVR6bFZ/q1i936adtEwMG7O+ab9Ftu0Y
	 RNwX/NLKdo2lHa6rxWVsKTkw5yGpPq4gGYJ+4sBTBQtbB96hlO7tCEZ6rwsu2fccZD
	 zg4PIspBBB03yUZuZAi6PH0enosudywiN4eWPdaeRqqi2tulfj1u4HAhd2mBTlHMuS
	 MZhk+mJiw8row==
From: Mark Brown <broonie@kernel.org>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260803140728.12747-1-jszhang@kernel.org>
References: <20260803140728.12747-1-jszhang@kernel.org>
Subject: Re: [PATCH 0/4] spi: cadence-xspi: remove 64BIT dependency
Message-Id: <178585067184.111355.3780002274805282993.b4-ty@b4>
Date: Tue, 04 Aug 2026 14:37:51 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1990; i=broonie@kernel.org;
 h=from:subject:message-id; bh=USlFxTYxBfdRtNbOprpMAEFcqrQR/2fxm8aG4BeQqWQ=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqckB4K1H9Rk9mj1TSjVQ6vRf9ZkaSbwuL2/ek9
 PhcMP9HS1aJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCanJAeAAKCRAk1otyXVSH
 0NFjB/9KsbOsIQ9Tx+RRVqp7CshuN5o0fhbmgU9/zRuFGrNfChYxRf8seqh0ZMsTxxBF1xrn++/
 VR5qMz5zvK33NlZA6uu72booiK+edSmR9tdbg7bu0Cj2mN5/f1JX+n+y9mSjG91Yp3+s10PwKIZ
 m4R2RHGnHiwSzRxX6ZioEbcWKnh/um9Zx+r2xynDE1SU/Yjl9sUR9lRD/Y4EmDCEzzFfG6n+avl
 l5vf5SuL1ErDttq3ZhiOpXf2aHZ6B+0WB5IJqQ3xNQRe1hu88aCuBPmtAItro7MhUvN1n1ehvxd
 d+Cml5cJVPoFlSxvBsnYZwHQyZGFSTGesmOBENBkbUo50c6e
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Mon, 03 Aug 2026 22:07:24 +0800, Jisheng Zhang wrote:
> spi: cadence-xspi: remove 64BIT dependency
> 
> Currently, cadence-xspi depends on 64BIT. This dependency isn't from
> cadence xspi controller itself, but from marvell support code and 64bit
> slave dma interface performance optimization.
> 
> This series tries to remove the 64BIT dependency.
> patch1 is the preparation patch to move some code so we can group
> marvell support code together. No functionality change.
> patch2 and patch3 remove the two causes of 64BIT dependency.
> patch4 finally removes the 64BIT Kconfig dependency.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.3

Thanks!

[1/4] spi: cadence-xspi: group marvell support code together
      https://git.kernel.org/broonie/spi/c/94d031d26168
[2/4] spi: cadence-xspi: put marvell support code under CONFIG_64BIT
      https://git.kernel.org/broonie/spi/c/63371e187e9d
[3/4] spi: cadence-xspi: only use readsq/writesq under 64BIT
      https://git.kernel.org/broonie/spi/c/0ab32c1c2b6d
[4/4] spi: cadence-xspi: remove 64BIT Kconfig dependency
      https://git.kernel.org/broonie/spi/c/54a6b7fe101c

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

