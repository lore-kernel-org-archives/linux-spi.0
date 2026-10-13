Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78EB2501F4E;
	Wed, 14 Oct 2026 12:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791982516; cv=none; b=EO7zIzYMqkE1R966YnrGbqMxl4VKJnnsuKn3iwdmxXQP4IdEH4uYprvTYwlVatkBDNF4iQtfXyYvfzGLGbpYjhfeprU6hXoKYXNZDjEoRg+taTaEyZkieC7FDtWmjqKJ34kvF45SFG16tj7AH9GPOu7ASYo5raXQi12rC5FAHDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791982516; c=relaxed/simple;
	bh=BMjUE31zh5IYCpI+XkO02Kt9gmDncIdsDyz/c5SzQxQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=HffyfDcZQlwaOQ3up0e+292y+4MIlnf/AbzFOOvwf9gGC5kBVVQE1aK31XRSJO08EQmKPXxCOIpbv17sNxq1z4sK84PQBqbKGdA/C6eN6UuZsDotWfMMpq6QrUVGOFSJ24SJjGx5qPRIHCovBt2aceUpTEUBazaw6y5WcWQPd4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EXVZusJd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EXVZusJd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E83E1F000FF;
	Wed, 14 Oct 2026 12:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791982508;
	bh=v0sGdjZ05LZsvsf2jNfCbObVfnO6ofStPoiOND3H/m0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=EXVZusJdnctO2PoK8ieQKPllZg+fDaPeF/1lvXZPaxtQ4RCuq8r8iJ/BlYMfocAsI
	 96WyJiBh1KcgPwynNEJ4MAhNgRGaEf8JggYeXFsxlhc2rZMqng7H+/kdtD6zYKfa5G
	 q6zhgyM8RWCq+ibOYq8/czb9PJXwMDsHjCmeCnn11s/gs43eNc6nmmQ5eGcrmt7cv4
	 S45mqHrgH2CDrPDZ55fOvww3B1bMawMPeX7aTUM7qq9H+J0EnwB0wgjFkpIXTnPcUU
	 DiNMXyXhcYWyvi9S+5Sk14J5YOLH6OM5hHcDRK4rTd1efd4NuhlyaHkAMMFyhIzIt2
	 f5zAhsp6CoEWQ==
From: Mark Brown <broonie@kernel.org>
To: Carlos Jones <carlosjr.jones@analog.com>
Cc: Laxman Dewangan <ldewangan@nvidia.com>, 
 Thierry Reding <thierry.reding@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Sowjanya Komatineni <skomatineni@nvidia.com>, linux-spi@vger.kernel.org, 
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261002085540.1625-1-carlosjr.jones@analog.com>
References: <20261002085540.1625-1-carlosjr.jones@analog.com>
Subject: Re: [PATCH] spi: tegra114: assert CS GPIO for every transfer in a
 message
Message-Id: <179193000521.1606900.15408525415805469016.b4-ty@b4>
Date: Tue, 13 Oct 2026 23:20:05 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1136; i=broonie@kernel.org;
 h=from:subject:message-id; bh=BMjUE31zh5IYCpI+XkO02Kt9gmDncIdsDyz/c5SzQxQ=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLLOV6/c6nH56DqTmx5nAnPU7zeIzOcuPBHXtaHBz/iwz
 6R5GxJDO0pYGMS4GGTFFFnisrhf1pe8XsN3cGEbzBxWJpAhDFycAjCRth8M3/QcD7JUxCzn+3w0
 29F7xtuIC7efeQtYKOxQsBHf9Y2zj+F/nYsh241t4V89fQJu65+5b6a/d8GCijleOww1r/+xP+r
 PDAA=
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Fri, 02 Oct 2026 16:55:40 +0800, Carlos Jones wrote:
> spi: tegra114: assert CS GPIO for every transfer in a message

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.3

Thanks!

[1/1] spi: tegra114: assert CS GPIO for every transfer in a message
      https://git.kernel.org/broonie/spi/c/8980bc573ae2

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

