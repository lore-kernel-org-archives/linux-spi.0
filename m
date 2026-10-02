Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D540D420898;
	Fri,  2 Oct 2026 12:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790945934; cv=none; b=Dq1DATWiFIvdaPvST0T+1rqxVTxmzIyG0aRTPx5c+xQhIwsbH2XAmRSJyONk8k+1fLDv7USo2tthjo5LBrmUKKJdnYuZuqixxfNf6Wnl8D794pUl0ty33u+76LBNk34BqwUpGOe4XUuTWFgGzuzlaGOPuSNAZhEAfTwzoGeu18c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790945934; c=relaxed/simple;
	bh=ZZog2DmzD6JYHzIOPkxymMrGPQfxhMFEozr7PgktX+M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=CdwoScDkT251BYzLJQzq4A4wk62l6uLX++bXP8aBn+dy584nbfJoXynDPgfJtXY2Mf3tQ67Vh4D2FlD3cMA7YqyGD2qNsq5sblHw8pW8nWCCgUo5L5OQcNCRixDDxXNTkSoL31QSoiZX8bM2a9HEsJegsFh/cmICmh0j6xhHjks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E9fle4+S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E9fle4+S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 373C51F000FF;
	Fri,  2 Oct 2026 12:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790945932;
	bh=+2V7CaCvNrpvmbbJwh1WNIboZ7/7dvdjBHWJRak6y1Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=E9fle4+ShkEJyX93P+zCxQYNpaiuneKl3cDuESA0qdhga/zr0Ff9pWRe2/xTdmvjB
	 AEbEc4auXu8VPovNsWl5nIOEtRIM5wkOzM6GdyK/QSDaT2gNyJItsXcLCARk3Hsb6j
	 +GbRVebu96DSgkaQ3+mOmF2lTpnyPpBBtlehuvJz9ASppldg3jTh1AyfDtmGxOZTYA
	 J9eHakUB9H0dbNy1OIjXT4OCUGJVbHs4EoFCMrnXVA8Ka+LO8qgj6mMMG1UZ98hBkJ
	 zjFWDJblHXXQ6Dc9QZsiPF95hn9nOqfcxjokndQLJRkOyhxJgrSVhhsRIyfgU430bk
	 Tk1hl2Acsveqw==
From: Mark Brown <broonie@kernel.org>
To: corbet@lwn.net, Jesse Jeronimus <jesse.jeronimus@gmail.com>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org, 
 dlechner@baylibre.com, skhan@linuxfoundation.org, rdunlap@infradead.org, 
 linux-spi@vger.kernel.org, linux-doc@vger.kernel.org, 
 driver-core@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20261002110752.89529-1-jesse.jeronimus@gmail.com>
References: <20261002110752.89529-1-jesse.jeronimus@gmail.com>
Subject: Re: [PATCH] Documentation: devres: Remove non-existent SPI
 register helpers
Message-Id: <179094140888.83544.16333779168176030027.b4-ty@b4>
Date: Fri, 02 Oct 2026 12:43:28 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1143; i=broonie@kernel.org;
 h=from:subject:message-id; bh=ZZog2DmzD6JYHzIOPkxymMrGPQfxhMFEozr7PgktX+M=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqv6qHzcBcA5vqVY30uOJacgpKRb5KhxuteVUaF
 O9UU4iPNHSJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCar+qhwAKCRAk1otyXVSH
 0J9+CACApkMvr45KcscqprNr05WFgzHatE5NaDuGAQfG3KTKeaqP/9A4Go4QB+/L8Q795h/BS1v
 V9DUWAEn7XLRhXUt5yE7UkJwVpxmobyBFlPsfDa28YkaK9ENi0R9d1lCj4kOOJjcNbJxsx2q8+h
 94Z7+c3mlClSGd1ZQC2SH+UyM4/l6W/S/fxgtGtGJKqxU2+LQp5S8J/5Bsp6bLI95m7xnyIp6XP
 Pyu9f+Z7a5CjxUP/QF6yYvnytfWWTfa1AfAn8yyv0X+Fj/3g+TWqMsUV0T9VaYqLi6AzYaxuGD4
 2/4bt2kdyRkjAyay7ew410tzzUZf/BZuVkVAK7fiOEQii9jx
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Fri, 02 Oct 2026 13:06:46 +0200, Jesse Jeronimus wrote:
> Documentation: devres: Remove non-existent SPI register helpers

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.4

Thanks!

[1/1] Documentation: devres: Remove non-existent SPI register helpers
      https://git.kernel.org/broonie/spi/c/d220c9443db6

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

