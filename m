Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD56D490C0B;
	Sat,  5 Sep 2026 11:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788609568; cv=none; b=UNb9JIDY9DuzfrSSgBRI8g7R29GThw6q8Hz1Tj9NZLc/c04zMALTAMZI1LoxMS+Mz0EanDeHUtNUkJVrvthBgqcPMgFXCR46gzt5SDIXDlN7ioMik7/oeQ4GRUfL+27nqt0H7T4sELLfmaVWgtxhw2nRzIVL9KUvtwr9jdE0OXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788609568; c=relaxed/simple;
	bh=uCd0Y2s1ntfPkF8I49DOtN1YzSDetCsyUch43wSRXSg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=sMUTLtAYq46fRGGBcJfpUNbWuc5n/EswR8Pgr7ljKfPgzlXbwxk3yfmK9DCXEyz7IZ2xbe99f8UDNNIDRIVuqnf5oSYiELdaOW0Bky5b8PxPZf/Kl+rWVDer1tyih27wou9mZtY0YVsyUkqwNlOOEoipJ/XZmCDGXYNaqUSg6AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BsbMrz/H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BsbMrz/H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7910C1F00A3D;
	Sat,  5 Sep 2026 11:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788609567;
	bh=D51OQaPymGUeRCghX48Gk3kPeHwg7sCjWLRZ+NnuoY0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=BsbMrz/HgGZhfDPss1emYfP++PCe60dt5hFwzIZGnYzBdISCTYxXvigK5/dFt5wh+
	 l67nD02jT/yrrKg7OmM0qPQiJQUHB+JWvh0H7QU0YKgkQNtPWlkwIiKeHP1KpyeTc9
	 Kfzpu5F6fHK6bguTBiY0osvvf5sgWROCEyiIG2ndCOXCPKURjPwIYWPwKF27HfRhCC
	 wC0CTy4bgRkF+pyY9gWlNV4wE3al50N4LPd08F00Wjc6gs/oWH0kBKlokNpg/OFjoF
	 GR6etXhfzaiyjDgP7UmegQ5DlVe3JHBzzPATPXRvPtCB7uwlu2TJ1QMToBlJQT+bnm
	 NiX4Yu+y3lqKA==
From: Mark Brown <broonie@kernel.org>
To: Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Ikjoon Jang <ikjn@chromium.org>, Felix Gu <ustc.gu@gmail.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
In-Reply-To: <20260904-mtk-nor-v1-1-cefdca098f83@gmail.com>
References: <20260904-mtk-nor-v1-1-cefdca098f83@gmail.com>
Subject: Re: [PATCH] spi: mtk-nor: fix runtime PM usage count leak in probe
 error path
Message-Id: <178854774645.632048.7126140576103303391.b4-ty@b4>
Date: Fri, 04 Sep 2026 19:49:06 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1140; i=broonie@kernel.org;
 h=from:subject:message-id; bh=uCd0Y2s1ntfPkF8I49DOtN1YzSDetCsyUch43wSRXSg=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqnAQaaY4GiSLKP34zq6mShUvL4Ags9zm8EIUcd
 TVQl30UFWOJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCapwEGgAKCRAk1otyXVSH
 0Ct1B/9PW0ZumOIjwq2XTY3SF8GLJ8lUSYSFQ5+tCw8dj+FJ4IOHjqpq1TTz4TxBhd4LPCDLbtg
 S1bJyRlP2KYMeBPyi5B2E89PVzLhQs47iDldDu1DuCw6QBQRIH93IcMcFDrv8HADXYjhkMubgDK
 ZZe5Umaf88kWFs2Wn4d/ITXp3w7/yXcyo6FrjnricbLEAHUMdnw5unjGj0AOD7g+cnTIRRF2bQL
 DSCzUzfRa1INdV4IkcP9ANHn6Ld4i0D52y+fm2S56vmNjxQWdCwPxxI+rLHYyJUgfLr1cxS6Xtx
 krWthXEojov5bt8UsQBnTJoIW2fnoy7J2eyQSENdFWhIzxjU
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Fri, 04 Sep 2026 23:51:29 +0800, Felix Gu wrote:
> spi: mtk-nor: fix runtime PM usage count leak in probe error path

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.4

Thanks!

[1/1] spi: mtk-nor: fix runtime PM usage count leak in probe error path
      https://git.kernel.org/broonie/spi/c/4cee1ed13e26

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

