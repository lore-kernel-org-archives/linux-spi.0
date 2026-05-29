Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F57333CE86
	for <linux-spi@vger.kernel.org>; Fri, 29 May 2026 14:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780064409; cv=none; b=N6qQF893wi9yxo4qjOJ/q8H+IE5F9ZwPbyt2vRcFSS9qspHF8VAKixJzw22GMNMs5FI0RuywP2SvvnZ3PGicymHO1C93+Gs2xCnhCb69uux93bifShYnq9G30OS1Qqj33s1TZeNIdcbhT1wJrY7LTwzpzZt9BVqBQzbv6S8mkdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780064409; c=relaxed/simple;
	bh=TXcTdjZIMhxA3lNPZg2c6i/yIM8aRsXPv6SHuWGsiIg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=SCiQLlsACmYHfq4TDU3bdbjQBPbx6oR2TLnm7QSV8TnzgZz/Dy0Ctf8jgYHF9CDTsqsM7lxJnHcfgk1P3wpYMCJxw9ztVYgTxtCTBizqNRTDeiPzhdtqHHQE4mfPKGK56z7iKqI4/Gl7OJLNHXaKdt+n7Z37yg+q73/nQMtu2us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XJxjKJNF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XJxjKJNF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 235FC1F00893;
	Fri, 29 May 2026 14:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780064408;
	bh=i0L5NLdMBQKGuTHkD4jbeeoeVtSCnorp/tOTWacOXoo=;
	h=Subject:From:Date:To;
	b=XJxjKJNFzSRA/ikMGIdRMfOCf5nFKSRmaSxLAON7HXeGgdGTKWIOrW2b2waIfcf/Z
	 Kg30E4N0Lb1w7PvK7cuXifVp4twll+nhSWUjrvMeg0y2biC7jR3hvBHhebduZk6rRi
	 6AtJLUJmKxXrtSm/6TKW29+8vODvDa2/uPH+x/hqG1cC0tWskk6Oq0Y7QBzvpJsnBs
	 WXQ0FVNl/nBleBkAkx6tnDuEXwLx010GIvWMs3oqy90KaPIcBLfaBp9efp8Mwxn0pb
	 Dbh+ja3sho1bGKZ5ajrgS7ddf42t9OaJsU9rCt+gfE3STsClF3s1KD+Hn/VTYVQ4pv
	 wzJz67PO9ueBQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1C2DB3930184;
	Fri, 29 May 2026 14:20:13 +0000 (UTC)
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
 <178006441168.1822719.16437915060151143342.git-patchwork-summary@kernel.org>
Date: Fri, 29 May 2026 14:20:11 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: spi-mem: avoid mutating op template in spi_mem_supports_op()
  Submitter: Santhosh Kumar K <s-k6@ti.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1101784
  Lore link: https://lore.kernel.org/r/20260527173736.2243004-1-s-k6@ti.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


