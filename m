Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5CA4EA394;
	Mon, 28 Sep 2026 22:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790634056; cv=none; b=okVtRBr4dq0lQpR8eXVQV4ytI5/kZfopM9V7tgbV3b1yIkvqEopnC8SoYmJpa8pjxB+f4/ZgUthPru8DXtuiKPw6FJUl8p+CfzZV/mSp8J47q6D7VVwwEUSpUvMDjSMOVEdcEUZbCPc+SuJviFnGdArtM/Of9BGEZ7wZIP4OujA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790634056; c=relaxed/simple;
	bh=qwBr7qgSJBxQrETVz9hLv/sVivxe5PJTogswBRC8VAk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=jsJBULq9npVXoTWH1s3cniKcEvplmS6sGTjeQlxLlj+LyPdJBeHzD6TW2cWrw8AOAQYjjw4vhRrlhXNKyzQOE/GwdG3I0rA7cxgJVW5OURhPHXDF8W21f+DpKwh3BknsuDmgblvuc9L0SJJM6RVMyFIMUJHHKoa4M6JijDyfbFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Le0Dg79A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Le0Dg79A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45D271F000FF;
	Mon, 28 Sep 2026 22:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790634055;
	bh=iAW8bFnmrbYnYZAGQIQheLoNYokDW2v2w9HKGIy8zIM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=Le0Dg79AisqVrKTNVFdviQGsIWw+LUYvKYTe6vAEc7OzEQ/jxWXvw11wEDWe+gjT+
	 EuYspMkUUFp22n5Cncjm/za90ej7M27wVZjas7w4Te5fDJrv9u5nBGZQvf+ZGo9f4X
	 5kuDoeA7APn7CbjJAsKVV39HjCdngU6ZFH7HuHhcyVZiDg2cNKsxwjf+8ATgfEc4Yl
	 8Qq2kkewsV18cQKiViLylWupwCtx9P3yK3dnMPE7rGSy5WaTT471HlSHDdOqvlvvOm
	 Zlw4ubfjMTYFk6Qz8c4P3ZRbzhSo9vg4pNMI0NFlu3PU5FZRlrwzg4jgDzhWarsvLA
	 pVRyVn96VspDA==
From: Mark Brown <broonie@kernel.org>
To: Md Sadre Alam <md.alam@oss.qualcomm.com>, 
 Sricharan Ramabadhran <quic_srichara@quicinc.com>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>, 
 Gabor Juhos <j4g8y7@gmail.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260922-qpic-snand-fix-cw_read-readloc-v1-1-67f6819fb3d7@gmail.com>
References: <20260922-qpic-snand-fix-cw_read-readloc-v1-1-67f6819fb3d7@gmail.com>
Subject: Re: [PATCH] spi: spi-qpic-snand: fix read location register usage
 in qcom_spi_config_cw_read()
Message-Id: <179062026368.139547.15603330259275906747.b4-ty@b4>
Date: Mon, 28 Sep 2026 19:31:03 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1177; i=broonie@kernel.org;
 h=from:subject:message-id; bh=qwBr7qgSJBxQrETVz9hLv/sVivxe5PJTogswBRC8VAk=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBquuhDlJXqXyZmKre7LhW5vLhmw82FMIFEVK2v+
 IkOx2gSFkuJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCarroQwAKCRAk1otyXVSH
 0FyrB/43ZGiwKsWP62iiEfUdkmCCHXjRncQA+Cn+VbxYBUMZUs2teiaFd5ogQApsQiUGlS/jlLO
 f9JcyMgLn+knOPhIlcDaFyjfa9GOmp2sbkKDQAzxGXDcsJZ2UYQCJowhzhs4GZF4WJ6jqY3XbNQ
 PV/L1mW4PGDl6w+8gdObU1qTcDq6+xN9IdR/h/R6R9Ovt5Zb5fFQoFEtyr1J1p6pSbpG8gpkkgQ
 RZeufxdSprOG73JrmjLwzB2G9dNuY9j/yv6c7hn9ivmT8g9+hXx9TN6UrtR3420qUvx5drn1XLy
 USZBh1F7jX6x29OGaYZp6I+ubKE8CoS3b0lsoa4SgIq7FNCs
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Tue, 22 Sep 2026 19:50:57 +0200, Gabor Juhos wrote:
> spi: spi-qpic-snand: fix read location register usage in qcom_spi_config_cw_read()

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.4

Thanks!

[1/1] spi: spi-qpic-snand: fix read location register usage in qcom_spi_config_cw_read()
      https://git.kernel.org/broonie/spi/c/f3c0a2b557ea

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

