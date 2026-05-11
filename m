Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985B630100D;
	Mon, 11 May 2026 12:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778500944; cv=none; b=eWo7PMFF4hTBsoLSPKHKNbWmzZ7iWeQoE7hBi++P/RYCfhu+ECpDNvfhcCrGthcDjsOTisyTLDUE5tZ+o99SPF+hKXdJkPgEqlnEbu7DYTZyPgImkGNVdFL71gLoBl40sovnGBBHcQI7JnTwp6ILThQc7vXORQzC86nY4l3JzR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778500944; c=relaxed/simple;
	bh=tcUjao8toctquWUR810OPXb7nvFt/jKJi6trNH8YDuE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=A26CaR9ItLX7T77wP7K0CdrbHAuJPEh8Vy6Y6nWs4HuLWbil6BeDUKiL/4C7iGKBX3TrITn9FGOTAdcRvkf6/O15GVS8k1KNLC/fpDmz3rSOPLnmkt0l+1aca3TaRdvsOizT0Q+wn/RxCxgG5e7YgM9yTnEbrE6TPixXucTu/7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u4iWkltp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u4iWkltp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 958D7C2BCC9;
	Mon, 11 May 2026 12:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778500944;
	bh=tcUjao8toctquWUR810OPXb7nvFt/jKJi6trNH8YDuE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=u4iWkltpYBVRZVLoU+PQ/Ccs2KCQDPsTyQYe8PWcgvQyjzx0/lYy5svfct1VEfL/5
	 UD0VIKptFJUFkcCPNLstYN++F/gvrXk3RurLH4eO7ShocxPfO5EHcDLlG16hJW60e2
	 J4vIRRmW/wPGZhA2CTQtck0EheiT60a+DesGvfEwpBlLwJ0+Vppw1Eg32BZ7LuW9YI
	 qC/jkclzNg3+2MSyJlbpEW5thDaJJWJqYEifmaw8D57zpqMrsNwyNdEXk4NHejI38i
	 aMxAZe1qzwxDsekVidu4vpoL2pMV7c8eHV3pwaJhDUsnU8vtdL9NhjwSBqhFpbVxIo
	 Kbs4coi/ICJmQ==
From: Mark Brown <broonie@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: Linus Walleij <linusw@kernel.org>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Jassi Brar <jassisinghbrar@gmail.com>, 
 Laxman Dewangan <ldewangan@nvidia.com>, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260505072909.618363-1-johan@kernel.org>
References: <20260505072909.618363-1-johan@kernel.org>
Subject: Re: [PATCH 00/20] spi: switch to managed controller allocation
 (part 2/3)
Message-Id: <177846096975.988959.14333112263170344165.b4-ty@b4>
Date: Mon, 11 May 2026 09:56:09 +0900
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3698; i=broonie@kernel.org;
 h=from:subject:message-id; bh=tcUjao8toctquWUR810OPXb7nvFt/jKJi6trNH8YDuE=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqAcVN9Jm60Ho+1+Hauyg/UCNPA6pMmLMphyJi6
 FrWrPGAs7SJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCagHFTQAKCRAk1otyXVSH
 0FGmB/4xi9q/bD//I1s4m8L8NDAHFFjohh7cY3JT74hXHU2kFX5XATosJFrm8XZlIr4MSsuEmxB
 WaX0MN9uDpDg9HuKPOV/87448pH1FdZxc5o/XC924/Lyamk5I5sT7/MQRsT8bdolRVsb4NY+5EP
 56mpRWuBD3fyE7aLdBRpDob1gxAh6uSlQwdGLKB/qbYibjh09QO/cGTAJbf6C5hUY15/mA/4hIs
 aQXWHHCqPDj+TbjKUVTdRflRPg6iNfjJY1HRDIikSTXza72G5t2kmi1bnmFEY76cCFmbomTPUfR
 N/5Nv+ui6u17b+y3bUGcGK9nwYqMMejjRjQbAamMh7Vn3Sxz
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Tue, 05 May 2026 09:28:49 +0200, Johan Hovold wrote:
> spi: switch to managed controller allocation (part 2/3)
> 
> In preparation for fixing the SPI controller API so that it no longer
> drops a reference when deregistering (non-managed) controllers (cf.
> [1]), this series converts drivers using non-managed registration to use
> managed allocation.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.2

Thanks!

[01/20] spi: pic32: switch to managed controller allocation
        https://git.kernel.org/broonie/spi/c/4af89d7d8552
[02/20] spi: pic32-sqi: switch to managed controller allocation
        https://git.kernel.org/broonie/spi/c/dda3a77e1a32
[03/20] spi: pl022: switch to managed controller allocation
        https://git.kernel.org/broonie/spi/c/02efc5557c8e
[04/20] spi: qup: switch to managed controller allocation
        https://git.kernel.org/broonie/spi/c/86e8160240af
[05/20] spi: rspi: switch to managed controller allocation
        https://git.kernel.org/broonie/spi/c/368d0e6c6f82
[06/20] spi: sh-hspi: switch to managed controller allocation
        https://git.kernel.org/broonie/spi/c/042414e4da73
[07/20] spi: sh-msiof: switch to managed controller allocation
        https://git.kernel.org/broonie/spi/c/354b0a4ad4eb
[08/20] spi: sifive: switch to managed controller allocation
        https://git.kernel.org/broonie/spi/c/fd260013577d
[09/20] spi: slave-mt27xx: switch to managed controller allocation
        https://git.kernel.org/broonie/spi/c/cd1cd2ff56bf
[10/20] spi: sprd: switch to managed controller allocation
        https://git.kernel.org/broonie/spi/c/d68627cc76cd
[11/20] spi: st-ssc4: switch to managed controller allocation
        https://git.kernel.org/broonie/spi/c/d3cf5ebdf1c9
[12/20] spi: sun4i: switch to managed controller allocation
        https://git.kernel.org/broonie/spi/c/02b36d644ded
[13/20] spi: sun6i: switch to managed controller allocation
        https://git.kernel.org/broonie/spi/c/9864636b1cd9
[14/20] spi: syncuacer: switch to managed controller allocation
        https://git.kernel.org/broonie/spi/c/5d5bbf177d18
[15/20] spi: tegra114: switch to managed controller allocation
        https://git.kernel.org/broonie/spi/c/3068e7063cc4
[16/20] spi: tegra20-sflash: switch to managed controller allocation
        https://git.kernel.org/broonie/spi/c/3a14bf4f5453
[17/20] spi: ti-qspi: switch to managed controller allocation
        https://git.kernel.org/broonie/spi/c/76a24627b98c
[18/20] spi: ti-qspi: cleanup registration error path
        https://git.kernel.org/broonie/spi/c/f8689d5a9ee4
[19/20] spi: uniphier: switch to managed controller allocation
        https://git.kernel.org/broonie/spi/c/789986b14564
[20/20] spi: zync-qspi: switch to managed controller allocation
        https://git.kernel.org/broonie/spi/c/be552efa43ee

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

