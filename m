Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792669887;
	b=YFAQ338BEXuf3Sc2okbrAqa3Z8eI9X9BIchK3k8WHENsQTG9xq9KbNasrp0zGVAvHvVI
	 Tyb0uTARE65cxs8gA9C6Oa+gRtIKUvGqhSjpXUeZBTJ3GIL+DyC7bLAFr3IluFhRK4eaK
	 2WRrrvYENp5ijgPg/vM2fYscA5fTYhyMbObpwyib7nKwC0HF8cttkd4AJ7/k7qWn/UpCB
	 +WcecbacZwa5dnQzrsO9sqggPqvoODQlNLyY3EqE1A/IGio2elKcM5rr+YAjP/nMamN/K
	 aP2RcZmyZoZ3O9Q0FQfV4kL6RIrh3woT/Q4QSbl1I63hl4jQujGsGi9y/Y5t+Qa/bEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792669887;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=/TXd5dPmQW/FdjoYQcFG1PodSXgdJZsvkRdQUDNsOjE=;
	b=kEwXvLFgAU/9EXv9BR6pWpxIs001tFaz+Kx3jqE5vi5aqWbN8TmioQsKq26qhonWgOHA
	 fxGKQB/zUIbpabjKF1jDxX30qRMseOE63uRemTUfe4QqqOUxiAeqw44W3RRl9uGH6O7dJ
	 GRNXj7DU39gf3bQRDS/cxBr5IbsVOh8lbOqCKlveF+lF7naKtsrkNkc3+mg47lTYJUg4h
	 j6YtY+Govf+PUM8PE819XoX+VSMX5GZaHeDC72tKDx8DhD/AN0UWFXfwTCeM61wPKjibJ
	 hnmQ0ckpNeY4krkvDxRDQKnePtWL/aDPFoM7TxIipRprY4g+GYmtJVc0xXTkwCOmsTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BJmlrutD;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987A0606A31D
	for <linux-spi@vger.kernel.org>; Thu, 22 Oct 2026 11:51:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 987A0606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BJmlrutD
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-48b0584ad71so1248002f8f.0
        for <linux-spi@vger.kernel.org>; Thu, 22 Oct 2026 04:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792669885; x=1793274685; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/TXd5dPmQW/FdjoYQcFG1PodSXgdJZsvkRdQUDNsOjE=;
        b=BJmlrutDH4Bepk7izBYBkebrA6NRUkSljExzOxyO8LnJ8w1p5tZ/d7vrJfg3j6wYya
         aIZWmsN7pjuxCtE9/vZl+JP63R7r0rb0nJei3kg7hxz5ZokW9vVFmH9F4W7JamDZ4M81
         bmxt5BS+nxEOg3pt0M5Z2fpxz1/v/cfkklfwh97m147uoqKNbkXLploXRuXOjUj5SyWl
         iYS/zLnqzQD7YU6zKDdkHhRTBKm0jPExk7u5BrJYJEXrvujlD9e3stcRjs9MSiaXXtMN
         Kt2FuXgqnlQ/Re/s1FTHxT+/nxPUJAeJrBeOiJeOb52JRywBqQNVlI0xpWqmc0S9BCsF
         wI9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792669885; x=1793274685;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/TXd5dPmQW/FdjoYQcFG1PodSXgdJZsvkRdQUDNsOjE=;
        b=guSyE3L/z0xWbMPJ9UImrOURnTW1xE1lzNdJbFkM2bwx5qJOorMQqMC4e/j5+WD7kO
         YOpPg4jKV8Xe8zIasPAxiLUSlpLr3E6z6e2/RWhwcKzC+tiifZ77lEKn1SGbomWn+eAy
         HHeGO4M+OeNZbgU662iUyohTCmy56lalyEN37bPBVINlt79yzQBTecj1qUfcsgswQPz4
         WH2++kYxIa9xnxMXOjA97iZ59kUxsd8UfoZqX6QxNNatT2nVPfx/gI/89HYjJ/RvHT8w
         v/iafyZiFBhdvuv0DholRw3wsGAxSPWn8u6QbfL89DFoKoc33nA59vQTyo3MyHcUFM1a
         Ej/w==
