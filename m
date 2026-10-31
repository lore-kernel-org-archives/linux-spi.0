Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793414394;
	b=YnSRsBJE6KbxtL9Hkf3PGMg7qDWaHTwyTf9El1w0rpjjGP9zj8uT6aVrVBBII4nP0/tK
	 G6Rk+olMB34cToDBlLndGS2KmG7FNzEJuUG1n0ZLNLLtWHxs3JwPGj8IAU1vBTeo1DBm9
	 u0R28wOnK0K3dYGHPWQQFNZZu23qpU9/i2BGBKaBZFrSJUSrit/5mEPGgTbizQjP4N6vY
	 Dz1MF9K1Qg63HJT9xPIQXwKd84Y5VF1j9Ou8cvmM6pH9Xs2lSMXCE3ylAtc3M9GYPmCZb
	 YvTjLUfHlewnPiw1APT41L5uFBz6FxNP80eNMC91/zJbMMdOj18CSYsRPgmDRRhJhhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793414394;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=piM8eBA62VwSbnQR+cjmfd8LxrXIq2seOpkUOZ9qd4E=;
	b=Jw9KGfUK4jSAMvt3DnX28+fz1AguLRZrkm0FttnkxEC+53FAwU9cf9Vaud2R1AT7+E58
	 l81GvOaH97uzcw0A6CMjuaQgCrlWVqNgq0dHOqhIpYRUML3rRBafzdfu6XCQEPhr3tXub
	 XCzeV5q39aJnu59Q3lvqN0qtGNrpo3SoSspbU2A6k65bM51enAm/3KYjaeLpTv3CX7wuW
	 oNCM8vnJ5vLicc6PPRnLg6ht89KnWiWrDNiBQ3aFlshgv9E93lFzxIHF9X4eCg4zcpOUc
	 MRIP5Dmw3mx0wkXHY/hmGj9B24SfL5eB/5UCQrZahYbtHQ3HZC6gjniL0QYCuNfktlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LeRni7od;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4788C606A31A
	for <linux-spi@vger.kernel.org>; Sat, 31 Oct 2026 02:39:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4788C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LeRni7od
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-3645f0f3fcdso2243236eec.0
        for <linux-spi@vger.kernel.org>; Fri, 30 Oct 2026 19:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793414392; x=1794019192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=piM8eBA62VwSbnQR+cjmfd8LxrXIq2seOpkUOZ9qd4E=;
        b=LeRni7odaRZoXAvnLaclH4vnpxuCG3bxk+dXiY/g0FKl+yrvI1QqtiRFcLbmej/qaY
         cQ/L9gPjCJ5UpYHpkZ4tuqu+ZRSMquNWgCXlHGNs+AUKcIdsz/7/FWgZ1fiWvZXHHRrp
         TxoJyFErfbEwgh09SEPG0hLL2TyGRFpXTPI5FiTQu0QetUbHRyxjn3bf2EUuFkUEGcXM
         p6+cBjy1K2Iaa3MzBBOdNYsunWrGo+UjowMpsFE5fn3hYzF4gV7ULvruzZHGC7/RyvCk
         LdyF5FWz5AydyAfYbGndCi/9UiLrpIN2660YYJB8S/WcUcoASvLWssEzz24d49TmNUCa
         BCcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793414392; x=1794019192;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=piM8eBA62VwSbnQR+cjmfd8LxrXIq2seOpkUOZ9qd4E=;
        b=CF2BmmBw+psA9s4Ac3tcIjElmAi4BM6FprBEw7wn9vEhryefqAYvrDrS/R5erjt26H
         nvpN4YY0FuOo0ABerzHJ8Hs8dqTJeaWs1UIxov062JoAslgK3vQsU8WI0UMV0mnyR6e8
         42p0ApiH1064Wjso9A0Bw/6cKYSklbvGaa2q78vUX6SVJjnzUxQyou+e9IoR1mW8bkfS
         tjHIIgmjDSguEuXQr82mCgN+vQUd/oHV17cG0ccOn0Zk8kdKx9QLM+/+nQs7E1RTvsal
         k+rHMTArNXkBkP9q7UtPzKgoa1Uivrg7HzN1ZDXcBU3hDdmGeXT3AbAs+GGUKTJwtnEy
         69VA==
