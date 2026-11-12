Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794466208;
	b=FV+AsKZYrKSKWOspvLss9ProecbUXooLmCQph1WI0LVl934qL4PXHHyfVaOYT80pcf59
	 eFcPMoG88VSK1cj6d8S+jTowMVToB6PwgtvEY5y5co6GBWFXeCAQeiBxVEoN8vC68uTnx
	 mzq4HzQ/uFTpJSkRpxyKpWZZ8HmCtACzypO0RQJ3Klq4GueluRB1EvI1dBXhGqKZ/jmSA
	 +VKjMUjHzw2+wFBgTWpwUchbp0KEsXHugKV2+BBnDq0ZG3RS0n3bb4/m39y7LpjdtlMDM
	 PspSPElEcd6aTCsW2X3IQR0VNF3rfx3wYNrsOqcwisRfLhKbnFWheK9BEW+d7ETZvag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794466208;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=b9b3tYu+beF9g/ZwB2Rnwljh+myz1+aTj2HUWSMtgl8=;
	b=msADf0QX4e0alaYRsKtsXQ9hf21mWbDXtTBIydQDyYVDi/cpuqKZpVupROhUfney2MBE
	 MxcqzW01UBYFxTBptHNnV5qzAue5On4G6ZiYUrYrVHIpoQzidPC1Zdiuvn4R0MJ2OLy8v
	 3HrfdznE0shhxLRVv1XpuD7HLDSqb0xKQTrcwVJjChKC1nS02ONdEA91lZu2GKbBgAZTp
	 QD0yWdFeQ4GTpIb7TaVf3WEB6GUp8SN+P/VSsrgZ6MXP6VCFU4lJ/Az9DA/CuuatafUd8
	 tijBfS5PdZ6Lkx47mIhuIwYI79TkBQqs9EIj5Jy7zSGGsdpb6pfDt1XqCdJtrl4czbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SgwHHH6R;
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2A960A5BC5
	for <linux-spi@vger.kernel.org>; Thu, 12 Nov 2026 06:50:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A2A960A5BC5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SgwHHH6R
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-33fb4680717so4750307eec.1
        for <linux-spi@vger.kernel.org>; Wed, 11 Nov 2026 22:50:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794466208; x=1795071008; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b9b3tYu+beF9g/ZwB2Rnwljh+myz1+aTj2HUWSMtgl8=;
        b=SgwHHH6RYgrx0noh7brEbqdSa5d/fDZSvuAXPUJIHRvvV+j5ClLWPhI0JL0ULpv1Jv
         0VarGnytt4sarhu13itTjd07vwTPjpCspNi0HnqRtbz0JOr1hsR5/pqXwZ99FGDmHwf5
         rmXmfBFmDRXwXUulQFjmmGOoVNY4eCZWv7BEZY/TQljtwS0ZbX9oRn1K8paxFkVFijTL
         UWp2djiJnUa/JPioAkfE1nwfnGD7qgu5Zq2eg4sTrAgjdmNCzVDOLk0F5K1zws0QDhyi
         yTP6i+386VzhoW2oOnCMhyXn289l21H6fqZEgiRThTIv0Ailz81BvhaWtoT7yH1wXOEZ
         +pQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794466208; x=1795071008;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=b9b3tYu+beF9g/ZwB2Rnwljh+myz1+aTj2HUWSMtgl8=;
        b=q6DtEfJZzz2wR9yTB/l/G8sq96LJ60MbnJCOfQfF0OY9LLDpXW1aBzM4GNERUgoajp
         eHsLAlJt6DqRcp9krKvq7bsqC4deP3YB5osNIR7s+zTquzLWLZWw2xWAN2W6aq5MLNSU
         dy+pkDq8943P9qK7VD5SnFblwdPIWFXkrgwNilQwP7D8MDLw0WpeO1JmX92W4wPb8SH5
         4TJwh/dnZvTy2mydQNOtnMe5cApaAiVPfvzQyvzK76+0+H8WTAMC5pzNcF8V7nmVC+Sr
         JTSfzBJuqKMOdeEyKhreoGC7Xt8jeJcs7YHsW90vBLEdFJWb43pTMu6kJscGBZsyn/C8
         zzhA==