X-Forwarded-Encrypted: i=1; AKwUvBwxuf4kcveVRply1S2ckR4FXkiYvY7cWO+6S/3WcRauFncJh6WSZYGIdpgA8n2ErLbf9DvVXWKGpsY=@vger.kernel.org
X-Gm-Message-State: AFq9FYIr15i6cldEw22AUxoyJ12mq1NdghMaWZB4jUgn95NfhB08OtYr
	W8Tp51pSL18GV8Osvu94vkthHnjp82fCVw8YwN4lVI5TJ75/1rFjOJDj
X-Gm-Gg: AYBFou3SJzZ1dWWhbHYmD1JZqi2DqeaGJAfSzJXzxL9aIjSUYfd7SZJxN9RAH9K+MrC
	geatqdYHhImlsceCMy2xKoRMs7Pnlrfo0IwmZ3Ke5wyFJYzvttdOgwID8z1fyD98WEIo88IbFTh
	HgqiGUuVSW2TfMbqCG5nQXiRBwmTd6r2p6EfGbzhKO16+PZXJ0YwezVVG3ks2CbVassitgRL0vq
	Mp0lXVw9DJH5WnaU9uvtBWref5RMBt50KpJoe5DfBCV2kOa6WIJvw6Z0zkf5q2XXq05pFu5Z3ar
	eiSlusWF5y97iVJjCBvzF9dbh4ukFDPm39T9ZQdSs4QzJE7uJQ81UYxFyhfENpqK+vd1BDt/ixI
	CtYPfUMjBOKXDMBP0i+D3AfmPVDn/6mztxaGRf5LvRUEiJt0N7NHF9v6ldnNfEFE6QZpTnIdzhu
	ki4+iBfti7lxhOxnlI1I1w7of1Jo6Ww7r4drAUyJyQYKSFaHoMgUq2svWkW72QjcH31xhZmIbm3
	58WTYfNX78GJ1DjognCWfeM/YuVBclS7iQqRK3vmdM/XBJiVD2cYcbDV0MLP+APmhMsdugKAE5f
	hgXPRjVZSG8MfTHk
X-Received: by 2002:a05:6000:1864:b0:48d:f4b2:b29d with SMTP id ffacd0b85a97d-48e264e8a10mr10554202f8f.53.1792669884742;
        Thu, 22 Oct 2026 04:51:24 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e254f0bc2sm11722358f8f.1.2026.10.22.04.51.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 04:51:24 -0700 (PDT)
Date: Thu, 22 Oct 2026 12:51:22 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Ninad Naik <ninadnaik07@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, linux-spi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: mtk-snfi: use min() in mtk_snand_read_page_cache()
Message-ID: <20261022125122.75a0d528@pumpkin>
In-Reply-To: <20261022102020.107609-1-ninadnaik07@gmail.com>
References: <20261022102020.107609-1-ninadnaik07@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 22 Oct 2026 15:50:20 +0530
Ninad Naik <ninadnaik07@gmail.com> wrote:

> Replace the ternary case with min() to pick the smaller of cap_len and
> req_left.
> No functional change intended. Compile tested only.
> Found using Coccinelle.
> 
> Signed-off-by: Ninad Naik <ninadnaik07@gmail.com>
> ---
>  drivers/spi/spi-mtk-snfi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-mtk-snfi.c b/drivers/spi/spi-mtk-snfi.c
> index 6e96e50fedad..bbb65a21a684 100644
> --- a/drivers/spi/spi-mtk-snfi.c
> +++ b/drivers/spi/spi-mtk-snfi.c
> @@ -1017,7 +1017,7 @@ static int mtk_snand_read_page_cache(struct mtk_snand *snf,
>  			if (req_left)
>  				memcpy(op->data.buf.in + snf->nfi_cfg.page_size,
>  				       buf_fdm,
> -				       cap_len < req_left ? cap_len : req_left);
> +				       min(cap_len, req_left));

If you are going to do that then join the lines.

David

>  		} else if (rd_offset < snf->buf_len) {
>  			u32 cap_len = snf->buf_len - rd_offset;
>  

