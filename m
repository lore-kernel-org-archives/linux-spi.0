Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5723D1714
	for <linux-spi@vger.kernel.org>; Wed, 11 Mar 2026 10:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773226071; cv=none; b=EM/tIIToos3pn2aU0REEpqwOVWO7QYJsomA1P85Atwkr47WwwSMM/vDSXVPZyXVgKiNDvyQNRthMASV2mE3+ALa2ZTEFurCbVJffLUkp3Ham7XnN/DBcSiaKeihOPrfYASwsfVHzEBsLWaIXbH3KDZDvO1crPq4Y+YFcQhKVXPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773226071; c=relaxed/simple;
	bh=Tt/gzW5Q9wooSfIbzLNJn7PmJO8jsAkPI/aIt3efRgc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Pe3/KRC2yifWf9RP36T03igeoEAV1kxi0szxtRDZmDZ+AptqZeDNDUb2ptqcQ58tc8mO3nSN9pEKhDJvrfxxLuLu9WZRZxn3wvzZaSEGQF4WELv/+5eFp+TJwy+PkDMS9KtZTxpiYvIBpNTTxrvIqrQwaPKjtt3bgiIvH19XQAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oy783K79; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oy783K79"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28673C4CEF7;
	Wed, 11 Mar 2026 10:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773226071;
	bh=Tt/gzW5Q9wooSfIbzLNJn7PmJO8jsAkPI/aIt3efRgc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=oy783K79iDUZVHi8p3FF53HkzICdFDVy5bsBaz07WvvVXO2y6nUrH2rk151e41Qhc
	 6sSa0spLPM8Cf260Z1G4wKE/w6pSbw+wo1W8YFHnjwldM5eORXAW8Ut5MY2SI4jpHo
	 zliGILm4PWJBv11gd0InI38ArqCdIcINvWegHXbOXdREEImNt00wyA1hDAWUYOg7cP
	 Y8ox7pPgwc9K0eAChjkaC4Prjqw2wPndWK20S4JkZ7XlA5yOUuC7zldXjD5DkPwBf9
	 KeVCZw8GQEPlFLTWahGlamUrpRIJTzBasUkztsrykT6FjMv65Ms5N2llnH6RDWMQlH
	 y6ogokKnH3PsA==
From: Mark Brown <broonie@kernel.org>
To: Alan Borzeszkowski <alan.borzeszkowski@linux.intel.com>
Cc: linux-spi@vger.kernel.org, mika.westerberg@linux.intel.com
In-Reply-To: <20260309153703.74282-1-alan.borzeszkowski@linux.intel.com>
References: <20260309153703.74282-1-alan.borzeszkowski@linux.intel.com>
Subject: Re: [PATCH] spi: intel-pci: Add support for Nova Lake mobile SPI
 flash
Message-Id: <177322607090.10718.7153559066230282123.b4-ty@kernel.org>
Date: Wed, 11 Mar 2026 10:47:50 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-68380

On Mon, 09 Mar 2026 16:37:03 +0100, Alan Borzeszkowski wrote:
> Add Intel Nova Lake PCD-H SPI serial flash PCI ID to the list of
> supported devices.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: intel-pci: Add support for Nova Lake mobile SPI flash
      commit: 85b731ad4bbf6eb3fedf267ab00be3596f148432

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

