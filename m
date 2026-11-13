Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794592900;
	b=kybzwTKJd33YbRxDGt/zWeF9sFlR1kpF1ELkD3iWtp/r/NIlY7+9516Bq5LvpjZ4v3mY
	 SU6+ODm1J+e/Z+7Z/xoIbrAmeKa3LlTuNVUI9yjNXwq32lGdxeg0P7lxeHJQQTzXVQ6aD
	 njGCEc3RstJGbCR9jTF9+1csdow2Kd5+Kikc5Fn6ODt2jYMq7FjfyBfsUbYolUtRgYHHJ
	 9OX9I/T642mLq1bdkKRaKiK7CENBGTSU4gwph2b4tbjsRT11NLAr9sp3nFB2uokkcJ8w/
	 yfVNAhk+KG+9pbQ990ajXDJDO5352oRRToMkKcjoA0yMaLaFg+godtYSM8t174uH+6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794592900;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=fei6i2HUpsCUUYKRfgUiNwOal5hCWRa/kM9HPb8mLEw=;
	b=D+n+PBQazpOdDIi5qEQoqL8Owbp2142CjG/J7b5GLKm9C/5nvTA/S68wblMPaENhR3GR
	 8F4QSiwFTNp3a5xVHUT+13iD4q/NV70BJJgHqvhdZyX/NarHqdjvoxo4np1rSB56K+0Fs
	 j/FVNhLL9NqrpwNVbFC0ATAUhkh+NoIT9cc4zi7jKLkDhQbz3i3bixkOc5unogaREBrL0
	 CZXmgdbQhAM2bRpPFY8Vl/LLJn/GstWV9hdnbfTk9xM4lU2lICgCZShUD7FbzeT7m11Pv
	 TLCAS91KJ/fy1iLS7kYkNCtI8rHFpZa787dEZLcdZjg5XwFIwftw01S+IuZS4o8Zouw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OEpv5h1y;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC0F606B220;
	Fri, 13 Nov 2026 18:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OEpv5h1y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B5A51F000C6;
	Fri, 13 Nov 2026 18:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794592899;
	bh=fei6i2HUpsCUUYKRfgUiNwOal5hCWRa/kM9HPb8mLEw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=OEpv5h1yLV8OFSZCu+UvI9BFOHqrnvFckVSjU/GYLfx5ZBm9/kvEbk5qoXxf4ymd3
	 LzsezAE7ZUDdfa2vop6R46I0l/7PPU8lNtAfpvfT+njTsRclL/A4PnUxs8wGSa+ANs
	 FQy8qFfhmL2kXJaTfLpSP8TPUZlSoSRQ3wujKaYqHSlxRHhpiYHQTc/6u7QAlgcGs1
	 y0R7XofHW5AFhHKXiJAyA07DeMWCTshwJmNVW5wv+Vhyj1U8G/9nDjIO887fTxAGDn
	 0m1zoQ7/KnP8oCQTSJF2FJ6OlPnBmT/gcoT9UPFhOHbI21ryaBmS/+KFokoi1MWgfO
	 93EW87uYExEtg==
From: Mark Brown <broonie@kernel.org>
To: Binbin Zhou <zhoubb.aaron@gmail.com>, Yinbo Zhu <zhuyinbo@loongson.cn>, 
 Huacai Chen <chenhuacai@kernel.org>, Binbin Zhou <zhoubinbin@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>, Xuerui Wang <kernel@xen0n.name>, 
 loongarch@lists.linux.dev, linux-spi@vger.kernel.org
In-Reply-To: <cover.1794538736.git.zhoubinbin@loongson.cn>
References: <cover.1794538736.git.zhoubinbin@loongson.cn>
Subject: Re: [PATCH v2 0/7] spi: loongson: Fixes, cleanup and IRQ support
Message-Id: <179458651530.68977.3697194516871626286.b4-ty@b4>
Date: Fri, 13 Nov 2026 16:15:15 +0000
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2037; i=broonie@kernel.org;
 h=from:subject:message-id; bh=GPgo+uG8JpRAExqEI7ahg9NF4Ya79KVDkuNdAF1ApAY=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLK+BzQE34pdqFN7YvH9ssrjkZMil4aZez89Vmep2vZqA
 7PK7pv9HaUsDGJcDLJiiixxWdwv60ter+E7uLANZg4rE8gQBi5OAZhI0wpGhrO3n+YsM0jp36w9
 uaorqih35s7pj42vHjb8s+xf+G71S0sYGVYJLXMxjd22udf5+ab9AkekJ3/j2SF6bTujVHzfj8d
 JmVwA
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Fri, 13 Nov 2026 13:42:21 +0800, Binbin Zhou wrote:
> spi: loongson: Fixes, cleanup and IRQ support
> 
> Hi all:
> 
> This series fixes several long-standing bugs in the Loongson SPI
> controller driver, cleans up register access, and adds interrupt-driven
> transfers with a polling fallback.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.5

Thanks!

[1/7] spi: loongson: Fix incorrect SPI mode caching logic
      https://git.kernel.org/broonie/spi/c/99967afeeffe
[2/7] spi: loongson: Drop redundant CS deassert in setup()
      https://git.kernel.org/broonie/spi/c/d60a8b838ba7
[3/7] spi: loongson: Make suspend/resume registers PM-specific
      https://git.kernel.org/broonie/spi/c/30d93695c357
[4/7] spi: loongson: Fix clock rate retrieval on ACPI platforms
      https://git.kernel.org/broonie/spi/c/39a0b497e0db
[5/7] spi: loongson: Fix clock divider calculation with explicit table
      https://git.kernel.org/broonie/spi/c/fdaf557e63c3
[6/7] spi: loongson: Use bitfield helpers for register access
      https://git.kernel.org/broonie/spi/c/834d129ceef0
[7/7] spi: loongson: Add interrupt mode support
      https://git.kernel.org/broonie/spi/c/bb8651fab896

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

