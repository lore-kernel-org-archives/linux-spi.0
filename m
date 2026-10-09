Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0264C8C50;
	Fri,  9 Oct 2026 11:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791544580; cv=pass; b=M642z5tcuwtfxS/BX2qwjKhpvmu1aoQgRs0p7DSp/socUPmXh1lGe1b/MyH2b19q5cdUQGEXS4axFd0gizhx9CoAha7exOWmx12gY4j9LIbEXJzJ5mVWV/dRXzLlKJjH3AUMZ48XFiU0EYMHhFFLPNlo2onRRyyDo52I0Sy2gHg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791544580; c=relaxed/simple;
	bh=T3ACDfbvQpsVVVLYQgg6TWpBSQG+DtK6HDDd+DKT4GY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=T9U7klDDTRS1t18TUaniQqTsnYELWp+I5300kqk4omerg+8jnJeBfcz3mu4t885NXJOjLMZjMkGhg4AFGomlE84Dor2kOBp4ryRLSjljpRQ+QLp+I628318fXBOWgvaOXVVhDPQscUmI0MM0AxZlU6YyZKM1A3iDlEewxQzFYA0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=CBerIp8d; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="CBerIp8d"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id EF5E5202603;
	Fri, 09 Oct 2026 13:16:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791544562;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pZhgQZMcCK8iwoM7B5lUWQ/ev59BhqT2j3HB6CW70Ps=;
	b=CBerIp8dyDVW16GYdn7XotlAyfFv6VEebEIilK0q9DCblkAz3JIHBj5rpbesy4edXPVb/D
	5kBK+Qc6PfNkmk19mT2jg/l85DvxIUMk0axbEk03/TCljfDXgrRQ08xTSc3bypQ4MvRdtT
	eOMlnUxcZp/kDxth0THr0HiN1w1SyMrFuO6UpT534nhzvQucTZ2ZlOh/Hl+x/notKjr8px
	CiOJ1K7l4Sr8l77WwzRcp0p5gJv7d6a6ro1SZyKZW5EdktreLplkpgxl3jyiOUXeuJIcjg
	mC4k5AT316LmQmqt/7tJUSWJNvnEnSpTUtDJHxR1y2f5wlyzD2C2WNd4v4Zmqg==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1791544562; a=rsa-sha256;
	cv=none;
	b=g5XJXXb8JH33Frzm6sOvH/g1BFKvIXKjubdZno9quSsJVMR5ysw9yC/x6+xgriociVmTTX
	X3tJWN+w/7bgW5LNsLTuMYK1DCPdVqFCsFfisN53Sp19l2E+/YADjim6qNZ8nsH9Mg6Ryf
	DBdVWhYIQdgN9F5epDkflPxE4CIyZgL6adHm2kZRlKh3IQ0IislkafAqEC2Wl1UaaYpOPP
	IcQTKmn+6W+2fphOU8oHDrscbjRpT0WHCPgCVtXAdv63ccP6EUO7jYXc9m7fgcpEsyYxc3
	4wZ0L7OcNzsO4jV1kGtG9xK49kfpNH84J3BYStRmPgpfIc8tXsSW2KgVheTJwg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791544562;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pZhgQZMcCK8iwoM7B5lUWQ/ev59BhqT2j3HB6CW70Ps=;
	b=cgzNBXu7PisZvbgl39j3u4c7rILXHwqAdmG6S0c5gg5M0EL+95bX8365nkxFYqvIY85nui
	t+SGuHlz8XY4MvzMdelniTVfGtCwCbtpS4wbE462H1QOw2GLuTSMJYNk9K5f3l5j2gNukT
	2p+vxx5UyDhZa7knC70O5TWqp+rYRCbQflNARpWLYRuWk6kSqxLDryWz1gO2567RlkahDa
	8rGl4eZQJWw3j543aB01YvL5trPf3KsCPk9XChXcx50y2aVKbNM9srcXT9G3A3U15iBeds
	BOi6DDcvLL7xkrQRI33Tlzq47cXmprG550dpxifZHaEsp3VDr+c06k2z9qi+EA==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xF8a2-0052MH-2p;
	Fri, 09 Oct 2026 13:16:02 +0200
Received: from hardanger.blackshift.org (90-182-211-1.rcp.o2.cz [90.182.211.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id EAEC95BD5D7;
	Fri, 09 Oct 2026 10:16:41 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH spi-next 0/3] spi: spi-fsl-lpspi: various cleanup and
 enhancement patches - part 2
Date: Fri, 09 Oct 2026 12:16:34 +0200
Message-Id: <20261009-spi-fsl-lpspi-more-cleanups-v1-0-2d4549d5205e@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMQQqDMBBFryKz7oCJRbFXKV3EONaRGENGRRDvb
 tLu/uM/3glCkUngVZwQaWfhxSdQjwLsaPyXkPvEoEtdl62qUQLjIA5dyGteIqF1ZPwWBHtt2+p
 pqkYbBakQIg18/OpvyLqnY4XP/5Gtm8iuOQ7XdQN+MwRLiQAAAA==
X-Change-ID: 20260916-spi-fsl-lpspi-more-cleanups-d2c934a372a1
To: Frank Li <Frank.Li@nxp.com>, Mark Brown <broonie@kernel.org>
Cc: kernel@pengutronix.de, linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=723; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=T3ACDfbvQpsVVVLYQgg6TWpBSQG+DtK6HDDd+DKT4GY=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsg6sZ+F5dqmtZ/2lxnyrJ4kkTatI3uxgeKe2q9RDg+z6
 18tDfyq3VHKwiDGxSArpsiy9McJRYFAh9LelwmTYOawMoEMYeDiFICJ7N3B8D/pvdv0n1v22N75
 7sa1cM+erR2xHG8Sbp1Tj4/5Ivz+NZ8Kw/9gkfra47v7tNVfN+QUKpd0tJyMyn50qnQ3z18v6V/
 fS7kB
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54

While optimizing the spi-fsl-lpspi driver, I created some cleanup and
enhacement patches.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
Marc Kleine-Budde (3):
      spi: spi-fsl-lpspi: pass struct fsl_lpspi_data instead of struct spi_controller if possible
      spi: spi-fsl-lpspi: fsl_lpspi_transfer_one(): directly return ret
      spi: spi-fsl-lpspi: cache content of Interrupt Enable Register (IER)

 drivers/spi/spi-fsl-lpspi.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)
---
base-commit: 85b0e19de168d82cbd879a4c8e13fabad5ef4dd8
change-id: 20260916-spi-fsl-lpspi-more-cleanups-d2c934a372a1

Best regards,
--  
Marc Kleine-Budde <mkl@pengutronix.de>

