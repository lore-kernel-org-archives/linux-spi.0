Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F5C36E496;
	Mon, 20 Apr 2026 16:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776703546; cv=none; b=klWDASJHo+7azVc+klAySCvmLumC73R/47YyJsCAfN9V8NG5ymzZCAr0AOKm4HeOcQ2aIQAHWjJCNEY2JZznjgaLBDeKS2hk/gsME20Lt9z6fxYLjMCun+0O1EfJuF7l9XwizkZ+YSxtDiUFoaAJyyOSKgFO4XMy/rby+DVuBnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776703546; c=relaxed/simple;
	bh=6W7qeaT6s63a+EL6RgwQ/mchJTExaft7eGswP1JgNjw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=swvwMhFuAoQ3PmWKFxFgqOQgV6i8ZjuL5zuEIYSbMnzq50VWOjx8qdkcwC43ez2EdCzub4nfgoNJ38xMngU9JVgsAEjKI774Irl4dW401fEeOMKdFJP3evmWrUN++kUf/I8gKXgreN6r2usYh9i8739zXtRqjaUvfu7VAhN8ggc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SKu9G8Tg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SKu9G8Tg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB951C19425;
	Mon, 20 Apr 2026 16:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776703546;
	bh=6W7qeaT6s63a+EL6RgwQ/mchJTExaft7eGswP1JgNjw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=SKu9G8TglwXvya/VJWxZV9p9VUutwCRa5ZknW7c1PVNjQsFvsHYbdmaqz/wJMQPRl
	 GuDgt8ycYI78Gmr6MYKzzyAe+/xPHYiuZhqscQeiLCtrNJO/ex0tmbgJGhLGjvlWFo
	 R5zWof9UP/tm0REOU5bt4U4M9tXlW1r9CAK1Nz8DD4vTwcQRRRtqFkGIb56dr8MFLf
	 QqjfCmigaykiuwdGZvXo/J4BXurdv7XF/uSK24agutU2NuInwUtKqvFcbWGyf3A2Yi
	 kf3vmhAgc9nOqGh67P5rXvfPAAGqlvn7V5+e+0CaCq+NLyiyDszo9VRxJkAkfqYoWF
	 FEw24ez1fB6qw==
From: Mark Brown <broonie@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260414134319.978196-1-johan@kernel.org>
References: <20260414134319.978196-1-johan@kernel.org>
Subject: Re: [PATCH 0/8] spi: fix explicit controller deregistration
Message-Id: <177668524964.42338.4704750587277974160.b4-ty@b4>
Date: Mon, 20 Apr 2026 12:40:49 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2222; i=broonie@kernel.org;
 h=from:subject:message-id; bh=6W7qeaT6s63a+EL6RgwQ/mchJTExaft7eGswP1JgNjw=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBp5lg46Js0klV2nGKoj8Iln1a9tTeJU5NN1dJol
 6MGnur6OemJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaeZYOAAKCRAk1otyXVSH
 0NnpB/9p9MkPDlUOpXUKrZ4ZMjnJMPzOhnnvz6tCCDU20GKu6gYj0occ7G+YljdodWwo2os6wXs
 CN3PBaTYtx1ipO8one2kChTlmebFQMrNAdfnjVU3zHL170K7JaqFMHLXGJWAUW5ybMmRGNMHVgQ
 iPC+zhR1K96f1mhkm8xQWn6CD0l63AMNiBwcgoaB3rqFHM4u1Jiz10bHBKMrbZpYqa0YQjPq24o
 F5RGmeVESQxrGt0pWX1fkrpFheFSEkbeDYydMJKr+kwck6woEcws2dO5FcdfVb5fSuxtISDlyZt
 CSXB2RG6Ajs8mmzUK6MbUpclU7y82MCrWywO+mms5T2g4RIU
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Tue, 14 Apr 2026 15:43:11 +0200, Johan Hovold wrote:
> spi: fix explicit controller deregistration
> 
> Turns out we have a few drivers that get the tear down ordering wrong
> also when not using device managed registration (cf. [1] and [2]).
> 
> Fix this to avoid issues like system errors due to unclocked accesses,
> NULL-pointer dereferences, hangs or failed I/O during during
> deregistration (e.g. when powering down devices).
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.1

Thanks!

[1/8] spi: cadence: fix controller deregistration
      https://git.kernel.org/broonie/spi/c/666fa7e9ca98
[2/8] spi: cadence-quadspi: fix controller deregistration
      https://git.kernel.org/broonie/spi/c/964ee9793760
[3/8] spi: mpc52xx: fix controller deregistration
      https://git.kernel.org/broonie/spi/c/0f997fdae819
[4/8] spi: mpc52xx: fix use-after-free on unbind
      https://git.kernel.org/broonie/spi/c/706b3dc2ac7a
[5/8] spi: mxic: fix controller deregistration
      https://git.kernel.org/broonie/spi/c/adbc595e2720
[6/8] spi: orion: fix controller deregistration
      https://git.kernel.org/broonie/spi/c/220f4f11104a
[7/8] spi: topcliff-pch: fix controller deregistration
      https://git.kernel.org/broonie/spi/c/5d6f477d6fc0
[8/8] spi: topcliff-pch: fix use-after-free on unbind
      https://git.kernel.org/broonie/spi/c/9d72732fe70c

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

