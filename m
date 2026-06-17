Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E24F271464;
	Thu, 18 Jun 2026 12:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781787145; cv=none; b=U8UcH4KUapbi3diNui5QpS2YneRJq9rSQXAydfgJLtlUFpxi3/JuECmsFvphmzYRiPbIwgiWXr5se5vbtBDz5yZRM+66gZbUdp8+vlu5uaqIVUQlSKwAP3bQ8rZ3UfgfAchnFuwA5Q6TZ+k+3jScffK9iaHFr1esQ7nNGKEUMX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781787145; c=relaxed/simple;
	bh=uQJrtuGnG0WWanP84qoHW/qjQTASn02Q9dmXp4y3V2U=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=cyy0fZon2mYe17Zc6AL9OgLDPxb3JP8TOuiLjyW2KHg5fXen52D6hpvr8IKMCLDVVyK6RN9tmBQRPn675UAvkrT+uQknMUftY/vG0r0GUJ7YXVly8FnTpeKeGRXQ9WiFb+C89lAkXujXPwaMx28JLg3OcW+XRGXiOsgIRf5S4fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dXs/+z85; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dXs/+z85"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E6471F000E9;
	Thu, 18 Jun 2026 12:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781787143;
	bh=DbEE6vVMVLLwKGWgSCIlGAUyidkBz2v+BxlSm+ItCFo=;
	h=From:To:In-Reply-To:References:Subject:Date;
	b=dXs/+z85UnuwLWVsPfz86AmXBgBSz6mptFE+gMxp1JoSM4VRT+Yx8FciCDBoWyoEd
	 sjVx4dULb+vwTv+ns60m2WUCuUlvvAN/RVDp9U3FZ9cOWXkGZCiS2wq8kUD4FAfqSo
	 R1imfniKH8XEOBaSWc1Pr0g7MBqVVK15TKvdBUGte2ftKwoksdodv1KHJE0K6Oyz1H
	 dQruqCk2d33AZKN1hBjAky5IZdzXNQhz43VC2Cubdjc460HEU5cUsu1cMjNBnLyazO
	 G8+l9iaMyUlIGtxGps3BiYW4TDB5i+HIGNN6G3ybqTIGWz5prwjmRgZu3/w1lf64/j
	 xNweA9Bolw9EA==
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
In-Reply-To: <20260617092406.2649384-1-andriy.shevchenko@linux.intel.com>
References: <20260617092406.2649384-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] spi: acpi: Free resource list at appropriate
 time
Message-Id: <178170471559.38451.1368348135051947329.b4-ty@b4>
Date: Wed, 17 Jun 2026 14:58:35 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1115; i=broonie@kernel.org;
 h=from:subject:message-id; bh=uQJrtuGnG0WWanP84qoHW/qjQTASn02Q9dmXp4y3V2U=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqM+oGNmAQTdwlvihojFQqEJqCzzXSwXYMaHeK1
 cEK7DEYVk+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCajPqBgAKCRAk1otyXVSH
 0I8pB/44pS2fxg6Gyu69IMqDBaU7FFxohKr1ebu3fSxakuv2N3/GiZ3iJi5Xa834BwSdPw6dEP+
 nPj4xR3W72IbT57rjMIGLIlxhnF8lSnNKKdScGmIrfa36AR3s4Ym2Ry0dY2bNSEahbzwCDGpDh3
 IHF/Sb4Rzin3X0ct7t9WeNjZUEQej5VJhp/0mYXgKV2EucCoB74CifuBlX16DY5sXYpYY7KpyzX
 zFwchrf3RkBb+0FzABhSxk4NT44BHzMoMuysYDP05FgWu5MPJlg07weDlYuhuLxI5D/R0iFgCDY
 GnYGQDNZGl83My3DfTFg2+9hDzemy/6ywTUmkZY5s6Ogs33z
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Wed, 17 Jun 2026 11:24:06 +0200, Andy Shevchenko wrote:
> spi: acpi: Free resource list at appropriate time

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.2

Thanks!

[1/1] spi: acpi: Free resource list at appropriate time
      https://git.kernel.org/broonie/spi/c/12aad822fb9a

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

