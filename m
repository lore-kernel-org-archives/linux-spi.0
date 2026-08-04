Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8900F2AD2E;
	Wed,  5 Aug 2026 10:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785926795; cv=none; b=Ix3AUhLgkf0JHW14MBrDRxKJFfrVd+ZwAAtnUpsoiESYB+ZAQlxanLdRwNzEgCZTTWiUozyu3mepVqKPbKw2eR2lvVkNlyBnX0N+9afFe5mDLG0pD4HPdW/4bqiQWZltT6fE3XdE6v1GmnJ4DvEzOlsV4QmvDTdQvrOPTWgcIMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785926795; c=relaxed/simple;
	bh=oLgmaWjJ5rmsZN0/W9XaUC4aRTGnh2irm+YvE93NI7Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=HZR9nC6pY6KO6yJhhXVvVY6XOeFFwXeupt1VL5rxEe9mZiBdLbpD7RxuZfnX+osLFwqqgo/8ig5rokicF0pcIEXPDryYqYCgctkYwNMyzgsHbq0dceGw3fdvCBXvmOeZXVrBtyGkItO5lLE/zBawmkeF8aqNi8NpDXuFpS+OyuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DixDWkk4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DixDWkk4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DA911F000E9;
	Wed,  5 Aug 2026 10:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785926794;
	bh=55CliCjCzMc09OskGbdUw0NpSN102FCwrBmwHwFC50A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=DixDWkk4x7jZMuP9YPjMKAeh8G1vEfN6Qbk2nlPys7Apyyrvd6R3bUDR084kkWl0L
	 JxQYqek5R7O8Mb0I5Kpcy/rEGc6E5VUeUv3unA9a4fbDfa3MF0UVHXhr5m2mzdHT1H
	 IJ/eGtYzdnN4jMWSBCpesc3iR1393w8Y9xB41RbR9pXiI5Ew1VJBodLA57YG1KWHKE
	 QfXJc8SI/DVZ7eIXVCVwn4bOtuplJz1/dDPJC5ylTbHXWbWb611/YbWugEJWrVN3uh
	 BWBkUKsKTi5slGtoWQqz0HFUarfItcdHNXgQFyK6nMiH7MZisCAlvVc/P98blD1BC7
	 2sIVGWoJZ64lA==
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, Rosen Penev <rosenp@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20260727201543.18857-1-rosenp@gmail.com>
References: <20260727201543.18857-1-rosenp@gmail.com>
Subject: Re: [PATCH] spi: ath79: use devm everywhere in probe
Message-Id: <178588512461.111355.5886175543058474853.b4-ty@b4>
Date: Wed, 05 Aug 2026 00:12:04 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1093; i=broonie@kernel.org;
 h=from:subject:message-id; bh=oLgmaWjJ5rmsZN0/W9XaUC4aRTGnh2irm+YvE93NI7Y=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqcxSIjhOKWJNXEIm0uFFzhREK4yj+KUqm57mm2
 ZY6glhu/dyJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCanMUiAAKCRAk1otyXVSH
 0PbIB/9DxWjMW2aNMqzJfitIzfKkOeKWht+EdITExfSnrr3vXYsbE6Vw9mMNNRGHCuDESuY7Vz2
 2vlkldqwM/8nt4K0HUwCxIaKSeb9UCt8PZnSLYIf4hn8j84xd153RQg0ZhtGZ4O39mpl5amGspf
 IwttwGI+Z+K5TnBfJmbz+6J/W5Y6Gfc9Bs4FWkGLSUv1gwwgeycZh58cx4cmZG4ojjSmZUKs0Gu
 mF5v2bgD44oweRqGVCQCkBPeDR6wzmhTVlwhq3/xKPa4XPlldeK9+CsuY6Zcmb1JbDzqKaQ8xMK
 lDj1fEs0xClSTcADcqnloDBHfrD4RKIO28yIs7gZXFOpczHh
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Mon, 27 Jul 2026 13:15:43 -0700, Rosen Penev wrote:
> spi: ath79: use devm everywhere in probe

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.3

Thanks!

[1/1] spi: ath79: use devm everywhere in probe
      https://git.kernel.org/broonie/spi/c/362a11ef1bea

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

