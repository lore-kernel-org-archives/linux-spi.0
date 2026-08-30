Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3E637F8BA;
	Tue,  1 Sep 2026 21:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788296934; cv=none; b=tanQ0QaLeK0ZObbz35JtNtBjFjPbVGZv2Wx2rBgyoLyTIEjZbA4GiIrtp4megs7Nq4W3jwPmUv7VPtDe6cRCGVP/kw/Uzhyv3sFqa9l5tE3385109qEJ5Wcf82O5yHMTDefw+N8pEHmnCKzlshDmb4ZOMOo1CzMgXVmko0N8X7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788296934; c=relaxed/simple;
	bh=mmYt39LnvCNEcwATxeLYyW0mch6/WCobWSTwzhik6G8=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=vAoUjp9ISUzF/5QnUrOTQP9EcTNZHOsqPwvv5YdaE1ccjhr2FbtDHDGFkorBmEPRlV0lmz2z5WEKwqTIJEm+oECavhcHFXZbO88iZfR6SLTgEqocJLmnUFnXKFKny4gPxWcLHKJVnmTunduEkq1Ho0FwoxhF1Tb5IgpfTuhBcpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h6g1V6dC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h6g1V6dC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49D791F000E9;
	Tue,  1 Sep 2026 21:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788296932;
	bh=QPncs8blFpXiOAlFtz/zklCEij/uJJhr0vvVB+kLjAQ=;
	h=From:To:In-Reply-To:References:Subject:Date;
	b=h6g1V6dCq9bzAYbiU8tz9YShtRcfYd6lHTLs6z5xbAzt6PRDbSe5jHhNG6p60Y+42
	 WSZAWSWYRs0DdLo1zQ34Pxk+dlPkqLmUy2cTgZUWEPOZTe/M+0DZqkOnIPNYzrygjA
	 2fAIHkI737+y3FLI/RM4pyIAWcfNFzOO9W9VkEEzgjcnRzz2rcx8FCCsCk50J+ZLyA
	 odD2aXvVZQ833ApRBYTbUzR681rVzx5DpyfZBu2DoWqYrGmVRAnAWZpfQPyorZ8Vzc
	 DZKWsx4LarR7YDbRfKwlv9gebUxuwW3vW5k1SZre59v1jqnN+q5NbtrGD02jfUpmVt
	 u+6zdAI6q6yLA==
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
In-Reply-To: <20260821105541.1432348-1-andriy.shevchenko@linux.intel.com>
References: <20260821105541.1432348-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 0/3] spi: Kconfig cleanups
Message-Id: <178813044759.13461.8252493848794533489.b4-ty@b4>
Date: Sun, 30 Aug 2026 23:54:07 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1589; i=broonie@kernel.org;
 h=from:subject:message-id; bh=mmYt39LnvCNEcwATxeLYyW0mch6/WCobWSTwzhik6G8=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqlz7hFk9NQ6kVH2ghoHhnU/hH+TcgYksq/I7wE
 RjZG4rop4eJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCapc+4QAKCRAk1otyXVSH
 0DidB/0aebhbL5gwotamrtaSPj/Js0HvMAsGJ0XanHCkuYnnloc9T1IPQjMhbKPzGvadqi45Sj0
 UvDX5JEk2TU4Kdm8aTnK85I8BYJ1Nv6p1xROn6h7JMgi/TsMxyJDu8vm+xMhuB5fwX+0qYbu+gg
 omRZgYHWhlKCnPfLp+dU5FtJ6fUtxrURoSmcFYJLhB40OBDOMvR3/qQ8EE7N0E3CdnUSoRzLQ+J
 No2k0aztK3MD3R+fairIC95vQ6Z7+zJXFlylx3LVNU56aWqC9/tBkh1s5V0bjCNqONsEHMbUVTQ
 tAqEip4hdI0jMNG1vlAoKD57fPfo4bGP+rlb7zQBbJedAhrH
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Fri, 21 Aug 2026 12:54:51 +0200, Andy Shevchenko wrote:
> spi: Kconfig cleanups
> 
> With time the section order is diverged, put it back into order.
> 
> Andy Shevchenko (3):
>   spi: Fix tab and space mixture in Kconfig
>   spi: Drop redundant dependency on SPI_MASTER
>   spi: Fix the section ordering in accordance with the comment
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.4

Thanks!

[1/3] spi: Fix tab and space mixture in Kconfig
      https://git.kernel.org/broonie/spi/c/dd007297551f
[2/3] spi: Drop redundant dependency on SPI_MASTER
      https://git.kernel.org/broonie/spi/c/4895d7068723
[3/3] spi: Fix the section ordering in accordance with the comment
      https://git.kernel.org/broonie/spi/c/d696b9109d23

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

