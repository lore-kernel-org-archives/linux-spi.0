Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF41951EE00;
	Thu, 15 Oct 2026 12:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792067963; cv=none; b=UL96NDNCCovQCpJT2UOvejSqQ0u6ceL2vLP6YMPi+Ihudmz8LUE0ZKUecC2f7nMD7c5j1OP37VfEbJ2MQwBrxdmW+4Ym30s+mR1jJWq+73ROQypcHqye5jp91LP5PsEWnaPrwUVj4oGUnXltbsQWVPgm0ODdMwfNcGiDId5IcD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792067963; c=relaxed/simple;
	bh=GSecCTQAw/WamuIAXPlOndh9fgcTg/WUAYch/pZdmTg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=MGFGcE46yUMFAjC9q0UGoiSp51aaIug6xjHqS1smkMQTozizeh3uQFPz5DCKxfJSPZsloo7Q3C/kVZoapIAse/+0NCvtcif83ekFtI+Z+uB0jwb4vZB+gXlsFgwEbs+si+m5q5q6W3WABuZFK5Qiy4qEiUCiw2PqhBfh43i5zf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eWUN9UHP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eWUN9UHP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE9421F000C6;
	Thu, 15 Oct 2026 12:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792067962;
	bh=XjTiP9/tve+ZXV3Z+ewsGt8qleBnoUGkecKYxUZQ5JQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=eWUN9UHPB/D3hFbX+Jr/7nPGmVa5td9wHiC2L2riWSVQKmwnmm5w5VjNpz4sUCH0j
	 DE6O7RHJ94yZmusE+UKCDwQxIRHOP3AKbuqGDUVs4bViYZQSt0lZmFS4D5MEHWyC0K
	 k7KNfnRX+Tmco91HDMPHVN5FrTjeXLKxgykOjWCXqAHLCxLRdYciEFKepi1Cvshh7n
	 vCJtloLqCXwmH8APHI/dnidUqt8L6iW7wOvzzgGLZIl9T+JXN8s86I0hsRPYURPYgI
	 Ec5ZgH+pAQQ9e71VJ1k2UnN+MjCgtEc2y2rm5LV1nRttZxtzN+3YzU4F47OnJ4T+FE
	 MYNPk9P9VPl0A==
From: Mark Brown <broonie@kernel.org>
To: Aayush Kumar <code@aayushk.dev>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261009133609.579046-1-code@aayushk.dev>
References: <20261009133609.579046-1-code@aayushk.dev>
Subject: Re: [PATCH 0/5] spi: replace strcpy(), sprintf() and
 simple_strtoul() with strscpy(), snprintf() and kstrtoul()
Message-Id: <179192110854.1606900.17753669067928386534.b4-ty@b4>
Date: Tue, 13 Oct 2026 20:51:48 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2071; i=broonie@kernel.org;
 h=from:subject:message-id; bh=GSecCTQAw/WamuIAXPlOndh9fgcTg/WUAYch/pZdmTg=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLIunKyI3GB3/77MlSPx20s/WF6O6im3FqlcviKqWfTxc
 ZY9M51jOkpZGMS4GGTFFFnisrhf1pe8XsN3cGEbzBxWJpAhDFycAjCRDRKMDDds280ZvIzctT3m
 PuHeuT7RtTPhd+iTWymhhxZdeLJnXikjw51zUtKeNZHnve7mO3eZHvj0N1f2il6kTsltyR7B1GN
 OvAA=
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Fri, 09 Oct 2026 19:06:04 +0530, Aayush Kumar wrote:
> spi: replace strcpy(), sprintf() and simple_strtoul() with strscpy(), snprintf() and kstrtoul()
> 
> Replace strcpy(), sprintf() and simple_strtoul() with their safer
> modern equivalents (strscpy, snprintf, kstrtoul).
> 
> Aayush Kumar (5):
>   spi: butterfly: Use strscpy() instead of strcpy()
>   spi: lm70llp: Use strscpy() instead of strcpy()
>   spi: tle62x0: Use kstrtoul() instead of simple_strtoul()
>   spi: omap2-mcspi: Use snprintf() instead of sprintf()
>   spi: s3c64xx: Use snprintf() instead of sprintf()
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.4

Thanks!

[1/5] spi: butterfly: Use strscpy() instead of strcpy()
      https://git.kernel.org/broonie/spi/c/e9b641d92963
[2/5] spi: lm70llp: Use strscpy() instead of strcpy()
      https://git.kernel.org/broonie/spi/c/ae6056b248eb
[3/5] spi: tle62x0: Use kstrtoul() instead of simple_strtoul()
      https://git.kernel.org/broonie/spi/c/9a6b86cee9d7
[4/5] spi: omap2-mcspi: Use snprintf() instead of sprintf()
      https://git.kernel.org/broonie/spi/c/50f3d77e805f
[5/5] spi: s3c64xx: Use snprintf() instead of sprintf()
      https://git.kernel.org/broonie/spi/c/65f9474caced

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

