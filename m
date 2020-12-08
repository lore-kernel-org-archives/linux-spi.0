Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73787C4361B
	for <linux-spi@archiver.kernel.org>; Tue,  8 Dec 2020 13:59:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40AA923B1B
	for <linux-spi@archiver.kernel.org>; Tue,  8 Dec 2020 13:59:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729377AbgLHN7k (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Tue, 8 Dec 2020 08:59:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:59016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728546AbgLHN7k (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 8 Dec 2020 08:59:40 -0500
Date:   Tue, 8 Dec 2020 13:58:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607435939;
        bh=LSi8ojieKrceW+5RgQBGS8ZrcFvoD00bJOloiQQsde8=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=oeQs8CzOCWTSMfkz4eCD7YHB7Frnchx+/kKH76wMpAI5OD15M56PfFz71t19uC8jV
         7iWI6jDbrJAP7PZoQHtZKNdyASAkQwHlUuOsL9wlWglrqFTfPPOsQ5Q9ivYMulRchU
         8lQkbqEOxaqHiyUTyAVpU0RCMi2wv/UYJuMNdp5JPM+gi7VN/gUXZiKpSwrdCzLU1T
         xqfQP5RvLCh4P/Pq+cNADAb7v2U0XPreZ2B57MkXHpX58CG/RMnMxkHHu8OHDYez/V
         kQNI/2bsKI+oNe6O8oCOczAWacrFUnjCVHLYklFateSxTn1L+U55nwmfm5zxCV0tqb
         iy6xwS5IwCHQA==
From:   Mark Brown <broonie@kernel.org>
To:     zhangqing <zhangqing@loongson.cn>
Cc:     Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-spi@vger.kernel.org, Huacai Chen <chenhc@lemote.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, gaojuxin@loongson.cn,
        yangtiezhu@loongson.cn
Subject: Re: [PATCH v2 2/4] spi: Add devicetree bindings documentation for
 Loongson SPI
Message-ID: <20201208135852.GD6686@sirena.org.uk>
References: <1607413467-17698-1-git-send-email-zhangqing@loongson.cn>
 <1607413467-17698-2-git-send-email-zhangqing@loongson.cn>
 <b97c4d59-3279-f67d-d951-1e9436faa640@gmail.com>
 <20e7dafc-8c67-79e4-e64a-a08e21101678@loongson.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ylS2wUBXLOxYXZFQ"
Content-Disposition: inline
In-Reply-To: <20e7dafc-8c67-79e4-e64a-a08e21101678@loongson.cn>
X-Cookie: Do not dry clean.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--ylS2wUBXLOxYXZFQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 08, 2020 at 06:47:10PM +0800, zhangqing wrote:
> On 12/08/2020 04:40 PM, Sergei Shtylyov wrote:

> > > +Required properties:

> > > +- #interrupts: No hardware interrupt.

> >    You say it's a required prop, yet yuoe example doesn't have it...

>         I want to emphasize here that LS7A SPI has no hardware interrupts,
> and DT is not actually used.

There is no need to do this, and documenting the property as required
just makes things confusing here.

--ylS2wUBXLOxYXZFQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/PhpwACgkQJNaLcl1U
h9C+nQf+P3HpOh15bXGyJm/WK8G7yzmX7Hv6UzcGcFZJnIlhktCKW1mZahTIWPvQ
ybY5eb0NrxsC39cXRHqOx1ozKvMh38EsKq5WyYyicucZ2ThoWbGHe8X/GWbN6sHj
e9opkqQascDoyhI6lA9F+243z2iwiZpE8kKFDtEuAt4bCt5r7OoEoC3hfir9VEnL
h+Mn/7eKFOTwzzfihSxxCqNVXNqiFW9mRL9j/D0kkCc4LkoIIA1RCCMpOHuVHG8N
6xoBagHxkjF+0MIZnxdeBv5lKG7ZrU6v4xU3HW9m5mFoYudGM+uQIaTP5eam3dhU
pmAHS9SmXX0L1kGbD7e+sGjb0NFH5Q==
=fOh1
-----END PGP SIGNATURE-----

--ylS2wUBXLOxYXZFQ--
