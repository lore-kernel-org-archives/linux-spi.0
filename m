Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793706795;
	b=l4/HjvuJ8LY/7weMkv9LhL6CXH4C17OqpA419aX2xg7p/iaD0c1VBTiXI/6KQEhtw102
	 /YDvfnqOt/VtBgnmmdZnO7M8rXSLGaYWHS3Km2Cfo4K2bKjpq15xfqb1+gkz06kLstM0A
	 fyrjD/4aaJjxQ6ntwlbFLoBFoqeZs9+TaQQmEM/fiDVGk4/LkPHqJpFwJEsWPaNFeMBgX
	 ht5rA6dXMo5O7PVNSV3lN4PIZrJFbmcAp8ooFteQX6cqWc5Yf7KG/4Gm+9MsI1qs5lhj9
	 8GN0JQwVC8o1H+0S1PbiRlRC12G0Ey57/bXoAuxAMQwHJqfMmGNZA+eXsTvVT01opgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793706795;
	h=Received:DKIM-Signature:Received:From:To:In-Reply-To:References:
	 Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=QX4vvRkpVr0B80U59OYR0KCNPvp4g1VB7b3k3yNPpZ4=;
	b=PCNp0jSRTQalZrg7EFb+6kpl8zCSip4FuAa/cOuqcTBNCIhNBa2xrgmKUU4KSSSY5ZDK
	 p+77OjHdGb5FX6245GbpxDh5SGHzOX1dbGpKS+lPfrOnvbbL1f7ciFce7TqJICsEgWdC6
	 VSY4Z8A8ke4v3L9M8WVe1uk49mAmpdHnj8rFGYCOgiYEfzs5eht0uHi9NQF4oWxnrk+Xt
	 e2d0MtK3Qtw1KEk1xjP3KHi59sqpvEI3gJvqWAvpWcHGoh4SMPkNKwz+8Zv8lRQW+auTa
	 kq5wFMGswWnb60USUyQIrF3FUk9ATKFyraFUoVO+3rOnqXYKdV+ovKVA8rYnK/bZe7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EQEWA0Ld;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B85C606A324;
	Tue,  3 Nov 2026 11:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EQEWA0Ld
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA6C11F000C1;
	Tue,  3 Nov 2026 11:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793706794;
	bh=QX4vvRkpVr0B80U59OYR0KCNPvp4g1VB7b3k3yNPpZ4=;
	h=From:To:In-Reply-To:References:Subject:Date;
	b=EQEWA0LdkL+WaYQuTgDi2I+F52yCDuKksk7JPbpsk/R0L+yg54REe7AoH5MMYM3Ap
	 kMAYH3C5cf50p+SarjWctte1bPZrro2QfJ4kydJi0HrcrmIqZfbsLaluco1QzlQCtK
	 NNbEJ537LLA8sRlESlgKqbxfp/EOenCSI7SU+BQVPNlrK9Pxi8H8G74ylQKjCi638S
	 suEWo+Ix945UhL/yNsaq64qPhBuxKDWOD6NP5Q4XRby6P/8GFipmaEU1e7A7iC7qSq
	 W9JEiq2aub/rdA9B5GqQWPECRA6b6ED4OvdJAsZdqIJBrOTIAg7VYW9RxIVFaxHsWI
	 D9EttiZ0arnIw==
Received: from traversing.sirena.org.uk (localhost [IPv6:::1])
	by traversing.sirena.org.uk (Postfix) with ESMTP id 5B780253A5DF;
	Tue, 03 Nov 2026 11:53:13 +0000 (GMT)
From: Mark Brown <broonie@kernel.org>
To: Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, Felix Gu <ustc.gu@gmail.com>, 
 Atsushi Nemoto <atsushi.nemoto@sord.co.jp>, linux-spi@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Jiale Yao <yaojiale02@163.com>
In-Reply-To: <20261019084443.1824122-1-yaojiale02@163.com>
References: <20261019084443.1824122-1-yaojiale02@163.com>
Subject: Re: [PATCH 0/2] spi: handle runtime resume failures
Message-Id: <179365918672.2186205.4416835232546842511.b4-ty@b4>
Date: Mon, 02 Nov 2026 22:39:46 +0000
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1504; i=broonie@kernel.org;
 h=from:subject:message-id; bh=lIzAZG4+GOPocoiDdMsg4lKiIR+1ubBdn9tppcCIBMA=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLJentZ8vFpbfsnaPT+/fJ/i+rLa++T8CZyf9Nj6N955O
 OnCogzBBx2lLAxiXAyyYooscVncL+tLXq/hO7iwDWYOKxPIEAYuTgGYSB8nI8Nu9ZRFHBNLQrd3
 JEvO1ere9SHpX4bP2k+vFX6Uubz5ofSbkWH5x4V7Pj/9xHH17q7sGXErCpkjC0u2b13wb8Nj3Wt
 HPsXyAgA=
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Mon, 19 Oct 2026 16:44:41 +0800, Jiale Yao wrote:
> spi: handle runtime resume failures
> 
> The STM32 OSPI remove path and the TI QSPI clock setup helper ignore
> pm_runtime_resume_and_get() failures. A failed runtime resume leaves the
> controller unavailable, so following register accesses are unsafe and a
> later runtime PM put can be unmatched.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.5

Thanks!

[1/2] spi: stm32-ospi: handle runtime resume failure in remove
      https://git.kernel.org/broonie/spi/c/e359991c180a
[2/2] spi: ti-qspi: handle setup clock runtime resume failure
      https://git.kernel.org/broonie/spi/c/b21192833996

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

