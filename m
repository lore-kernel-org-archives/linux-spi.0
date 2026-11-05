Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793963381;
	b=DuDqBjzKzOCc7Dsci515R0GKTM/mBlYfjtEs/nLxBtyxVHVBM74gYv1FuWrHJCHG7vMZ
	 ALQNdDnwmsnu5otxny8oTAFC6vycYUzy7k2jHygiAz6kvtdJ7QiJbDufAnFsjp3m6e0PP
	 sDHPRS7zKJeV6cyRnYDcC8Uhxitp9fRWqHaFs1y7JYznuPupXDU2IehzabIR4NO9FJF7n
	 nI1Qi7Zg6V7/f4PRVQi5Thf24tiEiDaw9wTOY3LebrnIdi/ViUcdJ4MQhbhh6kI7Wohgf
	 e2Q8+sI3+I0EX3re1l5sNxzw2lU+Vqek4snQYjMk3hUr0yzWpQsXvxqKC+Ark6PT7Gw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793963381;
	h=Received:DKIM-Signature:Received:From:To:Cc:In-Reply-To:References:
	 Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=BbgI/fg5Vv6TpV5LNbbTNKOCgVgDnfLxy/DdQCF/Nt0=;
	b=I/QRl9xJH1uRbngtg8qyfOxKy0j3OZeFyT/+paNO8EFOFz/jD8kSgN1rd5zTrahczhAp
	 RB1cv5fthjYPDqPv6377+zn/lJXdkJD3JEW3RaCx/KKo/4vnk0JkVli9U2Q0evW3JAH7L
	 XWtfmmr1bNG8kAN8gmIMeswvafJe+VZOT8sdd9zsenliGIpfakSR8mEUnLSQto2HoRhyk
	 RLZaV/3wOcyYxiBjzxeVb0arNyTHEcuE1wE4u2uh/bd3IcJf9JZwlypgzrgVw1UUhorgW
	 zVCbj9Bhty7Pp2Z4EtEwTKbLjVIo74DgAfYSYFCncoAZDF8YsBddSQOhMYVu/iNjy9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WQlq67op;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58641606A330;
	Fri,  6 Nov 2026 11:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WQlq67op
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64BF21F008A1;
	Fri,  6 Nov 2026 11:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793963381;
	bh=BbgI/fg5Vv6TpV5LNbbTNKOCgVgDnfLxy/DdQCF/Nt0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=WQlq67opXPqkif8MNGGSCwjy7SciDVJagjdlSWNRZuM4ylEbyBBDwxBGGk5POOxKy
	 7Dokl1dRtARuYheK7fwSEMyZQCiA+98Pe2iefyJzGPg9zppFx9InTAJM1oGD4eZIr0
	 UHdLUOkGChewbSEkTTQgJMjYuJPItVOh0Fdgsz8qNU2cUq6W4NpmvkdLzVCle80dMS
	 IouHDFBpdM8agJaqF0pN8ZLfwbq7mz6d+DYTqiJDmDeZLpGAgu5G6a5DIf+wzFLiGY
	 DBlGNho33XG9rwxxHiNrqwJV2K3bi2ocljTdzs4ZrNl5yFQnN3RLdHYha3goru9yVH
	 6oVk7S6LbgJ0w==
Received: from traversing.sirena.org.uk (localhost [IPv6:::1])
	by traversing.sirena.org.uk (Postfix) with ESMTP id 985D627E8440;
	Fri, 06 Nov 2026 11:09:29 +0000 (GMT)
From: Mark Brown <broonie@kernel.org>
To: Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>, 
 Takahiro Kuwano <takahiro.kuwano@infineon.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Paul Cercueil <paul.cercueil@bootlin.com>
Cc: Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>, 
 "Guilherme G . Piccoli" <gpiccoli@igalia.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-spi@vger.kernel.org, Bharat Bhushan <bbhushan2@marvell.com>, 
 Sunil Kovvuri Goutham <sgoutham@marvell.com>, 
 Tanmay Jagdale <tanmay@marvell.com>
In-Reply-To: <20261016102917.171095-1-paul.cercueil@bootlin.com>
References: <20261016102917.171095-1-paul.cercueil@bootlin.com>
Subject: Re: (subset) [PATCH v4 0/7] spi: Add support for panic mem writes
Message-Id: <179389951044.3073895.8929573229341803829.b4-ty@b4>
Date: Thu, 05 Nov 2026 17:25:10 +0000
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1312; i=broonie@kernel.org;
 h=from:subject:message-id; bh=z5DoyuXWSXWF8C2OUkElOyX4o16/3/SLC3dohqCg9mA=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLLebs0s2xu6SUPRbnGxcpn6s9fnv9bzWjtz9SyOeum4z
 CRqxq4jHaUsDGJcDLJiiixxWdwv60ter+E7uLANZg4rE8gQBi5OAZiIGifD/yzWTRUmRe5CPJt2
 a8T9kItRmHjXrmzuoeL1iq1HL24yz2VkOG9osDjdZ93Z+n5j6R1Fmo+6WznX6lXNWXPo6cYZSQ8
 9mQE=
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Fri, 16 Oct 2026 12:29:10 +0200, Paul Cercueil wrote:
> spi: Add support for panic mem writes
> 
> Hi,
> 
> Here is the v4 of my patchset that updates the MTD spi-nor code as well
> as the spi-mem code, to add support for panic mem writes to a memory
> partition configured as pstore.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.4

Thanks!

[1/7] spi: spi-mem: Add support for panic mem writes
      https://git.kernel.org/broonie/sound/c/20f1752b9241

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

