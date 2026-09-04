Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D604D4334C9;
	Fri,  4 Sep 2026 21:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788558760; cv=none; b=LdoMR2KguSGuV1rCWbZYEKm6353p5ThjdWdCjf9VHuKSUlC6f5Wk15E/5HIeSUhSK3xFyn7b00oStK9LBAS9Qp5zqwg6QYTJEHac5zV0DGD2pvaRQGNfOum34M/C25GhjneoXMGhcR66u3wccQ1uUpBprHNd+pxbmXu+76syQ6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788558760; c=relaxed/simple;
	bh=wMqTGoLLJbBJdQG3yMcjZTC7pXYDy20vC6SuyBvRLJo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=j5hD0fDNVce4CHSbR9zEvDXqG4tWpjJLxcZWVk0KROs5peVyWwrf2dAoOV7ChlWpBA+tlX5q4XHtXx+W/o+B5FcykGWLthnqdTo9heiRJGZ9SN+rNXyCTfKhJ9MwpG+qdlGLP3p0/eQmya7jmL27qhjP4nW3eRn0ctzH6yOsmI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K9bAKdco; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K9bAKdco"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4DFF1F00A3E;
	Fri,  4 Sep 2026 21:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788558758;
	bh=GKH0V4hja8nWjfqqL5nOFAxorgjEnccpiV1mnva5/Vc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=K9bAKdcopkCTj/44rV0xwnGclpm22P33VR4F7cg8Gf0C9XXttHdn8sAyVp6cZ3Hh0
	 dFUPUJV5u4yEU3SQqeHi+tlYBnFXpt2FSEFXlT2kl658SDqKbIJVDWi5i7EUOSrrt1
	 5TNa0jt5ebQk+JxCrhq3T5oteBVzwVNdou0G7Fvn5z4nET41Ff0LH/DJlJJtZwAK6o
	 8w9m7RYNTssud8stJLAQEWez2+VyuSFQAuI2FKaXRrOFstny+YJoy6Qe89ovtYID+u
	 bUT4mIF++8RjlE7wa2xpFz26ap0p/HVmS6AyVByjm9tCiJlhGsmx0ooslXuOiAPu7Q
	 0Cdn2yze8difw==
From: Mark Brown <broonie@kernel.org>
To: konrad.dybcio@oss.qualcomm.com, 
 Praveen Talari <praveen.talari@oss.qualcomm.com>
Cc: mukesh.savaliya@oss.qualcomm.com, linux-arm-msm@vger.kernel.org, 
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 chandana.chiluveru@oss.qualcomm.com
In-Reply-To: <20260818-add-shutdown-and-panic-notifier-for-spi-v3-0-8b62c4bc2d21@oss.qualcomm.com>
References: <20260818-add-shutdown-and-panic-notifier-for-spi-v3-0-8b62c4bc2d21@oss.qualcomm.com>
Subject: Re: [PATCH v3 0/2] spi: qcom-geni: Add shutdown and panic notifier
 support
Message-Id: <178854132667.632048.4537239412747313939.b4-ty@b4>
Date: Fri, 04 Sep 2026 18:02:06 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1689; i=broonie@kernel.org;
 h=from:subject:message-id; bh=wMqTGoLLJbBJdQG3yMcjZTC7pXYDy20vC6SuyBvRLJo=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqmz2iiQ9xIjdqZ6zxlR9RtZhSvL6vUbQaLcUKW
 KoWCrtaBr2JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaps9ogAKCRAk1otyXVSH
 0GKjB/wNotBhyfDDMn9yanf07RTps06HWZ6Lg7JViJnSDyFhkeYiexq1fGMdnJQp0Yte1jZ9V7m
 1sezeYkYxM5zxMz1WDgxcnj+7ywwaLSayTXFAGd94EJIYDHHm+6rEyGEoi/Kic3xCJsalYMayTO
 DQNqpfxUtp59PR2WTf2FuJnmmxBL2J8x67i0h1sKpWxABeUje19LXSOwV387PHfXZj0Fe/INxCW
 ST7OtUqA7WVaVtY4bmjJNBF/jRjYVZaHX1IDU5rDS8Clwm029Z5jyl+xJp9FvmcA2TqS2vvgWPj
 hQFks/V4+3ZcVAsB13O1u9papHvvvERh9p3P0p/h5pSqKip7
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Tue, 18 Aug 2026 18:58:06 +0530, Praveen Talari wrote:
> spi: qcom-geni: Add shutdown and panic notifier support
> 
> On VM-based platforms, if an SPI DMA transfer is in progress when the
> guest is torn down (via reboot/shutdown or a panic/crash), the DMA
> engine can keep issuing transactions to IOVAs that have already been
> invalidated as part of teardown. The SMMU then raises context faults,
> which can affect other VMs sharing the same SMMU instance and obscure
> the real root cause of the crash.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.4

Thanks!

[1/2] spi: qcom-geni: Add shutdown callback to quiesce hardware on reboot
      https://git.kernel.org/broonie/spi/c/3958b39fa5b7
[2/2] spi: qcom-geni: Add panic notifier to cancel and reset DMA during panic
      https://git.kernel.org/broonie/spi/c/b7b192e58f35

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

