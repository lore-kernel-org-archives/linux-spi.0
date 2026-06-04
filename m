Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC83947885F;
	Thu,  4 Jun 2026 13:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780579076; cv=none; b=P26WHoE7PbG82hnZyGpXEd3Magxf0QleSEWrfuLeYT3mo53hfDbv75Unpy9JeKnfCsOjq1tvinbO2DAWDW2EbKfBp2LI80TL0Q0sDAA0Z20aSVaITD2HQ4xDKtutXuoP4/bfTuFU6l/OsI2UQJ8YWletHibygLIabklR5EJ/PFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780579076; c=relaxed/simple;
	bh=zn1Lm+fRejrsYIOSB8rsiXH6l35CzE1tAPf5lDnxRyk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=s1nm0fk5MAMYk9D9qpXhX/J4HmuU5UPgnZu53H7AEcUcIMhDlrvt8EUhRiYzYoPWsZHHqnX+EbIB10BNjYXggHhdjaBkjjVsKUylxUvDMQSRxSnUIvnZIH/p/K37xjYM/jmh+VFS2rWPLiUD4ZjdPQnwIbO0lh7N88BSnxY7toc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iRjUdIHQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iRjUdIHQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEEF81F00893;
	Thu,  4 Jun 2026 13:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780579075;
	bh=X15DOJrGAU6/p/GgClO4pFs91oz0UspJ/IwGaA/qsWA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=iRjUdIHQdleCduxWUAbPWQLH+veKxKvr2LML7RZ4oQrSdtB9kqrTqXyaz0DS0Nqqu
	 IwkoM6cTNYO/nGdzcHOCyNFx6j6P3cnYVH5Em9KvsbWpbeY8EQ3vkBDF13Z9d2X2g6
	 NfXOCbGB2wBjyGOZNlPcSXNyUYnNX08jO6TwjDoiRP6+2IzGu4KSE0lDNROeFiXmMg
	 yc4QSeSXP4gWTEgxTqBfiJAGZMfT//l3Imds34i21Xk736EP2usYUuDSMr7pxktMkB
	 7lfRCOzYfRe+xs1M8l/cN/esv4dICEHtUbX8dZCYNdlbyvhWJ/xjp2UAE8lTWpNooA
	 MgmwzHPMdcSUA==
From: Mark Brown <broonie@kernel.org>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260602235825.28614-1-jszhang@kernel.org>
References: <20260602235825.28614-1-jszhang@kernel.org>
Subject: Re: [PATCH v3] spi: cadence-xspi: Support 32bit and 64bit slave
 dma interface
Message-Id: <178056886874.53724.4850286391745939707.b4-ty@b4>
Date: Thu, 04 Jun 2026 11:27:48 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1141; i=broonie@kernel.org;
 h=from:subject:message-id; bh=zn1Lm+fRejrsYIOSB8rsiXH6l35CzE1tAPf5lDnxRyk=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqIXsB3EiUV/pZAkmf6xBq3JMTO2lefe46gepz4
 tTaS8o1aYyJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaiF7AQAKCRAk1otyXVSH
 0KVTB/40ByzAY4a06qkisuQNIbXUb00iuOqBhEcDJuvGcXnnFg8v7thPZ+WHUh8SxddHf8kK8Rh
 X6sUBIcPas3WSkwnWAAaze1ZT4C3wJF1bpimT4ODBAWgh2MwAMNueauTGv+iR2Fri4Kvn4IJ9yS
 8ZBK1GgYxQsJb0gySXttse+QOKjx9z1M/MI2DM5lS8OUce+LYTy/z4dJrg7QcNHQK0n4wNTHHq6
 rQku4HyMYNzlsjkLzFDd7sHFPDh7X6qwhkCdT7Z8SWvNM2WRJ/+u5Cjz6eurXFQyDyz7CiAzcvp
 XuxOBZraqt627BQ6DrSwi5Umswm6DQpBOluSiTEe+5AumPmd
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Wed, 03 Jun 2026 07:58:25 +0800, Jisheng Zhang wrote:
> spi: cadence-xspi: Support 32bit and 64bit slave dma interface

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.2

Thanks!

[1/1] spi: cadence-xspi: Support 32bit and 64bit slave dma interface
      https://git.kernel.org/broonie/sound/c/4954d4eca469

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

