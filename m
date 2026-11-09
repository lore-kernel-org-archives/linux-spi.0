Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794242614;
	b=hHY4a/gfNIWYV+936/88hmiUjYvDdexwyIpaFJMQItvxo/T+nQeg4wS+oXwrhRA0fHlv
	 fsxiNvwblX7SHAqU+eFla3MFQ/4O0X5a4WBHtefKD8h3VQLf2cLLjuzigisieV2KdYcJT
	 w8FK4WC3TpMO9DisJN9wM++MQ/etrl2tEj85iNphHvnPaW+FCL+H4pH2i6+sUe3PoOEwL
	 30tSjJB1xsOY5EwySpaE8ABdia/SVMO/tifWT+1bWWpXf/g+1IKeiZgPQGhbPFhgnWG1t
	 btEZFSUziZCBh7E1rfqqU1org+XjngLhldsrCkvzn1uzPMmNuq4hO0DIW0yj8Ir+KpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794242614;
	h=Received:DKIM-Signature:Received:From:To:Cc:In-Reply-To:References:
	 Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=4wvwnrnYRSWazkZZ5GBPN6+dTTg8gprY55YCxx6vRAM=;
	b=e6mKmCeCNUiwqxwX+C1wy98ap9ggxpzKpOHr7ryJcXkajbiI09SVvt4tJPcavqmjKv8k
	 9PsD7LIdf0tbQ2mORA9YXqOqbisTLr9YBxjpK9K9VJDbKjomRr1F/xtxtWW6ePR2OS6FA
	 7gBKnOpQKcy09p/VjZTuhzFSI5xQ+MMOmdR4LBH7eA+kkAs9sf7tUyAH7AwMXM5CjTbmQ
	 PGuq+v5Xjnl5qdNFSLo8vrhoTUKfGlQf7waEEHlRFURH3TnTUUmAermleCHaEGi39DGNA
	 5MaDxYKO/WPsaKcyGSaRSTokuXk6GTj9IP8SiylFUGpDGWz4OoiJrnfaZ802UOuckCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aRN6iv+0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EBF1606A31C;
	Mon,  9 Nov 2026 16:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aRN6iv+0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C063A1F0089F;
	Mon,  9 Nov 2026 16:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794242614;
	bh=4wvwnrnYRSWazkZZ5GBPN6+dTTg8gprY55YCxx6vRAM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=aRN6iv+0ew4h3G8y1cHnmmRUo/D7yCwGhx5RCY2LNAmjrMr8xCA3U2GP36bYofZx0
	 RwSQs+YkE9ogjpA79UYGY5iCCCYJqHLTl3dpM+2sgquZBl5UcgxTqJ9ccmNObUAdN1
	 lbJ/c/8yA72AfUJ740SPRNNt99/4gVI7ipeGdLK7s/3o3IQcr1ze1YMhGCGj2+jcqp
	 V6YZKiKIYWlKeKTzJrtZD4xGJipjcaXT89SIV7MaQZuU4aCgn7aaFfnG0374Y32KgP
	 A8npkwAeveFYqpyR96eD++fbxGoosx7oVjpQv8etR7SBGpP8k21hWMUJcqQixCqOxq
	 TRe4gS6lXW4XQ==
Received: from traversing.sirena.org.uk (localhost [IPv6:::1])
	by traversing.sirena.org.uk (Postfix) with ESMTP id F41FB2EC77D5;
	Mon, 09 Nov 2026 16:43:29 +0000 (GMT)
From: Mark Brown <broonie@kernel.org>
To: "Baek Kyu, Kim" <pocj8ur4in@gmail.com>
Cc: Carlos Song <carlos.song@nxp.com>, Frank Li <Frank.Li@nxp.com>, 
 linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20261031060344.94687-1-pocj8ur4in@gmail.com>
References: <20261031060344.94687-1-pocj8ur4in@gmail.com>
Subject: Re: [PATCH] spi: imx: Avoid PIO replay after a completed DMA
 package
Message-Id: <179422617449.3711751.13685592101715221085.b4-ty@b4>
Date: Mon, 09 Nov 2026 12:09:34 +0000
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1127; i=broonie@kernel.org;
 h=from:subject:message-id; bh=NS78jCBQO5kgqQAWEra2ic9nU8cMaihqjR7hrccNZNI=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLI+/tARPJEh+JtvbYxjZ8vtoBm2zXVL5BUTb13JdTeP4
 tb98nZXRykLgxgXg6yYIktcFvfL+pLXa/gOLmyDmcPKBDKEgYtTACbSrcnwvyxJ0a9h5QsV87cL
 5+s4trxRna77e9HOxVc8Nva8yk/lm8nI8JDvMkvWNG5/kXnfRXb86/ALri3f+WPhRceGgx0zZl1
 u4AIA
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Sat, 31 Oct 2026 15:03:44 +0900, Baek Kyu, Kim wrote:
> spi: imx: Avoid PIO replay after a completed DMA package

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.5

Thanks!

[1/1] spi: imx: Avoid PIO replay after a completed DMA package
      https://git.kernel.org/broonie/spi/c/2eb2136b475a

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

