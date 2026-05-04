Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECAA355F2B;
	Tue,  5 May 2026 01:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777943399; cv=none; b=c4CueBqrdgc8l+ViYfLDsvLADO1jHTI1rVLFo0vEPvWG9b3rI7TSwYZNbqXVSAZRz9T5C361tx2NbKbb/eRfXd2mRiRBh5ZAPJ12apuzVPsKJ1fklkq4uQpyFPu48bPO29G+s8cVmxg0kruJpN3ny9wtx5ZsX8lshxv7s95+52g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777943399; c=relaxed/simple;
	bh=331x4UD/hucbKl1nlqNUXkmQvG2PL1J3nt7IJ4rDd44=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ciQndadTpmIIsM5l3H6prleeiF75tP5IZScSj2SXIRWvNZgKMWg50O6ZssqHdnUI69enQl+Pi+fbNL4wMvUL6rLzK6Iw9lkWf7Gc0PzwoBxK7tVnfoiHQWp2Hs9+o1i+t25U5Td4tFE/25aT+cmD7t0YkbEsjZgOMt61AgIx00U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WDQnDTLY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WDQnDTLY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B716DC2BCF6;
	Tue,  5 May 2026 01:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777943398;
	bh=331x4UD/hucbKl1nlqNUXkmQvG2PL1J3nt7IJ4rDd44=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=WDQnDTLYdKp7iUJBAjxYDIOQT2CE+Tz/buaJkZiJie688Zg+TAS0Da+N0ImIxzdCC
	 JTEu5ZoE+GwuPGtH6z7lRQlg55E7j4XGuGrHGcrEBTHqQHFN9i4XZwBSWGAWTW6AsT
	 ykCblgjXfVBNwtKvtbE+q83cqxNVnlhJgKRYmB+paQ5LeUH0/3AAf9Z7dhA+/b2tHM
	 x7BqyeB8t/PBuJvvtM/veymYaiCv/4cXNii8g0JMfUs/zuh6c0VDRNuIfVPyc5F4Dl
	 R1yNdCiGGYZ3yOWs2BDaUiAZGeEdtJ73kHFlL6an70fiJZcqpOfAnKBrEbyBmUdF8V
	 GU61S3/CAzdFw==
From: Mark Brown <broonie@kernel.org>
To: Frank.Li@nxp.com, s.hauer@pengutronix.de, 
 John Madieu <john.madieu@gmail.com>
Cc: kernel@pengutronix.de, festevam@gmail.com, carlos.song@nxp.com, 
 linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260501135951.2416527-1-john.madieu@gmail.com>
References: <20260501135951.2416527-1-john.madieu@gmail.com>
Subject: Re: [PATCH 0/3] spi: imx: Three fixes for the i.MX SPI driver
Message-Id: <177790094182.458539.6679525030679687136.b4-ty@b4>
Date: Mon, 04 May 2026 22:22:21 +0900
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1504; i=broonie@kernel.org;
 h=from:subject:message-id; bh=331x4UD/hucbKl1nlqNUXkmQvG2PL1J3nt7IJ4rDd44=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBp+UNjQEdr3fbB4i6Gr5VRNP/UOajM+6Ey1rvVq
 FD5DTR0PumJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaflDYwAKCRAk1otyXVSH
 0MNRB/kB90jLxBer/YNvrpbas4Pq5Rgcekh2UyIoLynQSQbqU7k2ES2RgOe5BQ7QiyyfyNExK/q
 On5xhPiG1P/qxbOMSdki2e4SSJAXIYtjpW04HKaaHk9w3F66Iyj8djYcuMlcUmSI8yoLghnIgVu
 qLQeIIPTxNBPZnnMjesvha5DfWSOPHuL76cPJ63nceed7fVq1iF18UdX6j1wQPcH/LAnKH9lAiZ
 eIe6lcIxMOYYjHMct4lj/E4FIhavhMq/JCE0NGM0A3IqFHfwSARAnvPRn8GHcNsrLQG7fGfc2tP
 uHAF7Wb7lT4DeDcBSEBLUB1fqYST9+p4RoFk9W1X2ooATFB5
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Fri, 01 May 2026 13:59:48 +0000, John Madieu wrote:
> spi: imx: Three fixes for the i.MX SPI driver
> 
> Hi All,
> 
> This series independent fixes found in the i.MX SPI driver.
> 
> These are:
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.1

Thanks!

[1/3] spi: imx: Fix precedence bug in spi_imx_dma_max_wml_find()
      https://git.kernel.org/broonie/spi/c/24e0fd8b8520
[2/3] spi: imx: Fix UAF on package-1 prepare failure in spi_imx_dma_data_prepare()
      https://git.kernel.org/broonie/spi/c/f5b554825504
[3/3] spi: imx: Propagate prepare_transfer() error from spi_imx_setupxfer()
      https://git.kernel.org/broonie/spi/c/894e04b71162

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

