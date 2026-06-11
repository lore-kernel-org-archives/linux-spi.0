Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCA83F54C6
	for <linux-spi@vger.kernel.org>; Thu, 11 Jun 2026 18:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781201853; cv=none; b=Nt7YD3K/ETAa1P6lH4NRraatm21+xdwPAUcIDH+QWw41R9cJd9SVEN3oggKsGS5SCoKmtt3612t0Skdik8b8hjfbIc+Kcd8SdJgSSWh/ztaNDtUoiaHoeXd9yddiWHzorCzmO44q4CezLnoKxb3o/e65osoZ5GjhXsO0ZMy6CaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781201853; c=relaxed/simple;
	bh=W8+EOQoOD0gA2dKGqnRL2kg5kr5f80/ms/kEi6nxbvc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=mvmc/f9N8GmJzOtwEWzrhBfu79ymr96PuVCweQOuWkJLstTKCExZbxKq5ACp1ZBIy8FqPBGdv4eJkh4CX4tdvHr/LZ7Jk++q4Uo9LhsFziDZHTwrocMdelDXsRcYL4uKTjhRqlQ9WB3JRN4AHrsYfv7w8FzwDzxR1xg0ZIkBvhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kvJF2FLI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kvJF2FLI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2988D1F000E9;
	Thu, 11 Jun 2026 18:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781201850;
	bh=9quXLuafVpuj6orZK6Vsww2slOuRDaq3WXfRO3wgMZg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=kvJF2FLIZsxViBR3q9dAFzLiKgorxgxRDIxvTO0fP9sIj7dApqpDvPOy6kznjwvJl
	 Ftm8k3REz0sHE8ShPq7UPpr5czmVG07wOE+oQoIho0K/5LeNrbHKIe4TLF6UInbhlY
	 cnby5c++HapIJ6qe27iS4YHdFNU2m1DhRAXwrZWwsfrscWGlbGX4t+ghhAsCRY1x3r
	 Zrztgj99/iO9Tnk6zbhP6RFYqDAKZlXn7bcavl+jgK2WYqkOxaiGcsPMMwvsw1CCtE
	 /KkAMp9sH68kxBcP07myh8ka7JHzuZDdu4lmEa1tfavk6vjfT4uLvpdGaLOMKcFPRD
	 87NhqmeQEaduQ==
From: Mark Brown <broonie@kernel.org>
To: Michal Simek <michal.simek@amd.com>, 
 Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: linux-spi@vger.kernel.org
In-Reply-To: <20260610222843.782337-1-vadim.fedorenko@linux.dev>
References: <20260610222843.782337-1-vadim.fedorenko@linux.dev>
Subject: Re: [PATCH] spi: xilinx: let transfers timeout in case of no IRQ
Message-Id: <178118570057.447103.4262051279167519070.b4-ty@b4>
Date: Thu, 11 Jun 2026 14:48:20 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1121; i=broonie@kernel.org;
 h=from:subject:message-id; bh=W8+EOQoOD0gA2dKGqnRL2kg5kr5f80/ms/kEi6nxbvc=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqKvu3m5iy7JL7LXWCVDjXlOtgownT2ZXIOhcND
 lXBD4luBNaJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCair7twAKCRAk1otyXVSH
 0ChpB/4h90+rDQ5Oi9ZRH5Mo/Yw6wyWmkrvjW18djtSlc/eP0VhYh/NifRKuqonSOdgEbQIrR3M
 CUmmIYE6OYGZ4YhL99EVrfhQSqdnak2nUnjzHpzxw3xONdMGA4KV2JdPJxi3cAHTyoMkM8OhhQz
 xJfmROApw+RvUJamb7IdLbI5gcSy1w2Mb9rFeVPwsYTJU8KzmqeVvHDbVWoPo1gAVsvWh5hbTJX
 CDj61/6U45WxG+6yWfGeFZbA5s//rDcc+tYvLm6v1NfKhfKlzyxWFlL4qpItCeZ24qKAtCq0y9o
 mOm5Pd2DDnkMCBbF3QRBT+0QDR7g7JSf+95RI6Imrzak+qJh
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Wed, 10 Jun 2026 22:28:43 +0000, Vadim Fedorenko wrote:
> spi: xilinx: let transfers timeout in case of no IRQ

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.2

Thanks!

[1/1] spi: xilinx: let transfers timeout in case of no IRQ
      https://git.kernel.org/broonie/spi/c/0f95264f49ac

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

