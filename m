Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453353EDAA2;
	Mon, 30 Mar 2026 22:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774910570; cv=none; b=rM9EDtTxI4evz3/AmzAw9AKagPsuNtGCcnCoPQ31EdjVHZ0AKQm59aZJ+doUHLGSx8ZTJ7xETnHj6ekIdGe9CKpnZox+II38i5ah7CJQDzkI3ampx04g7xdh1M6bLzap5wSpmUVcnEKSL/6E2YeBsiiiwtIB9LtRRJ/o5JKFDGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774910570; c=relaxed/simple;
	bh=WJUmNyHI33Ksdcve8J6YydVvh7qixIZn6EjlrvkUTHQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=aXV/l/IVeswGzWaT4PuDZPGW64C+6bJsmYiSkQ/pa35geiEk/pxaPPAtKNCLrT5OxvHvnZp93ZOX7oKmBduo8VU+eRWPYe9MsM1cYRDKRw/7P1774qUofQ2oXQpqdOJQwcs67Y37vxkmbHGaDmbJ6bg7dm9EEnAV6kdfVMiT9Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zb9Dbfg9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zb9Dbfg9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43C97C4CEF7;
	Mon, 30 Mar 2026 22:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774910569;
	bh=WJUmNyHI33Ksdcve8J6YydVvh7qixIZn6EjlrvkUTHQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Zb9Dbfg9hUNrWQ1loGToOdl+1qsAhj6+m14i2NRC2dGewKMaB/dOQAUNfCNDitaU5
	 Cm6JFuFhUp8SAl896uBm8pOzBx0kNxAE+L8HJtxJjqNU7lP2e/P3qrvwZuQfDhKKsl
	 5WiW/O8KeP79L7C2tNjOYNv9HfcNALMLXxXefa8IEEF96uyCmocvry+vdD+8mX5JWE
	 58NTy+nu/i5eZ50YlWI+BTM9k3aj1e9O/2qEE101zQau/u6dTxtI4jg7b7BfcxYBzh
	 NYL0xXx68l+jp5Ur/OZT/XIDeOtolO6mb9K1/MS/MHGlWPwoRKcJqf7RtwegRpni3I
	 qMbbT8btEx6Pw==
From: Mark Brown <broonie@kernel.org>
To: Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, Felix Gu <ustc.gu@gmail.com>
Cc: linux-spi@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260329-ospi-v1-1-cc8cf1c82c4a@gmail.com>
References: <20260329-ospi-v1-1-cc8cf1c82c4a@gmail.com>
Subject: Re: [PATCH] spi: stm32-ospi: Fix resource leak in remove()
 callback
Message-Id: <177487334325.97912.13454188633754990000.b4-ty@b4>
Date: Mon, 30 Mar 2026 13:22:23 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev-3ac6c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1122; i=broonie@kernel.org;
 h=from:subject:message-id; bh=WJUmNyHI33Ksdcve8J6YydVvh7qixIZn6EjlrvkUTHQ=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBpyvxnVDjtLZDM2CXSDaxJ2aMbGfIoYxQaaj+Ss
 wM4QuWJpYSJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCacr8ZwAKCRAk1otyXVSH
 0Fr0B/4wZMN1jN3fHRdwE1W1kQK3iCOwoQ4Wdk/P/GQWrK0U2e7fVUWAkUJvdd9hCc6Bk3fIk3T
 MSzzgV5Lbb8ObQvr2CmrR/7SKzDOfInspxZ0ik07JKpQi/jmvYsIPMkAtUK52GuBMkVKWlvHHF0
 2YZSLXTZn2HE2CFINvMJBoUmXZ+AzT34SHCrZvT1IJmzpYoJWBSuSFk2c3oHlTnGk+okrcjPnHc
 6+QEAo/fo9VoiKn5n9nRxMKGIp+2VuRnwP2H3BRb9bKgGuQwIPTXOeO0tvCYZv3aDAszEg8VLDo
 rqsehY1DJNNNhP40HYzH5m9+k7lJpEDpiBmaS2l+JX4R1rmp
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Sun, 29 Mar 2026 19:14:05 +0800, Felix Gu wrote:
> spi: stm32-ospi: Fix resource leak in remove() callback

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.0

Thanks!

[1/1] spi: stm32-ospi: Fix resource leak in remove() callback
      https://git.kernel.org/broonie/sound/c/73cd1f97946a

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

