Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3836C4B337D;
	Thu, 24 Sep 2026 19:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790277092; cv=none; b=NHGqFknBWZmoZrYJkuVsEPf9pvrtIw/GY4BkojCbb9nRtwvWrmP5yuf2Jt5E5L6VeRwWs6PQWC3+aM8rkDY00YbAKo5ixSpIoF1K4JBiQz89N68/nPxPKxP9Kjzd3KJSF9lHHywj7Xm8W7ZJbpbadgT2SYxABoQRTbI/EH8hOig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790277092; c=relaxed/simple;
	bh=BrLUtCNY4C+q23jUQaKfBakKzeVPqQzhSMf2q3+XDF8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=snomzXhuMxRl8f1TJJ7LBTkG9kxsis+cNzoAkwrGso0SeEJd+Dd79CkmI1ajeI1K2bJ0ca/b2fzCx3lfsYIGxR5QyVsHxtovBDE7jFkcyIV9xSaTi63wxJnOrHnz4n+QCNhn/tUhTVzVBcwRgUJLzWFGWgLrItOIJ/yrFCYYkwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=efznepHY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="efznepHY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D1FB1F000FF;
	Thu, 24 Sep 2026 19:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790277090;
	bh=RU4yZcHPGA665sTAUwvZEqO64Z4PiN3l9rXR3QWGwNg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=efznepHY6zoypW8oMX5hZaSRddvPcKbCzWATpEfFyf5BxNMIxvLTqSLeIiFMAjhaX
	 d84XcQF7u5ha09C0sK9VD4bKa+iAZRCXXBT9kZRzXBkKMu/3VU19E3A5LOLynAMFEf
	 NQiPRgFIK7E5qNoBewr+wZhkXclHbnup0JcRwUM71Ueu4Yrjn2HDzUZmuG8pXQPRmw
	 go0lpH+yo5CL3pJB0il17LmWceUuE6rsvccg/AhPuNypWqBzlGuHb1pZ772Hlnu2as
	 UDansorX3KuCCyNdC2JVpEzFXFFskyzRg/KboIE5oF5LvfRwJgs0Xo0nFNApfYIH3b
	 ojl1fVJV9E7zA==
From: Mark Brown <broonie@kernel.org>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260817151404.28324-1-jszhang@kernel.org>
References: <20260817151404.28324-1-jszhang@kernel.org>
Subject: Re: (subset) [PATCH 0/2] spi: dw: clean ups from "use threaded
 interrupt"
Message-Id: <179027359714.149798.16557738915945460170.b4-ty@b4>
Date: Thu, 24 Sep 2026 19:13:17 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1501; i=broonie@kernel.org;
 h=from:subject:message-id; bh=BrLUtCNY4C+q23jUQaKfBakKzeVPqQzhSMf2q3+XDF8=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqtXXflvBzHi5otIUuWLw10astOFCpACpZZrDSs
 GgLL4V+VEqJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCarV13wAKCRAk1otyXVSH
 0OUcB/4mIqpDEEmaIzdQlJqGJhQfVvSatRXLAR3o5ugQabWT8m4AiH6ezM3dn3uq90FPovM2CfS
 Z769syXLLweqbUKLwZywxmFUGDW2g6TD+Bo4yYj9RRdiz8/rVwlI8pn4n06pukv0CChShORWUfn
 kdnF9vKFrB3Zo4ssk353hhxckAKAQrTL8btlz4DUIB2gu9NQb9l2YryiqWNtsLXS+wjngpRoYSu
 lcg5cyvd1ARaK/sr6JgtCVHzyePQHXDofyIncorkP1vVV10Rn8lSXCvdEzKS3iVagdsC8ktCacT
 b8IJNM1hH48cyUU04+HE4ZVAahxWFplO62ENegyA498Ku+a3
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Mon, 17 Aug 2026 23:14:02 +0800, Jisheng Zhang wrote:
> spi: dw: clean ups from "use threaded interrupt"
> 
> Two clean ups from the series "spi: dw: use threaded interrupt"
> 
> Hi Mark,
> 
> The enhanced spi mode was merged, I'm a bit concerned with potential
> bugs with "use threaded interrupt" with it, it's better to let the
> threaded interrupt tested with it. But I don't have available HW, so I
> will cook new version once v7.3-rc1 is out and ask sifive people help
> for test.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.4

Thanks!

[1/2] spi: dw: use DW_SPI_ISR directly
      https://git.kernel.org/broonie/spi/c/2f06fa7a4150

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