X-Forwarded-Encrypted: i=1; AL+hErEoPjerpm+aOONZlVPRE9fEem5bx8QFlXVYN4i3BzmReWOROqKO3lVy/kIh9IDukzDM7fUu/CyE0Dg=@vger.kernel.org
X-Gm-Message-State: APuU4Z8shHMOC4PQ1ea2S0tJUR1sPSQxdbFzkgEsZ1tsrkrOQRtZJYOp
	6QwqqqAjbAZsyPXsJASt9MCz1qyfCmDBBOKA9cICLC1tIXIAbv8ob1OV
X-Gm-Gg: AYBFou2m/cWNFge1t9GO8m0P3SZB+O3oFbZcgcTIYRC40WctZzOFGisMfip/Kh6KaJj
	yh06x35A3CIlyDVOiuXHgLiv3o2Ol++lLgrSE8Q8uwF7dCmc9jflPRlwWjZSNrl0UdeRECAEtzp
	1KvJw3J+GcjtKOUnlh1dWu5dLnRYwxroSUpGpxckZJKRDf0G+TKrR/2cCwTrJtwbge4IvV5P43+
	0kQgd4MR732GvNHDVlZPQxpqqFVLQc/o/bgE+DUoR1C2hLNDYsskLHTjjaJUqlBQAq+Qyh7kIRN
	PyTNL93swj8qsrF6me5IZNVg5Q2Wdp2xRbyj/d4Ovs+pwnC1bjiu0d5tGbksSv6TlJigyluWIS9
	ZiHZ68Iix1v2fQ45E6oSe4dUH1nFrzbppqQSS+q90zK+eJDyfaxm/P7NMAw/doWKV7t0dNrCLj1
	C7/lDtm/QLfCVtBuSl8FRPTP+4/f6bv5d0hl6KcChBNOb6iAsxKdaPRYSYIxSObm1onQo4OcMIc
	EyXEJ/I6E+Tqa9gkieAb3x/AwpLb3uVkLmRUahM5yvf7hji1QVKgj+5WuWwjx2TtLzfJD3Ik5Hb
	NHLzrA+FPnVPf9v29nGM2Q+WGSFuwx9UoqoArndwe/3TPATxfTQ987HIznwkXSUwXTKAAYXj5tF
	qFKJiauIAiglig+EZ
X-Received: by 2002:a05:693c:68c7:b0:374:e25e:a533 with SMTP id 5a478bee46e88-376864688a8mr4910852eec.35.1794466207572;
        Wed, 11 Nov 2026 22:50:07 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:182d:659:ffce:39a4])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37520cfdfadsm27190961eec.19.2026.11.11.22.50.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 22:50:06 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Linus Walleij <linusw@kernel.org>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Arnd Bergmann <arnd@arndb.de>
Cc: Mark Brown <broonie@kernel.org>,
	"H . Nikolaus Schaller" <hns@goldelico.com>,
	Kris Bahnsen <kris@embeddedTS.com>,
	Mark Featherston <mark@embeddedTS.com>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	linux-input@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] Input: ads7846 - remove unneeded memory barriers
Date: Wed, 11 Nov 2026 22:49:55 -0800
Message-ID: <20261112064957.1796975-4-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.56.0.567.gdb80ae8cd5-goog
In-Reply-To: <20261112064957.1796975-1-dmitry.torokhov@gmail.com>
References: <20261112064957.1796975-1-dmitry.torokhov@gmail.com>
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

The driver invokes mb() after setting the stopped flag in ads7846_stop()
and ads7846_restart(). These mandatory barriers lack pairing barriers on
the reader side and are unnecessary.

The wait queue operations wake_up() and wait_event_timeout(), along
with disable_irq() and enable_irq(), already provide the required
synchronization and memory ordering when stopping and restarting the
device polling. Remove the redundant barriers.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/ads7846.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
index f1827684c902..6352117cd898 100644
--- a/drivers/input/touchscreen/ads7846.c
+++ b/drivers/input/touchscreen/ads7846.c
@@ -235,7 +235,6 @@ static void ads7846_stop(struct ads7846 *ts)
 	if (!ts->disabled && !ts->suspended) {
 		/* Signal IRQ thread to stop polling and disable the handler. */
 		ts->stopped = true;
-		mb();
 		wake_up(&ts->wait);
 		disable_irq(ts->spi->irq);
 	}
@@ -251,7 +250,6 @@ static void ads7846_restart(struct ads7846 *ts)
 
 		/* Tell IRQ thread that it may poll the device. */
 		ts->stopped = false;
-		mb();
 		enable_irq(ts->spi->irq);
 	}
 }
-- 
2.56.0.567.gdb80ae8cd5-goog

