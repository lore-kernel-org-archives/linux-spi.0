Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794743017;
	b=2FvEYW9VuIt5xpJswcgu0TpJXBPMh1SRJ1pLaXJ8vvxNJddDweJ1Zo0fricB0pKv1N0H
	 ehM79Q8Cp11SKv5//1mBd7zxxu6FWG65+dnOz4ENPJ0rWTnWlOTCRKJ9bapeh43YJuC5O
	 +au2mnyORRsDvtkqwPm0LtIHcdETueeNmkPP0JDcroOrQ1SFo33zWJoaTEYnBEqUVL5sG
	 Z347OvBbL4gCThgF3svKQtCx00gOHr2iEJZwXDV6ZPO4iIE+SFJGTiYm0ZnbHjqHaTX3Q
	 io1EtgIVtx+8HfrE60fZoD0i5PDdzgrPRz7BPYP4cqC2aebDMaR1bpTsswK0Bhit9qQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794743017;
	h=Received:DKIM-Signature:Received:From:To:Cc:In-Reply-To:References:
	 Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=ndCwkyzBkwNimno4N3pad5pkUlTC+Q9Xp+JRgN8DBtg=;
	b=H1WCpUBYIZ4ejARbZYnuDQPbuvq/bZGuFQC65dJ27et9JIDurwjZ3Q4rJ8tTnSogf+IN
	 cvRgEEQIfyDfUKYPm178G3DYkw3knvk6r/jZ1sShkAZi8CKzdDsRPoz5z+zodpu6+SsJC
	 hZyLqt8YIyk3nTKiMMDqIZOIZIoj6A6hRzsKshY0lP6mHbbl7kOjMv6N07ZAGm9T2JTLN
	 TbMxV8aOLxcvGOpG2iSduu0dA+8HP1LSoRJ0ZRruFhzupNUb1FenROPmIkc0/r8xBRUZ9
	 xbqxNrBcjIO2K1tfy4vC2t9P/3fzYQy/zGLJ9FgMkvhk2bTOjecy9n0Whcncs8wp6OA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Arf2WU6n;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14DC606A31E
	for <linux-spi@vger.kernel.org>; Sun, 15 Nov 2026 11:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Arf2WU6n
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 545BD1F000C4;
	Sun, 15 Nov 2026 11:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794743017;
	bh=ndCwkyzBkwNimno4N3pad5pkUlTC+Q9Xp+JRgN8DBtg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=Arf2WU6nh3QBzMXGb+EO2FgZNI0iBMFe2jr+PJcswFaAKrr4O45TXihEKtQ+YIqtB
	 I65oMBH6EvAekUYFmyz4Wivz0ArUeUtBvaAwTn68zZEwJ1ZyfxWfQlzVFoPGngUF+e
	 7PWGymHfcAqNdy902uHrjGojh2Xce7Mz56FjB+7ds165xNr4fQ4sts+kozCQViNd1c
	 /vQMqXQY4ffktALySp0slffohNF1kwK8Emm/3U+SW2ELsShf7s/yBpNdWjJBZu3Ea+
	 64f/a8rpAFxQu3Brty7BNIOVT1wd3dtQZIuzjc/lZpUUmX6vT0G5gRWT/r+LfcMSAw
	 ivUuoT1Jn1IzQ==
Received: from traversing.sirena.org.uk (localhost [IPv6:::1])
	by traversing.sirena.org.uk (Postfix) with ESMTP id 8B2263366BEE;
	Sun, 15 Nov 2026 11:43:35 +0000 (GMT)
From: Mark Brown <broonie@kernel.org>
To: Joseph CT Chan <jctchan@gmail.com>
Cc: linux-spi@vger.kernel.org, David Lechner <dlechner@baylibre.com>, 
 Bart Van Assche <bvanassche@acm.org>, 
 Joseph CT Chan <josephctchan@google.com>
In-Reply-To: <20261113020352.1741295-1-jctchan@gmail.com>
References: <20261113020352.1741295-1-jctchan@gmail.com>
Subject: Re: [PATCH v3 0/2] spi: unoptimize message when queuing it fails
Message-Id: <179461119119.590303.9535934468622842107.b4-ty@b4>
Date: Fri, 13 Nov 2026 23:06:31 +0000
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1825; i=broonie@kernel.org;
 h=from:subject:message-id; bh=rEPNX6MqaySi8GrPVbbGlcGh9wUm4m52v7oBHgPgBZY=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLJ+znr+P9ao3o79SS1P145pvHs/HIu5ZsV+6lHcl1/yO
 1/dYp80o6OUhUGMi0FWTJElLov7ZX3J6zV8Bxe2wcxhZQIZwsDFKQAT8TFhZNgc8nn18u+xsnVc
 tturfRe9e5I7l2nb5nen5iYtSnyizTmR4X/UztKXEn+5p+U7Xj8bfuxkel2oUS1fIefkjoUne/Y
 7FfMBAA==
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Fri, 13 Nov 2026 02:03:50 +0000, Joseph CT Chan wrote:
> spi: unoptimize message when queuing it fails
> 
> From: Joseph CT Chan <josephctchan@google.com>
> 
> Hi Mark,
> 
> spi_async() and spi_sync() optimize a message before they queue it. If
> queuing fails, the message is never finalized, so the split transfers
> and the controller's optimize state leak and the message stays marked
> as optimized. This happens with -EBUSY while another device holds
> spi_bus_lock() (for example mmc_spi), with a stopped queue, and with an
> error from a legacy transfer() callback. Patch 1 unoptimizes the message
> on those error paths, and patch 2 adds KUnit tests for them.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.5

Thanks!

[1/2] spi: unoptimize message when queuing it fails
      https://git.kernel.org/broonie/spi/c/91db5febb159
[2/2] spi: add KUnit tests for message optimize state on queue errors
      https://git.kernel.org/broonie/spi/c/f6fa7376869c

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

