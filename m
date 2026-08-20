Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87BC539936E
	for <linux-spi@vger.kernel.org>; Thu, 20 Aug 2026 18:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787252036; cv=none; b=hwmiWKQ1O1ACO+PNSLQys74+G4H0rLm43eO29Pxk7RGKXSsklgZGA9ynYOaC+M8lOaSn1fXTa9R4FumhWv+C4EjyloO2KtydbBuqqyedF0sN3qbg5WDXp7cxWwtvybeWEPEfAZb3WSZ0c2yoWtYUiHukjorhIJGzSW4pMga5ZaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787252036; c=relaxed/simple;
	bh=+pX1E2Cobxoo851nb9w4JUZl3NhD5xsNcinFTWR3dkA=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=PYvmbjXi9S9kxzTcV1c93kLXBiD7c6tk3J9WWJ10DhECOWhsQT9xgCF+O9lXAQMuGc/05oI0XpA4n4uJ+mOPbzJkiKpB4CB8rHdRNY/RvFwlwyiXKgCFZD/RTEAsg+bHcqAXvzvsD9lX5XR3cw3W6Qj2CMyr0bYL8CeYaHUdh3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fqcvZNL9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fqcvZNL9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B24AD1F000E9;
	Thu, 20 Aug 2026 18:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787252034;
	bh=/0vlBvhszkq6/OYpzvVoLGf2gMIJLKNt45pqJTloI7E=;
	h=From:To:In-Reply-To:References:Subject:Date;
	b=fqcvZNL9+lKZr6gUI+qIbYY433I42mAzB1HvHDLqRCi8MWXgLOZ8MXJwkV7QMZix0
	 oxdkYiIpPKccNZ8jwWbg+2oDYu6oF0byBs+yC6fMutCwFQKR4c3U1Sqv6eoshyTrQp
	 sW9YhlT8OT1nyKt6L61VwnjpjSjC+P4VqUvGxu44J02Zggy4Ox+/NMd4VjZkHNIMOE
	 0Kl26+VhIDxrK2PWVZNMInqvVd/kPuZqz2pDKYGAYQZM5NOAyQC3fOc+qQjeuMJKaW
	 I3V0yuZxg2caSk25IA1q+FOLcUiRHh8iarXqb3l5mTcK6t6SmU6b222yjp9ZncxWr4
	 thg8YqV02Z7fQ==
From: Mark Brown <broonie@kernel.org>
To: zhuyinbo@loongson.cn, linux-spi@vger.kernel.org, 
 Li Jun <lijun01@kylinos.cn>
In-Reply-To: <20260820092351.101605-1-lijun01@kylinos.cn>
References: <20260820092351.101605-1-lijun01@kylinos.cn>
Subject: Re: [PATCH v3] spi: loongson: pm: add .freeze .poweroff .thaw
 .restore
Message-Id: <178722846543.89147.10945192927320044324.b4-ty@b4>
Date: Thu, 20 Aug 2026 13:21:05 +0100
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
 h=from:subject:message-id; bh=+pX1E2Cobxoo851nb9w4JUZl3NhD5xsNcinFTWR3dkA=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqh00/b4+k24yqIFsuvFL2g9REM+6kqzvn+VbJF
 1oGM7MlxnOJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaodNPwAKCRAk1otyXVSH
 0AYHB/97ZM7C2+4mjhPEqFX4uszP3E0ncts2odx1WiEPWauX3sZUUmYmFdISsi5OMZ2pfQRbka8
 lv/oY2IaRdUX3lJxxBbVQYDjgLjHESBkN87I+H9mSOafFsYHu66tmDN3Ff9Adto9dyl8psqNty0
 +4xMcgJExa3pDmiZUu4eUIbYI7AAoDHfrD//ZGaSmjKcCOH4Jv3lgQ9oikMJU1pK0mwT8w0jrHj
 6O81YQxQkwI46jxMsYItKnxtpFiDDfpw3gHKPHCK1BBLSl4j2ed6Yaka2TNNeSP1YUt9L+mUILF
 R9hwgtFVrck1VepgkJTSeONofO0xy1BN4y4cZVXN4QxPwehJ
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Thu, 20 Aug 2026 17:23:51 +0800, Li Jun wrote:
> spi: loongson: pm: add .freeze .poweroff .thaw .restore

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.3

Thanks!

[1/1] spi: loongson: pm: add .freeze .poweroff .thaw .restore
      https://git.kernel.org/broonie/spi/c/a9c2f0d401fd

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

