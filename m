Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7583C2768;
	Tue,  3 Mar 2026 14:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772547615; cv=none; b=brZzZPGtiAPXGe+gFDuyJSE5duw20zce89FaALypRgtdXMu50c/nVYZMQY5X51XLfzBp5TQ84htO/KmkJrIKXFcvR4CyA9qGeF5fJjY6ojlCo4PX/1YGAmOZ7RibrEqo3ApAbWYjw9aEV38XF9LU1q9gAaVc+Rw27ypAzAm87Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772547615; c=relaxed/simple;
	bh=ofivp0B1nbe1j1DkdafI9OBLxqcUuIMZvL8HnOoz8ko=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ZV78oZDHXJ9k/jsdaIxUfJhK9GhXpDk5k3wj8pDn5D339/Trakl3h/Mp5Nr1CXWuXZyMraO9TNQeSV/Wf8HGKtTrgkY++sSdhDEvCh0vTbFLbYXYLOdMxN6uTVmtMxo2YqnPbZ3QUgMIgYa1aq0vPoZpMA43JTMdCP8a2dIztp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dYGf7j8h; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dYGf7j8h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F7A8C116C6;
	Tue,  3 Mar 2026 14:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772547614;
	bh=ofivp0B1nbe1j1DkdafI9OBLxqcUuIMZvL8HnOoz8ko=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=dYGf7j8hxyGWgRv3nnKMyXbyb8UfEBpacQ8Y3xvQcnbsKcyoHpbRiAevZcyOgo+Rc
	 voW38lKCQaUVq/SNXIthk+PnHbksB8eyoGe4DZn30mFtfrlhtv7HYcUbpuptCsNFYc
	 pssam9AWt4FLj4IMEAF/4SzmOiqv+Z41R/XOPao9B63XtkjLeMoYxy1AXEgfptOFz6
	 H0JukVqBYWg0dLqy3MZr39DIupQ6hgL1pC14cs4YkRCAvbgU4vmKaBSCf4FDGuMOUz
	 tKtHTOF3dOfGxN4uPp3E3ISdkXs51NNAO2RmEM+byGmTo6aly2M1o7KM+fWdPwnfYM
	 3HzFj0XyaA0Ng==
From: Mark Brown <broonie@kernel.org>
To: Vladimir Yakovlev <vovchkir@gmail.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260302113233.773414-1-vovchkir@gmail.com>
References: <20260302113233.773414-1-vovchkir@gmail.com>
Subject: Re: [PATCH] spi: spi-dw-dma: fix print error log when wait finish
 transaction
Message-Id: <177254761385.95700.14624648151530211972.b4-ty@kernel.org>
Date: Tue, 03 Mar 2026 14:20:13 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-6ac23

On Mon, 02 Mar 2026 14:32:33 +0300, Vladimir Yakovlev wrote:
> If an error occurs, the device may not have a current message. In this
> case, the system will crash.
> 
> In this case, it's better to use dev from the struct host.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-dw-dma: fix print error log when wait finish transaction
      commit: 3b46d61890632c8f8b117147b6923bff4b42ccb7

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

