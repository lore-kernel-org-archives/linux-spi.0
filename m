Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795723089;
	b=SmU/1XcNNdkrVgAhz5TZC8j2k48ige2hTOy4j9VunWmYu/c+XOxXYhAToC0wGdvaxNpE
	 bwXSREjXiv9m2rzHFZbaguR9DTZq1EjHtIw+3IRsQoloBHQ8VD+MbGpqh6k21Z4lqYqnr
	 aCA0gW+JKWxoc4h0fAocnMVnpFa1M0BhxQEhIcDXLszVW+yqoIL+vgdqd0FIw6WO1bweJ
	 Hn30eHPSLptJdQ6sjrkoXwvyb0i30+TEftWAfRm+H0MuoSHiAWgYAMa5OW/X3eTLdAgta
	 Zfw1aIchPfhGBB2wMMROGRNMl5Yd1TlK5Q2/bmTf+aKEMu2PeltVEzRBgGNYu+ev0SA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795723089;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=o40ZMp6L9GWuLZgBO++kzbO4ADAkEmeck3FmFKYHjlQ=;
	b=jMOIXviK0aOwBzcRrFAfAe4UDYGZcM6gWosXXKHkPeyPauK1jcMCae2O3Ezjg+beO/A6
	 M6RaYOEsM1zPPtYb9cwA0a8BiAyUynYHHL+vDSYni5XcQVgw1pAk2YMfJqjmuQGiivTSq
	 3TKHKkY7t2HiGCReajqBqEYeoAzMqEwwFyLoD8TmZVVnl519AecZXWcqW7WXOy8vPhe5c
	 cVTJbJYGHKFL0FTY90YO5iFF7oYnJt1xHibUgmYe9nm3J5JQMA7OodgOtUPGixTV/6uCE
	 Up5bdr5f5vTEToKY6Jbc49dg8vqxSjdpCItVuUYGJ0S23fm5cUGnHt+I1wU8am+G1lg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lHwQz4KV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C1B606A31C
	for <linux-spi@vger.kernel.org>; Thu, 26 Nov 2026 19:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lHwQz4KV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C5971F000C0;
	Thu, 26 Nov 2026 19:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795723088;
	bh=o40ZMp6L9GWuLZgBO++kzbO4ADAkEmeck3FmFKYHjlQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=lHwQz4KVbOL8Dtx98oGZeCbNN0lwsbJqj9/lxN5GETrtkTyK49uSb2QdCn4fegZKC
	 1qtlLDM7xbSuSsMfgq5WdDuxtgsAUjb7Ir+ji5QreBSRMGl/DfDrWQZI4xpZvuCUfM
	 qke2Fi7ssSTFiFEJynXOmtR8NYCKZkHSqu2REyLbTuagwM+8cGfOLr4Ys7eaIyBnxK
	 gbDfR1entLB5ahyg8upPQ6JFoAC1feA7WovkVsShDvBXZXvel38pab/WqDv8G6eJ3Z
	 q51wRGHlx+nrB40+whykWahtiPP5YJKYDrnJn0AII26psRjFhQvyjk9pOK/w3qOZPn
	 4D2rQFmzMFBFw==
From: Mark Brown <broonie@kernel.org>
To: Srikanth Boyapally <srikanth.boyapally@amd.com>
Cc: srikanthboyapally2026@gmail.com, linux-arm-kernel@lists.infradead.org, 
 michal.simek@amd.com, linux-spi@vger.kernel.org, git@amd.com
In-Reply-To: <20261125-zynqmp_padding-v1-1-bc0f925fb898@amd.com>
References: <20261125-zynqmp_padding-v1-1-bc0f925fb898@amd.com>
Subject: Re: [PATCH] spi: spi-zynqmp-gqspi: Initialize padding in partial
 TX FIFO words
Message-Id: <179571178855.142532.14702744978738116513.b4-ty@b4>
Date: Thu, 26 Nov 2026 16:49:48 +0000
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1152; i=broonie@kernel.org;
 h=from:subject:message-id; bh=IIalJbyE8LsWWpe1urHO5EkM+LIwpwhzuPkHVsTPR40=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLI5+n0jN2q+35Zzt+q5riHrdI6YGsXS9ayLBLZNnvyg9
 BqTrO7LjlIWBjEuBlkxRZa4LO6X9SWv1/AdXNgGM4eVCWQIAxenAExESoSRocnllMnCbfd++jYa
 LJryVu6AcPiLWR2H4sSO1t2peHw2Yx8jw9Vtcvyt2nwCZ8rCw8I9d3qK7GuN+Zr9YLHq1XuZtR1
 XGQE=
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Wed, 25 Nov 2026 23:12:50 +0530, Srikanth Boyapally wrote:
> spi: spi-zynqmp-gqspi: Initialize padding in partial TX FIFO words

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.4

Thanks!

[1/1] spi: spi-zynqmp-gqspi: Initialize padding in partial TX FIFO words
      https://git.kernel.org/broonie/spi/c/f1fcf7e295c6

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

