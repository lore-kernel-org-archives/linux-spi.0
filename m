Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD956466B4A;
	Tue, 28 Apr 2026 18:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777399884; cv=none; b=lNNiL/0U+SH7ZfXn0FEkg/vX7G+XwSoOLhf7Tgw/OJ1z6Zvf250yuF1nurG0ObVlubpJM/Na9UfeN1fr3zVdxMaxgUpJPIlpfRQmd/9dq+csT9KDjbH19dLPrGe4XDTR7dVkBggaplVbPS/5G+1sR9C4AxpwuxuVsNjni5zhcK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777399884; c=relaxed/simple;
	bh=YpDlTI9oI/uDSq/nVya8Mx+RNyorLJWbHegc8OdnHAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Tmysc60rSnwhsor+JPzHIF59ykUInHyEam5xzVzKKRJfOsf089r+Y37YP1F/+OdqVbpKeRv8cMDl9SFTN8X6YrMXGiw9xdYjMXrS6kN7ivuR0uLZYFzuaAwYr1RaQxRVeXlsEDkxTOvWXvH7QHjk0e8GZEKfj5lqzWfDnKIq4Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K1hWN7Ka; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K1hWN7Ka"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 998BCC2BCAF;
	Tue, 28 Apr 2026 18:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777399884;
	bh=YpDlTI9oI/uDSq/nVya8Mx+RNyorLJWbHegc8OdnHAQ=;
	h=From:To:Cc:Subject:Date:From;
	b=K1hWN7Kagp/O+nHdFSIj8Gh/XicMKcwPLE3rbcsyZX/U498qquvcXHAiq476GJZUY
	 RTWvooib3DvrRwBZiGghphNWqE/bVNKjCKBBjlhVfLW/iSOAfZ1zjWcAD7vl8LbjtJ
	 q7ajvLu5VM0z1xeCAfuvBYVBeFh915naj5HCJSawHjbnqiQHOsJrEGCgeQpjpG2lvk
	 iN4x41ZZuNKcw/IP4kiP3mQzgmLc3Srstn/0nNCOUI9PibeR5ulZAUtr+TYARmhAtU
	 hgyAF0XIEYWHIrW+dW498gXJchZtzeMy86Qv9lEm4j2m3eG/k/+iKO+YXtZiOzWW/e
	 IacAhzV49jCsw==
From: Conor Dooley <conor@kernel.org>
To: broonie@kernel.org
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Cyril Jean <cyril.jean@microchip.com>,
	Valentina.FernandezAlanis@microchip.com,
	linux-riscv@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] microchip core-qspi cleanup
Date: Tue, 28 Apr 2026 19:11:10 +0100
Message-ID: <20260428-surfboard-unhearing-96776be0495d@spud>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=716; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=xWfg8zDHosnjdk8OauMots+Zabf1Nhr291AHb82xBWE=; b=owGbwMvMwCVWscWwfUFT0iXG02pJDJkfftgvYXJg9nzvdWfNmQPZBh5MC6qUu6fc5LKOvOTu0 btyT/S1jlIWBjEuBlkxRZbE230tUuv/uOxw7nkLM4eVCWQIAxenAEzEVZqRoXXd5o7N/KErXv3a ERW+4Effw8KTfetmrlRry3ZKZF0rJ8/wz0BFhKkvddXXlurmy8cfCcRfdd9Rs7xg5STR2McGCc8 ieQA=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

Hey Mark,

Here's the other two changes, that didn't conflict with the fixes.

Cheers,
Conor.

CC: Conor Dooley <conor.dooley@microchip.com>
CC: Daire McNamara <daire.mcnamara@microchip.com>
CC: Mark Brown <broonie@kernel.org>
CC: Cyril Jean <cyril.jean@microchip.com>
CC: Valentina.FernandezAlanis@microchip.com
CC: linux-riscv@lists.infradead.org
CC: linux-spi@vger.kernel.org
CC: linux-kernel@vger.kernel.org

Conor Dooley (2):
  spi: microchip-core-qspi: report device on which timeout occured
    instead of which controller
  spi: microchip-core-qspi: remove an unused define

 drivers/spi/spi-microchip-core-qspi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

-- 
2.53.0

