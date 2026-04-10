Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9F433C53D;
	Fri, 10 Apr 2026 08:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775810077; cv=none; b=oLSZr1INtowE0zY7BSinf0vcykZvT4d5/mJqu1cyuhIy8Y/yeIIsB3CjRMHRZN21fTd9fv94svVdL2VaayMT+Oxx5wg4rLd73tfzpZ60OdPd7gA0yawSWiY+2uKPlmHTMWyMAhcddviocM3tCFojUlD8MZRf0weXIO1fF5yeH5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775810077; c=relaxed/simple;
	bh=/UZ0+UsnuMsfjcKhAQq/cLSD0ISjV5nElPJvqtFMmzI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ny0MeKzysYqeVfPzDgahZtzuhF3HstP61vypnzEyJ6Fn8WuF04h+B1t6N6a/vj0/oVc2w0q2/8km95rrD13olX+8ZOprAJgulwmzQpa7AW5bTYItnuAItYYaUGKKpx8qB06CjVdUmshIA95AZyzBN+89t+0/vwqn5Pt85zMRaTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dms4JVVr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dms4JVVr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D6FFC2BC87;
	Fri, 10 Apr 2026 08:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775810077;
	bh=/UZ0+UsnuMsfjcKhAQq/cLSD0ISjV5nElPJvqtFMmzI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Dms4JVVrfR4OFke69aAGLbkQdnariHhPcn2SglSfl/iJHhGnKMmgEI/4xAMnTO814
	 wOZ9zVQOk2/a9uPml/xkipC5wQoT7h0/tsuZHxv7WZWrGs4KObTyoBmRcx5odq7qQ4
	 NGCEZJBj2xdXKVoazN6jb/h4kkm+Do18e6t6JbaFW8e6bWtFXXBUXJCvyc2h6OGmJ3
	 345EtVECgXSt9bCa9DJZE0C3QlPQ3yknob1gfvTkZjKhPky/3R8SB0krrc3Zrbav/g
	 gl3jPV4Q/JkxZM5TifGOt337spFLQNO9vR1j/X6CaiJJr+zj+WJ90kn7kbSovw8D8A
	 8lWfflmWXep+g==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wB7Jz-000000027Ie-0BLB;
	Fri, 10 Apr 2026 10:34:35 +0200
From: Johan Hovold <johan@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Masahisa Kojima <kojima.masahisa@socionext.com>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 1/2] MAINTAINERS: update Socionext SPI maintainer address
Date: Fri, 10 Apr 2026 10:34:22 +0200
Message-ID: <20260410083423.504695-2-johan@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260410083423.504695-1-johan@kernel.org>
References: <20260410083423.504695-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Linaro address is bouncing so switch to Masahisa's Socionext address
also found in MAINTAINERS.

Cc: Masahisa Kojima <kojima.masahisa@socionext.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 213f6a294a9f..e22dcbeb7132 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24465,7 +24465,7 @@ F:	Documentation/devicetree/bindings/net/socionext,synquacer-netsec.yaml
 F:	drivers/net/ethernet/socionext/netsec.c
 
 SOCIONEXT (SNI) Synquacer SPI DRIVER
-M:	Masahisa Kojima <masahisa.kojima@linaro.org>
+M:	Masahisa Kojima <kojima.masahisa@socionext.com>
 M:	Jassi Brar <jaswinder.singh@linaro.org>
 L:	linux-spi@vger.kernel.org
 S:	Maintained
-- 
2.52.0

