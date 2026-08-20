Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03873DA5AE
	for <linux-spi@vger.kernel.org>; Thu, 20 Aug 2026 09:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787219932; cv=none; b=E68Qof5yo3+2bwgOEya8to5ZQwC+1WSFRXkt4MQj55SFK9cNAkWOuVbfHYkFP+ImCmPFpF2biCh7vNN2hF3/CKb6/ipY7q+whAdOLqvWritmeLT5++eorp6eZrsDrtkG+ciuNDh/S8NzXUdN487tYHNMYiRS70tFZhDzgzz4xTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787219932; c=relaxed/simple;
	bh=f+pXmBvmUI0Pzunaq6JqJcr/HShEtYogY/aDrlP90g0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=SaL4ZAsMo9PPs0QBfjOR0yMNrv8PBYaftOsyzoQwS2pAGtQx0PlIrBu4TiVQ+jkx2E8Ppp6zz+Hsg/TlZkcvD26P0YkwQb1sWTleSKN2gj0Jwg//wQB8Riwx50EWICBqzoE0mOTiu8u9eLAF+vg/WKrq1bW5+8mcUudLwTo08TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l4YArqFX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l4YArqFX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 645671F000E9;
	Thu, 20 Aug 2026 09:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787219930;
	bh=yBQHQ94Giujjsi8N6D7MEB66S5hda61OQOZWubsJ9V4=;
	h=Subject:From:Date:To;
	b=l4YArqFX9E96bvxgsymNcPYz2C74Lcu14cqg8v4U/6JpRxxxPF0A7qSAHy56AmE7+
	 wvwQxtr73K5zFjF7imRld/kwH8+xVu6RYH9/wfFPlwgCAI/7Efc1niyY+eF/YVdYBy
	 4vWau6c8iUNxE7sBSEqBsqyE/g+EnD/eNzETUdVg4OhXRMT5Oxr4C061aimlC4rKA4
	 Ojvq8mVKdXVVj8QYbHiGGdqUUZMG9fi1M6FSrAHGH6l2MC6RLt9O6EgUXS4ZhIvRXo
	 BbcsLkMe1HVWEjFMl824tecMdVfMYKxL2zzlMxqJpj3xyxNu1UqRvinQ2kPJmxgfsb
	 zkW/2DJ1GSCvQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198AF3811A6D;
	Thu, 20 Aug 2026 09:58:02 +0000 (UTC)
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
 <178721988067.3930552.18300896956422178714.git-patchwork-housekeeping@kernel.org>
Date: Thu, 20 Aug 2026 09:58:00 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v3] spi: loongson: pm: add .freeze .poweroff .thaw .restore (2026-08-20T09:23:51)
  Superseding: [v2] spi: loongson: pm: add .freeze .poweroff .thaw .restore (2026-08-19T01:45:52):
    [v2] spi: loongson: pm: add .freeze .poweroff .thaw .restore

Checked 161 series in 2.77 seconds.
This project currently has 16335 active patches.


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

