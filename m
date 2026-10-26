Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793039666;
	b=oWtToKiavW0ERUVvUqdW/chrVsxjNan9Gt0R3ey7VQrYknlsW7CdOdA4Yr9lvp6q2Fm4
	 Y2jYXRwdE3WIi6e1DnAdGXdn5A8PASVUpj/jT/HxX7jcrotAZ6LtjvIuLkKjn1KDqmomq
	 89o8jIzfCKC/XeklGLynBUiIhDj/xCYGccb2Q0eyBkoEUp5DOlfR4AUylPRFGS9ATPskR
	 MolzUdqL7ApTxArAWkgUBC2XEYndX+lncdov8RHywOeQukv1HNw1MAwDB+eB+kpvxDoqf
	 VzFMR2DZiweBQ/ZqPoDBDkIcFPWiLSLF8t9QCktQS0pAcTpd9isDeID5ado70DANg5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793039666;
	h=Received:DKIM-Signature:Received:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=3wbR0f7hq5tu+683v3MSCvgSjzLlikwc4KOj8SHDYns=;
	b=Caqv3/9Bq+VciLjWJUHjhG1tjA6jou6QrHb6Dh/bZcT2YWnb1UDGNH7fZWknFbFBPWGF
	 OC7v/gMbd9769ZKa5nMTGzMf4D49s0vwRYJgZ+FkOjgVY2W6Xsquuh/508QJLmvqqsEeh
	 jcSQLncC9sl2fNRaLGyb9v2n6lKJva7H+k2W5cIEc8HGL1Q/yds8uVglxYR97QXN9Q4Gs
	 UGbCK16FQuT8sVo1jMijiIg02wiBo+GeH0oHGfTOY58Q5qyMDhO5ps5fFhBIfszXo9XnQ
	 L/vdVaBlBoATTkGEq6Y8MAU/E/vbMgtzOvKHV6e3Eylt1iyrzWLhQf+0srLQ5nxVLtw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A6ymt6Nh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56EDE606A31A;
	Mon, 26 Oct 2026 18:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A6ymt6Nh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A043A1F01825;
	Mon, 26 Oct 2026 18:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793039665;
	bh=3wbR0f7hq5tu+683v3MSCvgSjzLlikwc4KOj8SHDYns=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=A6ymt6NhRRk/vzH+DKAI6uUHS5AMxzPVImUQcd6LlBAwTEV6lLJDGBSrfJ9JAMd+v
	 l4uXi58bL1SyXPXgE9nFr+9f2x5dHX8dPSyTdN0mziRyysU0AG0dHLGG3RbSRECIvn
	 j7OgqyLvblGsPx+9a7AYtHHWcVO9iE61J4ZOTCvc5vFEVYDXpJiZwNEU07lUI+7VHI
	 rG7ddsymutGcqxc9T2uXwdwEzQoO+gTIFGVv6YTrBI8s5qoXgsxsVQ0FHAK1gHyDJ9
	 kVHIIb+9uB9BgV0hnAY1mCebDSCeYhajV+pPZI/mOkcM3QPUuJ1u4lSFjC/UYLKx7V
	 EUmCeZCAF02cQ==
Received: from traversing.sirena.org.uk (localhost [IPv6:::1])
	by traversing.sirena.org.uk (Postfix) with ESMTP id 234781E90B60;
	Mon, 26 Oct 2026 18:34:08 +0000 (GMT)
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] spi: pic32-sqi: guard against empty BD list in
 pic32_sqi_one_message()
From: Mark Brown <broonie@kernel.org>
To: Li Ximo <lixicaicai@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Wang Haoran <haoranwangsec@gmail.com>
In-Reply-To: <20261026115219.3528114-1-lixicaicai@gmail.com>
References: <20261026115219.3528114-1-lixicaicai@gmail.com>
Date: Mon, 26 Oct 2026 18:34:05 +0000
Message-Id: <179303964583.199157.8033090930388504353.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=751; i=broonie@kernel.org;
 h=from:subject:message-id; bh=AMaj3BVYprdxeQk93rrlgFicald8g9t0ygQpzqem2Ms=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLLuz5W/OidL6JrLsq5tYq9Xb7s9sfnsp10L8hv+W5WZN
 ztusRYL7ihlYRDjYpAVU2SJy+J+WV/yeg3fwYVtMHNYmUCGMHBxCsBE9lxnZPjT8r/wnrci20Hm
 vzN409PkrlsYMXH3/w3+O22tptjZc1KMDL8rY0z89d/PuPn3yr8+Q70cKaVNkUsvf476+Eil5Z6
 wOT8A
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

> Fix it by bailing out with -EINVAL when bd_list_used is empty, before
> both list_last_entry() and list_first_entry(). The xfer_out cleanup path
> tolerates an empty list, and normal messages with at least one transfer
> are unaffected. This also matches the existing list_empty() guard in
> ring_desc_get() in the same file.

>  
> +	/* a message with no transfers leaves the BD list empty */

The core will reject a message with no transfers, it will allow a
message where none of the transfers have a tx_buf or rx_buf.

> +	if (list_empty(&sqi->bd_list_used)) {
> +		ret = -EINVAL;
> +		goto xfer_out;

We need to update msg->status too, the timeout path below does the right
thing here.

-- 
Mark Brown <broonie@kernel.org>
