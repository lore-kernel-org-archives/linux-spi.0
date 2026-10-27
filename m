Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793072208;
	b=3Lrft+3V31LihqfjWN0T+RslA6eiA1HHHTqQXY6rTECgrCvP7LOXA3wXGn4tty4VNESb
	 f0B7UKSmon1IzxXV79Fu0QkB8RUG8eLIzHXYR8mg4JzDOxTZMDenwB07tOYgsRBPOyn2k
	 2jKVOgxz1y796NKz0eKShDih0DxkH/Pr2fjUt5cNU59ta1lx19Vn6YlID+fnr/zmc4ace
	 RNeN6/5T1VGJgasNvba4MJXCFbXfOBczAxf/iNEbGch2HnJe+6qGEuLcFDITYPKo8WMGW
	 hlna83COodW2iCalEVQwZcvEF+5S6BDSE9aeKrNrOnAWK29N0cH5JmqlCaHN1TdEObg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793072208;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=6c7PKsG38+tOfTfvUEgpG6Qz3gpdcpa+17ieiPJrhz0=;
	b=lctotSGT/oAyGaj2r8/mYBdX9MRLuIQ6LzdScsheCWoCIFkxVXAO+XBdFoUZAVPv/QBx
	 IBWhMBuxvAn/Qu/ZdEON0y+VUaitxIAJTfhBgN29qYZSoI7CfKSO3W7MXLIq0mKg7e7ZB
	 N7sNaIp6iMgNfw/9NCVbYXHDgdxHdc3T15d0Nl2FXgWDdjH9ekXzebEhuCNcLIVED3L1t
	 o/fClLPZidt01TnGoHJacjfQftgL9ADepHf9yr664TPNw5rkRiQnM0WWommYYu9AwmLal
	 uFTtOxTyo569NMD3BMpXHVrOlXTBnVh3S3Kf83km8TElZsug8KK2KHc7JjSYhf7FIJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MRjOpxl+;
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8474E606A31D
	for <linux-spi@vger.kernel.org>; Tue, 27 Oct 2026 03:36:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8474E606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MRjOpxl+
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48afbd2c386so2216027f8f.3
        for <linux-spi@vger.kernel.org>; Mon, 26 Oct 2026 20:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793072207; x=1793677007; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6c7PKsG38+tOfTfvUEgpG6Qz3gpdcpa+17ieiPJrhz0=;
        b=MRjOpxl+8GGg1ztN8ltrKhRXrV7iJjTqadrmooRNsM27ZIJ/xqV2fYpzyT2XflNm3Q
         ozVNLb2fIDRVTO4Rv76j55QenRfaX9SC62L55NNTTlfZnH4aR72dupaG+Pmz0fEkMTfC
         VafkbS+bxJ7pJjb50JKYUWAU+NHgP3lQHOe4mLqgrn8yoBFPAJ5T531ckfGWRWHBQquM
         60OCmE+UYDwlP47vPduh1/64QZO3rBvDpeB/NqdYbKTctZv9lpzovkgP0pKcN9/p/9Y9
         U4wNgOg/Y+xgPl1AK1KBrUUaoZSKl+t0j2ORpry9qBzK7KxLix/9PWv4wgI3cEJw0Xzc
         cL4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793072207; x=1793677007;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6c7PKsG38+tOfTfvUEgpG6Qz3gpdcpa+17ieiPJrhz0=;
        b=s0UHD7emymbRDGXg7dGceW3iVmOQubLmYYbwToDbec2Ms07RcFeqvSET7FGB8hQCh5
         FZxQjOWnHph/RVwYkmH7G6QUdnLQKQte8LXYE/5DcAQxOUhieHB5BqPt68rS942WpKHF
         UIc4aXKaN72s26OhSRbG4wLAMbIQ5Uqq0IH7+5EuF8vzv04mAcVZtcQbOjAOLt84qtSy
         mlPos5LTzsbigjHxeVfr5gmChSgAlI7+JMvucsQMF6LNUMSegg7yQNub16o9Gv4ZMLdn
         JhMnimH4Pj36+HT79oL5Ln2x78iTHukgvicX954LnfDZYTB13dTA5uZlwndzM+z5PGKD
         JfRA==
X-Forwarded-Encrypted: i=1; AKwUvBwQbfvbohfYwPn+jpPKW+BUR2KGjbRaaHWe8s6dbc0AVTgkqO2OKOgFuNmgNt+dQ3LT4KUk8CEa07Y=@vger.kernel.org
X-Gm-Message-State: AFq9FYI4NOImEAy3FUhdx06/ATIEBg9L3FwATrfC2WnsyquAeDfntdgP
	5Z3q3NtwE97izp1P0+Fp8WaWPiiSZweBk6GppN55DvZ/YoXkoPWXoTjf
