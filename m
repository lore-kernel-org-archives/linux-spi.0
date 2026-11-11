Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794393366;
	b=SloFuej+CxoAfgzAVRAkfe3PETZmUmtvWWlwXUt9TPbSjBGpp9FtnWaAELeExKUBla+4
	 zOMdtkDfqcdFN93DYN4O3Nk1/7nG1WUg4Vs4ZvZRSTz8hJvRpwJ7Fit4gO5+MXwVi+zai
	 7LJJb7ZoDBbgV+VdrfzEOd3aVERk96azXN46YUFnm73rPyYwkxmwhZOBR1k459y/fk0rL
	 6ZWU0V5GhHIA19HZz+PMwkov8t4jvWWSpynjNMQemuC+bhbeEye/RX2/jEQgIz37bc/4s
	 CMynz23V9bIMIAUC97CayDrDq54P0zPYW+YqNySuF2PaZlz0G41jVpvO/acMfrWEL7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794393366;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=fpePK/0d0d0lXzlJvMKO6HJskD1MK4TqDY4IFNa6L7U=;
	b=QX5AG7H5of9jP6kPAM32FBSNRj5aFPROidr/opM74dAsDMR7lenHSuNTKSaElrEOci01
	 wvCefbo8EFE5sUJMYA6tw7+q0fiN9x5dj6vImhwU8CtbEXfnetezKI7UWp85btTXhqW8s
	 zNhmpu+SB9n2/9vGtJwtvSnaxAgr6dnu7xlcT7rMAKGLrFJ2m4OkMHmNRxZ+c3ONdKgAO
	 gUrKcgNuCo7otcSSJSIJQBdh/L2752ZIYC4QUl3k/9eyu2+fnBg5ymdRI3ECOlAP3mESA
	 gGvz1UofeV2u/viuq0OKidOj30o0Eb1UY34HiIDIoEDjNiup+EO8GvDjOTQqEb6QwKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=Tb3R9rMq;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3986606A8AF;
	Wed, 11 Nov 2026 10:36:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F3986606A8AF
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=Tb3R9rMq
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 42A30C79A86;
	Wed, 11 Nov 2026 10:36:01 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 890716017E;
	Wed, 11 Nov 2026 10:35:59 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7C14A11BC1D79;
	Wed, 11 Nov 2026 11:35:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1794393358; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=fpePK/0d0d0lXzlJvMKO6HJskD1MK4TqDY4IFNa6L7U=;
	b=Tb3R9rMqytO47cwb8BouPxt9OsdiyBpZgg6czw/jkzUOzgk6EknnWeSpzrh/BDzrNUQH2I
	0USb8h0A3sFUplppxurFck+A/mNERo4MITl5xEchHIC3DFa61lsY6wVTeCgRIKXevG/OY9
	cx1UVIHiJ0nSm45nGzhx1PDhsIbMKW2ZPPzZ2OnNUDWVmxa7fbr5tqlJIcA62oh/xIkvDO
	hdvquVj72ZUAbMvWwoVCpHhPTTvTyKDF3q0fLSRgyoam9y7O2W+PbxX9LgeVqXzLTiAgOr
	oNIl7/PqwXz5kMygTxRYVF4D4HTdxma4m8zRTNF1Rb4ZCU+K4Xm+Yql95bD9LQ==
From: Paul Cercueil <paul.cercueil@bootlin.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Sunil Kovvuri Goutham <sgoutham@marvell.com>,
	Tanmay Jagdale <tanmay@marvell.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Paul Cercueil <paul.cercueil@bootlin.com>
Subject: [PATCH v2 3/6] spi: cadence-xspi: Inform SPI core about size transferred
Date: Wed, 11 Nov 2026 11:35:38 +0100
Message-ID: <20261111103541.100848-4-paul.cercueil@bootlin.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261111103541.100848-1-paul.cercueil@bootlin.com>
References: <20261111103541.100848-1-paul.cercueil@bootlin.com>
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
X-Last-TLS-Session-Version: TLSv1.3

From: Tanmay Jagdale <tanmay@marvell.com>

The SPI core expects the 'actual_length' field of the spi_message to be
updated with the number of bytes transferred.

Fixes: 931e389ded0f ("spi: cadence: Add Marvell xfer operation support")
Signed-off-by: Tanmay Jagdale <tanmay@marvell.com>
Co-developed-by: Paul Cercueil <paul.cercueil@bootlin.com>
Signed-off-by: Paul Cercueil <paul.cercueil@bootlin.com>

---

v2: No change
---
 drivers/spi/spi-cadence-xspi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-cadence-xspi.c b/drivers/spi/spi-cadence-xspi.c
index 87b986a318f3..189f87321777 100644
--- a/drivers/spi/spi-cadence-xspi.c
+++ b/drivers/spi/spi-cadence-xspi.c
@@ -1207,6 +1207,7 @@ static int cdns_xspi_transfer_one_message_b0(struct spi_controller *controller,
 			}
 			cs_change = t->cs_change;
 			t->len -= current_transfer_len;
+			m->actual_length += current_transfer_len;
 		}
 		spi_transfer_delay_exec(t);
 	}
-- 
2.47.3

