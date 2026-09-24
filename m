Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7FA48822A;
	Fri, 25 Sep 2026 10:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790331359; cv=none; b=vAI+Ka1L8sO9bzw7Y0WK8W+CfwBeUMmtmurXw5+hp5VScgt1kFyIeKSj8L2sl3+eYBTxQLNxD4W9mlBEVyoucqaZPujf6G4LXt84muzn1uGtC52uDEv2iTdP8lmqGCdxlh/sre6yUkNIUW4mXtnWOlV0kYu2GQLInpKa255MnOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790331359; c=relaxed/simple;
	bh=wfWF/fWfj4VLQeGJC9cBpsgoFz0LSWS3oauYzKEDVIk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=et3F5Eb8TCYiCH6H3d1f0nl2v5rBetYBsfPQTgMV3A4kxHFMoE6M/kEIVxAHpxAd/O54a61y4B0VYZV51AIdJY8xesFt5MUytBgLZ0AY+p0iwxJauVvKGOb19aRf8RD4Wt/ysacSHON6ZgdEkxs+JVEL7Y1mdkyiut1/y+zhkY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N04T8Cij; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N04T8Cij"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CEB81F0089B;
	Fri, 25 Sep 2026 10:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790331358;
	bh=I6jF7DMRmKQ/9R1R/h/vfgHtGZOOmh5tgfoLmvW1jjc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=N04T8CijZOTbBo/fEkKVK5JuOg7RIn6YE0e4GXsIyXSae1LU6EjE9o9wEluzcB6dS
	 kJuyd/qxnVZ0uIVZW2tLoYz2riDofL202+ixFG/kyExZpLz0T4xh11+LsgwWcz0U/T
	 OiVYNJCrNhhr8Gj7HeYbqNtpHelZldl+RNcqRBqxX4E8jOmFwSEg1iw34ASkGhNGAT
	 qDKKh9vk9S1iFTU+k0NH/STfuB3VnIJR3yEdJjQSKXBqDQCeJje394D9P/0k1jzmdY
	 npugJMIYCprrgMMcvYM7yoVTIF5YleHMEzbErcbVhn7xi+ycTKNwEF9FRWQAUDj5rd
	 thwQgw5+aYusg==
From: Mark Brown <broonie@kernel.org>
To: quic_mdalam@quicinc.com, Ziyang Huang <hzyitc@outlook.com>
Cc: j4g8y7@gmail.com, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <SEYPR01MB5882463D860A9670617D5834C9A72@SEYPR01MB5882.apcprd01.prod.exchangelabs.com>
References: <SEYPR01MB5882463D860A9670617D5834C9A72@SEYPR01MB5882.apcprd01.prod.exchangelabs.com>
Subject: Re: [PATCH v2] spi: spi-qpic-snand: reject when no enough OOB
 space
Message-Id: <179029043927.149798.9171868174419782866.b4-ty@b4>
Date: Thu, 24 Sep 2026 23:53:59 +0100
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
 h=from:subject:message-id; bh=wfWF/fWfj4VLQeGJC9cBpsgoFz0LSWS3oauYzKEDVIk=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqtkna77L9DogncmSXl1hts7gzPSyjUj+KuWqwa
 lzXT/6iICGJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCarZJ2gAKCRAk1otyXVSH
 0M++CACEsbbj/ZtA+RYrXAo6GqGgmsrY/gJl0cCCgAviLtcv6t4pY29lcgHtRaCr8BcjAP+g+ZN
 utHF3KGIV8eTvUj7zs9LvK7Z2oAHkIcwDWKtCC0Qv14Ibq+lN+Y8T82Vk+KJ8ObMgWda4C6m3VD
 p0QZdhTGOBQFuXm9RLskl9RUobI97PXsbMvKWJWKw2wJfwu3HoaTimYFhXt5waPCKd1sce44/e/
 VJpsC8BHbJQeXxTjw1ERIs9rUA98rh9aQHOPRhH55mJ0HPzUxidEdUGT47w3iL7u0jgQqwQgDf3
 5/gFH6Pb0QBmqu0v2+a9g7XqquZbuAvbPP35B1iz5Mcxkxn5
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Mon, 17 Aug 2026 23:15:02 +0800, Ziyang Huang wrote:
> spi: spi-qpic-snand: reject when no enough OOB space

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.4

Thanks!

[1/1] spi: spi-qpic-snand: reject when no enough OOB space
      https://git.kernel.org/broonie/spi/c/2a252105e034

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