X-Gm-Gg: AYBFou3qE35C1ovyity7m0maa58T4NmAJn4Ik2JpZ/q8L5uphi8ox612kPssKxR7/vo
	Vr+6wZZwhRHWgGlb2NjvTOeS5IOYugo53jas3zuo2xCPHSSOZX4U97suOawcHaD6yDE1dWSYpbt
	McKHQUeT5T2av/0qkW03WmSGnfL1oJUxRVSxDFJCAPW7RT7dQzp72ZJqtLOfrbwumVNkzMjoFH6
	gO/E1equmfkT7LxwgCJfqB/oFPYwYAKBOU5q6KVo2yq2n5CGRw0KayazXm8MMxl4/m6jRnB7fWg
	zxEDWLsl8qgmZGUK1nyFLJtd77dODh3Ngtoz2UqjD1I+3zVSXOjjn9NKQDKOw7+/ti5KXlZldfj
	UEYqOhWv3CzlnY3YLGwNZXL5niUIcBPxuFAdtyEMsBQ2hq3j5axu15S0r6Ns709X/JxMjplDW9A
	A8FDf5SBg3xKA/TECPMRSpmpjVKMZIiKk9JnW1mxgjojSlSjXQqarwBO9/qNbRn/7r22BXovJit
	/t2X/sBpleU1XR64VT28ONT6zpuOcrLnZyGJa5As6bU1C83xMWPqp+upGntr2jpB/GUKM0IJ/5+
	DrgnbHY2QkjBQa7PRdJPRqkqYI+tc4b767I8dlV3hIO5ZLHRyl2suM0Lbd2DM8QuvKAh78u2l0A
	Ze9wfmknxnACuB5vkK9zZ3W9MPkjEdXfXRG7Ai5IZG5IymKxmWkKUgvsOdtrC5FUKXa23p7uxtk
	teungdelj4lOBJMQ1UCl4xIgKR
X-Received: by 2002:adf:eb4e:0:b0:48d:ef7d:4b4c with SMTP id ffacd0b85a97d-48e3eb936e5mr10274220f8f.44.1793072206749;
        Mon, 26 Oct 2026 20:36:46 -0700 (PDT)
Received: from MacBook-Pro-von-Karl.localdomain (dynamic-2a02-3100-b2ac-9b01-6900-1f92-d182-4435.310.pool.telefonica.de. [2a02:3100:b2ac:9b01:6900:1f92:d182:4435])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ecd39a9sm20409291f8f.46.2026.10.26.20.36.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 26 Oct 2026 20:36:45 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Shuai Liu <847807867@qq.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	linux-spi@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	Mark Brown <broonie@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/3] rust: spi: add SPI driver abstractions
Date: Tue, 27 Oct 2026 04:36:32 +0100
Message-Id: <20261027033632.77840-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <tencent_66EE264CDD33A4355946E42D9ACA7019C409@qq.com>
References: <20261027030352.615926-1-847807867@qq.com> <tencent_66EE264CDD33A4355946E42D9ACA7019C409@qq.com>
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> +    pub fn write_then_read(&self, write_buf: &[u8], read_buf: &mut [u8]) -> Result {
> +        let n_tx = u32::try_from(write_buf.len())?;
> +        let n_rx = u32::try_from(read_buf.len())?;

Could we check n_tx.checked_add(n_rx) here? spi_write_then_read() adds
these as unsigned int when sizing its bounce buffer. The individual
conversions don't prevent the sum from wrapping.

On a 64-bit kernel, VVec can provide two disjoint 2 GiB slices. It uses
vmalloc, so the kmalloc limit doesn't bound the inputs. With a bound
device and a successful 4 GiB allocation:

    use kernel::alloc::{flags::GFP_KERNEL, VVec};

    let mut storage = VVec::<u8>::zeroed(1usize << 32, GFP_KERNEL)?;
    let (tx, rx) = storage.split_at_mut(1usize << 31);
    dev.write_then_read(tx, rx)?;

Both lengths fit in u32, but their sum wraps to zero. C then selects
or allocates only SPI_BUFSIZ bytes and attempts to copy 2 GiB into it.
The allocation size has already wrapped before kmalloc sees it.

The C helper is intended for small transfers, but this safe wrapper
accepts arbitrary slices. Bound doesn't constrain their lengths.

Found during source review with AI assistance. I haven't compiled or
run this example, and I don't know of an in-tree caller passing such
large buffers.

Thanks,
Karl
