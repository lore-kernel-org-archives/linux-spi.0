Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479AB42FCCA
	for <linux-spi@vger.kernel.org>; Fri,  7 Aug 2026 11:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786102252; cv=none; b=KseBr8umVSD50HEYmaDmNxabPUyWDxTimrlWF+W52D6NHYHSwUiWkBLWytH29YykNnZ1aiAF1Xx1v08Rm4ZTfgCjCzYzNP3uQW0hI71TJaGsa9u3oy2QkHo7TtJhXRaR+Yd4eFeuSoXhlq3AOBNCyNPK0lXPiju+NlnqpCq1rsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786102252; c=relaxed/simple;
	bh=sxJLi0yiCXgJZsBtFq9eZQfdqE4k5uC1D6I9FykUoBQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=ieW+M/NAFh3YV77HA3sYzCSawIWWxkJ+J0Ts86erkgXyhThxLNII/cbXUAwywdK8De0x4eBPuRb/KgjFGHEnGBq2nDuhqv5nhkBAwyCwCeRvxKJ9Lrlxz5TgOUabnrXN3ijzuceSviWmnXOklH1UjUA5DEwVdlDJCZk3MFfbGe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oi1oYMcm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oi1oYMcm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD8FE1F00ADB;
	Fri,  7 Aug 2026 11:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786102249;
	bh=CvwDA2Q4zOWxft1nIiV0n480vILELDqZZzF41xB/Wwo=;
	h=Subject:From:Date:To;
	b=oi1oYMcmq7FTQU5eTtT9GOa/1Yj3rrxNdPm7CbP8LldPUZgr9cKc9nMTEUwmQU5ML
	 eb945oMXVeSOXpvnNsFTy4tof4YTW/uhXlJOWVQA2GysIq+uPpdAl1RW5lkHeFexxy
	 nhZRNxw+wW9WIQYAbXMClpNh13z2hKRoBMhxVOH3sUa18Z4HYJmQ9GjufF6BgcXwK4
	 wXhRD1M0PquN3Zgzswsj60gGIlcctgRg9V3Q0HjI8xQgaUCK856WvT5lgP+Pehv8d+
	 NipGVG38c3FSJt3eITlNmOfRd2g7NRZ4kHDQ+d2fKieeXAeUxaMMcVgD90T9FHn8pQ
	 NmOJjPEAsoMfw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D2F89380AA68;
	Fri,  7 Aug 2026 11:30:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From: patchwork-bot+spi-devel-general@kernel.org
Message-Id: 
 <178610220850.1748289.16346298990744516531.git-patchwork-summary@kernel.org>
Date: Fri, 07 Aug 2026 11:30:08 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: add new_device/delete_device sysfs interface
  Submitter: Vishwaroop A <va@nvidia.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1139312
  Lore link: https://lore.kernel.org/r/20260803104614.2548375-1-va@nvidia.com
    Patches: [v9,1/2] spi: add new_device/delete_device sysfs interface
             [v9,2/2] docs: spi: add documentation for userspace device instantiation


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


