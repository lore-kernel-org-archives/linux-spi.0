Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793623392;
	b=YZgN3V428eLECNEsz9UjU2JVaI+OwUbReZ1QmdjvquJW6oZAtvj7ZLhXfD80aAjd6ciR
	 TrT9FSjLGIXxNMElkdxgf0osDSh2I7hUSlbr0zmZcFIaUGZi1Qd41sLsordl7hfEuDQRh
	 QZH/aYMnuNxdtRiHNZt0ZBVBZfFcXhd4V4Fra/6tPVT/G7igihwKLXO14fjaHhK9QtPxj
	 QLnVpZCJ6h6H2GqbD4/WeKz9k8PfcTAZmHQRoPEx2Tkhh5JHaMpvcvJt2FU0pIiyv51Sw
	 PYy2gvkcgoflbTzxHj0Sbm1ldGEVNONRkOgwYelfMTzKhDAlPjKg2GD/PomQVR90Elw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793623392;
	h=Received:DKIM-Signature:Received:From:To:Cc:In-Reply-To:References:
	 Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=qh0+ehsvHE6sZydhz/Lp/6nlkZRPMxmmjl7AynibAx0=;
	b=MEa0jSLm8fGAMFPsSPtDq7+5bwS4TgZL9nu5fyW9D7fsk2wystGjwdEnu1aO6emXr4Bi
	 UCupzh8MvVZt1i2OPJJz+GtPPCPVowV7ugy4PSgv1Q5ah0zc/MN9XISlHigWglj8XfGIo
	 qIiiKZ6/ZPEgMTBYyVMpI6El1Gl3nO5lCjg4Z8NGyb645fsENdHglRXaFPGOfYE3LpAEy
	 RwkOUYR1BPshx8bg3/F7Vi39i73TpA7YPa3oD31mIx8UYAw9GCc81xNbyiOB1K4nclTuc
	 4dYZdMwWiwetLsGmWT9XDvWxPSkU9urbyi7tP4RjY137F8ApY8XrIJrCOjYwmJP+dug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=au8JYQzv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F0560A3824;
	Mon,  2 Nov 2026 12:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=au8JYQzv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ADAD1F00A17;
	Mon,  2 Nov 2026 12:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793623391;
	bh=qh0+ehsvHE6sZydhz/Lp/6nlkZRPMxmmjl7AynibAx0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=au8JYQzvnX/3dgoimqtxNT6thA3Ing1lgsa9xbB0ei4JV6aPqmMAui4T1i8d8NaPg
	 aQBFMW35BZZxrQVQKDAXf7VpMjlEeFf+Q4Hg87ssriCTcj4rTqbEmEHraKPxY0EkJZ
	 7bLPxqyNn51Tv1LXyV1UiGvtBkbprRDztMX/97bkoewVBD6aWeWRlQMLltEV9TGBQ7
	 hdqdmvCwCxNt1ahRuY+m6SXRU4opMkWd5PKAUx1aKPmZYNU2fbAsPMg9LFd5bQJvCC
	 Zi6CipFq5zpqSX5rET+ABnZTUwsP4oA2Mn/QiDr5CNk8d3V4hjbN89/UhJMAU73cOs
	 aAw5QN0a8DKhQ==
Received: from traversing.sirena.org.uk (localhost [IPv6:::1])
	by traversing.sirena.org.uk (Postfix) with ESMTP id B781D2310565;
	Mon, 02 Nov 2026 12:43:09 +0000 (GMT)
From: Mark Brown <broonie@kernel.org>
To: Gowtham S Bhushan <gowtham398gs@gmail.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 syzbot+41172204e7323356ecdb@syzkaller.appspotmail.com
In-Reply-To: <20261031023942.591298-1-gowtham398gs@gmail.com>
References: <20261031023942.591298-1-gowtham398gs@gmail.com>
Subject: Re: [PATCH] spi: core: do not WARN on OOM spi_controller_id_alloc
Message-Id: <179358012894.1776482.2352256641722105490.b4-ty@b4>
Date: Mon, 02 Nov 2026 00:42:08 +0000
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1125; i=broonie@kernel.org;
 h=from:subject:message-id; bh=PmH8KZ0cNk74D5K7ZlZfPgkATno2fj2DnqWIVQ6Ou/c=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLJetMbendLg9mpynNm7orgNhbfDNdRuJmYt1/v+69q3j
 7PNaz8/7ShlYRDjYpAVU2SJy+J+WV/yeg3fwYVtMHNYmUCGMHBxCsBElKsYGfZJcEk/dKvzcW4P
 LmW+v4pvZXhirOGGSJbOZpcdW2VetzIyTFPwOPz/uEfh9OqFF1783HF0ynxnW7V8d32nC/ccKo/
 PYgUA
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Sat, 31 Oct 2026 08:09:42 +0530, Gowtham S Bhushan wrote:
> spi: core: do not WARN on OOM spi_controller_id_alloc

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.5

Thanks!

[1/1] spi: core: do not WARN on OOM spi_controller_id_alloc
      https://git.kernel.org/broonie/spi/c/d65548129990

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

