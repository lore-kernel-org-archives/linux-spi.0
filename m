Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1412D97A4;
	Wed, 28 Jan 2026 13:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769605588; cv=none; b=bnlmsUr0c8JekQvm0074ZUOKe8MZ7lOEUL57/vM3//+yRmCynNKnrxLoDlFqoGC1ObIMoxZjVQ5OSizaDcDpth4l1LU1uyiecP24qoz1PA+fczeD9ue3fUbJtRwFV/8kzSTYlIDGkixPIqAhzuVmlS8y+2Yf+bLB09f1rSa0Qvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769605588; c=relaxed/simple;
	bh=r1fZSr0IvTlpuB5HuW79n7uRT9PQV/E04hDgpki1sK4=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=rzx5AZ7K6pxy8KfQGiayAmdJaINhMofeXdPgimJeKhzhH82LmXCg37z8sMoQcfJGyxSqqrwJ2HDg2Cj48pDBmirFRYTJvGmQgIDUwswha7w2i/Vkp7//1GKIDbZw6TkeN+QHobgYgDWejYNRkOnMhiBlQadz2sH/eXmyQ35QCsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MCsYeive; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MCsYeive"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14FC1C4CEF1;
	Wed, 28 Jan 2026 13:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769605588;
	bh=r1fZSr0IvTlpuB5HuW79n7uRT9PQV/E04hDgpki1sK4=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=MCsYeiveMYPiB7ZQExQ9ogtkxyQWW3eRgEK86jrT+0LHPiEqT1AtRnyk2UbQ/9ip/
	 DAneno7wnREaFR8NlvLUh0VLtAGxu97Pxe8Docd99OuI9vdQfq78xTRLEwbTp18cWo
	 36kbAW6nCjAv49rcJS0/QhnlnhMKf6/GVCLX+hKGMiZOiF+bwlNMHwvhhd6lxP/YMM
	 5D7tVIGEs3B6QI+2q2VN2/q5Y2OBajeP+zdYZV6CU6dY5jlGXfhaCLrsXv+ZiFPnqi
	 hQcVMqc/qZhnv1ZUv6/3q/8arNGjjIyBXHS9RYx/ZB39v2LhA0Abdk/9x5PZlelNTE
	 lRMtuIXj5NEPQ==
From: Mark Brown <broonie@kernel.org>
To: clg@kaod.org, joel@jms.id.au, andrew@codeconstruct.com.au, 
 linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org, 
 linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, BMC-SW@aspeedtech.com, pmenzel@molgen.mpg.de, 
 Boris Brezillon <bbrezillon@kernel.org>, 
 Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
In-Reply-To: <20260120123005.1392071-1-chin-ting_kuo@aspeedtech.com>
References: <20260120123005.1392071-1-chin-ting_kuo@aspeedtech.com>
Subject: Re: [PATCH v3 0/2] spi: aspeed: Improve handling of shared SPI
 controllers
Message-Id: <176960558580.1648911.5452842376187241181.b4-ty@kernel.org>
Date: Wed, 28 Jan 2026 13:06:25 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-47773

On Tue, 20 Jan 2026 20:30:03 +0800, Chin-Ting Kuo wrote:
> This patch series improves handling of SPI controllers that are
> shared by spi-mem devices and other SPI peripherals.
> 
> The primary goal of this series is to support non-spi-mem devices in
> the ASPEED FMC/SPI controller driver. It also addresses an issue in
> the spi-mem framework observed when different types of SPI devices
> operate concurrently on the same controller, ensuring that spi-mem
> operations are properly serialized.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: spi-mem: Protect dirmap_create() with spi_mem_access_start/end
      commit: 53f826ff5e0e3ecb279862ca7cce1491b94bb017
[2/2] spi: aspeed: Add support for non-spi-mem devices
      commit: 04f7516ab70f7b82aae1d2830af2ee6f17f3fe98

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

