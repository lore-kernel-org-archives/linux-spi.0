Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9E2299A90;
	Mon, 16 Mar 2026 01:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773625099; cv=none; b=fk+xtWzmYwApTyffR3S9deIYniX5bclb9AkSjjnQepbUD/vGGtRexNcDhX7YwrWlebOauSF1xRvJv2X+X84hjny/xkn6ZbojAHeLEhnc/DQHEE21eqZ3lbSdNmuK1UP+jUCDQER28A+sbGCAF9+2YNIO/s+41y2r3EwszhPENTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773625099; c=relaxed/simple;
	bh=ESNF40KoNoWSjpvWZpNCqLbrkWb/WsgA17BJHw+YV/4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=fsGpwJunjTevSSXQj+x2jSxdNuw7MsH/WFRVj3JB9J10KlsRhTtDckLZYRlCiWDYAxg8vY83B32QkYqmm8cYKAiscTVdZbNA00aPG0QgrpIJEMSHDUfqX5Cm+alTJ2Sn5W8WielBoCuZzs454mp7ZPJwyygODkHwtv5covzvdYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RAXedXBm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RAXedXBm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7220C19425;
	Mon, 16 Mar 2026 01:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773625099;
	bh=ESNF40KoNoWSjpvWZpNCqLbrkWb/WsgA17BJHw+YV/4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=RAXedXBmClcpvNdl5F90co+yMH+sLTUWdZWIx0Vf0iIAD2i7QFd4NLrm1DdJAZOfO
	 fne4mSOeuH/JIY2prc3urG3A2N35vz5EvOCJmEjMGvi2jGN+251UD5Qy0Nu/1uMGI3
	 Ia5ik3usOGEnvpgAQsB5c6qu41rMhFnz3Gaz4663ig7riDVopRD8BhvLw/W8VpCLLc
	 CixWq5GxFoudQCs+iVPif03Les5NiObK0+sc8M6jubTlF+n63zymBmVZqC+QD2zAYO
	 civE/9D/hHLe9Sm6rszkJeuvqiEI+2CXqucjsGBAREM8H/BvdK7GYYjYOSXL10PWFQ
	 LJ2O91hFPchOQ==
From: Mark Brown <broonie@kernel.org>
To: Liang Yang <liang.yang@amlogic.com>, Feng Chen <feng.chen@amlogic.com>, 
 Xianwei Zhao <xianwei.zhao@amlogic.com>, Felix Gu <ustc.gu@gmail.com>
Cc: linux-amlogic@lists.infradead.org, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260308-spifc-a4-1-v1-1-77e286c26832@gmail.com>
References: <20260308-spifc-a4-1-v1-1-77e286c26832@gmail.com>
Subject: Re: [PATCH] spi: amlogic: spifc-a4: Remove redundant clock cleanup
Message-Id: <177362386770.208027.17731827267836968110.b4-ty@kernel.org>
Date: Mon, 16 Mar 2026 01:17:47 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-5154a
X-Developer-Signature: v=1; a=openpgp-sha256; l=1118; i=broonie@kernel.org;
 h=from:subject:message-id; bh=ESNF40KoNoWSjpvWZpNCqLbrkWb/WsgA17BJHw+YV/4=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBpt18IjHcXjzKooaL0t2Sy0QWIpV+vpwmgY+t0W
 qE9UDQ+4KyJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCabdfCAAKCRAk1otyXVSH
 0P+EB/908b4EwSZA70lzcRpGpQ0wvqMxuC6eiG+4KDOupMf7m81SUOIxI4RU+ISHzmbS29Ta62Y
 47Dtr3WknaBbXqnoM91AUlW5ZLoCSIaItECiAFk2Gz81WbiFY1vZs70kW9qm2HhMPVwgXPlc1ko
 dur0fRQiCs+VYUL4+Zv7zMRH/ydU/aSEX1zJz4oMtpK+lC/oEVU4MepV9geztQ1DK8ZXSgy6yG0
 YhAtIuIOdpShRPponGmSo8LKq8YzO60SYN7NBFVkNqJiCGVyXSIg3pLq3S630MwkbmWygsC6T5X
 B8D8w+QpZtS+KgNF8wBS3vnDQn9xlTimOlhKGIsCPyK0oS0q
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Sun, 08 Mar 2026 21:34:55 +0800, Felix Gu wrote:
> spi: amlogic: spifc-a4: Remove redundant clock cleanup

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.0

Thanks!

[1/1] spi: amlogic: spifc-a4: Remove redundant clock cleanup
      https://git.kernel.org/broonie/spi/c/a00da54d06f4

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

