Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9D048D89E;
	Wed, 29 Jul 2026 13:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785331944; cv=none; b=YrSkNlGXUWsnHohmy/A1tjYRAir/ohkW60ZJEs8PVNVspveQk455YwMzY1raxf2MREmSijKST7Vt6iV4cKZencyMEKwfu+NHX6lgYNQGPsPitTxRQzigdvleg1LqPc/Z8ztuIKLWgUvKda3ivOLuEwwbcTmOzFGI0XUFgdEFx3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785331944; c=relaxed/simple;
	bh=CGG+dd39rhYGTzWUkXzphAhxR8cRymnBQlxykMZwGI0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Nq/3V36u760fYwiIkVdI9+yYRlcQOK2rJUOqa2eTj9CDYP66tY6aQbV+jwhjQ4PHL5dIIeyVKejyajVDwXlbhrysriGSNWSgidiAhsieQwteAvuUciLNdbblSYbUACZYSyk8sTKqkn1zAjXLNeENIo1TvpWgpgX1N6dBCQguBsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S1NuYzvC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S1NuYzvC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEE601F00A3E;
	Wed, 29 Jul 2026 13:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785331935;
	bh=q0snjwYY/35qjO+0aSAGGXjnXUIy59ZB59Qt/9t+lAY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=S1NuYzvCwXI3OG/ntZWASONS/WAN97+ClbVmLNLhLJHSQoxyMJ4CtRWBkdCl6LCNF
	 7w+hCI34AOGOnyIDDukIuuP/aguYdiiU939XGsqSbPHfidxqDgVDTSuiP5G7bQ5vAK
	 O/EvybziqbmPb+avbIzQGzS0KpcDv3KUVUwISxBSS6mOVp8qDpDFF8kp5VIXUSIu/J
	 RMFFvwg0aIsfk9bJkgH4bOJC/mixpLGHsJFhtf9hSXarCzpZqw9eBMYqhaceK/BVnL
	 91XNoOXW69wrSeFEHzq1fUwv0YdrDwtKr1U4NELp66Vy0TKT1BilXKs7eVZVxXp61l
	 Jzel8vnhj5jRw==
From: Mark Brown <broonie@kernel.org>
To: Md Sadre Alam <md.alam@oss.qualcomm.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260716-8bitecc-v1-1-6eef4bcc3a14@oss.qualcomm.com>
References: <20260716-8bitecc-v1-1-6eef4bcc3a14@oss.qualcomm.com>
Subject: Re: [PATCH] spi: spi-qpic-snand: Increase ECC strength for large
 OOB SPI-NAND devices
Message-Id: <178519396846.552178.12604052410733033393.b4-ty@b4>
Date: Tue, 28 Jul 2026 00:12:48 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1161; i=broonie@kernel.org;
 h=from:subject:message-id; bh=CGG+dd39rhYGTzWUkXzphAhxR8cRymnBQlxykMZwGI0=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqagDd6HrWUOUGIwpVNTTzFdWMTuLiaxCtQ+hZ+
 NE7M+6fCCOJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCamoA3QAKCRAk1otyXVSH
 0MN1B/4plazBwu7ykxmxMUbtVEIqXVmeS3xK5y8URTW/SIwTLih8SwZ/oLfvPm1EJkP8p1fDaK1
 0dsY/gAUt16VinrJbuQThc9IGy8YCFhLrvpTpi+CYwh+gitbrgpZVogNInsB9+4J3QgRZ2IFfEx
 TW/rr/lEtbul66XZB6NUDi+2GUDSo0Uys62s2VhKrzU+EvriIFLZe5uUAYNIQKNv5apn5dz3USG
 EZkWfRVZkJzHyV94426DBygW22kj16gkPZuhq84dxiZRhygAdXO9A3WTsiZGCpAbSI0zgF/Qv3W
 O3qobAcOPFm4hrbCOqY1WDWWNsrTRzct9p++OrHHnkfDxUMo
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Thu, 16 Jul 2026 11:13:05 +0530, Md Sadre Alam wrote:
> spi: spi-qpic-snand: Increase ECC strength for large OOB SPI-NAND devices

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.3

Thanks!

[1/1] spi: spi-qpic-snand: Increase ECC strength for large OOB SPI-NAND devices
      https://git.kernel.org/broonie/spi/c/ed4b52b24c55

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

