Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19A94734C7
	for <linux-spi@vger.kernel.org>; Tue, 28 Jul 2026 19:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785268723; cv=none; b=XRZncGQylWFgjrt5lT21SJgqYlO3Mui69PFJz3jrTSISYwLwF0Ei8YopHL/eyYCZgmd1HplziWcYKkM/b6UwllwomvJhXfh8B4VKAeyc7HLb8FzwlSOPyr9mdEsIB4QQnXSZ6tGs9eWR6wUVjIAgRafr1dSdZJO0uxqC8SeFvU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785268723; c=relaxed/simple;
	bh=B7kyTTUmSc7KZXREkdFQ/5V1kl9dfN5vIDNfM8Kuf5I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=sXwgYXqH5Nw5itE+tAyN8xssOWrItqBULQNnWIqmUgNXmunDdX2NppHRn+fCvwYdBNRnlEhwAY/6ppwE/PKZdAyx45alZSrRIdMxpabRJEyPleNxHjNvx1ELDSEe4T9J7G2RnDIeJvgNDs4kd7AM/ubG3f4lxLyOryLuXBD7CyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a99wx8uL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a99wx8uL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6452F1F000E9;
	Tue, 28 Jul 2026 19:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785268722;
	bh=EWSIQNZmQcn5VzOftw58l+4FTbmE/kSLUqn9dgKqYqQ=;
	h=Subject:From:Date:To;
	b=a99wx8uLCp33DvF0K8hkBJvbRouRxhhNQCif/Rq+g4S84vjDzdkS9C9D8KD3hw58X
	 63PV1h3HQfG8GP4HBPZS4nQlgFsYfu3pr+eMKIFUs54QEHO3H6fku01154Yk3arhMR
	 XH9/IAJL5olyoiJVD/xfpJW+JdcnQ026H2zSf4ckC8ZW6tDfdE9B+6ehe2eb5zBr43
	 FXDw9bctlBx3UZTp7VWrjGEz4HuPSxmhD7fmwJQ4OKoHmb/BswqcAG7kZH47gQ3m9I
	 apjpPK6RrWqous0ieLLcuifQla+Dnz1vRSE3tuFVQfW7UEU8MgBXWsP1Werd/aX9OJ
	 G6FmjGfdX044A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569FF3924A41;
	Tue, 28 Jul 2026 19:58:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From: patchwork-bot+spi-devel-general@kernel.org
Message-Id: 
 <178526868694.2306826.7363660420930184396.git-patchwork-housekeeping@kernel.org>
Date: Tue, 28 Jul 2026 19:58:06 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v8] spi: add new_device/delete_device sysfs interface (2026-07-28T19:10:54)
  Superseding: [v7] spi: add new_device/delete_device sysfs interface (2026-07-28T03:05:39):
    [v7,1/2] spi: add new_device/delete_device sysfs interface
    [v7,2/2] docs: spi: add documentation for userspace device instantiation


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

