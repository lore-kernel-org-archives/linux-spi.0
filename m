Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B450D4248A5;
	Tue, 11 Aug 2026 22:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786486815; cv=none; b=LBodIwMTqlpdbr7SdOEJHnrAaHxgeorFBQcDv+eDGyCQbGsZqvgRspIlxfxxhx0FdELdKghYuc2qr2hMRYmGvEo6bIRLcErJf93zMa3frtHl9WXUC/qEk8kHOH3IStAaxE55b4o68/Ey636dZD/vNX6Mdgis4eHxvmunDeKre5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786486815; c=relaxed/simple;
	bh=zsuJPKQQoZ9WUZlLumAK8jhQU0lCOfBtI5jhGxhI0i4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=B4YZ1v6YAAtoFO+yUhZUKXaoWNa2uZ3KRcDbbSwFJZgQ5nWfp+IYexYmR9etu9Ix4C8RLfpDCKArgrixi9IxyCh3LzBkEcYCC8E0zzdtw1sb+YRWrWe0HGY5xBqFspzRq/hyLNKWuV4/pjCdrxoAXnRu4h/MV5Y6GORuxCWTnlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l1sl58P6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l1sl58P6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DF011F000E9;
	Tue, 11 Aug 2026 22:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786486814;
	bh=EGyQcmQ3lzLMKxDWNjsFrElf3eMPppwiSH7C2+HBmx8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=l1sl58P66dogw6JIzjtWvI/VyP52ZTa2uXOKXVX2nK26s4viPY8loVCvMdqhsREch
	 f+uTj90zj+Fprs/OhM09szC5VZBORWNwpqCHBrleRKzCfk/rihquuesahFkZZ8paXx
	 bMGFnKvGVOmB7oNyeSYi0vyhGnnGJ9VVxOHEU6qwFgdq1d6iYO0QbdTcAL75y4av7R
	 lrsMI5K6LTD1vbK03PFtFVrjx0GHtJf9epDFwkRAArXJPeIXC1qAFRsWNPsauf6vWU
	 eoB6lcF9N6MHKrwTAduMO2hvArNISitkAhBdKFI2CMVoktriD+nN+167mIeJtg+FdC
	 QPfxnYzYCZPdA==
From: Mark Brown <broonie@kernel.org>
To: Md Sadre Alam <md.alam@oss.qualcomm.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, Md Sadre Alam <mdalam@qti.qualcomm.com>
In-Reply-To: <20260807-quad-v2-0-8ec821e2f22b@oss.qualcomm.com>
References: <20260807-quad-v2-0-8ec821e2f22b@oss.qualcomm.com>
Subject: Re: [PATCH v2 0/3] Add quad mode support for QPIC SNAND
Message-Id: <178648290697.390283.3049277534434118401.b4-ty@b4>
Date: Tue, 11 Aug 2026 22:15:06 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1637; i=broonie@kernel.org;
 h=from:subject:message-id; bh=zsuJPKQQoZ9WUZlLumAK8jhQU0lCOfBtI5jhGxhI0i4=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqe6Ac3v+u3wrloZpnMWgBeF5c6pIYSe3/dEWIC
 MI9A7RsxDaJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCanugHAAKCRAk1otyXVSH
 0BSnB/92CCN4p38O2haUViPn14P6qI9Q9dYOYaU+cSCGi2QjD/IGMmxsWelezH5FOwPHNs9LVEn
 krpwRkgOyBH+H9aQ32JEXuAW9bGFNzS1pKc7m5/BtiobQxTSELcTiI+gZOldvD25M3hC4X+4VV3
 u7VWpmC6egTGGdJbG9VDaG44HoE8JIaYpZ8+0Gkfr55fqmyon27XzGJ/I3G8nZJNH4+AXJHcVHG
 lqJsiCsPi3AVnK1NH2hHbhRxCbMN2jQWXTdR9mW4MoXruF0boUjjnUnhjjPiUkEoZsw3/jyyL9u
 ibiOcTMklsxswyn03x6IqudFZrAyciUkd+Nu9obXeEdS0xAM
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Fri, 07 Aug 2026 21:33:54 +0530, Md Sadre Alam wrote:
> Add quad mode support for QPIC SNAND
> 
> The Qualcomm QPIC SPI-NAND controller supports both single (x1) and
> quad (x4) transfer modes, however the current driver operates only in
> single-bit mode. This series adds support for quad data transfers and
> includes a vendor-specific fix required for Macronix SPI-NAND devices.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.3

Thanks!

[1/3] spi: spi-qpic-snand: move command mapping helper
      https://git.kernel.org/broonie/spi/c/0d51ff742b41
[2/3] spi: spi-qpic-snand: add quad mode support
      https://git.kernel.org/broonie/spi/c/cdb1dbba4902
[3/3] spi: spi-qpic-snand: Handle Macronix quad read opcode 0x6b
      https://git.kernel.org/broonie/spi/c/7e3ffa9f46b7

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

