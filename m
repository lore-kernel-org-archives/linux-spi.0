Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D388223C516;
	Mon, 16 Mar 2026 01:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773625068; cv=none; b=h21695NGp8mpeJm/04zJ3P00u44Nic2PQXic0Q8nx+v6r0UtZ3k+LgEuUgYukAWu9bWGKRNnV+mrCOkdDSRWq+isejtK7ah3fxV/XS4GISi26pUKF2yF5n/MtEhc/KJ+ZGiq2H5a8t/WBwcXxyaCgjBv2Inwq5ISqPwYGsxeAdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773625068; c=relaxed/simple;
	bh=o2Kt//keYJ+NgTeHopW+uwqqu+ppeKzO49PBlKK0bEI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=pa5hyJG1o4K/e9JyiRxlf3cPUazG0qG6StBY4T8YP60ZXm97N+Bq846odkD4NRqrXXpBqC7WQJKJpwsjWPFH6RF0Sihas+c0P+t4bk0Zt58Rdh5huvItkTPl6sfPApOnOVhMSkkodV7UMwXGtep4y3W8zq6OmTvTxxVp09P6hNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C1O0f3aj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C1O0f3aj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87591C2BCAF;
	Mon, 16 Mar 2026 01:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773625068;
	bh=o2Kt//keYJ+NgTeHopW+uwqqu+ppeKzO49PBlKK0bEI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=C1O0f3aj4g8guDb9Ggr9S9XmVgoShCmQ9BuLZT2O6coVxka3j/7wV/Ta245IUZiD/
	 5sE/OGQwb9NJPDfmbLNUuBzOIMAC60bn8J0ab1xRnsJ6Q3B5LlQE1hfjhEVuHpheVL
	 vxqNw3oZoyiMirz46O1fdxzq9FXaSBU3GNung4xJ2Qp0FZ1qLPgTWcdmf6HGr/ALxw
	 rzrdWBQsQnQu/DvngHi2gMNhRzeILtWc247jk7s/lexErzvMqL22MsKBx/uFrVAKEL
	 iB93FHqnPqRAQ/k3yf/41E381wwMVFSd0qNjo0UhzrX8kxFungFZfei8BmGw9E/YHO
	 1wHmwtQGJzAHQ==
From: Mark Brown <broonie@kernel.org>
To: Vladimir Moravcevic <vmoravcevic@axiado.com>, 
 Tzu-Hao Wei <twei@axiado.com>, Swark Yang <syang@axiado.com>, 
 Prasad Bolisetty <pbolisetty@axiado.com>, Harshit Shah <hshah@axiado.com>, 
 Felix Gu <ustc.gu@gmail.com>
Cc: linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260302-axiado-v1-1-1132819f1cb7@gmail.com>
References: <20260302-axiado-v1-1-1132819f1cb7@gmail.com>
Subject: Re: [PATCH] spi: axiado: Fix double-free in ax_spi_probe()
Message-Id: <177362094240.178501.3639810667396404638.b4-ty@kernel.org>
Date: Mon, 16 Mar 2026 00:29:02 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-5154a
X-Developer-Signature: v=1; a=openpgp-sha256; l=1102; i=broonie@kernel.org;
 h=from:subject:message-id; bh=o2Kt//keYJ+NgTeHopW+uwqqu+ppeKzO49PBlKK0bEI=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBpt17pvrpdD7qpehSqBYHlW3c5n0W2MDvd8SiEK
 zYl1MmgCHmJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCabde6QAKCRAk1otyXVSH
 0BxHB/42RQEE9PvihKdowhdlYvGJQ882bYEMYvjBp9yrekPJUsK35hnaXnh+pfw+Gzqa5shBKcA
 9PJXO5O28NUF243uaH7umcplQ4Lr413leHxLZK5Ql6RmhGnJWlqL7A8AIVt8kADCNUT/yCQBRs3
 TnSbQqg9HLO88x4SUtaZH+He/2WCe51hbSDVh0RuSsoAxuVBNB8v3wPnvGXpOS4Ktdk4Oy2sDmf
 dtKhw4sKyw1AYcGLQ7lmti9OwG0S7z5z/LMbljyYK6tAJyl72lJ/dkCpBDkjM9yg/U7fpFQ7yqN
 tRYCpg7FixvgEQylGjKd5tsijo223bltKHD0Hl16oB+gQnEH
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Mon, 02 Mar 2026 01:08:40 +0800, Felix Gu wrote:
> spi: axiado: Fix double-free in ax_spi_probe()

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.0

Thanks!

[1/1] spi: axiado: Fix double-free in ax_spi_probe()
      https://git.kernel.org/broonie/spi/c/7fc5e2f5603c

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

