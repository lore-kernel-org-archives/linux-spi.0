Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2DE1D416C;
	Tue, 29 Sep 2026 10:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790676202; cv=none; b=dffVHUTMliqQr9uiAiDPrKyMZAri3WghzEL7xAjJ4lY6T2o8SPpoko1k6RptIaJgpkj0RnFhOGGEnPwLFYVpDsmW2tBcMVD6IrhuOrb+jdg0xkR843owUyeeOwpGkkkqV3pjxfFtLYvVvUszAFywrmXJxyaGpq9moMKNnYUoMoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790676202; c=relaxed/simple;
	bh=sQF1ijqj5LE8SBRqGw2k8iUqXxg3AS1UFnSFnLTDrXs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=fmeNB0dBQBowx1QAu6I+LqqkTiH/RCVroHoRzNccWo8mrQtVLjS2DCgwH796scbN8QVjGqRjBAoe8Gsj1EwRCzmey7MG0ehjsnmqI9aoFHoBt9THLr7lUqRbM83EN+X/DfxWXOSqsJbUWV8B/wZRct+XwNY+nV62KpG1PrB6GJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OJjHn3rE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OJjHn3rE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 902D01F000FF;
	Tue, 29 Sep 2026 10:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790676196;
	bh=fyV8wdbA9PD/PC0vY6GD6KQo9xffIYODnSB/nuBnSD8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=OJjHn3rEtKkIZJeeoOOe8w+ALm2QpbJxV7+jT8BnRQ/3F/EHqsSocWLl7Huy2qanU
	 oR1emfORSWeRc/W+MPRPrDbk5pxtObsTQSQIoVEGEC0FwM+YBa0nEA8Ixf7LHH0Wsa
	 /WWn36G0FiNdFD9LSPNwSrK3sRmqMsEdFY9cCfc4ovojtR8c9lH9zPw8pjm63dvC9C
	 9gyMvA39lIEOQg3L85O+feAwPDFd50ZTwdk5mzIKQx6n0Qn2/ZChEzesy65lVX8cWE
	 ix7JMiGi6IELSXy/lXZJP/5bykl7oHy/i9uRmK1HIk7cNrR67koL7jj/szF7qA2hOr
	 se8xu/QHk7RoA==
From: Mark Brown <broonie@kernel.org>
To: tsbogend@alpha.franken.de, robh@kernel.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org, Udaya Kiran Challa <challauday369@gmail.com>
Cc: skhan@linuxfoundation.org, me@brighamcampbell.com, 
 linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
In-Reply-To: <20260825162257.77042-1-challauday369@gmail.com>
References: <20260825162257.77042-1-challauday369@gmail.com>
Subject: Re: [PATCH v5] spi: dt-bindings: microchip,pic32mzda-spi: Convert
 to DT schema
Message-Id: <179063753265.139547.14430985812194627498.b4-ty@b4>
Date: Tue, 29 Sep 2026 00:18:52 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1146; i=broonie@kernel.org;
 h=from:subject:message-id; bh=sQF1ijqj5LE8SBRqGw2k8iUqXxg3AS1UFnSFnLTDrXs=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqu4zg6iwLt1fprBJltqdeHY8ouLDouI2p9Lnqy
 7xSmAArFOCJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaruM4AAKCRAk1otyXVSH
 0O0SB/wI8hR/F5iAdOPJrsVZllGvzRXrzyXyatmcrHbyJjnA00uakB0tQzA3bgs1KaOa9earV2m
 ddFNgLesmHB5weSX9zv7Du4tgIoK6d/4kOAkjJwR3a2nmvZT0sGur9OZjAWhyrtgQsDKMpoGBDz
 1wREMG8kNDMxlNRNyRZgw48Sc4JoDS3NYwTmQyexjahl+GZM/xn0YQQ0p7Aw/b7jxz7jbgtVMg9
 gYIuWXSfS1GMHSSc3By/Y/ZV6+Zg6BXiNMhtjyx6VQQlZGzK7HwxOFA5G8mkKTcMhQd2k9cE7Bu
 2BhaS2cFmKSGvu/MlXoa71v5wsEkQajYggpvqS5fa1TOKAFX
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Tue, 25 Aug 2026 21:52:57 +0530, Udaya Kiran Challa wrote:
> spi: dt-bindings: microchip,pic32mzda-spi: Convert to DT schema

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.4

Thanks!

[1/1] spi: dt-bindings: microchip,pic32mzda-spi: Convert to DT schema
      https://git.kernel.org/broonie/spi/c/cecb86a37ac0

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

