Return-Path: <linux-spi-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC0F3C61DB3
	for <linux-spi@archiver.kernel.org>; Fri,  6 Jan 2023 22:01:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236666AbjAFWBw (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Fri, 6 Jan 2023 17:01:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236693AbjAFWBL (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 6 Jan 2023 17:01:11 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 351DF848E2;
        Fri,  6 Jan 2023 14:00:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 80B90CE1E6D;
        Fri,  6 Jan 2023 22:00:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50C46C433EF;
        Fri,  6 Jan 2023 22:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673042453;
        bh=nY98X/gx6KdA7uOLij50iqYabHvIksPSbU47iL15GCk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LVSEz8npgVEzW/6ZhgEBmyJlBraMWVJelVMT/C0CrxIOdzmNJl8lvGKUXuRc1DmXc
         6uB038RuiDYugVZeiT/I6vmzWknWXmJqvMdk3JJaq37AD0WbfvRjSa6SYd1VkICZvA
         coRBF/pWNUx9OR10Y67++CUXZIVhgqhXBkden9lzD+YYXNrcjtiXjXZYgUYMNA8h1X
         F6sgeTVfp7XhhyneKZp4D0o3aioc0JiwvMBgiqNHl0NgJoH4phSD0wUYLMto73AL50
         U2J23VEgFqgPrxhCSA3nPfqqAykGPoYjdJzLq5VPWzvZCDmiGscvv+DHdIXIMDjDXL
         XcI99nmPUu1zA==
Date:   Fri, 6 Jan 2023 22:00:48 +0000
From:   Mark Brown <broonie@kernel.org>
To:     William Zhang <william.zhang@broadcom.com>
Cc:     Linux SPI List <linux-spi@vger.kernel.org>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        anand.gore@broadcom.com, tomer.yacoby@broadcom.com,
        dan.beygelman@broadcom.com, joel.peshkin@broadcom.com,
        f.fainelli@gmail.com, jonas.gorski@gmail.com,
        kursad.oney@broadcom.com, dregan@mail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/16] spi: bcm63xx-hsspi: Add prepend feature support
Message-ID: <Y7iaEOBP4TRBoDYy@sirena.org.uk>
References: <20230106200809.330769-1-william.zhang@broadcom.com>
 <20230106200809.330769-12-william.zhang@broadcom.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="03fzSve1xfjNt8Ya"
Content-Disposition: inline
In-Reply-To: <20230106200809.330769-12-william.zhang@broadcom.com>
X-Cookie: Do not fold, spindle or mutilate.
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--03fzSve1xfjNt8Ya
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 06, 2023 at 12:08:03PM -0800, William Zhang wrote:
> Multiple transfers within a SPI message may be combined into one
> transfer to the controller using its prepend feature. A SPI message is
> prependable only if the following are all true:
>   * One or more half duplex write transfer
>   * Optional full duplex read/write at the end
>   * No delay and cs_change between transfers

There is nothing driver specific here, this should be implemented in the
core - we have existing logic to rewrite messages to match driver
constraints, this could be added there possibly with flags to allow
drivers to disable or enable the merging if they've got special
requirements.

--03fzSve1xfjNt8Ya
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmO4mg8ACgkQJNaLcl1U
h9ACJwf/UE1spDfA2xj1/PcQ+u3EwHKl083wfkb2q6wwMJqDHkKLmUA4U8gD5dU8
/vZWPViLit19LVtn/P/v7n4yhwR4iks3mYnQKcvV9s88QKsuoY1hgfi4362VdbKf
bqciz2t2WhxEu1eGFjYpdEazyEHH+OkzFJDIGgdsYM+s1CLq1R1PCIPB3KFeIopW
5N2gk+83IHLPqNvHp5RM+fdU5kPv6tKLtcAoJO+0eI1HvOGs25Cp7wI7hgtOSR+V
XozRJNL3Nd9TYjvIGJvatNMWACBZ5Xo7h9GHhVxUWNzWvJk5g8GmTvRJS97rBQOT
5WgghfpwqkekaGIzRkCHfjEx4LFs6w==
=M+9u
-----END PGP SIGNATURE-----

--03fzSve1xfjNt8Ya--
