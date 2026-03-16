Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2598E24BD03;
	Mon, 16 Mar 2026 01:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773625104; cv=none; b=gYIK8HwadwItXdGv/AO7zsFHzlWs6s29Msl+83Xi4GoQe2IjOrqH6WEzBGaR7TdiEEzKY3gBCQ5ZcuA8pGyfXd6XiqGNeuJQhcm5BLxYNhLCbl6pgX3Htwze/kesP7ZLODjnR9AeMVoebgYB0d2w88IKhWJUBOYSw4OoPdRYBXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773625104; c=relaxed/simple;
	bh=d/9LTutW2/sfbxpaiA7+GoIDQgSxqq4jU+iCqYYTkk8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=NdWXWtWpMG+5jF+ZvrQTXqPMKMqpUGx2s4pR7182VSUZlGXQpKyuHrabrCWQtfWYdUp18tJgleeM8+yTm7zD5TbkFd3sNeT93mh6JjzeuOwydiBz5C5QkwjtAUw0WmJZN+bi/gR9AnQy+2QDrF2rBKSuVbBFIamOGEY7AMN9IjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ICv2+T1U; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ICv2+T1U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A189C19425;
	Mon, 16 Mar 2026 01:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773625103;
	bh=d/9LTutW2/sfbxpaiA7+GoIDQgSxqq4jU+iCqYYTkk8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ICv2+T1UU+THq3X8u997+aTGt4J6+WNH6l0bMFk0TrnmdEoo8cLrq/ldPkKYwiKzA
	 1VEKlzVQJ4pzGHsuvZAbVc6VH8wz/CfkHtwGYkfoQMZDjrXiQAQ5SiihcRpacX4mfU
	 tZvya1idwUCBjVe/FNnIDYEFV9Esl1dlAgivgEAOa52iUSBB+IkN6V2+Qqm5YEfhp/
	 NOkwgv7RYBlVCGjJdiR9aw+O3orEufmRpRFW8EwkahELdbHMJG3KvWY1bAR9UWJdkl
	 /pjT4YT4bJQaOSENcU5a6hybQ7N+RAHyyQDhaWeQ93QB/ujW2x7wmWfPymRRL/FfjO
	 eGeFFTmHcBh7A==
From: Mark Brown <broonie@kernel.org>
To: Sunny Luo <sunny.luo@amlogic.com>, 
 Xianwei Zhao <xianwei.zhao@amlogic.com>, Felix Gu <ustc.gu@gmail.com>
Cc: linux-amlogic@lists.infradead.org, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260308-spisg-1-v1-1-4e209faf228d@gmail.com>
References: <20260308-spisg-1-v1-1-4e209faf228d@gmail.com>
Subject: Re: [PATCH] spi: amlogic-spisg: Use IS_ERR() instead of
 IS_ERR_OR_NULL()
Message-Id: <177362379342.208027.8833588835159295792.b4-ty@kernel.org>
Date: Mon, 16 Mar 2026 01:16:33 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-5154a
X-Developer-Signature: v=1; a=openpgp-sha256; l=1130; i=broonie@kernel.org;
 h=from:subject:message-id; bh=d/9LTutW2/sfbxpaiA7+GoIDQgSxqq4jU+iCqYYTkk8=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBpt18NV87NGk4vInJUniwWubl2ofuZqX3p87FdJ
 8auBKVRhgWJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCabdfDQAKCRAk1otyXVSH
 0KwHB/wMmqc29o88Kcu690SET5mIfjY+xqLFm9ieRGtC2mhTLlkoGDqWGFp2ZNYPOwe7UYme6xs
 6Z6nRBP927eEZd60pajKacR4Tk+aCYUv7aiUbVOhZUKql2GA0SFuXjjcy/m0MjfQKY07GyL8ZY3
 pgNbQ9K57MBd6409tTZP8uMGXoRsaWCtUIJSWyJ5nM50T6C59I8QK6uot4VgpzWHP7yPwQWLnos
 qlZ12zF9gherDqq5ojDrRinOiV2eHBt1ihK4f2BkAFxuIPHiieo8ysRRUpjv3IKFUSzo6SsVdYX
 aIUnjXSwOA4zo69ANca9lHEnu+JWPmCfbVTI/DGcH+6WeBqM
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Sun, 08 Mar 2026 14:59:50 +0800, Felix Gu wrote:
> spi: amlogic-spisg: Use IS_ERR() instead of IS_ERR_OR_NULL()

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.1

Thanks!

[1/1] spi: amlogic-spisg: Use IS_ERR() instead of IS_ERR_OR_NULL()
      https://git.kernel.org/broonie/spi/c/8abf84f76a54

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

