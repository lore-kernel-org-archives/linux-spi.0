Return-Path: <SRS0=+Fl2=C7=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9C2AC2D0E2
	for <linux-spi@archiver.kernel.org>; Tue, 22 Sep 2020 12:02:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71BCE2399A
	for <linux-spi@archiver.kernel.org>; Tue, 22 Sep 2020 12:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600776127;
	bh=FAzNl294QE+Pk73zfSc9ZCv/wnXSmsx7fdUvZBqsPkA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FWff8ezia/E7FdU5cuxZexWEVEEW+cSf3+3OeeJgiqcTY7Ymz0weykxYzX2n5G0lY
	 Or+x6LcgMkKsK8TFWZGCQJkYd4pWMFF3qOkVDVgl8QziBYIJd1chseGQfB2q6Ce+vL
	 z3P8FlOirQ8zJBeDZiYQttjY+UnwYES6CT6/7P/g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbgIVMCG (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Tue, 22 Sep 2020 08:02:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:57902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726518AbgIVMCG (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 22 Sep 2020 08:02:06 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91C522388B;
        Tue, 22 Sep 2020 12:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600776126;
        bh=FAzNl294QE+Pk73zfSc9ZCv/wnXSmsx7fdUvZBqsPkA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=z/CS/EUQtbALVxt0bK/NwPbg97VA7K5YiObhrk1yCFZspmS+jATXU7zk/JlF8KJZQ
         uxPalyL5qTaIS3iWzAI9pO4WLXv6a11PcYS2co94SNa/D0RFI/4B5GTliRdGercVqW
         OK9EstzqZczOoskaRxx15jOdmWiE4SlKDgGfNESw=
Date:   Tue, 22 Sep 2020 13:01:12 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Chuanhong Guo <gch981213@gmail.com>
Cc:     linux-spi@vger.kernel.org, bayi.cheng@mediatek.com,
        stable@vger.kernel.org, Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] spi: spi-mtk-nor: fix timeout calculation overflow
Message-ID: <20200922120112.GS4792@sirena.org.uk>
References: <20200922114905.2942859-1-gch981213@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7gQyIpR7q4QSXYu+"
Content-Disposition: inline
In-Reply-To: <20200922114905.2942859-1-gch981213@gmail.com>
X-Cookie: Love thy neighbor, tune thy piano.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--7gQyIpR7q4QSXYu+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 22, 2020 at 07:49:02PM +0800, Chuanhong Guo wrote:

>  		if ((op->data.dir == SPI_MEM_DATA_IN) &&
>  		    mtk_nor_match_read(op)) {
> +			// limit size to prevent timeout calculation overflow
> +			if (op->data.nbytes > 0x400000)
> +				op->data.nbytes = 0x400000;

If there's a limit on transfer sizes there should also be a
max_transfer_size or max_message_size set (which we should pay attention
to in the core for flash stuff but IIRC we didn't do that yet).

--7gQyIpR7q4QSXYu+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9p54gACgkQJNaLcl1U
h9Bj1Af/YXCUW+7r4wFHXnbDYWGLaIDSH1EBxg+osM3SkN/IcE2rowTsLliZ4VUD
84kMrP5KqglN2081XuEx0PFtMWLgc5VXrFmxqS3E0t5oi7jqIgzDnT9jIXYITtHQ
UO8ZR6IGZ4nVVW+vHUc1vLBakKXOatjJkAwESGGzANYeMLEaDQTn6fDwVx2btYG9
Vo1wl6L5FYFTshq8Q/aC65qjdG52YCRC/3a/uhgIHIlWJ42mORi5lSXOGsbzmaNv
fyT9UXy0BdjXRTPIiNRbEZIioba0dAOFLEg43KZQZilNdgQmnX9ELA9QeCbMbnFu
lq4QZDUVpDhBxcrF/+gCVPINe5wyeg==
=Z/HV
-----END PGP SIGNATURE-----

--7gQyIpR7q4QSXYu+--
