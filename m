Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C87141D4EA;
	Fri,  7 Aug 2026 11:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786101866; cv=none; b=jxxYOwuHLZ1RB/pUWvwFp8NrV8/qF/UAfxD08O22sGiawF2y8TkaaAWt6kLP+ZWCxI4VRt+CI2fNe2eomOvyDEEfO2AF+paOwBWp1PuMX3bSj9wdQtzqidCjyihEHHp5nlQpqsAL4KAsUHJF28eXU4UpBAZtTnNQfPn+2ksWt40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786101866; c=relaxed/simple;
	bh=BLpAfIgdKE2g2TXD0nYMJQzdWT+koZWc69P9ILVrv8A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=P1EIx9HwGBqLiqvtDtW9enxNGm0oyDBV/skyUPLfCvJ8h/iPJ6GQDhIuzaM+0XRt6zvzsvWTRXobAdApJHezrWBxHk/RIdVmHJlW/fSZxPqeZ7hqcKBsvwyldQTM8e41m0eFxXtAveOmotS47kj/9239DVd9Crc8+NlesEJ628c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NpAyYgYi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NpAyYgYi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C89471F000E9;
	Fri,  7 Aug 2026 11:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786101865;
	bh=Y+OnyiutdAeZqdCaIL9vv826Rscy3ErecGau84y8hCg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=NpAyYgYiTHhaj/NZS4GWynUp3LpN7jIhG81h+HIdZraHExddMxDRJ91fY1Y5yauEx
	 X2TOAGXLZ2DU8KQmxJ9Opb2fkTHC2qIIyPkUy2/xn44b9QZxH+xjszl3MiND1Rjw3c
	 iro6fps9K0L/RWzXSDSf3yruV9kfsIBXCwbeKnpYqDTSzwKBWbxUybu0b80BUhMUsg
	 C6+y0djxelL0spLEisLJxLIsl1SxTiqpMbu8JgQpN2OBYzHqwsKbR2T1NnOlsWDHqN
	 ymRmnC5uzx7DXutci5iaC+jy+XOZ2HkVJYZZLuqM65YfRgHJX3QRLsU07sOEOx2jDD
	 2mSJ/uZsQvvaQ==
From: Mark Brown <broonie@kernel.org>
To: Vishwaroop A <va@nvidia.com>
Cc: linux-spi@vger.kernel.org, jonathanh@nvidia.com, 
 thierry.reding@gmail.com, corbet@lwn.net, linux-doc@vger.kernel.org, 
 smangipudi@nvidia.com
In-Reply-To: <20260803104614.2548375-1-va@nvidia.com>
References: <20260803104614.2548375-1-va@nvidia.com>
Subject: Re: [PATCH v9 0/2] spi: add new_device/delete_device sysfs
 interface
Message-Id: <178604004753.110757.12124960041355613352.b4-ty@b4>
Date: Thu, 06 Aug 2026 19:14:07 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev

On Mon, 03 Aug 2026 10:46:12 +0000, Vishwaroop A wrote:
> spi: add new_device/delete_device sysfs interface
> 
> Add I2C-style new_device/delete_device sysfs attributes to SPI host
> controllers, allowing userspace to instantiate and remove SPI devices
> at runtime without device-tree changes.
> 
> Patch 1 adds the new_device/delete_device attributes and the supporting
> infrastructure (userspace_clients list, manual sysfs group registration).
> Patch 2 adds the ABI and user-facing documentation.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.3

Thanks!

[1/2] spi: add new_device/delete_device sysfs interface
      https://git.kernel.org/broonie/spi/c/e0db3f62dbe6
[2/2] docs: spi: add documentation for userspace device instantiation
      https://git.kernel.org/broonie/spi/c/036d4b059be0

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

