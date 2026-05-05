Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C21F41325F;
	Tue,  5 May 2026 12:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777982826; cv=none; b=kT8GcRM3Jlo137gD5FznP5PKQgYkr9JjCFkPCZXbJA7ovT4mbzkv7lbL0UiHCFGgQqoTAj+Wq8Lob5iRMAnsILcRPNtZ0Uz9OuGyoOFxJjA8JCsRg6BCoobz/bh+YobUo/0Mh57iZLx4QSSRIEODsngDjfb90mP1pwriiyu4e8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777982826; c=relaxed/simple;
	bh=LBeJdDOIeVcNo9/1gFMW+zo6furMlQMsqazpANONYxw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=D3l4gSQC+HwGplNln4IBIXpEDakfwCi30vBf4d5BCCNtINkRVTLNnwMYoQWo/8uyuqZyPCJcrkvEGdiNv6c+Qt/ccF1P/xq6VXidWD0QCHD2U/IcYem1VH9J29DKEgkb2gBOnWcJYsfGFTeQ5zaq5QkeIVs3m4C3nVTnJVsUBwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IU57skwK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IU57skwK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E6B6C2BCC9;
	Tue,  5 May 2026 12:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777982826;
	bh=LBeJdDOIeVcNo9/1gFMW+zo6furMlQMsqazpANONYxw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=IU57skwKmg7nl3b1v4w/Dor2TLdDUcK8eiTpy+uk67GvhPFCGF1UVUUfnapB6OQ/A
	 uqJ/Dt1wwaNBv6C2bIbG0MyzHwFJP/N1PF7JtHZ+9xbgvcrmdZzX58q7BD3+hP6/q6
	 s4GYe7nOubenY+Nv55CP1fE7wvHIQaypVjrnoujJyNEzyZpzpef1xCPDNoRI20uigf
	 QMbs6LwqYGBT9086VWWyE47jkE6UNM+ebbAQBO9UrUE1sGlDxs8Iyv2ZBSv6CFlhMw
	 50BblpejeoFk5YkAYwxwgr2APpJ135JtlqyEfWP+zAuCy8+fFbQzKta/td2OZ0tQ7w
	 7r63IcIzZNwjg==
From: Mark Brown <broonie@kernel.org>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: Markus Schneider-Pargmann <msp@baylibre.com>, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260504142117.2116978-2-u.kleine-koenig@baylibre.com>
References: <20260504142117.2116978-2-u.kleine-koenig@baylibre.com>
Subject: Re: [PATCH] spi: Consistently define pci_device_ids using named
 initializers
Message-Id: <177794357553.568329.537517574530201355.b4-ty@b4>
Date: Tue, 05 May 2026 10:12:55 +0900
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1165; i=broonie@kernel.org;
 h=from:subject:message-id; bh=LBeJdDOIeVcNo9/1gFMW+zo6furMlQMsqazpANONYxw=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBp+d1oatPzd7U5KqbiAAtVkIqoGhF5ewkkClXb9
 NVroWmXVCuJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCafndaAAKCRAk1otyXVSH
 0LeFB/4k4JLvq44sw9b5ehiqklOLT762YZrjV+fnNQoMzz8wkN5Qjm8Czon2R4gyQsijijmIsTf
 ufJYs5DR6DCWcrM3k399jL4Wa5bEqNc1hr0wR5rF1lNj3LW2niPV/SxSvunVt1Gk+5xEIwXLUL0
 jaiVsn7DE2CkO/KnGR/xWIMgf2cTCAvzO/vmIJ3TPTFM+Z2JmLqkVvB8l0vwtsYB3XtWwwJNdq7
 E+CSSssJXuvGB++iIIwa8uTDNK95o9LMsu66IWVvf3SgUkFoFWttkk2HbYvvhi9LWkrV4Ms7s5A
 Vhv+p0KodIqz2yYrzUuoiUu+2vrT9RAr9LUuw3I8n6Dy2hUR
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Mon, 04 May 2026 16:21:17 +0200, Uwe Kleine-König (The Capable Hub) wrote:
> spi: Consistently define pci_device_ids using named initializers

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.2

Thanks!

[1/1] spi: Consistently define pci_device_ids using named initializers
      https://git.kernel.org/broonie/spi/c/e4358093816d

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

