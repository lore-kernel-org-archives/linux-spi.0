Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39714908D6;
	Mon,  5 Oct 2026 14:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791209812; cv=none; b=kwEZfjKsBAwd27hhLWXEWRa9ytZv3M00YTofmJOdlH2gztGI317YeEXqChITY8X6RlGwYYBnJHitRwJ4/E2Nvb649Ls25IWT1dVTeYrb15JfiAodecqIAO176FRXJ0cmg3C7TkEEZxN0pPtEaK07Z/NbxlAAvvFQcJ6lFXUVDHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791209812; c=relaxed/simple;
	bh=YMlyO+FGsc98ivn//gYAlUzTb7ACnvHX3iXMPlD64xs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=uXlUwoM4Ss1rTBXCSLEMB7aEzIaYS+XdPBIiOfZO+DA4L7NODwbUitEOCYdDjdZw8OHgFASCEsknbFsskB++zJxped/FmVHVYs7gTqZg1MQ8/0vnZ3/wxC7jkyccvpYgYcXu6wC9gtmA/McHpPjDtrlnuDpUvhj1qfVWzhEjjdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b+SPIA6W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b+SPIA6W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9315F1F00898;
	Mon,  5 Oct 2026 14:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791209798;
	bh=P231LzLHRsovrDWYQ1BWbGQxh67jwuD/VRp6cvIOiDM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=b+SPIA6WzImy5h8M98ZNdOxaCsqKPFXZmoT9J+FrkkdGzFuwvR5zrxj8v1anMxBpb
	 q2Gd4mYRJi0OZjWN8y3hA9R+7ychCqgBXO5DYZIql/yTZyYksNSldaggyv0kkJjoiz
	 gDkqQPdtJQR13JBSpOzTzexvBn/bIuva4P1npsUbSN7lStPVsnzvGPRPuZJy2GWjHq
	 IC5EjydGBqQUijP9nz7/Zy/QCWlOBkkkvLpkYFkd6m0X6LoL/r43X5/kFpCIum9PEJ
	 tn1+J2+z0hMJzcbtaU1jRbDitL9MN6cCCXuzBbbbUTh/BYQGsGGuYcycNNIrOuOw6V
	 g13be7dJgz6ZA==
From: Mark Brown <broonie@kernel.org>
To: Han Xu <han.xu@nxp.com>, Yogesh Gaur <yogeshgaur.83@gmail.com>, 
 Frank Li <Frank.Li@nxp.com>, haibo.chen@oss.nxp.com
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org, michael@walle.cc, 
 Haibo Chen <haibo.chen@nxp.com>
In-Reply-To: <20260928-fspi-fix-v1-1-a0f9288cd5c8@nxp.com>
References: <20260928-fspi-fix-v1-1-a0f9288cd5c8@nxp.com>
Subject: Re: [PATCH] spi: spi-nxp-fspi: exit stop mode before waiting for
 DLL lock
Message-Id: <179114538488.150114.10083607818738667634.b4-ty@b4>
Date: Sun, 04 Oct 2026 22:23:04 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1146; i=broonie@kernel.org;
 h=from:subject:message-id; bh=YMlyO+FGsc98ivn//gYAlUzTb7ACnvHX3iXMPlD64xs=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqw7FAdvl/qTcKbEtWX57y7xkColqMjmCV+QFDu
 cNpHm7iTbKJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCasOxQAAKCRAk1otyXVSH
 0DukCACGQvRKMYI+3N2fCIibKLVH5EPNmY5dMcQxRD4P1KIsc08hv0aV1a/UoDrTHkFThkCG2GU
 k0rvxtBJPBMMs/wni5dHvCRnvFUc2s2FWWoARkZiVEV/rjHHp9DKhxagJ65TSZ1IxLdpAMRTmQL
 jVLsdrdVo79Sx+EbVysAqgX9YlNW5/hFP/VfB/6AumL1IeMf3dVyBkESBGqfdplg4dF4YxO1QRN
 ix3qYzIdTlJVZdHtTAAQzXCKWOcMT3Y2iAdhjr5i4gAnftPxnoR7NSjGT2LZMq1ZnAeomaQ4T6X
 Glm8OtABowmaYw/slPtQ+TcbQMK/etK6gbKwIww/dUwdZAbJ
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Mon, 28 Sep 2026 19:53:11 +0800, haibo.chen@oss.nxp.com wrote:
> spi: spi-nxp-fspi: exit stop mode before waiting for DLL lock

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.3

Thanks!

[1/1] spi: spi-nxp-fspi: exit stop mode before waiting for DLL lock
      https://git.kernel.org/broonie/spi/c/94b6df050433

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

