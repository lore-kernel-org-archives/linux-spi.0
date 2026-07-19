Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448F7425872;
	Mon, 20 Jul 2026 13:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784553594; cv=none; b=hRI5Z6k/E6RjwBjpIHBp6oV0Qyx9404bDe4i5gLzv3P0dOBu7tjciy/ONAWDYI5gPsdU31HLUGEprT6iU8eHYwmGiIDM6TIsGP4Wd/kEe507lVqJR1x+YwF6sCvQ41N65evg7KhGws23fLvHvBZ29T7eXrWjWVd/FiH375x+aGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784553594; c=relaxed/simple;
	bh=zSln4JFHKMvtPgqQEoN1cf0nMwRxxuI7uTOA1ueBSJY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=CYYSlRxZMK6/49HXuulmW5oB9v14MewnbOUqKDaVG4LdSbuH4uCqWc1I35bDsEd6X+Ee+kpSU7i+Ok+4XH7kyWIAGT45jLXYeLCNTl2toV43H06jPDcql9q5iNR7tDQWpnQXjTSugfIcO+YD0kjOMq+vwvDRERSZUjW0gG9kD0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bV+Hvn5j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bV+Hvn5j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22FDE1F00A3A;
	Mon, 20 Jul 2026 13:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784553593;
	bh=N2F6OqijDAgxCZQOoV/vXM7bxYBnSV+cZVWcXVCaDLA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=bV+Hvn5jybVNvlS0SyepPzaTzj5esjqTzrolQ3EcatlhWafe1wbioSKTVXx7bsNtu
	 MhvGTP6uT15ma/Y97PowY5XCqMOXtsp6qFEmXi/JJbheisePmza/mDLGXlWxKb2LWH
	 eamktbLBtTg7eU5rVvTj5QD7J2IoN+hPLBPtV5HNgSUiLTeEAnhaSgiTaEjlDMcYfm
	 s97zgEjVROE995oebb2RjIGaRDRIv/rAbA015isXHJcS0YLX5VpaZRxFA7Tp1CI6oB
	 ECJ6TJnuXLdJ9PhPL7FNK9ow90Fqn9La2/Ht2Rm0CgTwCntM3RViY1leRjn5JScfTs
	 ZvQRU1ISIFsDg==
From: Mark Brown <broonie@kernel.org>
To: Babanpreet Singh <bbnpreetsingh@gmail.com>
Cc: Vladimir Moravcevic <vmoravcevic@axiado.com>, 
 Tzu-Hao Wei <twei@axiado.com>, Swark Yang <syang@axiado.com>, 
 Prasad Bolisetty <pbolisetty@axiado.com>, 
 Karthikeyan Mitran <kmitran@axiado.com>, kernel test robot <lkp@intel.com>, 
 Julia Lawall <julia.lawall@inria.fr>, linux-spi@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260713060807.7-1-bbnpreetsingh@gmail.com>
References: <20260713060807.7-1-bbnpreetsingh@gmail.com>
Subject: Re: [PATCH 0/2] spi: axiado: cond_no_effect and kernel-doc fixes
Message-Id: <178450176843.325809.14256051361365115123.b4-ty@b4>
Date: Sun, 19 Jul 2026 23:56:08 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1854; i=broonie@kernel.org;
 h=from:subject:message-id; bh=zSln4JFHKMvtPgqQEoN1cf0nMwRxxuI7uTOA1ueBSJY=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqXiB2eRbX7kAxhiTX1zUfiCjJlvejsf9RcyLPf
 RlQq3VqRT2JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCal4gdgAKCRAk1otyXVSH
 0NZQB/9aaQ1gP8vlvbR469Y9H2cpE/HxJp2Q7HIYt8y398NCDa5S9n/yt/u7xdECvrLFK3uWX+M
 VSrM5NVJ4YQe2wQjbic8WaGuXgrsc7BOs4X9WTBdCKoKeld7/Lm6YJVj0EnhKDr2IeI++fY/H9u
 3PpR98RWdNIdlUwX7PsFnn4n6fAB+VBoWEyLXwCyR3kOsLVfDVlYC6ozDluVQpIAkJ2EJGnbGYl
 tTpQTprtnZhFN2gCPWYvf3JGAi1eloPvUfFVc2yajudgDQMs/RNaE6l6EhfgjkrGbix9xRhEFVR
 BvqfGKdJQNsGdod6Wiu/IW+Q90e2s/8wEkW2Hu5hk58XNEED
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Mon, 13 Jul 2026 06:08:05 +0000, Babanpreet Singh wrote:
> spi: axiado: cond_no_effect and kernel-doc fixes
> 
> Two small cleanups for the Axiado SPI driver, both defects present
> since the driver was added in e75a6b00ad79 ("spi: axiado: Add driver
> for Axiado SPI DB controller").
> 
> Patch 1 addresses the coccinelle cond_no_effect warning reported by
> the kernel test robot on 2026-07-12 [1]: the RX-only/full-duplex
> else-if arm and the trailing else arm in ax_transfer_one() have
> identical bodies, so the second condition has no effect. The arms are
> merged; no functional change (on x86_64/gcc 14, only
> ax_transfer_one()'s object code changes, dropping the dead condition
> evaluation).
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.3

Thanks!

[1/2] spi: axiado: merge identical if/else branches in ax_transfer_one()
      https://git.kernel.org/broonie/spi/c/fc46551cfa3b
[2/2] spi: axiado: fix kernel-doc comments
      https://git.kernel.org/broonie/spi/c/7720f98d08fd

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

