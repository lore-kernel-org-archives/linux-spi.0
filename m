Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0EEE32E69A;
	Sat, 28 Feb 2026 17:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772299582; cv=none; b=LSTKVbwh55ViIkGXgYh/7oE0BWcfiQYN+LLHk4/KRS0LkQbZc9aMuqh4Eee+6W3VCWciXmmY5Dhea5k1abokBHvLTtbk8Drdcldt1VdqFvPvOcWzyiWx+R26e4VtcpDCnhSwzM7EMm7fLsVakOsHLznJpX2wOAIfWxD2kQDedys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772299582; c=relaxed/simple;
	bh=pREitDGLI3LZ858N99eR/2Dw53cT5GvKK7Eb6vLNoB0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=X3aSmUQTT9sT/GiOw7Kv/0FP4NPw+7m4JdecGrJwQJQkzInwA8r/P2krAOdJvrzVVE4XzKKa72ZlFlhgdNYIZPDAmQiquRrBhiIkeJwrMCnCpCgVpbr+lLNzt2R9sv9v1AnkitlfZ7D9UTvWvfa3pJR2O2SyjjnMnW9tOPE5uqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bJrsF1cc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bJrsF1cc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99EF5C19423;
	Sat, 28 Feb 2026 17:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772299581;
	bh=pREitDGLI3LZ858N99eR/2Dw53cT5GvKK7Eb6vLNoB0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=bJrsF1cczQ48oX154aPISyzowLd7CdGGajjnHyqhIOwSqnQy0lsN/E4uYNAmenimQ
	 1QPlgNVMTfMIHs0EmT/QyzN/IiKPeDJf7R0hkUGntfL+yR/TqJCwaBrbqVXHHZXA2v
	 3xqbaeQYT/b6FZ/OnY7m5hZAhc5/nDJzNiCkxB3hkB5U3yQbsWg6nouRMuTy7Xh/r0
	 ZvohtraPQ80yFcRWhDwleYb9PMjDOtaizMYytoWNglWJe7ZFmPxziYAYu6WDWTQ7CE
	 Y7/cY2rOz1IO4jPBWDCacmfLqu4jCRzAJBYtYCb9nm9KnQDvay/0lp7/TJfFM8eZzs
	 iEsd3P3lSEzYw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02C3239F2022;
	Sat, 28 Feb 2026 17:26:26 +0000 (UTC)
Subject: Re: [GIT PULL] SPI fixes for v7.0-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260228130341.543831AC58E4@finisterre.sirena.org.uk>
References: <20260228130341.543831AC58E4@finisterre.sirena.org.uk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260228130341.543831AC58E4@finisterre.sirena.org.uk>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v7.0-rc1
X-PR-Tracked-Commit-Id: e96493229a6399e902062213c6381162464cdd50
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2f9339c052bdbafaa8b02188d069fbb0e8df1f26
Message-Id: <177229958466.3021088.8993573777534319376.pr-tracker-bot@kernel.org>
Date: Sat, 28 Feb 2026 17:26:24 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 28 Feb 2026 13:03:34 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v7.0-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2f9339c052bdbafaa8b02188d069fbb0e8df1f26

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
