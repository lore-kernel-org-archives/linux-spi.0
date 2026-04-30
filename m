Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9BA279917;
	Thu, 30 Apr 2026 04:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777522364; cv=none; b=QzjB9ZlsPJbmFAVDhQsQbLA5tsfg3+jWsEK/KbC5DF6nGc39Hs4b8vyfGhMBO5oMx+Lvc0ZK5x7E6bZiRms0CrVsOHn+daPscl0YsOOi5AZ1S9OlQ1qFMrFSN7ErWdfn7oR5EssRwVmBmYXSsHR6shslnrV6V+qFUCLaHbx62V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777522364; c=relaxed/simple;
	bh=T77THerhIZ7VHQkgFQ09sGuhNgD5gu1lksybPLc7AXc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=oVe6srLWkZ08dpUKKouwl7KqqrM74dbCdqKfws+Aa/dnbc9VzWeDC/kX14vIJzWAnYxucaaMveC0SJSR+4GhVV+ryPTNZp+G2NM7tuov4jQ7psgtbylEY0owEIWkSt2Z7YeHcRxRzvWMoIJrqyLObvgmUdCSBf2r7899bnRuet0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V+8+BidP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V+8+BidP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09C9DC2BCB8;
	Thu, 30 Apr 2026 04:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777522363;
	bh=T77THerhIZ7VHQkgFQ09sGuhNgD5gu1lksybPLc7AXc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=V+8+BidPubXzh9WyR0aXF8rqvljDS13gEU8BBOXD/kLmV3qlNms++Kxsi25JsqLCw
	 qJqXXh0EAu7aFkelkIWEUumMsF5LCqxXm+k/4B3sBz/8LIv7v++1H3lxHZAxUeE/6Z
	 FM6vKEA25F6KTO9PNKJxIikMw05aCKLF6+GWoBKOPT3QWB7pSlnpNwCTleVpG75Q23
	 ZGqyyLYKDOYOb2ICH/wpr4Bc8enAeWu7PqwA/kAp7IY7c/canDJuLMOVbIrLQ21YVN
	 So+84jxFM3PDRRN+jdWqsar3ddSajm2uIGxskUy1YaPr6eva3G8FmmW6cPHpap8Y5l
	 qI3IqDZ5w7wfQ==
From: Mark Brown <broonie@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260429092301.166375-1-johan@kernel.org>
References: <20260429092301.166375-1-johan@kernel.org>
Subject: Re: [PATCH] spi: clean up controller registration return value
Message-Id: <177751376693.363516.16269563795215005376.b4-ty@b4>
Date: Thu, 30 Apr 2026 10:49:26 +0900
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1114; i=broonie@kernel.org;
 h=from:subject:message-id; bh=T77THerhIZ7VHQkgFQ09sGuhNgD5gu1lksybPLc7AXc=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBp8ta5lVCbjpcspz1JIruI4ZJSGeecH0ZrGey7x
 Ls8C3uKClSJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCafLWuQAKCRAk1otyXVSH
 0EJiB/9NKoEGuHoOSOEDwX3QOybDdkOtgAtaIA7ya+bSs5UzkMYoeofqlwmDUwB6Agy7lElpSz4
 gC28DrjoYYzZm+j1xDN5f1o3lXmfUDZbsv6VktlK/u0TPzbfZeK+r8w/tGoFjp2bElvfqABoc8h
 5My6JdGioPCmsvmA6QAYuq1ulszTyV1a4EetZzNz5693bVeDoJNjG3Ia1kWrRrM3vNb6TR7oDpV
 qOwwcKRtpFaYIiUFPU/pb3k9yWtEiPxz7sW0E8B14yz9cH31gLQzmZeR2eDLlJTri9oAq15x4WD
 uIJlA09sK8zjlDnI/n8d3pKugKnpjDDkg7a+hlydrDmqNcx1
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Wed, 29 Apr 2026 11:23:01 +0200, Johan Hovold wrote:
> spi: clean up controller registration return value

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.2

Thanks!

[1/1] spi: clean up controller registration return value
      https://git.kernel.org/broonie/spi/c/54dac8230d9c

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

