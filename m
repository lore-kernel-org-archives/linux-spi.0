Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF613BBA04;
	Mon,  8 Jun 2026 13:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780926892; cv=none; b=hAQnlmqUGsUoFlvwSQwz02b/+ZYrLFO6YnFwtqrAy8cj43XeLSgNnUhrNBoRR1E5my8MVfItRex4VPjbqq9trScyZpRtCZEusXPLoVSKfpIW1/VZYNamm4KCshgElqOcedfAuO1wzO5t3v4F8hB78cEgqSWBXIiYgB2s2yrZCxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780926892; c=relaxed/simple;
	bh=XZwUk4gYd7bvOj1M2BG8Xl7bFSA7c/lvIF9Ur15c8b0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=kAeLghMQtjsNFCBDvc9XtTCySTQfbW0wNqsfbpQ/puUMTCz3rLIHzQZsI3PryqOQOAsPjVQ9sv0v1ebrHUvLZZkZfc4UEK5ERR6IF4U/+PueVll+GaK2EGa0m+ATb4dhL90LRECiPoimcWHt1MmPtOVvVXAslTtVByB9N9J+ufY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UNEuqhri; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UNEuqhri"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 387441F00893;
	Mon,  8 Jun 2026 13:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780926891;
	bh=C6WSfCC75CTFwHR+CEqQ4BCpZcFP8W3YS2kUq7cTC7o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=UNEuqhriHO0ui9+SjQYgYno7MMLi3lurPi0TLcAaTa+0D4tSlbadMSNiEiqrr/S1C
	 b68qLGp2lYxvItFldPF8nTTYdN1MSj/Z7/CaZLduIXDy2CZDmpqbwXpdG4wCqt4Uhf
	 j0snImovACDwtfA/oBhoL+GISM94SH2E9g66XUYyC/i7TC4qoguOvvtdt2ofLNxwza
	 VY6kYJnVDzLQxUfWKuoq3lRmATcMCRjZbXPOUq0C0JBmXBIRGbd4uwSq5mcLzUKfFm
	 tINmPBwlpiQVs889gmxjR1yyRuKM37afuKeoPPJfD7RlHah4VZujVvW82dGCv7x8uJ
	 H2TrbdpDmkB6w==
From: Mark Brown <broonie@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Rosen Penev <rosenp@gmail.com>, Jisheng Zhang <jszhang@kernel.org>, 
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260606-spi-cadence-xspi-revert-compile-testing-v1-1-76219ea378bd@kernel.org>
References: <20260606-spi-cadence-xspi-revert-compile-testing-v1-1-76219ea378bd@kernel.org>
Subject: Re: [PATCH] spi: cadence-xspi: Revert COMPILE_TEST support
Message-Id: <178092110904.121051.4683679381605487799.b4-ty@b4>
Date: Mon, 08 Jun 2026 13:18:29 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1111; i=broonie@kernel.org;
 h=from:subject:message-id; bh=XZwUk4gYd7bvOj1M2BG8Xl7bFSA7c/lvIF9Ur15c8b0=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqJsmprn2m9JBLVXzihguvOntTNr/3T+fpr+EpE
 dwIBzilvR+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaibJqQAKCRAk1otyXVSH
 0NOYB/0Q22nBtq70ZoAoUu11vu9P7ajA6PEqL2fEvHmu1urDlhfAQ67RPmw+mRLOMcWorLDR0h5
 k4rIESJE198JWxY0JBjynJYCHuju9TAqV2Z+vuy8J4j/1kiR+1gGykDJSmn5+NfmTju8rVX2VjF
 WT6kJEs9BeThDIzfqaRaQl6ktJOcHyBhun+iAhY9b42frb/FVTUpinXgt91/MtI45NzB84CuEsd
 fOUmBkhJ0NKmaGoGTIOv44GxqwDz6EIx4nhJREmaP1SG+ZY2t7M2wjxEEGxmw724nQecbx1ASdy
 HleXq0vULqRaRzBgAntYmLhXuaSACLYGzRLMUqSVDAKXs60X
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Sat, 06 Jun 2026 15:26:04 -0700, Nathan Chancellor wrote:
> spi: cadence-xspi: Revert COMPILE_TEST support

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.2

Thanks!

[1/1] spi: cadence-xspi: Revert COMPILE_TEST support
      https://git.kernel.org/broonie/spi/c/2fb242e4f375

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

