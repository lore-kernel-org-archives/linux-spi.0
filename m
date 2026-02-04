Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCA73ED10D;
	Wed,  4 Feb 2026 12:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770206471; cv=none; b=eDEjB1A98ewWm+ULi7YEE9piAQYsmfxCbtrOAtrtaVEi7gQPV+4z5sLTFu3gaO/NGjADhpAbeGPncoaqtPufZG3Ppl5TQE/vV8KncLZ8PyN2qR/Xt+pVn44XZcDjFSXadHvY1NA3Sd2DxqZXAltde9egMh5ty6F/gA3uBhelhwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770206471; c=relaxed/simple;
	bh=lH9HiQe1icK5XV1tUanZj5QknosMljGA5uHaf6rP8m0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=f9EV+jC0O7hOCryyZYOnysD+68LQh+GzEA6DuIYeiIjI+QsghXLesTVhV1Lls9VFawFVrkKxcJhoPTWQd840zKqXehWYi1lSZxLyq4PQBnadbA8vKqjzPFXqwwmBRQ8W4U+Ml1FYbaIBfet/ILyC5ypRHC1iQzkvBg4SvbLLJ24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bnpkVKXq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bnpkVKXq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D674CC4CEF7;
	Wed,  4 Feb 2026 12:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770206470;
	bh=lH9HiQe1icK5XV1tUanZj5QknosMljGA5uHaf6rP8m0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=bnpkVKXq5h15PAsjSTSPDSsEdh7lZDngaFg/U/5F12w7+fW73XQPtblt2JvCdle3A
	 YPljGeR1CbxodJm7wh/a3geWpw3P2qi6f+bC20hQZ+7oSBJAxBlcHg/jUQgdRtb2wH
	 jDV8CGa/r89NepR+LSHoQPe5fiwtdzFXkANps8X8FqblRG/B2fjWMOxyyaKhDpgPK6
	 vfFmRRhfLBXDS5zKHTV/jxix1akvDDe5/7EpwTHm6JkkBAmm4xdhCRhbjGJkoWuNuJ
	 ta6p57Vvh/6dEPSdS3A+YoA81SlFZi2y/oSjGSa4X2cXchqrZ8YkPp2o0TUbncK1sk
	 P5ve/YyqgGKKA==
From: Mark Brown <broonie@kernel.org>
To: Michal Simek <michal.simek@amd.com>, 
 Abdurrahman Hussain <abdurrahman@nexthop.ai>
Cc: linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260203-spi-xilinx-v4-1-42f7c326061b@nexthop.ai>
References: <20260203-spi-xilinx-v4-1-42f7c326061b@nexthop.ai>
Subject: Re: [PATCH v4] spi: xilinx: use device property accessors.
Message-Id: <177020646960.61613.6842316976047547845.b4-ty@kernel.org>
Date: Wed, 04 Feb 2026 12:01:09 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-47773

On Tue, 03 Feb 2026 01:55:12 +0000, Abdurrahman Hussain wrote:
> Switch to device property accessors.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: xilinx: use device property accessors.
      commit: 4cc4ace709860c37f7f8019e950380a4694eb101

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

