Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5182F25A63B
	for <linux-spi@vger.kernel.org>; Mon, 27 Jan 2025 09:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737971769; cv=none; b=KBISUJfDx8uRpgqQf2GaiHGcJz/YGN3XKXvs3Tt1LmF2w7E+BAFMAOBxmWri3tEAXMU+PgTV12Aoq5Gy5/uPFF3qaFbJ3VQxDQIGgSfeeiEENQ+Xbs+2MiDuUUsHz0qkrPbs7/oFvOPriW3ppZktbE1KObirBjhNAiAHGJ8csSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737971769; c=relaxed/simple;
	bh=N7/bFzcbXmoVu3O7c61PEhT65P38v2jcbl1g+h5wqiQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=YklVTDS8nqEfFk18FpdwlgVJ1qceTZW+i01e6BJHXf3eJOue5Pz7ag0OZlbGhPUv4fK5Ldwe8xRdNz5EkPYueE5QW8tGWhtb9Pa+eYAI/Smu9mvISWdRZS9AC9TqQO3ITh1xuowIbzkWZWXFQ5k/CfbR8LMJqnvJV1LxnViQx2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A08FSr5w; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A08FSr5w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB942C4CED2;
	Mon, 27 Jan 2025 09:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737971768;
	bh=N7/bFzcbXmoVu3O7c61PEhT65P38v2jcbl1g+h5wqiQ=;
	h=Subject:From:Date:To:From;
	b=A08FSr5wzwd8ZwJSJ2sa2HYqgFcczu9yfaRXWAfv9M9utvRilxppD2WhMpyYQ2vMi
	 1exPTSHARxfwidw7QN7yYItmMR3KJ5YG/pfnm97IA//LPAV1Lvi3qckhUtFvgmp9A6
	 2MgKDihN70tNQ47FC9+Er3ocbMdViWQA5SpPB5DiewuOSl/YBISxase4PDEdNV/v4f
	 dLLEHfpeTAS/jcIH8oWY9SCUt0fcffpo7cJrOzXmkUGmBtM4HKLjGIlmC74lmt4XEJ
	 Rpv/dBcWdwkYf8jPLg7twFrvUX6dz9P9JUgVgJDkDGg4lt0u2184LplmCKgSFELzhz
	 jkDN3j1k9xYPg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70F87380AA7C;
	Mon, 27 Jan 2025 09:56:35 +0000 (UTC)
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
 <173797179391.3042064.7150381698959601754.git-patchwork-housekeeping@kernel.org>
Date: Mon, 27 Jan 2025 09:56:33 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v1] spi: atmel-quadspi: remove references to runtime PM on error path (2025-01-27T09:42:58)
  Superseding: [v1] spi: atmel-quadspi: remove references to runtime PM on error path (2025-01-14T17:23:29):
    spi: atmel-quadspi: remove references to runtime PM on error path


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

