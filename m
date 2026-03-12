Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E299386449;
	Thu, 12 Mar 2026 15:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773328886; cv=none; b=mtkO3tFrS6qP/e6dePh4TzEvbfnMhKY0EqeXmHv8opc9UOq0qxrN3bem8GJadp4+j9Xz5GqReadIuw/OLCaCLX0nI9lP8/Dv7Ng56btdx9DeMQN1tI1IbqiSYcfQ4NuI5fz/Icg5VpW0kHh3neg9ycG6x+1GjbMQ8dQgJC3bQIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773328886; c=relaxed/simple;
	bh=cEcD0t5vPgnAXtmH+U4gX2l+bU3wARMJi4cKEDyPYhc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z3Th2Vwn7saEn1eCkEE+ouY7l68fi0nydOpxWPcIwY8cyL9YFqbRq9mXLKfJOfKeV7thJQLcifLEHH8u8r3oxBoICH+bTeBKbHgl4XDlrvs+cPGhu//nYpZIMViuFXJ6jbfhbciqrQeEenumV56s6ovuNU/xD0VBK8bQ7EaJv9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VsAw1KTr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VsAw1KTr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 051EAC2BC86;
	Thu, 12 Mar 2026 15:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773328886;
	bh=cEcD0t5vPgnAXtmH+U4gX2l+bU3wARMJi4cKEDyPYhc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VsAw1KTrb9NMmEnraigsJhgupLuFpGBCi6dZoYex19wJGxCXh6hG8a+K8Tzsc+iQr
	 8vO+N1pTEXMYtBhmJJfJleOYS/NJ83e+wzcqq8RV904PK4wRvnDaFaYYKo32+PC7vE
	 yJIztTHZukmlLQ2t9TZOGbsJIeQltvXsLP4Lu0vgzX0pHQ8eBSxhW2DDs315sXCMMZ
	 ZGHu7z8I/T7q00uzT+qXjSOesTORREoPu32rq+nurPeqa+Lov1+v6BINyKXJYWTk6U
	 CQV9Q9uDWuSpzWtp0QvpT37J06St+O88SoQ9oTX2LksG5h2aFxOILKv5+OJenUwrCE
	 OL5pTqNSbmU7Q==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1w0hql-000000008Pe-3gNm;
	Thu, 12 Mar 2026 16:21:23 +0100
From: Johan Hovold <johan@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 5/5] spi: fix misleading controller deregistration kernel-doc
Date: Thu, 12 Mar 2026 16:18:17 +0100
Message-ID: <20260312151817.32100-6-johan@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260312151817.32100-1-johan@kernel.org>
References: <20260312151817.32100-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The controller reference count is not decremented on deregistration if
the controller has been allocated using devm_spi_alloc_host/target().

Amend the kernel-doc for devm_spi_register_controller() and
spi_unregister_controller() so that it reflects this (more recent)
behaviour.

Fixes: 5e844cc37a5c ("spi: Introduce device-managed SPI controller allocation")
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/spi/spi.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 34aca18a96d8..b5e2f1e1a89e 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -3523,7 +3523,8 @@ static void devm_spi_unregister_controller(void *ctlr)
  * Context: can sleep
  *
  * Register a SPI device as with spi_register_controller() which will
- * automatically be unregistered and freed.
+ * automatically be unregistered (and freed unless it has been allocated using
+ * devm_spi_alloc_host/target()).
  *
  * Return: zero on success, else a negative error code.
  */
@@ -3557,7 +3558,8 @@ static int __unregister(struct device *dev, void *null)
  *
  * This must be called from context that can sleep.
  *
- * Note that this function also drops a reference to the controller.
+ * Note that this function also drops a reference to the controller unless it
+ * has been allocated using devm_spi_alloc_host/target().
  */
 void spi_unregister_controller(struct spi_controller *ctlr)
 {
-- 
2.52.0

