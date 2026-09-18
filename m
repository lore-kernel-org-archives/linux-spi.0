Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10CA233B6F4;
	Sat, 19 Sep 2026 09:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789808650; cv=none; b=S7bh2PL18Osn2u7HTybchRCXLPTLITH2w5xzQduFy0dghBwC/WnkwdzQ/1EO1X6UIa+M47DIv+lXSAHbrVIZpbadHMhbb3KMBMrPFbrv7kVZmvcQmDQrJEOGx0njLpCdG7MB8IU6aiXVzyDPRoTlEp31QjWFPDdy6OIyRGleqcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789808650; c=relaxed/simple;
	bh=07mMyxMsaP6e9rVOkNiufgr3Dwg5HIHOcIaZCo5Ccuo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=PfXWDTEdUmNZyg235uK6P5ffW6G2yXX3TVNE0nZ16o5OlJvownmlh11CyDE6fE4To9pW2Kh6qOtQaTRfB4OmyYNG0ChOBXDcr3FJhvMr+v8GVJSFpJsNvurm2CuFOFU5cXJgnO+JE0iIi2VHfJtEPrXTBky2nfb/3AfCP6FsaUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gtY9+36Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gtY9+36Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10EA21F000FF;
	Sat, 19 Sep 2026 09:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789808648;
	bh=BBnavKyXduBDgDup2hJbOMSKrWBCyILhm4SU8REE7oQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=gtY9+36QQDLOAjld+dnCg2da7Sh9sWyFs4r67/H0RiQLIeaozrHAoxUgjK4bNHK/b
	 WHUY279yatJ16otcvxSYTH3X9vF7qie7F1Jz4ooSeCRggZjL620zpTWftDGIJ9vLY0
	 Z4a9mQfh9XjTtzwOG8xjbYjamL6yHzuS1wq/fwE1+qZfWpbYm7ZrcSCm/XBNN4I0gx
	 7iGzdI8Cgee7Yx9zVGoMiok/dqno+gP/API9OwzaBctQAlJj//BYgEGpA/52W7iT6D
	 IusCUOcKAhks32oGIV7CwmgEkyo/hj2ICPUdx3EV707q8UzIa2RCpiGbma05VZKETk
	 FAKcq0x9hhtYw==
From: Mark Brown <broonie@kernel.org>
To: Gabor Juhos <j4g8y7@gmail.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>, 
 Sricharan Ramabadhran <quic_srichara@quicinc.com>, 
 Md Sadre Alam <md.alam@oss.qualcomm.com>, linux-spi@vger.kernel.org, 
 linux-mtd@lists.infradead.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260918-qpic-snand-config_page_read-v1-1-a686c4657857@gmail.com>
References: <20260918-qpic-snand-config_page_read-v1-1-a686c4657857@gmail.com>
Subject: Re: [PATCH] spi: spi-qpic-snand: add qcom_spi_config_page_read()
 helper
Message-Id: <178976719898.1863384.8556438564232843245.b4-ty@b4>
Date: Fri, 18 Sep 2026 23:33:18 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1131; i=broonie@kernel.org;
 h=from:subject:message-id; bh=07mMyxMsaP6e9rVOkNiufgr3Dwg5HIHOcIaZCo5Ccuo=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqrlAECYDY8bpS7oTqenf0plXibSOVh5r1YS6tJ
 sdPOdx2ek6JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaq5QBAAKCRAk1otyXVSH
 0MXOCACGtIGO3qeCu0E8ocf6s0p8J5odLs/IVePHyKBnpef5RXVxGqvDE/HFGV92BLthlnT36JZ
 tQGvsD3bzMl+T81bEinbr8pU3e4PxStdW+odHzGfM0C0u3kh41OTQ9t7EPHp7/gnurNN1SlaoIi
 0kGNTCBAC1Q9D+memFbzOq60THq72YkABcg4z15Zin26WGc/BiPaN3QnukH9jQtEJduN4dsOM+A
 5YEMNCuYkONxc3JjXt25ZOvrS/FKzBbMFgpMrRWB0sBIzu3lEqie3JrMYijDMRUHegzduPihmyX
 baJ/XEZsTRbCNzE+5XUBGEsdY9t4lilkVkizdasm3qrn409u
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Fri, 18 Sep 2026 21:53:08 +0200, Gabor Juhos wrote:
> spi: spi-qpic-snand: add qcom_spi_config_page_read() helper

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.4

Thanks!

[1/1] spi: spi-qpic-snand: add qcom_spi_config_page_read() helper
      https://git.kernel.org/broonie/spi/c/001cdc434aa8

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

