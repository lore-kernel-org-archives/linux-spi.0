Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E777E2F549C;
	Mon, 11 May 2026 12:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778500949; cv=none; b=Ith2HcosDILMwEPXwJY5k8s/rRwnWw8wjWqrutxEGB/wwOqWRcKrxzNHl2YwyzokcPpNmrs+hCkqz2fIOyJZMDd2aFcfbZucvNjnGv8t/ztitz69cJvIn1sz6ok94BNoMmJa76iibToCnApATW4LR3oqppXwCDg0MaFvMRHqLow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778500949; c=relaxed/simple;
	bh=C79tqVaid3bMp0IWCqGmXs+I/52gXN7k9dQKzJGMPw4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Klczd74g9uCWq85mqwE9C2M+fTLD8krKahbkMJgM9C2BRqg03IV6xds7Bj2B8ZZZSaDSe+ligASH+CpeA2+ac0RNDc3FGJgNNXHEvNJCIzdkiivTwawqnZhXS2fcQntuJnKPfx7nyDO6sQSWobgFGGbRzEtaXKKneflPGZypp/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OFhqCAEF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OFhqCAEF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64207C2BCB0;
	Mon, 11 May 2026 12:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778500948;
	bh=C79tqVaid3bMp0IWCqGmXs+I/52gXN7k9dQKzJGMPw4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=OFhqCAEFO+Q/+kRJp0wbEzbRv7AkQyQ3HV0rsJyZMlBKJSoRofFTi29gPDhj9W0C8
	 BRvWN7NjhkYWT0cDbV5YpKIzc49o6kdJNpzjMpO5tg0TlnBqw2nvo5txTz2vyaAOWc
	 v75SEkgDOYsVe7Wf65P6oMr9Icginod3WX6lJ2JzgUqKXkbktod+y3/jvagLVcUion
	 RpzbjG2+NZJ3TIQhRZvTESN3FmNsh8ClHTP1AKPGDQyEwDvFsbpgXQDx7dbZB4ZFsf
	 FkD1Do+qwmCB3kapVjofwg7/WygFdcVOpf/4eUeDMfOBp6rX5i2Ky9uFGeo6DcMmYd
	 VAep2R3yykadA==
From: Mark Brown <broonie@kernel.org>
To: Krishnamoorthi M <krishnamoorthi.m@amd.com>
Cc: Akshata MukundShetty <akshata.mukundshetty@amd.com>, 
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20260507180051.4158674-1-krishnamoorthi.m@amd.com>
References: <20260507180051.4158674-1-krishnamoorthi.m@amd.com>
Subject: Re: [PATCH] spi: amd: Set correct bus number in ACPI probe path
Message-Id: <177845935499.986162.15900576730103665475.b4-ty@b4>
Date: Mon, 11 May 2026 09:29:14 +0900
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1124; i=broonie@kernel.org;
 h=from:subject:message-id; bh=C79tqVaid3bMp0IWCqGmXs+I/52gXN7k9dQKzJGMPw4=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqAcVSrDIbevqWPp7Nt2DT7T6vXFJSIA35JsAL8
 4JiShYrL5GJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCagHFUgAKCRAk1otyXVSH
 0JwkB/0QN4ETM2qxT1g+QiiBhrGOUTCupg/38/ni7QYOrwO2XJ4nUXYJ24hDWcOPMQaDJvXKs3d
 RgFDR3qFL4lwCKqvZ7sS2aKykG64a+SY/rDNahKMVambzSOjJsQTJyYoZVjZgphBze1GBbwJjWo
 Ad1QfbK6CNOqDjdHL7On+JSri6FXjGpRQFBCB+5UPFvq9L5zaIcoTop3fza8W9CkeL85KEFw+br
 LxboE+yO0LysU6TgnAO/jeZ3Q5dnDleLuvsAIn41u9zwjLbVf/h4eYdPL2gprGalCwcMBra785s
 n6QpbIIchBGjgNWYeDH3FTkMZULUzKvqTs3+cbBs4WNl5TX8
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Thu, 07 May 2026 23:30:51 +0530, Krishnamoorthi M wrote:
> spi: amd: Set correct bus number in ACPI probe path

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.1

Thanks!

[1/1] spi: amd: Set correct bus number in ACPI probe path
      https://git.kernel.org/broonie/sound/c/422bd00b71ab

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

