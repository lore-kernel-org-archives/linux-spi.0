Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E0F3EA967;
	Tue, 13 Oct 2026 13:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791899924; cv=none; b=XYGZxIajPIvvWO48XUmb0lBAv+fGpWNG7mhit/JcCXV43or/EI3ljrL25cmICnkizrb7XJkUEBjMJ4Cub7VQOUBj4B+y+ltsUBwrCnwM4o5NxRYMhJGJsC7FK5vr7uP+2t98p1PbUZHmWTp3VyM3Zu/F/Cr6O6pF4ZJEGTWF+4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791899924; c=relaxed/simple;
	bh=4Hzefgt0QwOsJW3KIKz0Kv5ifgXEDkmy3mH+8kS7ZjI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=kqNf7Rbssoyayb8uAMsi8XJo3KhJVeRip2GJ3PCSFKqUrQ7GKwuWDwWCJS+lgdzv4USJhS1I/FRZo05Y/jI6Ene+jyQ5pXXoj+DVGKYNjhiiX6uiLzJ9MMHNWAteP2ZF4zHEWSqzNYFJVI4NVz1eu09QM4oZduAnOfhLDuK2sfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lvoh9BW4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lvoh9BW4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ECC11F000FF;
	Tue, 13 Oct 2026 13:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791899923;
	bh=iCpsBwF9GyU0jqv8hk9fSnDQ7AiQXk7U+I5K3vYYrms=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=lvoh9BW4dbZsqCzxmYA9CQJpS6BnOWjFg61TH/MBeo3x5VXs24FH1m3cNEP6P7z0n
	 uyyAFlgp1hrnAeVUnJWjW3dSxxzvP4FK+dgZQBFAm0hsEb7P1HDole9hzqIWH+CCRn
	 q79vEDCameNckeD8ORZdlh8CfnwTSkoFXJOUrKbIQ8CtLd6P09YR3wb/ffpcI02Vs6
	 ig+3HLBrwSgGoGC2qFnpRZsqDjp3e+TaWgAzRZqq4uao9R0/6Qm8bab2XdQepbANph
	 4R474jAEai6Nem97XeoWBKIc9j0dVZ8D6FvnTO3IrzqadNwR/DszuNALsRSHvIqpRg
	 a/rw7kENLGbMg==
From: Mark Brown <broonie@kernel.org>
To: Aayush Kumar <code@aayushk.dev>
Cc: David Laight <david.laight.linux@gmail.com>, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Aayush Kumar <aayushkmx@gmail.com>
In-Reply-To: <20261010083504.26261-1-code@aayushk.dev>
References: <20261010083504.26261-1-code@aayushk.dev>
Subject: Re: [PATCH v2 0/3] spi: use kstrtoul() and snprintf()
Message-Id: <179184723839.1099724.14865584632017804553.b4-ty@b4>
Date: Tue, 13 Oct 2026 00:20:38 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1503; i=broonie@kernel.org;
 h=from:subject:message-id; bh=4Hzefgt0QwOsJW3KIKz0Kv5ifgXEDkmy3mH+8kS7ZjI=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLLOWQooG/nMXflfpGbZ2iuL2V64zHSLmN+u/Hf2vZOVk
 +wbtUPmdZSyMIhxMciKKbLEZXG/rC95vYbv4MI2mDmsTCBDGLg4BWAi+nmMDJ2dhzcc5tWaOn36
 hrqjt/8fTZBLry6cv6pfz7lC0EN7siIjQ9MD8a1BF7LrmKyOaPYJB3/5MpMz0iP4oci8z48rQlN
 U2AE=
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Sat, 10 Oct 2026 14:05:01 +0530, Aayush Kumar wrote:
> spi: use kstrtoul() and snprintf()
> 
> From: Aayush Kumar <aayushkmx@gmail.com>
> 
> Replace simple_strtoul() with kstrtoul() and sprintf() with snprintf()
> in three SPI drivers.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.4

Thanks!

[1/3] spi: tle62x0: Use kstrtoul() instead of simple_strtoul()
      https://git.kernel.org/broonie/misc/c/54f4db17f9d3
[2/3] spi: omap2-mcspi: Use snprintf() instead of sprintf()
      https://git.kernel.org/broonie/misc/c/9efc388655e4
[3/3] spi: s3c64xx: Use snprintf() instead of sprintf()
      https://git.kernel.org/broonie/misc/c/506fbac9274c

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

