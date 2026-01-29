Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C002D94BA;
	Thu, 29 Jan 2026 18:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769710919; cv=none; b=mCr8GtEIMOVQZoE+NKVUqJhyN49LiNCCooe3Q4/eNNMbfbpSqoidgJmaq2zmqgZOdMWFbaDgLCyrwnjWegNRHQb01hh4NpylCcgqONcC67TTUM4S532Z9siTdtZ9q7JuePzgGRsPK+TUTeTbrpMKYE3pYkN4IWZHP2e7tI1ylmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769710919; c=relaxed/simple;
	bh=smmDVtSu0ZWVhA9ZOtKVV4fgkqduoylTndwo/jjLwEY=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=QMZbd34BrWjsVj7AoHmGzstYDFoOHDNa9uAeUWyUHUQMqeXCDIEOKPsxK96ycoy6PELaRJeNxF19991TqIG9jRFcT3rqiokRD8gug4y3KMk70vXM2j9grtvLcZ+KEoSnj1QUWSBain7RC7O7mg9Ltfugxdr1VEeCt1YK8hsYROw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OwYUC7Eo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OwYUC7Eo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0434C19422;
	Thu, 29 Jan 2026 18:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769710918;
	bh=smmDVtSu0ZWVhA9ZOtKVV4fgkqduoylTndwo/jjLwEY=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=OwYUC7EoQlAjO/OcyFMf3OVkAYJae3BZBvzhTdJhLGxFhXa/sH4vuaHDC0MJ9qayK
	 Zll2E94BlJK54k89UnLVZfVn6JnxfQFM1PA6dNaLcWKtQlLIdTInXOsmQFVsi9aIzt
	 S5YPNfPSee4fawQDiScRRQnBIcfpYE7+6SbQnoMq2NU5Xn/x7NQX2OF8GoWwetNtHT
	 HRAC8Aw41iQQeiZvfNpnY83cXaM30EM6J1O2CKB0SLX98tmzQ6PNK7y8261VEkuHsE
	 H0rKB3D2RmkGg3iGzF8Md6r4qA9F5S465eHT0kg0MwmMy46k4eSksrI01tvLbMr0u/
	 nGyOr7uLf78Og==
From: Mark Brown <broonie@kernel.org>
To: =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>, 
 linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
In-Reply-To: <20260127210541.4068379-1-andriy.shevchenko@linux.intel.com>
References: <20260127210541.4068379-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] spi: dw: Remove not-going-to-be-supported code
 for Baikal SoC
Message-Id: <176971091764.126792.4625838654630170843.b4-ty@kernel.org>
Date: Thu, 29 Jan 2026 18:21:57 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-47773

On Tue, 27 Jan 2026 22:05:41 +0100, Andy Shevchenko wrote:
> As noticed in the discussion [1] the Baikal SoC and platforms
> are not going to be finalized, hence remove stale code.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] spi: dw: Remove not-going-to-be-supported code for Baikal SoC
      commit: 5e037759b4b8288d66e791d686b79653a6615115

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

