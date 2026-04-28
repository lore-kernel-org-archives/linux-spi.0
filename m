Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39E427587D;
	Tue, 28 Apr 2026 03:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777347454; cv=none; b=qc1PaNei+7wKVPaGfBolJXVDubV4zvjYBTIZBmVKVJcCiHYn8A+fEBqmIs2zrADM+JwDN0sFakyLdDey1swW3xpzYGrjjrK82zYUL2fWB4QfVTGaR+w6pl1go293HqKzLptK3Qyvau5+6I6dlPnVAqnw1QRG/V9rgvmm6g2B05s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777347454; c=relaxed/simple;
	bh=5T1Y+3ixBP4MWH0kDoYr/M9lHLniulXzZSW89qNFyCc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Z0fNyfk4DrEeT19YVSBlSd2l7gcr7bIQUFqUgsKk07yPipFMeLl8WbAu0bSWEW2chVlfDSVEydQA0vhoxVS3YF/YcOYSyrV5oZhWIQiv0OOy3ZfowN6RwN4bDL9V9U4jv/U5UTO/vq6wLyOBKYE37wsEI7fE6AC079Q7BMHZDVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c44JFtfr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c44JFtfr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEF11C2BCAF;
	Tue, 28 Apr 2026 03:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777347453;
	bh=5T1Y+3ixBP4MWH0kDoYr/M9lHLniulXzZSW89qNFyCc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=c44JFtfr6aWnbrcsCiw4Nr7FwtC65zZXIYAQ4STp89PfMQIId9RwdJuvdQ1gHyhib
	 poVBA4imyZeunKXNnuKcw9XWSWUiEm5H5KFKXR+FzdgCcwCEELzzlBl8dckkmbKrcI
	 rnUGmuUukw+cKEyy6kfJnAyQpyA+GzjOnbg81Hmc0zDm6d3mPPBINcdRIGjCRkp75G
	 xUWZtZO2v9QAdRtw7zRT0YMD5FkLpKPN/sp6qgxusTiTXVfzNi7C5to5fOLoDPtblt
	 2nWQdFf1noH7NNG9FHLq7Odj4waR05mMsFEy8mut2ToqiM7G9HK8RGYEmM4n6+W56e
	 tycw0NRTe7HMw==
From: Mark Brown <broonie@kernel.org>
To: Sunny Luo <sunny.luo@amlogic.com>, 
 Xianwei Zhao <xianwei.zhao@amlogic.com>, Felix Gu <ustc.gu@gmail.com>
Cc: linux-amlogic@lists.infradead.org, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260428-amlogic-spisg-v1-1-8eecc3b446d6@gmail.com>
References: <20260428-amlogic-spisg-v1-1-8eecc3b446d6@gmail.com>
Subject: Re: [PATCH] spi: amlogic-spisg: initialize completion before
 requesting IRQ
Message-Id: <177733784146.324244.3020070967543229096.b4-ty@b4>
Date: Tue, 28 Apr 2026 09:57:21 +0900
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1136; i=broonie@kernel.org;
 h=from:subject:message-id; bh=5T1Y+3ixBP4MWH0kDoYr/M9lHLniulXzZSW89qNFyCc=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBp8Ct7Y00fBSSxGtMIo2f6hSBpox9AkbyHBmpEf
 lNMp+TJH4qJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCafArewAKCRAk1otyXVSH
 0OPBB/97cab0SZgYSGSRAZqFAqPrBZG/DX0QTLPjd4shAFlkHIVdJyCGCrSgQwe62NJQgTUPzkH
 nziaEWkix8gTQna+f9gmoBOxDgs2WU5kQjdkyatlitcJcw59nsa3lfmqY+bEC0iekgYodBIYpQc
 KxXS8cuprYo1AiPE0OKfnQI/VGhaYBHH/KtkMYTmiXts2BZOWTvEsv48cOnHFjoy7SI2xjSNCXH
 wZnXqhjGqDtLdkHdROXTrt3AwI1XDRsjXD2oQ/AnIw7TcZUbALNgav2p64I8+0rQ4qeSQ9I86G4
 kpMQx0N7RWnnpWI/scbMthpBlBYDAGHmJe9kzGIMl4PWc81D
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Tue, 28 Apr 2026 01:42:00 +0800, Felix Gu wrote:
> spi: amlogic-spisg: initialize completion before requesting IRQ

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.1

Thanks!

[1/1] spi: amlogic-spisg: initialize completion before requesting IRQ
      https://git.kernel.org/broonie/spi/c/8d0189c1ea98

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

