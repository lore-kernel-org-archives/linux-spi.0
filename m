Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE1536E460;
	Sat, 18 Jul 2026 21:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784411807; cv=none; b=FtKAFu8h098uwl1+EhSq/Eo3yuEZGTnivqnFP0SCs87oITBZTIqRxRfhr60mh5W7qL+v8QA4A/Y7sDNB1F3OkdvK6B81CUeN/WvS3YVQmNJ1rl81VM2XSZHH5VHXmc5cf3TMP9JtozNZs0eHGfITZ1Vda86bbEh9Y2n6NK32Bs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784411807; c=relaxed/simple;
	bh=h8zhREtGJLvO7iSEfChFPjTYzuDO1sEdErI364gAwnU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=JH74hKE1vJj4oB4bvdv/gDOYfiQUs3i3RxAGAVHpT7t2BkrzOMxdI17xmhDVCRVi6yHuclV5yVBfCIA3ZbmwKaGffwsCspCmt40HcrO2r5iE43YGtbIZM0atS1e7+yoYQcu49M8inYRlG2GpgguO9Gap+enlTzYhDLImvWET62s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dWbEHGEd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dWbEHGEd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BBCC1F00A3A;
	Sat, 18 Jul 2026 21:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784411806;
	bh=1gqBYQBGkgBUDfYbhyeXiYj90UVwqTYRtWwAvxgYFI0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=dWbEHGEdIu+dXwJ7mpSItMkoq9r0iFUTXOLrMorsZ8SO2Kuu4ePK66kEzpQje/Kj7
	 yz4eXgJmTvto40A/5p4sBd7mrid1Cxo/fUiS1IU10cLyA/mk2f3F9TLVdBkssmm/oa
	 fVGx9IcfhtkYzjT17+bQ6TuFcy4Vh++TjOKziVwqe+jzoI6c+9wp4IQaSYLnlJvip9
	 1YOuHVN0tLK1MjvXx1svBDszdIr8CFvC6KNyT1Mi5zSpIV0HmlPR7RXNewro+Ern3+
	 7RWk1btLG86r4IUgg9V62q8QAAXVmLEw+pUfzb9hjf/mDYzsE/H1HdtoFqvGQnY6Y7
	 kZvxnEoWU5RdQ==
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, Rosen Penev <rosenp@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20260716231411.1737001-1-rosenp@gmail.com>
References: <20260716231411.1737001-1-rosenp@gmail.com>
Subject: Re: [PATCHv2] spi: orion: use devm_clk_get_optional_enabled for
 axi clock
Message-Id: <178437850374.5332.10672824807350986052.b4-ty@b4>
Date: Sat, 18 Jul 2026 13:41:43 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1131; i=broonie@kernel.org;
 h=from:subject:message-id; bh=h8zhREtGJLvO7iSEfChFPjTYzuDO1sEdErI364gAwnU=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqW/acQbj/m6CqlgkbNhQPMboLYRnRzQ+EVGLC6
 GNdfsLgBVKJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCalv2nAAKCRAk1otyXVSH
 0AacB/9+Jz5yOgQI0hjSds7oCn9dLwQu89kriHjov4Pz/h+gvNYMzO7N7PWptxrdAOJSptIqZOk
 JlEAC0bNgEfmD3palp3R+oD7/pDaqAHiNoZdOC9uH2J+JPolDO1p9/gLv8KOPNL+fOGKqnCyqey
 Fr4uez1xK+XVG62QmsMYSpX347zyLB7HKOOPGJUk+zJ53Xto/FsjKx/dizWMz7rAdOWBNSXDE+w
 sj3KI9984S80A4G+SW8ubMyivr1+L2eBv/ujBdvfreb5cYewENxaNXaTbZqdnANPw85gl1WtRou
 CxXu+iass+res1rXEZ8Hlonm7ui+jMnI6EpQHQoJPvs2BKPU
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Thu, 16 Jul 2026 16:14:11 -0700, Rosen Penev wrote:
> spi: orion: use devm_clk_get_optional_enabled for axi clock

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.3

Thanks!

[1/1] spi: orion: use devm_clk_get_optional_enabled for axi clock
      https://git.kernel.org/broonie/spi/c/61c2eaa653c2

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

