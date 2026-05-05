Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49F937FF54;
	Tue,  5 May 2026 12:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777982831; cv=none; b=G4NeY5M8qqZ5FqqJZrM/1hQH9yogHcbcI1DKIP+aLyhI8cbaWgKAKhlRAlIleYEkZtAJb58w3bZZ82+MHgMKP7O+b0WVYINNsiyTgNrpUb8WfFenSmybnQmNBeB/USuM0xNWqLa/XyNLVwgj8IXbA3ospgPzupDLfLBaeWSg/vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777982831; c=relaxed/simple;
	bh=oW/HofVwVDDCs7aU29w4wlnOuMO7mQT+FHY2O43m8As=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=LqltKf2r02LsrDUQC/cR+q1wWeDCOKMkKURWSDu9ZLiHkitJYgGH0ikFX9ZCTBMP+22RYPjJfKcM/reJiOV9tMo1Rd0MKpDGPm5B5QfS9RnRmUYAGjTEitN2rsSA1EDSvTjEuCgQYLppQ0jA/ljEehQRR8ekE6cv6HqwER9jOuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tdnA3CP9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tdnA3CP9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31B22C2BCC7;
	Tue,  5 May 2026 12:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777982830;
	bh=oW/HofVwVDDCs7aU29w4wlnOuMO7mQT+FHY2O43m8As=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=tdnA3CP9DcboDmLXrTZ6UuHmsSYkYq/F9IV7SO5ynR9eBf1MhiCQhnV1hL538mswT
	 JiN1nIcLCbOJ4mY9Lw/2qu56Z23xkqLTuLehVhNjxxMyLu0YdBXZWJlgMgN4FUOQdH
	 4+rb2va1huwxHEoS9OBcx20jeLgf1ncb4FGeDv2MNtAOyCFAYcVO4+EwfQ4r5WwfW6
	 nlQ3BGVXqqPnG31jMWOOfNlfT0/ziH8ZsLBiH8E2ZxrmI7WY2UIINsUNUa35lYxfiK
	 71bA7FQ9ylnxK0V+wEjMSbY4dpdg7AUjCLCmrHu9drTEXVw86JEAiVR82qdFSV4gk7
	 fScmLvIcrJ/iA==
From: Mark Brown <broonie@kernel.org>
To: Yixun Lan <dlan@kernel.org>, Alex Elder <elder@riscstar.com>, 
 Guodong Xu <guodong@riscstar.com>
Cc: linux-spi@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org, 
 kernel test robot <lkp@intel.com>
In-Reply-To: <20260505-spi-spacemit-k1-fix-overflow-v1-1-77564c2e4e86@riscstar.com>
References: <20260505-spi-spacemit-k1-fix-overflow-v1-1-77564c2e4e86@riscstar.com>
Subject: Re: [PATCH] spi: spacemit: add u64 cast to NSEC_PER_SEC to avoid
 32-bit overflow
Message-Id: <177794648818.568329.10654930281467778555.b4-ty@b4>
Date: Tue, 05 May 2026 11:01:28 +0900
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1148; i=broonie@kernel.org;
 h=from:subject:message-id; bh=oW/HofVwVDDCs7aU29w4wlnOuMO7mQT+FHY2O43m8As=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBp+d1r1OyUdmuot+JUsi74qKBLVXlu6w350F1MN
 ZHSlVhFRbeJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCafndawAKCRAk1otyXVSH
 0G9OB/47BN6chYC+exVNUiFfISGR2RdvFG1yQe0ShvZ/KP71smIwsW8HWvmzMHhzVwjDcRUs5OW
 GAyMF2xGDphYUP6+aXbRlVgdlcqDcad8iFlYbsWMlit3ByJfKsfnSv5qcW4qa25HUAFytTC4xKD
 xzqg3Ot7c+gHFLRHMomockXGuqqidjD7bSHB/XHvMHDWYo09KOspOZ/XHTYsEVMx2ilbiCSGwYi
 d3vfLGVQHJn2fo/yzPCfC8Eq4q5DzGQGjUz4IazbdVEHX0bdoj67Uu3XoI32pVRDMro8paeB7ZI
 mErh8p3HoT7lEzX2dAup8px/E8cXbbVt+hKsjVoklPRzDQDo
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Tue, 05 May 2026 09:53:34 -0400, Guodong Xu wrote:
> spi: spacemit: add u64 cast to NSEC_PER_SEC to avoid 32-bit overflow

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.2

Thanks!

[1/1] spi: spacemit: add u64 cast to NSEC_PER_SEC to avoid 32-bit overflow
      https://git.kernel.org/broonie/spi/c/00cef7eb08c8

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

