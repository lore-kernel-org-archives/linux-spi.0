Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00E2330B14;
	Wed, 22 Apr 2026 19:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776887869; cv=none; b=igOP94rVAEL0WuQ/Ny914FCoxOtlKLm2JCdVYuZN+fBwedTZQ1X7PZHV1mHxk8AhScqESJbUfLz64dlyu8VWv4d7o82QEtWg3FnVzOtNwEzre4FAHXsoiXLOX0sUW2P8fZ+jVduHJhxrA8s0Xw3NsfDj3Y4ao1GTQc16Aj0UBOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776887869; c=relaxed/simple;
	bh=FWzsRLAFUafT6WTV6RCbtrl5CpsMSJUWMwum3hoMqB4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=TcwG8vb34z2ym41OIdekQoFsGuVbaWQRjFB6loW4tB8LYAgJD8ZOUubJx/UpPdLfrKtEww7khA3oIR3IQ3cX6HTfyXvkvz7oq3Op/VUoN2gKRPDcgG1+q2eYYBtgOONWtWtpSPG/3UkkH8yobysmdLmfcT2tsPgOG3OwpyNWH/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=etLWJAoR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="etLWJAoR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82B71C19425;
	Wed, 22 Apr 2026 19:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776887869;
	bh=FWzsRLAFUafT6WTV6RCbtrl5CpsMSJUWMwum3hoMqB4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=etLWJAoREoUxEG1RQYw460YGXghyCnFkwpEBQsNZ9JXVVdjJcblpyawwghFHhU4xW
	 En1p6aaHrMCqtvRjiwvJVWLPL5EvhkHTHg2dSyx4K/FbQqU6omct5d66Hf1/5Vn5xB
	 0O5iQ0hky9xpCUutv+Z59nAUtsXa3xYBoPhqjM0ts8TUkxWM6bGUp7xvqwgRPEYBO9
	 EPzct6RgLpLwK9OjLe+RiGsfpRZQXujE8jdPSnWnlhJo6lKBg5IM0KKTUrJRsiZK69
	 uoz5IniCLZ3s1yeKiMG1zr40L4EMVb1drCN6+qrm+OUBjCQ+ER8l1T6YbL/1VAp+gG
	 k24BuZ4GfrL8Q==
From: Mark Brown <broonie@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: Saravana Kannan <saravanak@kernel.org>, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260410154907.129248-1-johan@kernel.org>
References: <20260410154907.129248-1-johan@kernel.org>
Subject: Re: [PATCH 0/2] spi: fix resource leaks on device setup failure
Message-Id: <177686703462.36226.8329335259517142171.b4-ty@b4>
Date: Wed, 22 Apr 2026 15:10:34 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1395; i=broonie@kernel.org;
 h=from:subject:message-id; bh=FWzsRLAFUafT6WTV6RCbtrl5CpsMSJUWMwum3hoMqB4=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBp6Sg78cm7UGFX5UtlH/izIuEP01FNWB8qMxeyp
 G/7S+IJaL6JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaekoOwAKCRAk1otyXVSH
 0JZzB/49SDxupljIS7SW9/DKPbYqL35I/dfp9QwxsB60BV863wZzjs13SDjvKsUQph390b4xGd/
 A8rs38t25Mo9l2yrSDpjxAY6kzEJuzbH3etGJryayTPFaC8hM/O9i+8mHcwcjZThQctl9ZjB/FR
 NmFTtqwO161PuphY5MW1Cg55mtWupIsr9l14qzCl1Gey1XUBI8ddAadrEUr6yooFRiUDip7L3Cd
 FRP3/EU4v2kKCySOqYR6RlgXi3SbclbRpBuj5gg6C4J7Nj3MWWrLjzlbrzDRyq2UrIHNgG/t4z+
 lCCopUEoOdi+b6Iep9WSgUTB5iD4FGFsosl3T+zaG3ZrksdV
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Fri, 10 Apr 2026 17:49:05 +0200, Johan Hovold wrote:
> spi: fix resource leaks on device setup failure
> 
> Make sure to call controller cleanup() if spi_setup() fails while
> registering a device to avoid leaking any resources allocated by
> setup().
> 
> Johan
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.1

Thanks!

[1/2] spi: fix resource leaks on device setup failure
      https://git.kernel.org/broonie/spi/c/db357034f7e0
[2/2] spi: fix controller cleanup() documentation
      https://git.kernel.org/broonie/spi/c/a6e23843e949

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