X-Gm-Message-State: AFq9FYKf0X3K8NfJmAWOrIOE+pfUB30uh/tiNqUUBRl5GPox/BMIDL18
	Zqz2Nnb5lvRISkNe1LvmhgYR1ASDVVgZpdlNMwpJEwOoL9cnE9SqsO80TUmnEFFOyWg=
X-Gm-Gg: AYBFou37mKY5OnS3fLKu4Cralx1dI7RTbkUS3Q4FtzZhzh+KlU2vdVkGdk7RVy7s3rN
	EH9jcreaenmrQumeI6rBO8G7NSGzbkQVbuoVxs+54y2pR7dxL6824Sd3hapMuJq8fipWv7SpRWQ
	A1Jyb0Ifqo4AH8C8xpDVIqwndEEivTQv/uBtW8Ok7ah9VynRnz4wvdCJGOWdjm7ZuEJwmuOyDmT
	be4qBiO/pAUIXfD7cM+t0hb4F7WmJddyYiCNm0MP+PSQukgeCyRHdqEpUMeoe86BPRXT3VZeqCH
	0rLe0ioAw8Qcx183RYtSHOU6K9wOtI2ZlAzMou3YbQMkhHapSX3GBbqp4qnJI/2YcdmE+25I42p
	TnVsqHx9d/kII1FRpihlRnS2O7O5mRgeVBNfXRhEFmXJ33NlqsgojS1WYfDmePZFh9cahhwk9fm
	9gN5bDACanJhS4eCSLLfCskwV8BPmP0b9ITg074vchoFLvNwVvEEUGOEB3wun5i7l+Fp2y1p17w
	miVO+unGgcEI8b9PE6d23ArTjvY3LrM2mw1yixefmWl3NUGGfk8MiSvWmv3UT2HssqMHZgx2ohD
	/vp2rhlM0lxzZV162sh2TbywbQ==
X-Received: by 2002:a05:693c:87c6:10b0:367:5e31:ce29 with SMTP id 5a478bee46e88-36a42404ab3mr6235454eec.20.1793414392190;
        Fri, 30 Oct 2026 19:39:52 -0700 (PDT)
Received: from spidy ([2401:4900:55af:1de3:e93d:d70:4a7e:784d])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a429000f8sm11231278eec.13.2026.10.30.19.39.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 19:39:51 -0700 (PDT)
From: Gowtham S Bhushan <gowtham398gs@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Gowtham S Bhushan <gowtham398gs@gmail.com>,
	syzbot+41172204e7323356ecdb@syzkaller.appspotmail.com
Subject: [PATCH] spi: core: do not WARN on OOM spi_controller_id_alloc
Date: Sat, 31 Oct 2026 08:09:42 +0530
Message-ID: <20261031023942.591298-1-gowtham398gs@gmail.com>
X-Mailer: git-send-email 2.56.0
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

In spi_controller_id_alloc() (drivers/spi/spi.c), idr_alloc()
can return -ENOMEM when radix tree memory allocation fails 
under memory pressure or fault injection. The function
inappropriately invokes WARN(id < 0, "couldn't get idr") on any
failure rather than handling expected runtime allocation errors silently.

Modify the error handling path to only trigger a WARN when the failure
is due to reasons other than an out-of-memory condition (such as -ENOSPC).

Reported-by: syzbot+41172204e7323356ecdb@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=41172204e7323356ecdb
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Tested-by: syzbot+41172204e7323356ecdb@syzkaller.appspotmail.com

Signed-off-by: Gowtham S Bhushan <gowtham398gs@gmail.com>
---
 drivers/spi/spi.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 40cda0037ea5..a1276d194465 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -3631,8 +3631,17 @@ static int spi_controller_id_alloc(struct spi_controller *ctlr, int start, int e
 	mutex_lock(&board_lock);
 	id = idr_alloc(&spi_controller_idr, ctlr, start, end, GFP_KERNEL);
 	mutex_unlock(&board_lock);
-	if (WARN(id < 0, "couldn't get idr"))
+
+	/*
+	 * Modify the error handling path to only trigger a WARN when the failure
+	 * is not due to an out-of-memory condition
+	 */
+
+	if (id < 0) {
+		WARN(id != -ENOMEM, "couldn't get idr");
 		return id == -ENOSPC ? -EBUSY : id;
+	}
+
 	ctlr->bus_num = id;
 	return 0;
 }
-- 
2.56.0

