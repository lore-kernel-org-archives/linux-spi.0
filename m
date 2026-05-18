Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49686279DCC;
	Mon, 18 May 2026 16:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779121436; cv=none; b=aO+gypuh+jsztoAyiTNFdmwBSqn34/k76QgQXwqDOnDDRIY2TIpyYtK3Mu9M6uf1py0PPPtJo3nMD+y5k3T0+8/grtLrZ0f4ctdeQZ50mUkgJemsEp9hj0vkjfTX8naGeU3I1LB1egptvmtGe84eE+CZtZaoRY3yKPG1hXdkBSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779121436; c=relaxed/simple;
	bh=nIUdl308YnxITOK9mbUXgk/E2m98z5fraZt03zOERrg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=eeIJt2c8F+Dpq9QHyImUFSUk09R+P37i/x6xm2P+b96diu2Xzk6ObkjE4c6vIMYHyvLljg/Dvji9Lzkj48LquhlOOPyP0bXM6x8sB1hb1WXgRtc6ASssNIvBC12LZoWmzpwt7/6welz/QafJeGVIEAxHPgE6wSIwc19yKbxZz2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ug3aJgZJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ug3aJgZJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9A14C2BCB7;
	Mon, 18 May 2026 16:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779121436;
	bh=nIUdl308YnxITOK9mbUXgk/E2m98z5fraZt03zOERrg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ug3aJgZJUq1uQNhFs8k2RXGx39cXmn5WbF8GH2eACzCUVFbf3+xhoZqUTyPmPMVbH
	 cC5bhuWedbMrNjgZti4oAUVK5yHDGXO4ggWc/hJIKCFrsOi11LLxBrLQi02gZb/+gy
	 PoPG+9Uyj6wszlesI8soKS7RMKcullvDu3EsuqWRiEOeaaTSlXyfUzyndprv9zhgDK
	 KPouTMAPK0n1yLvIpL9lThBIhCIunAXoL1PZ9YU7ErDC85bX4bvO83t9sUYMYy0cmZ
	 I4tSTwuVva6nX9jOardCyHmtwiHaLKAxSAosPZBSROyqItAAIsCH4E5tVVfl3EL6zm
	 iI/WARe3rhiCg==
From: Mark Brown <broonie@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: Eddie James <eajames@linux.ibm.com>, Yang Shen <shenyang39@huawei.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260511150408.796155-1-johan@kernel.org>
References: <20260511150408.796155-1-johan@kernel.org>
Subject: Re: [PATCH 00/12] spi: switch to managed controller allocation
 (part 3/3)
Message-Id: <177909669876.31945.4167470997602764767.b4-ty@b4>
Date: Mon, 18 May 2026 10:31:38 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2721; i=broonie@kernel.org;
 h=from:subject:message-id; bh=nIUdl308YnxITOK9mbUXgk/E2m98z5fraZt03zOERrg=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqCz0ZrDSHm9Y9jw7CM7U2tnofNLof4/+pa9JmK
 of8FQgt4fCJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCags9GQAKCRAk1otyXVSH
 0J5RB/wO40FRwrMfPSDlCyeJoM48EAxJmLu+2vjJCfjAvDN622zXznF8mKYKwRlhzT00gy31f9p
 yf13QKeBry8ASLv0X1WNiBRdWNfzsHHyWU5Sw8DRcH/B/Y7ND+gr9+iRYKyhMNnEFD58CfCrcZ+
 MdWoyokfAcJQdyFtmQcYMxz6GdKwY3CceYxx1+Y59zIMbsVOgosi6OAGR3a70oLaqMOeEyLg+mp
 +SUauR2zDghjNnsyNoSBSz/2poRE1qWbprb06ZHjLVLHPymTEDlkCQvqyvT5ocSWOuzVOrSLEJA
 12JEvqWP4KDnENDflvPUV9r8elnpOlIJ95q5hfBs808NgJ7j
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Mon, 11 May 2026 17:03:56 +0200, Johan Hovold wrote:
> spi: switch to managed controller allocation (part 3/3)
> 
> In preparation for fixing the SPI controller API so that it no longer
> drops a reference when deregistering (non-managed) controllers (cf.
> [1]), this series converts drivers using managed registration to also
> use managed allocation.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.2

Thanks!

[01/12] spi: altera-platform: switch to managed controller allocation
        https://git.kernel.org/broonie/spi/c/a7a24f0eaa71
[02/12] spi: armada-3700: switch to managed controller allocation
        https://git.kernel.org/broonie/spi/c/5b4a0450fe2f
[03/12] spi: clps711x: switch to managed controller allocation
        https://git.kernel.org/broonie/spi/c/ee9575d2b3db
[04/12] spi: falcon: switch to managed controller allocation
        https://git.kernel.org/broonie/spi/c/864c368199cf
[05/12] spi: fsi: switch to managed controller allocation
        https://git.kernel.org/broonie/spi/c/c087eb4603d9
[06/12] spi: hisi-sfc-v3xx: switch to managed controller allocation
        https://git.kernel.org/broonie/spi/c/572a9fb1a609
[07/12] spi: jcore: switch to managed controller allocation
        https://git.kernel.org/broonie/spi/c/0a290bb1ff0b
[08/12] spi: lp8841-rtc: switch to managed controller allocation
        https://git.kernel.org/broonie/spi/c/06ba67d9d479
[09/12] spi: lp8841-rtc: drop unused ifdef
        https://git.kernel.org/broonie/spi/c/4fee1d3a563d
[10/12] spi: meson-spifc: switch to managed controller allocation
        https://git.kernel.org/broonie/spi/c/1e447a5aa124
[11/12] spi: mux: switch to managed controller allocation
        https://git.kernel.org/broonie/spi/c/60db555fca74
[12/12] spi: xlp: switch to managed controller allocation
        https://git.kernel.org/broonie/spi/c/f3d1dc0bc65a

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

