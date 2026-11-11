Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794365967;
	b=eIR4vjW1ihS2mc8Gp0sav2Ug8qiPArVXmUYRYM4C9B+cl3SzHZJIoeh0GoeP1/9Q+Rbh
	 ZY6OGnDe5xIEnYCvKATepzcRTPlK0k5rSBwwhG2XWJeaojAXxIheUE3fz09nN1mVv9i8N
	 Tf8f2A5WVaxmDsxUQE7p7E2MWrEX0w0odHHr1Es5Xn6pM08qSrwVrgXvGqNlZ46o8GOfx
	 ZKNPFfosTOWwESVJIMzk+PAAYO47BNpKiqGwNvdhMo90yeDPM66kXQFO4U8Ibtk/agzCp
	 ltf7XQKfHx5qDHxrkHQQi+gv4xUk9rDy+O8gXYC00NzsfVgOHjKRmjFmeoX2maFnJ9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794365967;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:To;
	bh=RneY6XckGwOp5QXXRlz2BTTfqtEllEnAoW7ZRdsiWg4=;
	b=emxEyB8nNjssBvCWMLydsirEoQv8DzgbhZFWK5BLDqimz4mh0lLSzQG9XZpsr6swPIxz
	 65A02Yka/738kEn3PeFPhrS9HUeoA9G8BvDzjN3UQc/WdH4IF0USRgRzWfXCg+N5iWQlT
	 1h7GzNIMVNZxzVyCU4wskOiY4yLEwDe0pIDOb9AEBTzoCaFGZ6upXDWulJ0sqLrn56UNB
	 s0/RlMz3SH1e2AJra7LxjSxcjzxO6Qw3L8zCr0FU8FaAGZBqlSWm9t9GvMbucaetehUJz
	 Xs/TvY4gdEcNXaZ4i7TN7fPvbZ+z+PxQ2yxmTDheb7UKhleiOsEGw9Y7WdS2fjsvuyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aoINy8Wk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AADE606A320
	for <linux-spi@vger.kernel.org>; Wed, 11 Nov 2026 02:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aoINy8Wk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0ACD1F0093C;
	Wed, 11 Nov 2026 02:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794365967;
	bh=RneY6XckGwOp5QXXRlz2BTTfqtEllEnAoW7ZRdsiWg4=;
	h=Subject:From:Date:To;
	b=aoINy8WkydY/bkwQiFZOgOvPk4s3w+UbPGSS/Cr7rhl4BHvJJZHJ9xgyQDa2Yl1B4
	 zZSnSC7/pwayeolbeY9k6eSqh5Trq8TLT+Zx1la8MzTLfBJ1/pFa+Uzo8e1NuTjVf5
	 JLxYexoXN03w36eJHOozH4/gG8gDQn8KjtPxd4rD7z+PK7tMSmgsr2SVAihhYt+uIE
	 JMIjfdC+Bd6DGPwizzdEcUTC4B5a38cD1/hU8W8VZgbrwu+gKWaw6z4h5yqjkN4oW4
	 JJAR6OGIX+cCJ3ky+fT2L6yAZ8myvPgV/uT3ekeHc1f+XMr/Zu9AQ+sgP8Nmg+c9fI
	 IgWJBLRitjzZw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id DACC6380332C;
	Wed, 11 Nov 2026 02:59:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From: patchwork-bot+spi-devel-general@kernel.org
Message-Id: 
 <179436596536.664018.12222907559922518501.git-patchwork-housekeeping@kernel.org>
Date: Wed, 11 Nov 2026 02:59:25 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: sunplus-sp7021: fix clock prepare leak in system sleep suspend (2026-11-11T02:42:35)
  Superseding: [v1] spi: sunplus-sp7021: fix clock prepare leak in system sleep suspend (2026-11-09T04:53:14):
    spi: sunplus-sp7021: fix clock prepare leak in system sleep suspend

Checked 215 series in 4.10 seconds.
This project currently has 17007 active patches.


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

