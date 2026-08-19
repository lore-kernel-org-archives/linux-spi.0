Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49491484252
	for <linux-spi@vger.kernel.org>; Wed, 19 Aug 2026 16:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787155705; cv=none; b=OKftDgTaVgHvEDIgGJCNWLfq5Gw4YAOTkNYgX9I+0AzFB4M1GfavOA9MgA5dSycYdpy1YSYx/twfiLKb8L91LCRAEhZTFUSRFVJRgN5h7jKvgLOzuaLaU5KNzFicJoKy+7NzSNrHiiKdF13EqI0v9bXrEBnXW8U3+s8MQ6iq568=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787155705; c=relaxed/simple;
	bh=PAvq5mWvvZHRnddmaJsqWM2/8B+z9YzVszYsBElIqvo=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=PEpawlP65eoVvLkA75ltWGse2m6qhC9OCa9dBXljmgp/DdMQr9HxHciBCUd0vlBidhXBC0sd5ppsuAeNOrp6SeVz1BRCyKJOHuxaZ/Q9CCujhGHu1ZN52YPz3pwXCzKot32+accYMNMuMci1LV68TGC4oDtvfl8jW5fYJEz6tJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=daDlPD3X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="daDlPD3X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CEE21F000E9;
	Wed, 19 Aug 2026 16:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787155704;
	bh=LyREh4su+yTfBbDmL4YqGxD76BhJFLHtpcFZRX1UePU=;
	h=From:To:In-Reply-To:References:Subject:Date;
	b=daDlPD3XxgB3mSxupqfpavixFFm/kinaPPZms5InS/Fm/wNSHixKvAeWKKT3KPXwF
	 /W12ezVd+IpWxdtegp/EJhLGSQI9jPiZ+CcdA7Smj1XcLyUdEO0Wr80yjt+r8jkqJ7
	 cupXmXoKt+nYrUM3MXyXD9zYAMfCZklD5ZvZ/N13T2SZB82ixKkycodm09VnIthzIG
	 xSSCC5UNHmCcaZzrEP5UBmu8/3UBkqlsuQfm9g2mNIX90eYIBWRiGYKtb20VTbEXH8
	 sudQaAV4vIPtBJ3JRqdZ5rjxE1N62VzpKZQMr6q6SWYxcZlup0i3ug7ArqUWZEsRxy
	 uMt02DCb9jR5Q==
From: Mark Brown <broonie@kernel.org>
To: zhuyinbo@loongson.cn, linux-spi@vger.kernel.org, 
 Li Jun <lijun01@kylinos.cn>
In-Reply-To: <20260819014552.1986077-1-lijun01@kylinos.cn>
References: <20260819014552.1986077-1-lijun01@kylinos.cn>
Subject: Re: [PATCH v2] spi: loongson: pm: add .freeze .poweroff .thaw
 .restore
Message-Id: <178714815167.98116.13649720235176569283.b4-ty@b4>
Date: Wed, 19 Aug 2026 15:02:31 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1118; i=broonie@kernel.org;
 h=from:subject:message-id; bh=PAvq5mWvvZHRnddmaJsqWM2/8B+z9YzVszYsBElIqvo=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqhdT0qjabDT8w1VBa0LtOs6A6LAGyOeRln6nJX
 cOosb/mm+OJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaoXU9AAKCRAk1otyXVSH
 0Gp0B/40kzbZjIvLSusyCPBtMkExIpnhitie5MqiSQubg4piLvj3Rq/kdyyber6H5y2qecgHkxR
 FeM8MV154B89Na2qinK8o5yy8oLa98ECituWI2RJ0zn9+V9I4ZbUe4ahX5mQjilmLwAEi7dLQP+
 KnlRZWP4EU6odYL55bpIOeYkzLd2pWTJROb0LuWBBOrgAJRyCW4ueaICr5/2qLyl5z+mUlFPWMb
 H8Pv9S+84/LQskFvLtAEi9tD6GPRbBt/TABvGKQkzqqstlG14uszrEv8mE5iKWciV+8yBANKrhG
 C/AYCdsk7VNDha8Ks5K6EPeh7vhoqt9Hd0yRjaD8fvdbPC+l
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Wed, 19 Aug 2026 09:45:52 +0800, Li Jun wrote:
> spi: loongson: pm: add .freeze .poweroff .thaw .restore

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.3

Thanks!

[1/1] spi: loongson: pm: add .freeze .poweroff .thaw .restore
      https://git.kernel.org/broonie/spi/c/b4b52cc0bc1c

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

