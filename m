Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F3C21D3CC
	for <linux-spi@vger.kernel.org>; Mon, 23 Mar 2026 01:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774230882; cv=none; b=KNTAfepvAnatfz+kkVRACHrntyEeNsVtrf/vzrojQ1Im/hoIPq+vrPMb9SkC3eQgtJznsLx3bXVVeuPjpd763fltAH5h16AbKJCiMeMhDeF3tAENuIRkr7ohZTn+Cy4NTnGVyZB5j56e+VHK5cEnQlWYlSgAYx9Z9dDfDBZkCVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774230882; c=relaxed/simple;
	bh=xbnlmh3BuRwGW7Lqvh/ofqvfdIvaooTvMkXqmF1U+S8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ipKknMjwOctS7CVOQWbwBP8ApxNXsswRJiMmDKhyuZso4u+7dyk6fYdt8aQOXBKHbDJF+OP0zmjA8ZFhwhwkxNHyQLPfLuvaKBK3AP0+b11grsNEQdzEzkx+r0EOxyCPyyhLhLxGZcvzTaVEqsXPwTTY2aH1ZtHkTkJGFXPH5pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NB11JN3D; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NB11JN3D"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2c0ea57fea7so4332628eec.0
        for <linux-spi@vger.kernel.org>; Sun, 22 Mar 2026 18:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774230880; x=1774835680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PnwwlSjzqxBbkaN2QOiq4ejjgo89iMENabtsUNWy5zQ=;
        b=NB11JN3DRmrEq/F1+ZU5+wKHjSa9j6UypHsCv0QhfvFaVO3Aylm7Nq3K0ZTxgZlfnQ
         lTDcXaei8GXF/Raj0P6phvzD7btSvi54sXWtuv8lAreghZ7c9SCohgCd4lS/UL4lmiT8
         W94uLTAwFL0MSCI/WW6WGBHG2QS+8C22oxgsHhX0uAnCJPW2BureWxUvPSMUEHI/mn57
         vwyv9kMmA4gaSgbWlRqsMYjIBxwjmYVg4TZXdHVWuMRxw3SaopdXg9nSsx0fetuIdJ8H
         I/RNR7hVt0vgvtvZ5B4bsA1yyddxWgzffR2h+GhiKn93cXxwI/8lwGNQukS8y5wcYEBs
         2/OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774230880; x=1774835680;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PnwwlSjzqxBbkaN2QOiq4ejjgo89iMENabtsUNWy5zQ=;
        b=gP28UHlQogisFqn/m10DDIU/EHUFkB5E1MaXK0BFzYrf2/ylFnYMZMc+uYb7GGdqlu
         voqZXLoO9xW8c91ZwMWKC+Bzr4eYoVo9+HsxCwKNjGzAj5Ob+gD57tATE5ML2di47dDW
         n7GkOtkmAoN22+R/InlqsPAkksUAwq/Pdf/srXm0YWhzi/tbL9bLtJwFjZcRNgRfmmvj
         iBDUwgBJUFTSYVML90SZ33miiiqQ7cjw+ER2KHKmDEABVkP+6X5rA2HFrrAfLfJgvGSo
         ogpl0V7C69L/jUIog6NqnKkq4lv/7WRH7XqCCYDGeDtCrzh9XGalRvZZ2JZthfMfI5st
         7n9A==
X-Forwarded-Encrypted: i=1; AJvYcCWvDs+FclTS51ZdpOYlXr2jZSCKBDonsPY75qEMS1AuI8UZLZMs3nTKMr83POJ2ZyfvVJHsR+5WEbY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3WXW8JYOxCKCS56Sy8ySBrPe/A4W6X2cka3VNskDoFY2I57GX
	xrxJvPu8CJi0VkbzG5ZYj5JmMg3wvSoVLvMnNduquSP4blMTbWEW/GYL
X-Gm-Gg: ATEYQzxDPEACkwtncSWspKk1GBFRximgVgUym1AMWTD1NzNMXMFe4hMxi5Rn67iBnxt
	wY3XwmB/MGfPS0BycZD9hcNDnZhuqNfZa5qdt6iLKTwax6ri171DGNG8wwvJfRFLz2bexTxScWT
	mhdZnZJzuvJuW2dqIxpZYWguaD2Ws2v5oLYFdrStvIlxyRd8tbrmdsImXOcHyP/xIVh57rmN0ef
	HGHCO9ejVuWaQ0bEfGrQIAr0SaPgUTMWHtLT6CMsOKdBLCd5Pngt1joNJh/0/vUVebNGQv2Asrn
	QVy8ZFRbvkeP+M7PH50n5hBk8qFRBcXZlt8kBs/FTFpQS0QOS9gZtDje3KgXWp7heuql8N+SDlH
	+nJCuUJJfkhI06FMmIKN1QrXbANzwCEigbh1K2kTSRUDYhjsTstV6Ab7AvCk89xnhSAJIBAEYhx
	ki7oGlp7IecftHyO4djECOjABCrO67UxDC/LoSd/a8e1DwuvMTKBwWhmajgVYHq/rzxodoUgxnl
	U2bnKdL5+vE9pE=
X-Received: by 2002:a05:7301:4198:b0:2c0:c415:cfd0 with SMTP id 5a478bee46e88-2c109666ba0mr4196054eec.15.1774230879729;
        Sun, 22 Mar 2026 18:54:39 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:b768:22ed:3eba:aeb3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c10b2cf068sm10976952eec.22.2026.03.22.18.54.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2026 18:54:39 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Peter Rosin <peda@axentia.se>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Moritz Fischer <mdf@kernel.org>,
	Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-leds@vger.kernel.org,
	linux-fpga@vger.kernel.org,
	driver-core@lists.linux.dev
Subject: [PATCH net-next 01/10] net: wan: framer: switch to using
 class_find_device_by_fwnode()
Date: Sun, 22 Mar 2026 18:54:19 -0700
Message-ID: <20260322-remove-device-find-by-of-node-v1-1-b72eb22a1215@gmail.com>
X-Mailer: git-send-email 2.53.0.959.g497ff81fa9-goog
In-Reply-To: <20260322-remove-device-find-by-of-node-v1-0-b72eb22a1215@gmail.com>
References: <20260322-remove-device-find-by-of-node-v1-0-b72eb22a1215@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-a6826
Content-Transfer-Encoding: quoted-printable

In preparation to class_find_device_by_of_node() going away switch to=0D
using class_find_device_by_fwnode().=0D
=0D
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>=0D
---=0D
 drivers/net/wan/framer/framer-core.c | 2 +-=0D
 1 file changed, 1 insertion(+), 1 deletion(-)=0D
=0D
diff --git a/drivers/net/wan/framer/framer-core.c b/drivers/net/wan/framer/=
framer-core.c=0D
index d779b03a9e1b..77ef1bfd476c 100644=0D
--- a/drivers/net/wan/framer/framer-core.c=0D
+++ b/drivers/net/wan/framer/framer-core.c=0D
@@ -745,7 +745,7 @@ struct framer *framer_provider_simple_of_xlate(struct d=
evice *dev,=0D
 {=0D
 	struct device *target_dev;=0D
 =0D
-	target_dev =3D class_find_device_by_of_node(&framer_class, args->np);=0D
+	target_dev =3D class_find_device_by_fwnode(&framer_class, of_fwnode_handl=
e(args->np));=0D
 	if (!target_dev)=0D
 		return ERR_PTR(-ENODEV);=0D
 =0D
=0D
-- =0D
2.53.0.959.g497ff81fa9-goog=0D
=0D
