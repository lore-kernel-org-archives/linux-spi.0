Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F704825A6;
	Mon,  5 Oct 2026 13:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791206098; cv=none; b=PdiEzPhTapu46A99roDfTNbAypT3Q+4Zx8a1k3AeLddRSoR+k3fAZoPhyHMsAfh6SD4Qx08b4EhWEQSJXgThKVs09nCMHsKVRuu3gYxo8iP0Bk7/0rGu+GuS95ibfubU3ZNDD53jX1nYDsErzZEvIzNYUlPtnkTG0Ytmw6mOJD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791206098; c=relaxed/simple;
	bh=HoRd64CGBSPHAygK6Bwh7r690KCdOZuqMTF0+T31sEo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Yfr6tvNJkXHYPcg2qMHe8KEQ9TXf0ltbSN0xhY0R5x1/pWHc63SZwBO2rljW6tW6eDcskehnPftH8lTZX7dfTbtAihydJ6lu0kH7XpwDZDDuFyfCSa7hchFhm60RAjtk335PNAMUqh5gJ8WCUhn/jQXuaXL1p1CaeqN0ZW5L5ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UWxpw7+w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UWxpw7+w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB95C1F00893;
	Mon,  5 Oct 2026 13:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791206096;
	bh=Vij8nuMtawA4EEgDodwVOo0PtTd64d9d4ZIlMDRzEPI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=UWxpw7+wb4AEgH3i/RbPmgLiISDLNvgTkCc9/4d9oAeNZIRuLJnOgCzp+7DVxk9hR
	 4QMeQS9Z+AmUWp/N2maz0kzleCDawQ+gQxxntnI8GvnCAy5TeID7NYTHuV+vCbJ2cQ
	 /uO4kuzeKWb5yEAiFjk8/L+MmdQnZQJdqQrvcKykbsNV505IC17NDcuj0VOYdkl/cr
	 540Z5UbXWAJvRqgQ2SPEKl+B4Jdfoejyv0XmPgaIMipUImUi40sLNNb1XdnnExHQJq
	 ZjrQpqqiRIhP2NrbwOL4v4wAHeg6xiulwuvs324dj1fyhnfkmNe+FVDohbzTPyaCBz
	 0YX/jtSF8T5VQ==
From: Mark Brown <broonie@kernel.org>
To: heiko@sntech.de, william.zhang@broadcom.com, kursad.oney@broadcom.com, 
 jonas.gorski@gmail.com, Guangshuo Li <lgs201920130244@gmail.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linusw@kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, jon.lin@rock-chips.com, 
 bcm-kernel-feedback-list@broadcom.com, noltari@gmail.com
In-Reply-To: <20260924112329.1566051-1-lgs201920130244@gmail.com>
References: <20260924112329.1566051-1-lgs201920130244@gmail.com>
Subject: Re: (subset) [PATCH 0/3] spi: balance remove-path teardown in
 three drivers
Message-Id: <179114318831.150114.12760845139771007579.b4-ty@b4>
Date: Sun, 04 Oct 2026 21:46:28 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1522; i=broonie@kernel.org;
 h=from:subject:message-id; bh=HoRd64CGBSPHAygK6Bwh7r690KCdOZuqMTF0+T31sEo=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqw6LKIw6I/a46gzhc7bnqluU5FckkZTqnoRQOa
 iofk9gNG6eJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCasOiygAKCRAk1otyXVSH
 0NlxB/9UJ7TS16VU2H/ap9bXFFDsZ0ziaeNgBroa41aDUN/rR/CBWJwP9doQg+ZZuhlHvGzQ4lD
 QsWQ077htkcLBq+Fwe8B1PsMZv1DIJF2YOBngqVkS08Mh6pmRpGJNMBKyupl05hNrMTWCBzsdTj
 B7BsdVqew3/8vToMJC8+lVuuhoP5X4W4G31gyMGa3nyj9/jYr+axDKI9CBx+pMpKsaEeUWNAMe7
 EqaKmjnXcifikaen1Jsm7rFajHUmh97DzABF9KhJdHR1YKh5tb/6ASnWBdZ8LgNzYJkvLD6jB0g
 Tb3n14IfnKjhBue3Gv8nNc/7qxJj8j1UMov0LNS1T4D6dEt7
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Thu, 24 Sep 2026 19:23:26 +0800, Guangshuo Li wrote:
> spi: balance remove-path teardown in three drivers
> 
> Several SPI drivers establish resources or runtime-PM state during probe
> but do not perform the matching teardown after successful removal.
> 
> Add the missing unmap or runtime-PM cleanup in each driver's remove path,
> following the cleanup already used by its probe error paths.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.4

Thanks!

[1/3] spi: fsl: unmap immr_spi_cs on remove
      https://git.kernel.org/broonie/spi/c/af1d882d421d
[3/3] spi: bcm63xx-hsspi: Disable runtime PM on remove
      https://git.kernel.org/broonie/spi/c/38232bd3cea7

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

