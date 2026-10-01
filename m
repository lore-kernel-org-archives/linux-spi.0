Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60FDA40EB9C;
	Thu,  1 Oct 2026 16:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790871913; cv=none; b=thHwog9b2zQnx+UtWGVqktrxST5ykIkQOoD4tXrpf/gYQ0XTPWuQjeVhXjS8Kn65AFylVNLed/wjQPMHsPwPb/9RZ+iXkxdm/IIhFHDzYwCx0hgH3CWcNf2YSnwJ6IgkwVRsFCbOm9Ca3KSns/bPXDL73Asnu4aZXw0kenntkxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790871913; c=relaxed/simple;
	bh=9f5fR8ZygI3S5dEWdY7lx5HtciK5bTAcqI/G/2sc6H0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=HWjT7v4de19Th3wSw6TQqNgoRaq9A4P2ScN0QpRIjflMM8C/uoQs6uvdFC/nzWps089mOtt83l+3D79h8/WrUe1cg3oQ7dVbHb98VbEXFhpiFfq7HTwfDuLcJ+KE71//9jE0ULWJpOnCvCGniSVmWU8pQEvgOZDzCag0fAjy5rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZOeLoq1D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZOeLoq1D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19EEF1F000FF;
	Thu,  1 Oct 2026 16:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790871912;
	bh=g2t1bjhjsQZufZ2bN7/yFugZjIB+7TOJvTziKR96xgM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=ZOeLoq1DOo1FmvLQmJZb1pg/ciKrxKWiahD6rqkAKGqniDRXWAUQdT/rcAaPsBhs6
	 DdvZ/9skJw1hAgru7h7+QSy4do0cbo7cVnSL4870pIh+pwVeJJk+wluPJ+KQE3LB3r
	 eqMHCXDxb6V2kXwTlmAw7aW8tAXcEgYoisBPaZqQPK2JMVo1Cs2a2i9lp1pWqgkHF4
	 gsAC14nKChrs3hzHbpyIfT9wiv/pXgrIJD2S8BszOAdCg1EzxILzqQtoaVd53N122g
	 Tp4T78dQ+yMkmqKu2ET3G2Skhm45WN+9MjsKjtwV00jDZPi+X5GwTmGEQ/9eNItJ8l
	 Ber3L/WF5/PTQ==
From: Mark Brown <broonie@kernel.org>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: linux-sound@vger.kernel.org, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
In-Reply-To: <20261001085830.4014291-1-rf@opensource.cirrus.com>
References: <20261001085830.4014291-1-rf@opensource.cirrus.com>
Subject: Re: [PATCH v2] spi: cs42l43: Workaround for wrong speaker ID on
 Dell XPS 13 DX13260
Message-Id: <179086909782.90966.6333433430524340548.b4-ty@b4>
Date: Thu, 01 Oct 2026 16:38:17 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1160; i=broonie@kernel.org;
 h=from:subject:message-id; bh=9f5fR8ZygI3S5dEWdY7lx5HtciK5bTAcqI/G/2sc6H0=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLL2dabOaVX4U/PdybfGYZnwrsSm8Om3y3Vuiu7yMQwO2
 qiwj+VVRykLgxgXg6yYIktcFvfL+pLXa/gOLmyDmcPKBDKEgYtTACZyKYThf+1XfffzPpfrV/bO
 Vf9lc/lKv/tJT8Uua2lORoHQKTvS7RgZVpl1HX/15fTi8Mw7aUt3vzE2NY4VXfuoRjXA+nmGyfI
 zrAA=
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Thu, 01 Oct 2026 09:58:30 +0100, Richard Fitzgerald wrote:
> spi: cs42l43: Workaround for wrong speaker ID on Dell XPS 13 DX13260

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.3

Thanks!

[1/1] spi: cs42l43: Workaround for wrong speaker ID on Dell XPS 13 DX13260
      https://git.kernel.org/broonie/sound/c/cad16d850e37

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

