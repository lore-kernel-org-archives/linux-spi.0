Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125A321171B
	for <linux-spi@vger.kernel.org>; Wed, 23 Jul 2025 17:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753293588; cv=none; b=GuMk4oyCzlONfHYNR3Oldaq6fkooMbZLVDWUzu64fQVJTCN3wFbgJCMhbH8gKb7jUX+egj8+LeLF4krrcg9IUzbLFEDqvqD6Q2/iStsFgVKi+Gwbawo2gf7tqZsb3f82g6fxwwfZZTGvcc1eRs8z+jGCaU/+DUKG/EQeNbE45gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753293588; c=relaxed/simple;
	bh=EYk0FBYVdgZ8fu2DO5baB3Wn9SKF69EneE4OWDO92mQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=XJpzhOarMwxWjOQ5+sQqODUybOriUwbgr/cUrFq+yuxuYABzLgXk1LklZ8ilYJVAKsFL66+X7JIskY/vJvOFW79LZfFXiiSrnGwcU7scsaPo711uAHOTHrAk5gOO/CCHgcopDkQtNF7EEEc/9e0DuwFYRG+bKX5d15kcTdMXPsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t3p87fwm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t3p87fwm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F719C4CEF4;
	Wed, 23 Jul 2025 17:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753293586;
	bh=EYk0FBYVdgZ8fu2DO5baB3Wn9SKF69EneE4OWDO92mQ=;
	h=Subject:From:Date:To:From;
	b=t3p87fwmDcg3JiBczlo+nLRNucYlaMtKzFp1RSYYJiMvvvVx5V1Hk4XbyNuY/Zstx
	 4ZoSeM5mBQDHHvRWsrEVYk33yQpqEQ/bNHKQ2zrt0UexOyxdWZBcI5IST8yWJb55yq
	 /idmXyArWtjUqKwxMC72MgU3gi7CiqOAd2jnCP9kUPBSAkQMXOcVCaaoSmG4tSKqh0
	 GceBI7xwyjuasUkRAP1/7GxkO+8JP09sbjdV62mpq2niR6zF1VNERVd8oqbYBw2EDV
	 OoMSnu8Efhzb9lP0U5XZDL6OlBNI+cBblhYlYRqQj/pMc1Z8R2dwISYAmJ3uMw2kVI
	 q2n+J9IOi3POw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EE5E0383BF4E;
	Wed, 23 Jul 2025 18:00:05 +0000 (UTC)
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
 <175329360459.1706047.1406826787697212155.git-patchwork-summary@kernel.org>
Date: Wed, 23 Jul 2025 18:00:04 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: spi-qpic-snand: simplify bad block marker duplication
  Submitter: Gabor Juhos <j4g8y7@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=981607
  Lore link: https://lore.kernel.org/r/20250711-qpic-snand-simplify-bbm-copy-v1-1-dd2608325f72@gmail.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


