Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315EA4B402B;
	Fri, 25 Sep 2026 14:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790347031; cv=none; b=QW5OyRkZRCYyK3cSXNA7zmXWwjicnELePH6nRTJGd6NXUcApdLgD7KeBtdxtwc4DS9D/zNQCFUl4ByMcgOGtmMD9IYSEOtVYoW4CV+k72MJgfFCbtAfUkjjGNKDTq6CGOsEPo+96FzCPKcd+/jyap0R+q5u/UeaYeKlUltt58qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790347031; c=relaxed/simple;
	bh=Bl8IIvnrQVF78k9CwRS6UimdhKGAw+yT6CR0DBASK9c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=FM/vt8CFRhrNB7EdDPdHBkM9JoxowFgNJ3+NZg3GsiBhJoRspsQTvv2euwlbDxWcWOy+9aJJKLiIStwns0u2ljxIt2IUcAm+DsLBjxxc3WVvVLSDCwSK7ZRptU21dGOgt5tFCzWbXnne9gTrLEkbbmNIbm8cLZqSjuTJfblO+y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ov7XUgnO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ov7XUgnO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64FD31F000FF;
	Fri, 25 Sep 2026 14:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790347014;
	bh=cvAmkNGNZHIJA9jAO4iSuxQA1wy1fFQU2RxWWTWGcPo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=Ov7XUgnOGfeuQqMWBzw8TAUmlsxOjlYGNRkhwVaVb/cDv/ZAFrRVhfuMwNRsmxO7b
	 M+WEwlYs6It+jmHao5vOANPLJDfiKFWwYYQmioam2jhzxhyVO8Xry0cHU8XuznySNl
	 LsgqjXHwF2Id8OweWjjKe4+38tjqhNFljURadZYe2SkJtxHMDL4pRvCfzk/Z3n7Zh+
	 s3SXEarNW/1FdBL0ki+zNU6eH8v+ZMqRN83FDWji0U7uMGjVus1IqU+nhd5Ke3tJ1W
	 2DG2Ri5QeUZe18TZxcG/fg2M2D+jQkW2+2LZwycUc3zvxptM0pyeLjWO64Vn+6Q6y5
	 /gZsLupZyQkGQ==
From: Mark Brown <broonie@kernel.org>
To: Heiko Stuebner <heiko@sntech.de>, Myeonghun Pak <mhun512@gmail.com>
Cc: linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Marek Szyprowski <m.szyprowski@samsung.com>, Ijae Kim <ae878000@gmail.com>
In-Reply-To: <20260912190056.42192-1-mhun512@gmail.com>
References: <20260912190056.42192-1-mhun512@gmail.com>
Subject: Re: [PATCH v2] spi: rockchip-sfc: skip DMA cleanup in PIO mode
Message-Id: <179029098401.149798.8341951933332552529.b4-ty@b4>
Date: Fri, 25 Sep 2026 00:03:04 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1109; i=broonie@kernel.org;
 h=from:subject:message-id; bh=Bl8IIvnrQVF78k9CwRS6UimdhKGAw+yT6CR0DBASK9c=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqtocBvqGTj+b5fo6Ahw9OKlEee+FqycNDOFXcf
 4naZISe77eJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaraHAQAKCRAk1otyXVSH
 0FyUB/9K285S1zV+w4jnqNyJaxxOfonuY+dEOlOwwYn+cq/TTxG1z8ppKzl2MN5xDBiThkbyZxL
 U9aZVjdBU6dUu+3iwHlS00noXjkICx/tiGEfn1DAcuXuAlfqcL7n1cfcGEuImw8ApSAoROOQLij
 SCx6guIZmMjyBW5HalzHAjwWy2/RlRO3RYxA9CLABj+Ecg22ewvlZYAiLdpPfktoaDJU9V9RJuV
 Sw2kcn4xC8w1u1vMKuUP+70Ei786DkATT04pK+8SpBToFjqhS9EykIIz5oJ15Wu3Y3Yca1MDiCY
 7+D/YcT3TIh6cqLm3Tz28p77Tn86/cDckwll52oe4pcU2re/
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Sat, 12 Sep 2026 15:00:56 -0400, Myeonghun Pak wrote:
> spi: rockchip-sfc: skip DMA cleanup in PIO mode

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.4

Thanks!

[1/1] spi: rockchip-sfc: skip DMA cleanup in PIO mode
      https://git.kernel.org/broonie/spi/c/926f9c44a76f

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

